# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
export PROMPT_DIRTRIM=2

if type vim >/dev/null 2>&1; then
  export EDITOR=vim
fi

if type less >/dev/null 2>&1; then
  export PAGER=less
fi
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls*:ll*:pwd*:cd*:cp*:sudo cp*:mv*:sudo mv*:rm*:sudo rm*"
export VERSION_CONTROL=t

if type brew >/dev/null 2>&1 && [ -d /usr/local/opt/coreutils/libexec ]; then
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

if [ -d /usr/local/share/git-core/contrib/diff-highlight ]; then
  export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
fi

export PATH=$PATH:$HOME/bin
