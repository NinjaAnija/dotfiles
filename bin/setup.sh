#!/bin/bash

if ! type git >/dev/null 2>&1; then
  echo 'git is required for setup dotfiles'
  exit 1
fi

gitv=`git --version | cut -d' ' -f3`
gitmajorv=`echo $gitv | cut -d'.' -f1`
gitmajorv=`expr $gitmajorv + 1`
gitminorv=`echo $gitv | cut -d'.' -f2`
gitminorv=`expr $gitminorv + 1`

if [ $gitmajorv -le 2 ] || [ $gitminorv -le 7 ]; then
  printf "WARN git version(=%s) is old, it should be 2.7.0 or more\n" $gitv
fi

export VERSION_CONTROL=t

DOTFILES=(.Brewfile .bashrc .bash_profile .bash_logout .inputrc .gitconfig .tigrc .tmux.conf .vimrc .vim/ftdetect/filetype.vim)

mkdir -p $HOME/.vim/ftdetect

for file in ${DOTFILES[@]}
do
  dotfilesymlink=`readlink $HOME/$file`
  if [ -z $dotfilesymlink ] || [ $dotfilesymlink != "$HOME/.dotfiles/$file" ]; then
    ln -binsv $HOME/.dotfiles/$file $HOME/$file
  fi
done

if type dircolors >/dev/null 2>&1 && ! [ -d $HOME/.etc/dircolors-solarized ]; then
  git clone https://github.com/seebi/dircolors-solarized $HOME/.etc/dircolors-solarized
else
  echo '-- update dircolors-solarized'
  cd $HOME/.etc/dircolors-solarized && git pull  
fi

if [ -d $HOME/.etc/dircolors-solarized ] && ! [ -L $HOME/.dircolors ]; then
  ln -binsv $HOME/.etc/dircolors-solarized/dircolors.ansi-universal $HOME/.dircolors
fi

if ! [ -d $HOME/.anyenv ]; then
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
  git clone https://github.com/znz/anyenv-update $HOME/.anyenv/plugins/anyenv-update
  git clone https://github.com/znz/anyenv-git $HOME/.anyenv/plugins/anyenv-git
else
  echo '-- update anyenv'
  anyenv update
fi

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  echo '-- update tpm'
  cd $HOME/.tmux/plugins/tpm && git pull
fi

cd $HOME

echo ''
echo 'COMPLETE !!'
echo 'you should => source ~/.bash_profile'
echo '           => C-x C-r (apply .inputrc)'
echo '           => tmux source ~/.tmux.conf => (on tmux) C-b I'
echo ''

