#!/bin/bash
set -euo pipefail
source ./config.sh

echo -e "${YELLOW}💾 Резервное копирование проекта...${RESET}"

read -p "Введите путь к директории проекта: " path

if [[ ! -d "$path" ]]; then
  echo -e "${RED}❌ Ошибка: директория не существует${RESET}"
  log "❌ Ошибка: директория $path не найдена" "$LOG_BACKUP"
  exit 1
fi

project_name=$(basename "$path")
timestamp=$(date '+%F_%H-%M-%S')
backup_name="backup_${project_name}_${timestamp}.tar.gz"
backup_path="/tmp/backups"

mkdir -p "$backup_path"

tar -czf "$backup_name" -C "$(dirname "$path")" "$project_name"
mv "$backup_name" "$backup_path"

log "✅ Создан бэкап: $backup_name" "$LOG_BACKUP"
echo -e "${GREEN}✅ Бэкап сохранён: ${backup_path}/${backup_name}${RESET}"

# Очистка старых архивов старше 7 дней
find "$backup_path" -name "backup_*.tar.gz" -mtime +7 -delete && \
  log "🧹 Удалены старые бэкапы (>7 дней)" "$LOG_BACKUP"
