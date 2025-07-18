#!/bin/bash

# Цвета
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Логи
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

LOG_MONITOR="$LOG_DIR/monitor.log"
LOG_BACKUP="$LOG_DIR/backup.log"
LOG_HEALTH="$LOG_DIR/healthcheck.log"
LOG_DOCKER="$LOG_DIR/docker_check.log"

# Общая лог-функция
log() {
  echo "$(date '+%F %T') — $1" >> "$2"
}
