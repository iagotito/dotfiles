#!/usr/bin/env bash
set -e

GTK3_CACHE="/usr/lib/gtk-3.0/3.0.0/immodules.cache"
GTK2_CACHE="/usr/lib/gtk-2.0/2.10.0/immodules.cache"
COMPOSE="/usr/share/X11/locale/en_US.UTF-8/Compose"
ENV_FILE="/etc/environment"

echo "Configuring GTK immodules…"

for file in "$GTK3_CACHE" "$GTK2_CACHE"; do
    if [[ -f "$file" ]]; then
        sed -i \
            -E 's/(cedilla".*"[^"]*")([^"]*)"/\1\2:en"/' \
            "$file"
    fi
done

echo "Fixing Compose mappings…"

sed -i \
    -e 's/ć/ç/g' \
    -e 's/Ć/Ç/g' \
    "$COMPOSE"

echo "Setting environment variables…"

grep -q '^GTK_IM_MODULE=cedilla' "$ENV_FILE" || \
    echo 'GTK_IM_MODULE=cedilla' >> "$ENV_FILE"

grep -q '^QT_IM_MODULE=cedilla' "$ENV_FILE" || \
    echo 'QT_IM_MODULE=cedilla' >> "$ENV_FILE"

echo "Done. Reboot required."
