# ==========================================
# 1. Environment & PATH (Preserved from Bash)
# ==========================================
# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Input filter
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
# 4. Aliases (Preserved from Bash)
# ==========================================
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ==========================================
# 5. Prompt & Git Integration (Transient)
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
