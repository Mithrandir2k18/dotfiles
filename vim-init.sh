#!/bin/bash
echo "Requiring sudo powers for duration of this script(max. 15 minutes)"
sudo -v
echo "Installing vim and used plugins..."
echo "Assuming dotfiles repo is located in ~/dotfiles"

ln -s ~/dotfiles/.vimrc ~/.vimrc
sudo apt update 
sudo apt upgrade -y
sudo apt install vim cscope -y

echo "Cloning plungins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/vim-scripts/taglist.vim.git ~/.vim/bundle/taglist-vim
git clone https://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround 
git clone https://github.com/tpope/vim-repeat.git ~/.vim/bundle/vim-repeat 

