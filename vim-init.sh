#!/bin/bash

echo "Installing vim and used plugins..."
echo "Assuming dotfiles repo is located in ~/dotfiles"

sudo -u $SUDO_USER "ln -s ~/dotfiles/.vimrc ~/.vimrc"


apt update && apt upgrade -y
apt install vim cscope

sudo -u $SUDO_USER "mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim"

sudo -u $SUDO_USER "git clone https://github.com/vim-scripts/taglist.vim ~/.vim/bundle/"
sudo -u $SUDO_USER "git clone https://github.com/tpope/vim-surround ~/.vim/bundle/"
sudo -u $SUDO_USER "git clone https://github.com/tpope/vim-repeat ~/.vim/bundle/"

