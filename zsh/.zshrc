# -- Powerlevel10k settings (first of all)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -- User scripts below

# Shell plugin manager
eval "$(sheldon source)"

# Rust (may change in future)
source "/Users/tarotene/.asdf/installs/rust/1.63.0/env"

# Auto completion
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# ghq bind
# see: https://zenn.dev/obregonia1/articles/e82868e8f66793
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^ghq' peco-src