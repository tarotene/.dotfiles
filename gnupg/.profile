# See also: https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b;

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# Add the following to your shell init to set up gpg-agent automatically for every shell
if [ -f "$HOME"/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source "$HOME"/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval "$(gpg-agent --daemon --write-env-file $HOME/.gnupg/.gpg-agent-info)"
fi
