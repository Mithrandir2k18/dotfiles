#!/bin/bash

function git_clone_if_missing {
    if [ ! -d "$HOME/.vim/bundle/$2" ] ; then
            git clone "https://github.com/$1/$2.git" "$HOME/.vim/bundle/$2"
    fi
}

echo "Loading plugins..."

git_clone_if_missing vim-scripts taglist.vim
git_clone_if_missing tpope vim-surround
git_clone_if_missing tpope vim-repeat
git_clone_if_missing bkad CamelCaseMotion
git_clone_if_missing vim-airline vim-airline

