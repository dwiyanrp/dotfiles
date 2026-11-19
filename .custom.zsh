# ═══════════════════════════════════════════════════════════════════════════
# Helpers
# ═══════════════════════════════════════════════════════════════════════════
path_add()  { case ":$PATH:" in *":$1:"*) ;; *) export PATH="$1:$PATH" ;; esac }
source_if() { [[ -f "$1" ]] && source "$1"; }

# ═══════════════════════════════════════════════════════════════════════════
# Environment Variables
# ═══════════════════════════════════════════════════════════════════════════
export GOPATH="$HOME/.local/share/go"
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"

# ═══════════════════════════════════════════════════════════════════════════
# Shell Integrations
# ═══════════════════════════════════════════════════════════════════════════
source_if "$BUN_INSTALL/_bun"                       # Bun completion

# ═══════════════════════════════════════════════════════════════════════════
# PATH (idempotent)
# ═══════════════════════════════════════════════════════════════════════════
path_add "$GOPATH/bin"
path_add "$PNPM_HOME/bin"
path_add "$BUN_INSTALL/bin"
path_add "$HOME/.pixi/bin"
path_add "$HOME/.opencode/bin"
path_add "$HOME/.kilo/bin"

# ═══════════════════════════════════════════════════════════════════════════
# Key Bindings
# ═══════════════════════════════════════════════════════════════════════════

zle     -N            tmux-connect
bindkey -M emacs '^F' tmux-connect
bindkey -M vicmd '^F' tmux-connect
bindkey -M viins '^F' tmux-connect

# ═══════════════════════════════════════════════════════════════════════════
# Aliases
# ═══════════════════════════════════════════════════════════════════════════

# Tools
alias agyy="agy --dangerously-skip-permissions"
alias zedo="zed ~/.config/opencode/opencode.json"
alias op="opencode2"

# Navigation
alias cd-nvim="cd ~/.config/nvim"
alias cd-dotfiles="cd ~/dotfiles"
alias cd-ghostty-themes="cd /Applications/Ghostty.app/Contents/Resources/ghostty/themes/"

# Neovim
alias nvimf="nvim -c ':Telescope find_files'"
alias nvim-customzsh="nvim ~/.customzsh && source ~/.customzsh"
alias nvim-ghostty="nvim ~/.config/ghostty/config"
alias nvim-sesh="nvim ~/.config/sesh/sesh.toml"
alias nvim-tmux="nvim ~/.config/tmux/tmux.conf && tmux source ~/.config/tmux/tmux.conf"
alias nvim-nvim="nvim ~/.config/nvim"
alias clear-nvim="rm -rf ~/.local/state/nvim && rm -rf ~/.local/share/nvim"

# Colima & Docker
alias c-up="colima start --arch aarch64 --vm-type=vz --vz-rosetta --cpu 4 --memory 8 --mount-type=virtiofs --network-address"
alias c-status="colima status"
alias c-down="colima stop"
alias lzd="lazydocker"

# ═══════════════════════════════════════════════════════════════════════════
# Functions
# ═══════════════════════════════════════════════════════════════════════════

delete-nvim() {
    rm -rf "$HOME/.config/nvim"
    rm -rf "$HOME/.local/state/nvim"
    rm -rf "$HOME/.local/share/nvim"
}

echo-path() {
    print -l ${(s.:.)PATH};
}

ln-config() {
  mkdir -p "$HOME/.config"
  ln -sf "$HOME/dotfiles/.config/tmux"              "$HOME/.config"
  ln -sf "$HOME/dotfiles/.config/tmux-sessionizer"  "$HOME/.config"
  ln -sf "$HOME/dotfiles/.config/sesh"              "$HOME/.config"
  ln -sf "$HOME/dotfiles/.config/ghostty"           "$HOME/.config"
  ln -sf "$HOME/dotfiles/.config/nvim"              "$HOME/.config"
}

re-source() {
    source "$HOME/.zshrc"
}

tmux-connect() { sesh-connect } # sesh-connect | tmux-sessionizer-connect

sesh-connect() {
  {
    exec </dev/tty
    exec <&1
    local selected_session
    selected_session=$(sesh list -tc --icons --hide-attached | fzf-tmux -p 80%,70% \
        --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
        --header '  ^a all ^t tmux ^g configs ^d tmux kill ^f find' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list -tc --icons)' \
        --preview-window 'right:55%' \
        --preview 'sesh preview {}' \
        --reverse \
    )
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$selected_session" ]] && return
    sesh connect "$selected_session"
  }
}

tmux-sessionizer-connect() {
  {
    exec </dev/tty
    exec <&1
    /Users/drp/c/temp/tmux-sessionizer/tmux-sessionizer
    zle reset-prompt > /dev/null 2>&1 || true
  }
}

# Docker
# export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
