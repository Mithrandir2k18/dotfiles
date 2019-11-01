set nocompatible
set encoding=utf-8

execute pathogen#infect()

" Displays
set number
set relativenumber


" Spelling
set spelllang=en_gb
set spell
hi clear SpellBad
hi SpellBad cterm=underline
set autoindent
set smartindent
set wrap
set linebreak
set nolist " list disables linebreak. Then wraps happen on a character, not a word

" Searching
set ignorecase " set ignorecase ignores case when searching


" TODO colorscheme
syntax on " enable syntax processing
set tabstop=4 " visual amount of spaces per tab
set softtabstop=4 " amount of spaces actually inserted per tab
set expandtab " convert tab to spaces
set showcmd " show the last command entered
" set cursorline " highlight current line
filetype plugin indent on " activates filetype detection and loads specific indent files(e.g. /indent/python.vim
set wildmenu " visual autocomplete for command menu(cycle through filenames)
" set lazyredraw " can improve speed during macros
set showmatch " highlights corresponding bracket when hoverd over it
set incsearch " search matches during typing
set hlsearch " highlight matches
" TODO folding

" Custom mappings:
let mapleader=' '
imap jj <Esc>
" map to write as sudo. Use if you forgot to 'sudo vim' a protected file and
" you KNOW WHAT YOU ARE DOING
cmap w!! w !sudo tee > /dev/null %

"MOVEMENT
" these two mappings make vim scroll down/up into visual lines and not skip
" over wrapped lines
" nnoremap j gj
" nnoremap k gk


" CtrlP
let g:ctrlp_match_window='bottom,order:btt' " order matches bottom to top
let g:ctrlp_switch_buffer=0 " always open files in new buffer
let g:ctrlp_working_path=0 " ctrlp will respect path change

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<Leader>') " camelcasemotion default mappings. Use <Space>w to skip ahead one word in a camelCased variable

" vim-airline
" TODO finish customization
let g:airline_powerline_fonts=1
" let g:Powerline_symbols='unicode'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_detect_spelllang=0
let g:airline_detect_spell=0

