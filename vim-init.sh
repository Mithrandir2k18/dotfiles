#!/bin/bash
echo "Requiring sudo powers for duration of this script(max. 15 minutes)"
sudo -v
echo "Installing vim and used plugins..."
echo "Assuming dotfiles repo is located in ~/dotfiles"

ln -s ~/dotfiles/.vimrc ~/.vimrc
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get install git curl vim ctags fonts-powerline -y

# TODO add powerline font dependency

echo "Installing pathogen..."
if [ ! -d "$HOME/.vim/autoload" ] ; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

./vim-load-plugins.sh

