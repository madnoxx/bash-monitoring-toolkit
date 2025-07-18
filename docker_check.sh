#!/bin/bash
set -euo pipefail
source ./config.sh

echo -e "${YELLOW}🐳 Проверка docker-compose.yml...${RESET}"

compose_file="docker-compose.yml"

# Проверка наличия docker-compose или docker compose
if command -v docker-compose &>/dev/null; then
  compose_cmd="docker-compose"
elif docker compose version &>/dev/null; then
  compose_cmd="docker compose"
else
  echo -e "${RED}❌ docker-compose не установлен${RESET}"
  log "❌ docker-compose не найден" "$LOG_DOCKER"
  exit 1
fi

# Проверка существования файла
if [[ ! -f "$compose_file" ]]; then
  echo -e "${RED}❌ Файл $compose_file не найден${RESET}"
  log "❌ Файл $compose_file отсутствует" "$LOG_DOCKER"
  exit 1
fi

# Валидация
if $compose_cmd config -q &>/dev/null; then
  echo -e "${GREEN}✅ docker-compose.yml валиден${RESET}"
  log "✅ docker-compose.yml валиден" "$LOG_DOCKER"
else
  echo -e "${RED}❌ Ошибка в docker-compose.yml${RESET}"
  log "❌ Ошибка в docker-compose.yml" "$LOG_DOCKER"
fi
