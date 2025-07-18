#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Список задач для планировщика
declare -A jobs=(
  ["monitor.sh"]="*/30 * * * *"
  ["healthcheck.sh"]="*/10 * * * *"
  ["backup.sh"]="0 2 * * *"
  ["docker_check.sh"]="0 3 * * *"
)

# Читаем текущие cron-задания пользователя
current_cron=$(crontab -l 2>/dev/null || true)

# Добавим новые задания, если их ещё нет
for script in "${!jobs[@]}"; do
  cron_line="${jobs[$script]} bash ${SCRIPT_DIR}/${script}"
  if ! echo "$current_cron" | grep -Fq "$script"; then
    echo "➕ Добавляем в crontab: $script"
    current_cron+=$'\n'"$cron_line"
  else
    echo "✅ Уже добавлено: $script"
  fi
done

# Устанавливаем обновлённый crontab
echo "$current_cron" | crontab -

echo -e "\n✅ Crontab обновлён. Просмотреть: crontab -l"
