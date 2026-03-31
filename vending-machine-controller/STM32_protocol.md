# STM32F407 通信协议说明

## 串口参数
| 参数 | 值 |
|------|----|
| 波特率 | 115200 |
| 数据位 | 8 |
| 停止位 | 1 |
| 校验位 | 无 |
| 连接方式 | USB转TTL |

---

## 1. 出货指令（Orange Pi → STM32）

### 帧格式
```
[0xAA] [行字节] [列字节] [0xBB]
```

| 字节 | 含义 | 值域 |
|------|------|------|
| 0xAA | 帧头 | 固定 |
| 行字节 | 货道行（ASCII） | 'A'=0x41 ~ 'F'=0x46 |
| 列字节 | 货道列（ASCII） | '0'=0x30 ~ '9'=0x39 |
| 0xBB | 帧尾 | 固定 |

### 示例
| 出货货道 | 十六进制指令 |
|---------|------------|
| A0 | `AA 41 30 BB` |
| A9 | `AA 41 39 BB` |
| F0 | `AA 46 30 BB` |
| F9 | `AA 46 39 BB` |

---

## 2. STM32 回复帧（STM32 → Orange Pi）

### 帧格式
```
[0xCC] [行字节] [列字节] [状态] [0xDD]
```

| 字节 | 含义 | 值域 |
|------|------|------|
| 0xCC | 帧头 | 固定 |
| 行字节 | 货道行（echo） | 同请求 |
| 列字节 | 货道列（echo） | 同请求 |
| 状态 | 执行结果 | 见下表 |
| 0xDD | 帧尾 | 固定 |

### 状态码
| 状态值 | 含义 |
|--------|------|
| 0x01 | 出货成功 |
| 0x02 | 出货失败（货道空或机械故障） |
| 0x03 | 执行中（请等待） |

### 示例
| 场景 | 十六进制回复 |
|------|------------|
| A0 出货成功 | `CC 41 30 01 DD` |
| A0 货道空 | `CC 41 30 02 DD` |

---

## 3. STM32 参考代码（HAL库）

```c
#include "usart.h"
#include "string.h"

#define FRAME_HEAD  0xAA
#define FRAME_TAIL  0xBB
#define RESP_HEAD   0xCC
#define RESP_TAIL   0xDD

#define STATUS_OK    0x01
#define STATUS_EMPTY 0x02
#define STATUS_BUSY  0x03

/* 货道数量: A0~F9 = 60个 */
#define ROWS 6   /* A~F */
#define COLS 10  /* 0~9 */

/* 每个货道的库存（实际应从传感器读取或内部计数） */
uint8_t inventory[ROWS][COLS];

/* 初始化库存 */
void Inventory_Init(void) {
    for (int r = 0; r < ROWS; r++)
        for (int c = 0; c < COLS; c++)
            inventory[r][c] = 5;  // 初始5个
}

/* 发送回复帧 */
void Send_Response(uint8_t row_char, uint8_t col_char, uint8_t status) {
    uint8_t resp[5] = {RESP_HEAD, row_char, col_char, status, RESP_TAIL};
    HAL_UART_Transmit(&huart1, resp, 5, 100);
}

/* 控制螺杆电机出货（根据你的硬件实现） */
uint8_t Motor_Dispense(int row, int col) {
    /* TODO: 控制对应货道的螺杆电机转动一圈 */
    /* 返回 1=成功, 0=失败 */
    
    // 示例：通过GPIO或PWM控制电机
    // Channel_Motor_Run(row * 10 + col);
    // HAL_Delay(1000);  // 等待出货完成
    
    return 1;  // 暂时返回成功
}

/* UART接收中断处理 */
uint8_t rx_buf[4];
uint8_t rx_count = 0;

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart) {
    if (huart->Instance == USART1) {
        // 重新启动接收
        HAL_UART_Receive_IT(&huart1, rx_buf, 4);
    }
}

/* 在主循环或接收完成回调中解析指令 */
void Parse_Command(uint8_t *buf, uint16_t len) {
    if (len < 4) return;
    if (buf[0] != FRAME_HEAD || buf[3] != FRAME_TAIL) return;

    uint8_t row_char = buf[1];  /* 'A'~'F' */
    uint8_t col_char = buf[2];  /* '0'~'9' */

    /* 转换为数组索引 */
    int row = row_char - 'A';  /* 0~5 */
    int col = col_char - '0';  /* 0~9 */

    if (row < 0 || row >= ROWS || col < 0 || col >= COLS) {
        Send_Response(row_char, col_char, STATUS_EMPTY);
        return;
    }

    if (inventory[row][col] <= 0) {
        Send_Response(row_char, col_char, STATUS_EMPTY);
        return;
    }

    /* 触发出货 */
    uint8_t ok = Motor_Dispense(row, col);

    if (ok) {
        inventory[row][col]--;
        Send_Response(row_char, col_char, STATUS_OK);
    } else {
        Send_Response(row_char, col_char, STATUS_EMPTY);
    }
}
```

---

## 4. 货道编号对照表

| 货道 | 行索引 | 列索引 | 指令(HEX) |
|------|--------|--------|-----------|
| A0   | 0      | 0      | AA 41 30 BB |
| A1   | 0      | 1      | AA 41 31 BB |
| ...  | ...    | ...    | ... |
| F8   | 5      | 8      | AA 46 38 BB |
| F9   | 5      | 9      | AA 46 39 BB |

---

## 5. 注意事项

1. STM32收到指令后**必须回复**，否则Orange Pi会超时（5秒）
2. 出货过程中如果又收到新指令，建议返回 STATUS_BUSY，等当前出货完成
3. 螺杆电机控制逻辑请根据你的硬件实现 `Motor_Dispense()` 函数
4. 建议在STM32中用**中断接收**，避免轮询丢包
