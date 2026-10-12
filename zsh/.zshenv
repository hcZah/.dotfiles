# Environment available to all zsh invocations (login, interactive, scripts).
# Keep the first occurrence of each PATH entry and drop duplicates, so nested
# shells (nvm exec, sudo, editors) don't grow PATH on every launch.
typeset -U path PATH
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
