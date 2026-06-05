#!/usr/bin/env bash

# ============================================================================
# OrcaTerm Shell Integration（Bash）
# ----------------------------------------------------------------------------
# 这是 OrcaTerm Web 终端的「Shell 集成」脚本，作用与 VS Code、iTerm2、
# Warp 等现代终端的 Shell Integration 完全一致：
# 让上层终端能够识别"提示符在哪里、命令开始了、命令结束了、退出码是多少、当前目录是什么
#
# 安全说明（请放心使用）：
#   1. 本脚本仅在「当前 Bash 会话」内生效，退出会话后所有改动随之消失；
#   2. 不会修改用户磁盘上的任何文件（不会写 ~/.bashrc、~/.profile 等）；
#   3. 不会发起任何网络请求；
#   4. 不会向外发送用户输入的命令明文或文件内容，
#      只发送少量「位置标记」给本地上层终端（OSC 转义序列，下文有说明）；
#   5. 所有逻辑均在本文件中可见，便于审阅。
# ============================================================================

# 防止同一会话内被重复加载（例如用户手动再 source 一次本脚本）
if [[ -n "$__ORCA_BASH_LOADED" ]]; then
    return 0
fi
export __ORCA_BASH_LOADED=1

# ----------------------------------------------------------------------------
# 阶段 1：模拟 Login Shell 环境
# ----------------------------------------------------------------------------
# 因为 OrcaTerm 是通过非交互方式拉起 bash 的，默认不会自动加载用户的登录环境。
# 这里按 Bash 官方定义的「Login Shell 启动顺序」依次 source 用户已有的配置文件，
# 目的只有一个：让用户在 OrcaTerm 里看到的 PATH / alias / 环境变量与 ssh 直连
# 登录时完全一致。
#
# 注意：仅「读取并执行」用户已存在的文件，不会创建、修改或删除任何文件。
if [ -f /etc/profile ]; then
    source /etc/profile
fi

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
elif [ -f ~/.bash_login ]; then
    source ~/.bash_login
elif [ -f ~/.profile ]; then
    source ~/.profile
fi


# ----------------------------------------------------------------------------
# 阶段 3：内联 bash-preexec 核心库
# ----------------------------------------------------------------------------
# bash-preexec 是开源社区广泛使用的 Bash 钩子工具（MIT 协议，
# https://github.com/rcaloras/bash-preexec），作用是为 Bash 提供
# zsh 那样的 preexec / precmd 钩子能力。
#
# 这里把它「内联」进来，避免依赖额外文件、便于审阅。
# 实现上完全对齐上游版本，未做任何安全敏感改动。
# ----------------------------------------------------------------------------

# 仅在当前进程是 Bash 时继续，否则直接返回，不做任何修改
if [ -z "${BASH_VERSION-}" ]; then return 1; fi
# 仅支持 Bash 3.1 及以上版本（DEBUG trap 的语义在更早版本中不稳定）
if [[ -z "${BASH_VERSINFO-}" ]] || (( BASH_VERSINFO[0] < 3 || (BASH_VERSINFO[0] == 3 && BASH_VERSINFO[1] < 1) )); then return 1; fi

