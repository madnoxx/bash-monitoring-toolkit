#!/bin/bash
set -euo pipefail
source ./config.sh

echo -e "${YELLOW}🌐 Проверка доступности URL...${RESET}"

read -p "Введите URL: " url

response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

if [[ "$response" == "200" ]]; then
  echo -e "${GREEN}🟢 Доступен (${response})${RESET}"
  log "$url — 🟢 OK ($response)" "$LOG_HEALTH"
else
  echo -e "${RED}🔴 Недоступен (${response})${RESET}"
  log "$url — 🔴 Ошибка ($response)" "$LOG_HEALTH"
fi

# Сохраняем только последние 20 строк лога
tail -n 20 "$LOG_HEALTH" > "$LOG_HEALTH.tmp" && mv "$LOG_HEALTH.tmp" "$LOG_HEALTH"
