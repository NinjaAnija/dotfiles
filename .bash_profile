# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
case "$HOSTNAME" in
  *\-local*) ps1color=36;;
  *\-dev*)   ps1color=32;;
  *\-stg*)   ps1color=33;;
  *\-prd*)   ps1color=31;;
  *)         ps1color=37;;
esac

if type __git_ps1 >/dev/null 2>&1; then
  export PS1='\[\e[90m\][\u\[\e[${ps1color}m\]@\e[1m\h \[\e[0m\]\w \[\e[90m\]]\[\e[35m\]$(__git_ps1) \[\e[90m\]\$\[\e[0m\] '
else
  export PS1='\[\e[90m\][\u\[\e[${ps1color}m\]@\e[1m\h \[\e[0m\]\w \[\e[90m\]] \$\[\e[0m\] '
fi

if type vim >/dev/null 2>&1; then
  export EDITOR=vim
fi
if type vim >/dev/null 2>&1; then
  export PAGER=less
fi
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls*:ll*:pwd*:cd*:cp*:sudo cp*:mv*:sudo mv*:rm*:sudo rm*"
export VERSION_CONTROL=t

if type brew >/dev/null 2>&1 [ -d /usr/local/opt/coreutils/libexec ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

if [ -r ~/.dircolors ] && type dircolors >/dev/null 2>&1; then
  eval "$(dircolors ~/.dircolors)"
fi

if [ -x ~/.anyenv/bin/anyenv ] && type anyenv >/dev/null 2>&1; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

if [ -d ~/.gitdiffhighlight.d ]; then
  export PATH=$PATH:$HOME/.gitdiffhighlight.d
fi

export PATH=$PATH:$HOME/bin