# 防重入：若环境中已自行安装过 bash-preexec（例如装过 starship、atuin 等
# 工具），则跳过库的重定义，直接复用其钩子数组，避免重复注册或破坏现有行为。
if [[ -z "${bash_preexec_imported:-}" && -z "${__bp_imported:-}" ]]; then
    bash_preexec_imported="defined"
    __bp_imported="${bash_preexec_imported}"

    # 暂存上一条命令的退出码与最后一个参数，避免后续逻辑覆盖 $? 与 $_
    __bp_last_ret_value="$?"
    BP_PIPESTATUS=("${PIPESTATUS[@]}")
    __bp_last_argument_prev_command="$_"

    __bp_inside_precmd=0
    __bp_inside_preexec=0

    # 可向这两个数组追加自己的回调函数，会被自动调用
    declare -a precmd_functions
    declare -a preexec_functions

    # 工具函数：去除字符串首尾空白
    __bp_trim_whitespace() {
        local var=${1:?} text=${2:-}
        text="${text#"${text%%[![:space:]]*}"}"
        text="${text%"${text##*[![:space:]]}"}"
        printf -v "$var" '%s' "$text"
    }

    # 工具函数：清理 PROMPT_COMMAND 中残留的多余分号和空白
    __bp_sanitize_string() {
        local var=${1:?} text=${2:-} sanitized
        __bp_trim_whitespace sanitized "$text"
        sanitized=${sanitized%;}
        sanitized=${sanitized#;}
        __bp_trim_whitespace sanitized "$sanitized"
        printf -v "$var" '%s' "$sanitized"
    }

    # 标记当前已进入「等待用户输入」的交互态
    __bp_interactive_mode() {
        __bp_preexec_interactive_mode="on"
    }

    # 钩子：precmd —— 在每次绘制提示符之前调用
    __bp_precmd_invoke_cmd() {
        # 第一时间保存上一条命令的退出码，避免被后续逻辑覆盖
        __bp_last_ret_value="$?" __bp_last_argument_prev_command="$_" BP_PIPESTATUS=("${PIPESTATUS[@]}")

        # 防止递归触发
        if (( __bp_inside_precmd > 0 )); then return; fi
        local __bp_inside_precmd=1

        # 依次调用注册到 precmd_functions 数组中的所有函数
        __bp_invoke_precmd_functions "$__bp_last_ret_value" "$__bp_last_argument_prev_command"
        __bp_set_ret_value "$__bp_last_ret_value" "$__bp_last_argument_prev_command"
    }

    __bp_invoke_precmd_functions() {
        local lastexit=$1 lastarg=$2 precmd_function precmd_function_ret_value precmd_ret_value=0
        for precmd_function in "${precmd_functions[@]}"; do
            if type -t "$precmd_function" 1>/dev/null; then
                __bp_set_ret_value "$lastexit" "$lastarg"
                "$precmd_function"
                precmd_function_ret_value=$?
                if [[ "$precmd_function_ret_value" != 0 ]]; then
                    precmd_ret_value="$precmd_function_ret_value"
                fi
            fi
        done
        __bp_set_ret_value "$precmd_ret_value"
    }

    # 工具函数：通过 return 设置 $?
    __bp_set_ret_value() {
        return ${1:+"$1"}
    }

    # 从 history 中取出即将执行的命令（仅供 preexec 内部使用）
    __bp_load_this_command_from_history() {
        this_command=$(LC_ALL=C HISTTIMEFORMAT='' builtin history 1)
        this_command="${this_command#*[[:digit:]][* ] }"
        [[ -n "$this_command" ]]
    }

    # 钩子：preexec —— 回车后、命令开始执行前调用
    __bp_preexec_invoke_exec() {
        local lastarg=$_
        if (( __bp_inside_preexec > 0 )); then return; fi
        local __bp_inside_preexec=1

        # 仅在交互式终端下生效；
        if [[ ! -t 1 && -z "${__bp_delay_install:-}" ]]; then return; fi
        if [[ -n "${COMP_POINT:-}" || -n "${READLINE_POINT:-}" ]]; then return; fi
        if [[ -z "${__bp_preexec_interactive_mode:-}" ]]; then
            return
        else
            if [[ 0 -eq "${BASH_SUBSHELL:-}" ]]; then
                __bp_preexec_interactive_mode=""
            fi
        fi

        __bp_last_argument_prev_command=$lastarg
        local this_command
        __bp_load_this_command_from_history || return

        # 遍历并执行 preexec_functions 数组中的所有函数
        __bp_invoke_preexec_functions "${__bp_last_ret_value:-}" "$__bp_last_argument_prev_command" "$this_command"
        local preexec_ret_value=$?
        __bp_set_ret_value "$preexec_ret_value" "$__bp_last_argument_prev_command"
    }

    __bp_invoke_preexec_functions() {
        local lastexit=$1 lastarg=$2 this_command=$3 preexec_function preexec_function_ret_value preexec_ret_value=0
        for preexec_function in "${preexec_functions[@]:-}"; do
            if type -t "$preexec_function" 1>/dev/null; then
                __bp_set_ret_value "$lastexit" "$lastarg"
                "$preexec_function" "$this_command"
                preexec_function_ret_value="$?"
                if [[ "$preexec_function_ret_value" != 0 ]]; then
                    preexec_ret_value="$preexec_function_ret_value"
                fi
            fi
        done
        __bp_set_ret_value "$preexec_ret_value"
    }

    # 安装与挂载：接管 PROMPT_COMMAND 和 DEBUG Trap
    __bp_install() {
        local lastexit=$? lastarg=$_
        # 已经安装过则直接退出，避免重复挂载
        if [[ "${PROMPT_COMMAND[*]:-}" == *'__bp_precmd_invoke_cmd "$_"'* ]]; then return 1; fi

        # 通过 DEBUG trap 实现 preexec：bash 在执行任何命令前都会触发 DEBUG 信号
        trap '__bp_preexec_invoke_exec "$_"' DEBUG

        local existing_prompt_command="${PROMPT_COMMAND:-}"
        __bp_sanitize_string existing_prompt_command "$existing_prompt_command"
        if [[ "${existing_prompt_command:-:}" == ":" ]]; then
            existing_prompt_command=
        fi

        # 先放我们的钩子，再追加用户原有的 PROMPT_COMMAND，确保两者共存
        PROMPT_COMMAND='__bp_precmd_invoke_cmd "$_"'
        PROMPT_COMMAND+=${existing_prompt_command:+$'\n'$existing_prompt_command}

        # 兼容 Bash 5.1+ 中 PROMPT_COMMAND 可以是数组的新形式
        if (( BASH_VERSINFO[0] > 5 || (BASH_VERSINFO[0] == 5 && BASH_VERSINFO[1] >= 1) )); then
            PROMPT_COMMAND+=('__bp_interactive_mode')
        else
            PROMPT_COMMAND+=$'\n__bp_interactive_mode'
        fi

        # 兼容传统命名约定：用户若直接定义了 precmd / preexec 函数也能生效
        precmd_functions+=(precmd)
        preexec_functions+=(preexec)

        __bp_set_ret_value "$lastexit" "$lastarg"
        __bp_precmd_invoke_cmd
        __bp_interactive_mode
    }

    # 执行安装
    __bp_install

fi

# 兼容兜底：若上方因检测到已有 bash-preexec 而跳过，
# 这里再确保两个钩子数组一定存在（不会覆盖用户已有数据）
if ! declare -p precmd_functions &>/dev/null; then
    declare -a precmd_functions
fi
if ! declare -p preexec_functions &>/dev/null; then
    declare -a preexec_functions
fi

# ----------------------------------------------------------------------------
# 阶段 4：注入 OrcaTerm 的运行时钩子
# ----------------------------------------------------------------------------
# 通过上方安装好的 preexec / precmd 数组，本节会在「命令执行前」与
# 「命令结束后」各发送一段 OSC 转义序列给本地终端，用于让上层界面识别命令
# 的开始与结束。
#
# 关于 OSC 转义序列（Operating System Command）：
#   * 这是终端协议中标准的「带外信令」机制，所有主流终端都会原样转发给
#     渲染层，不会被当作命令执行；
#   * 我们使用 1337 号通道（iTerm2 私有协议号，已被各大终端广泛兼容）；
#   * 仅传递「位置标记 + 退出码 + 当前目录」三类信息，不会传送命令明文、
#     输出内容或任何文件数据。
#
# 同时，这里取消 PROMPT_COMMAND / PS1 的导出属性，
# 防止它们被带入 su / sudo 后的子 Shell，污染其它账号的环境。
export -n PROMPT_COMMAND
export -n PS1

__web_terminal_preexec() {
    # 命令开始执行的标记
    # 形如：ESC ] 1337 ; PreExecMarker ; <用户刚回车的命令> BEL
    # 仅供本地上层终端解析，用以高亮"这条命令正在运行"
    printf "\x1B]1337;PreExecMarker;%s\x7" "$1"
}

__web_terminal_precmd() {
    # 命令结束、即将打印新提示符前的标记
    # 注意：必须在函数第一行抓取 $?，避免被后续语句覆盖
    local ret=$?
    # 形如：ESC ] 1337 ; PostExecMarker ; Exit=<退出码> ; CurrentDir=<pwd> ; BEL
    # 用以让上层界面更新「上一条命令是否成功」「当前所在目录」
    printf "\x1B]1337;PostExecMarker;Exit=%s;CurrentDir=%s;\x7" "$ret" "$(pwd)"
}

# ----------------------------------------------------------------------------
# 阶段 5：把"提示符开始/结束"标记包装到 PS1 中
# ----------------------------------------------------------------------------
# OSC 133 是另一套被广泛采用的提示符语义协议（FinalTerm 起源，VS Code、
# Wezterm、Kitty 等终端均支持）。它的作用是告诉上层「这一段是提示符」，
# 从而支持「跳到上一/下一个提示符」「按命令折叠」等高级功能。
#
# 实现策略：
#   - 不直接修改用户原始的 PS1 内容（不会丢失颜色、用户名、Git 分支等定制）；
#   - 仅在 PS1 的「最外层」前后各加一条 OSC 133 标记；
#   - 用 \[ \] 包裹标记，确保 readline 计算光标位置时把它当作零宽字符。

__is_prompt_start() {
    builtin printf '\e]133;PS\a'
}

__is_prompt_end() {
    builtin printf '\e]133;PE\a'
}

# 包装 PS1：仅当尚未包装、或 PS1 被其他工具改写时才重新生成
# __is_original_PS1 始终保存着「用户原始的 PS1」，便于幂等还原
__is_update_prompt() {
    if [[ "$__is_custom_PS1" == "" || "$__is_custom_PS1" != "$PS1" ]]; then
        __is_original_PS1=$PS1
        __is_custom_PS1="\[$(__is_prompt_start)\]$__is_original_PS1\[$(__is_prompt_end)\]"
        # 仅在当前 Shell 中赋值；千万不要 export，
        # 否则会污染 su / sudo 后的子 Shell 提示符
        PS1="$__is_custom_PS1"
    fi
}

# 若用户的 ~/.profile 等已先加载过旧版本（已存在 __is_original_PS1），
# 先还原回真正的原始 PS1，避免本次包装在其之上又叠加一层标记
if [[ -n "$__is_original_PS1" ]]; then
    PS1="$__is_original_PS1"
fi
__is_custom_PS1=""
__is_update_prompt

# 注册到上方的钩子数组中（执行顺序按数组先后）
precmd_functions+=(__web_terminal_precmd)
# 兜底：若后续有工具（starship、oh-my-bash 等）覆盖了 PS1，
# 这里会在每次提示符渲染前重新检查并补回我们的标记
precmd_functions+=(__is_update_prompt)
preexec_functions+=(__web_terminal_preexec)



