# ==========================================
# 1. Environment & PATH
# ==========================================
# Node Version Manager (NVM) — loaded lazily on first use.
# Sourcing nvm.sh eagerly costs ~1.2s per shell (script parse + implicit `nvm use`).
export NVM_DIR="$HOME/.nvm"

# Node binaries are resolved from nvm's default version without loading nvm.sh.
if [ -r "$NVM_DIR/alias/default" ]; then
  _nvm_default="$(<"$NVM_DIR/alias/default")"
  case "$_nvm_default" in
    lts/*|node/*) _nvm_default="${_nvm_default#*/}" ;;
  esac
  if [ -z "${_nvm_default##*[!0-9.]*}" ] && [ -x "$NVM_DIR/versions/node/v$_nvm_default/bin/node" ]; then
    export PATH="$NVM_DIR/versions/node/v$_nvm_default/bin:$PATH"
  fi
  unset _nvm_default
fi

nvm() {
  unset -f nvm
  . "$NVM_DIR/nvm.sh" --no-use
  nvm "$@"
}

# Input filter
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# .NET global tools
export PATH="$HOME/.dotnet/tools:$PATH"

# ==========================================
# 2. History Settings
# ==========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ==========================================
# 3. Completion System
# ==========================================
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive
compinit -d "$HOME/.zcompdump"

# ==========================================
# 4. Zoxide (jump-to-directory)
# ==========================================
# `eval "$(zoxide init zsh)"` is a pure zsh script — ~20ms, no node needed.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ==========================================
# 5. Aliases
# ==========================================
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# eza — icons are auto-detected from the terminal's font/colour support
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --all --icons=auto --group-directories-first'
  alias ll='eza --long --all --icons=auto --group-directories-first'
  alias la='eza --all --icons=auto --group-directories-first'
  alias lt='eza --tree --level=2 --all --icons=auto --group-directories-first'
  alias l='eza --all --icons=auto --group-directories-first'
fi

# fd — Debian/Ubuntu ships it as `fdfind`. Note: fd renders no icons itself,
# it only widens the search (`--hidden`, `--follow`).
if command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind --hidden --follow'
fi

# bat — Debian/Ubuntu ships it as `batcat`.
# NOTE: the Ubuntu build of bat (0.25.0 here) has no `--icons` flag, so no
# icons here — that flag only exists in newer upstream builds.
if command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ==========================================
# 6. Prompt & Git Integration (Transient)
# ==========================================
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' %F{yellow}git:(%b)%f'

set_prompt() {
    vcs_info
    PROMPT='%F{green}%n%f in %F{cyan}%~%f${vcs_info_msg_0_}
%(?.%F{magenta}❯%f.%F{red}❯%f) '
}

zle-line-init() {
    set_prompt
    zle reset-prompt
}

zle-line-finish() {
    PROMPT='%(?.%F{magenta}❯%f.%F{red}❯%f) '
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish

precmd() {
    set_prompt
}

# ==========================================
# 7. Angular CLI autocompletion
# ==========================================
# `ng completion script` boots Node + the Angular CLI (~1s). The output is
# static, so generate it once and cache it, regenerating only when @angular/cli
# changes on disk.
_ng_dump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/ng_completion.zsh"
if [ -d "$NVM_DIR/versions/node" ]; then
  mkdir -p "${_ng_dump:h}" 2>/dev/null
  _ng_src=("$NVM_DIR"/versions/node/*/lib/node_modules/@angular/cli/bin/ng.js(N))
  # Note: explicit braces — `A || B && C` would parse as `(A || B) && C`.
  if [ ! -s "$_ng_dump" ] || { [ -n "$_ng_src" ] && [ "$_ng_src[1]" -nt "$_ng_dump" ]; }; then
    "$NVM_DIR"/versions/node/*/bin/ng completion script >"$_ng_dump" 2>/dev/null
  fi
fi
[ -s "$_ng_dump" ] && source "$_ng_dump"
unset _ng_dump _ng_src
