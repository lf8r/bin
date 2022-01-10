#!/bin/bash
set -e

#Save copies of .profile, .bashrc and .bash_profile, if these files exist.
if [ -f "$HOME/.profile" ]; then
   mv ~/.profile ~/profile 
fi

if [ -f "$HOME/.bashrc" ]; then
   mv ~/.bashrc ~/bashrc
fi

if [ -f "$HOME/.bash_profile" ]; then
   mv ~/.bash_profile ~/bash_profile
fi

cat .profile >> ~/.profile
cp .gitconfig ~/.
cat .bashrc >> ~/.bashrc
cat .bash_profile >> ~/.bash_profile
mkdir -p ~/go/src
mkdir -p ~/go/pkg/mod
mkdir -p ~/go/bin
mkdir -p ~/.local
cp -R `pwd`/protoc-3 ~/.local
export PATH=$PATH:~/.local/protoc-3/bin

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/git-auto-complete.bash
chmod +x ~/git-auto-complete.bash

