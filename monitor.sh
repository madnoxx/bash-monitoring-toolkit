#!/bin/bash
set -euo pipefail
source ./config.sh

echo -e "${YELLOW}🔍 Мониторинг системы...${RESET}"

echo "Дата: $(date)"
log "Мониторинг запущен" "$LOG_MONITOR"

echo "Хост: $(hostname)"
log "Выведено имя хоста" "$LOG_MONITOR"

echo "CPU load: $(uptime | awk -F'load average:' '{print $2}')"
log "Выведено CPU" "$LOG_MONITOR"

echo "Память:"
free -h
log "Выведена память" "$LOG_MONITOR"

echo "Диск:"
df -h /
log "Выведен диск" "$LOG_MONITOR"

echo "Подключения: $(ss -tunap | wc -l)"
log "Выведены соединения" "$LOG_MONITOR"

log "Мониторинг завершён" "$LOG_MONITOR"
