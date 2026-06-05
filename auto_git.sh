#!/bin/bash
# Auto git commit & push — runs every 3 hours via cron
# Only does git operations, never modifies files

REPO_DIR="/home/ubuntu/gush-project"
LOG_FILE="/home/ubuntu/auto_git.log"

# Use the GUSH deploy key for GitHub auth
export GIT_SSH_COMMAND="ssh -i /home/ubuntu/.ssh/id_ed25519_gush -o IdentitiesOnly=yes -o StrictHostKeyChecking=no"

cd "$REPO_DIR" || { echo "[$(date)] ERROR: cannot cd to $REPO_DIR" >> "$LOG_FILE"; exit 1; }

# Check for uncommitted changes
if [ -z "$(git status --porcelain)" ]; then
    echo "[$(date)] No changes." >> "$LOG_FILE"
    exit 0
fi

# Stage all changes, commit, push
git add -A
COMMIT_MSG="auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
if git commit -m "$COMMIT_MSG" >> "$LOG_FILE" 2>&1; then
    if git push origin main >> "$LOG_FILE" 2>&1; then
        echo "[$(date)] Commit & push OK." >> "$LOG_FILE"
    else
        echo "[$(date)] Commit OK but push FAILED." >> "$LOG_FILE"
    fi
else
    echo "[$(date)] Nothing to commit." >> "$LOG_FILE"
fi
