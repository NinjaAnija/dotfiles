# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

# shopt
shopt -s autocd
shopt -s extglob
shopt -s globstar
shopt -s cdspell

# User specific aliases and functions
alias ..='cd ..'
alias ls='ls --color=auto'
alias ll='ls -la'
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

if [ -r ~/.gitcompletion.d/git-prompt.sh ]; then
  . ~/.gitcompletion.d/git-prompt.sh
fi

if [ -r ~/.gitcompletion.d/git-completion.bash ]; then
  . ~/.gitcompletion.d/git-completion.bash
fi

if type __git_complete >/dev/null 2>&1; then
  _g ()
  {
    __git_wrap__git_main
  }
  __git_complete g __git_main
fi

if [ -r ~/.hubcompletion.d/hub.bash_completion.sh ]; then
  . ~/.hubcompletion.d/hub.bash_completion.sh
fi

