# Shared helpers for my-git-wrapper commands.
# Not executable on purpose: it's sourced, never dispatched as a command.

CONFIG_FILE="$WRAPPER_DIR/.local-commit"

_repo_root() {
    "$REAL_GIT" rev-parse --show-toplevel 2>/dev/null
}

# Prints the configured local commit hash for the current repo, or fails.
get_local_commit() {
    local root
    root=$(_repo_root) || return 1
    [[ -f "$CONFIG_FILE" ]] || return 1
    awk -F'=' -v r="$root" '
        $1 == r { print substr($0, length($1) + 2); found=1 }
        END { exit !found }
    ' "$CONFIG_FILE"
}

# Stores the local commit hash for the current repo, replacing any prior entry.
set_local_commit() {
    local root="$1" hash="$2" tmp
    tmp=$(mktemp)
    if [[ -f "$CONFIG_FILE" ]]; then
        grep -v -F "${root}=" "$CONFIG_FILE" > "$tmp" || true
    fi
    echo "${root}=${hash}" >> "$tmp"
    mv "$tmp" "$CONFIG_FILE"
}
