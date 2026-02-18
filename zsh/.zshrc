export PATH=$PATH:/Users/jkunst/.local/bin
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export PEREC_DIR='~/.notes'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export PATH="/opt/homebrew/opt/llvm@18/bin:$PATH"

export XDG_CONFIG_HOME="${HOME}/.config"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# SDKMAN
if brew --prefix sdkman-cli &>/dev/null; then
  export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
  [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

nu

export PATH="${PATH}:/Users/jkunst/.azureauth/0.9.2"

# Added by Agency Claude Code installer
export PATH="/Users/jkunst/.claude-cli/currentVersion:$PATH"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
