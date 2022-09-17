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

# PATH mapping
typeset -U path PATH

# kernel-space path
path=(
  # Priorities depends on the underlying machine architecture;
  # See also: https://zenn.dev/sprout2000/articles/bd1fac2f3f83bc;
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

# user-space path
path+=($HOME/.local/bin $path)
path+=($HOME/.cargo/bin $path)

# Shell plugin manager
eval "$(sheldon source)"

# PATH mapping
typeset -U fpath FPATH

if type brew &>/dev/null; then
  fpath+=~/.zfunc
  fpath+=$(brew --prefix)/share/zsh-completions:$fpath

  autoload -Uz compinit
  compinit
fi

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

# Language VM
. $(brew --prefix asdf)/libexec/asdf.sh

# GPG

# NOTE: Output of `echo $GPG_TTY` shouldn't be "not a tty"
# See also: https://thecesrom.dev/2021/01/27/troubleshooting-gpg-signed-commits-on-macos/;
export GPG_TTY=$TTY # or $(tty)
gpgconf --launch gpg-agent

# C++ global include path
export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH:+${CPLUS_INCLUDE_PATH}:}$(brew --prefix)/include/"