#!/bin/bash

ostype=$(echo "${OSTYPE}")
vim_check="/bin/bash -c 'vim --version >/dev/null 2>&1'"
sudo_check="/bin/bash -c 'sudo --version >/dev/null 2>&1'"

if [[ "$ostype" == "linux-gnu"* ]]; then
    eval "$vim_check"

    if [[ "$?" -eq 0 ]]; then
        echo "VIM has been installed in ${ostype}"
    else
        eval "$sudo_check"

        if [[ "$?" -eq 0 ]]; then
            sudo apt-get update
            sudo apt-get install -y vim
        else
            apt-get update
            apt-get install -y vim
        fi
    fi
elif [[ "$ostype" == "darwin"* ]]; then
    echo "VIM has been installed in ${ostype}"
else
    echo "${ostype} is not supported!"
    exit 1
fi

if [[ -d ${HOME}/.vim/bundle ]]; then
    eval "$sudo_check"
    
    if [[ "$?" -eq 0 ]]; then
        sudo rm -r ${HOME}/.vim/bundle
    else
        rm -r ${HOME}/.vim/bundle
    fi
fi

git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

cat >${HOME}/.vimrc <<EOF
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'preservim/nerdcommenter'
Plugin 'blueyed/vim-diminactive'
call vundle#end()
filetype plugin indent on
EOF

vim +PluginInstall +qall

cat >>${HOME}/.vimrc <<EOF

if (empty(\$TMUX))
  if (has("nvim"))
    let \$NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

set autoindent
set cindent
set smartindent

set hlsearch
set ignorecase
set smartcase
set incsearch
set showmatch

set ruler

set paste
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\\
set encoding=utf-8
set fileencodings=utf8,cp949

set splitbelow
set termwinsize=10x0

syntax on
set background=dark
colorscheme onedark

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g\`\"" |
\ endif
au bufenter *
\ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
\ q | endif
au VimEnter *
\ :NERDTreeToggle |
\ wincmd p

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

map <C-b> <ESC>:NERDTreeToggle<CR>
map <C-d> <ESC>:bp <BAR> bd #<CR>
map <C-c><Left> <ESC>:bprevious!<CR>
map <C-c><Right> <ESC>:bnext!<CR>
map <C-x> <ESC>:terminal<CR>
map c <ESC>:set nonu \| <ESC>:noh \| <ESC>:set nolist<CR> \| :<CR>
vmap <C-_> <Leader>c<space>
EOF

exit 0
