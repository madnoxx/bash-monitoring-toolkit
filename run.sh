#!/bin/bash
set -euo pipefail
source ./config.sh

echo -e "${YELLOW}🚀 Запуск всех утилит Bash Monitoring Toolkit...${RESET}"

START_TIME=$(date '+%F %T')
log "▶ Запуск всех утилит" "$LOG_MONITOR"

for script in monitor.sh healthcheck.sh docker_check.sh backup.sh; do
  if [[ -x "./$script" ]]; then
    echo -e "${YELLOW}▶ Выполняется: $script${RESET}"
    ./"$script"
    echo
  else
    echo -e "${RED}⚠ Скрипт $script не найден или не исполняемый${RESET}"
    log "⚠ Пропущен $script (не найден или нет прав)" "$LOG_MONITOR"
  fi
done

END_TIME=$(date '+%F %T')
log "✅ Все утилиты выполнены (${START_TIME} → ${END_TIME})" "$LOG_MONITOR"

echo -e "${GREEN}✅ Все скрипты успешно выполнены${RESET}"
