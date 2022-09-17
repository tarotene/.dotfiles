# -- path

# sbin
export PATH="/usr/local/sbin:$PATH"

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# poetry and so on
export PATH="$HOME/.local/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# perl
export PATH="/Users/tarotene/perl5/bin:$PATH"
export PERL5LIB="/Users/tarotene/perl5/lib/perl5:$PERL5LIB"
export PERL_LOCAL_LIB_ROOT="/Users/tarotene/perl5:$PERL_LOCAL_LIB_ROOT"
export PERL_MB_OPT="--install_base \"/Users/tarotene/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/Users/tarotene/perl5"

# -- Identifications

# GPG
export GPG_TTY=$(tty)

# -- Language VMs
. /usr/local/opt/asdf/libexec/asdf.sh
