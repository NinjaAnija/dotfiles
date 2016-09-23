# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
set -o vi
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# shopt
shopt -s autocd
shopt -s extglob
shopt -s globstar
shopt -s cdspell

# User specific aliases and functions
alias ..='cd ..'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color'
alias df='df -h'
alias free='free -h'

if type vim >/dev/null 2>&1; then
  alias vi='vim'
fi

# git
alias g='git'
alias gd='git diff'
alias gs='git status'
alias gl='git log -p'

# when tig is available
if type tig >/dev/null 2>&1; then
  alias gs='tig status'
  alias gl='tig log -p'
fi

mkdir -p "$HOME/.bash_completion.d"
[ -d /usr/local/etc/bash_completion.d/ ] && cp /usr/local/etc/bash_completion.d/* "$HOME/.bash_completion.d"
while read line
do
  source "$line"
done < <(find "$HOME/.bash_completion.d/" -type f)

if type __git_complete >/dev/null 2>&1; then
  _g ()
  {
    __git_wrap__git_main
  }
  __git_complete g __git_main
fi

# re-overwrite PS1 (overwritten with /etc/bashrc)
case "$HOSTNAME" in
  *\-local*) ps1color=36;;
  *\dev-*)   ps1color=32;;
  *\stg-*)   ps1color=33;;
#  *\prd-*)   ps1color=31;;
  *)         ps1color=37;;
esac

if type __git_ps1 >/dev/null 2>&1; then
  export PS1='\[\e[90m\][\u\[\e[${ps1color}m\]@\[\e[1m\]\h \[\e[0m\]\w \[\e[90m\]]\[\e[35m\]$(__git_ps1) \[\e[90m\]\$\[\e[0m\] '
else
  export PS1='\[\e[90m\][\u\[\e[${ps1color}m\]@\[\e[1m\]\h \[\e[0m\]\w \[\e[90m\]] \$\[\e[0m\] '
fi

