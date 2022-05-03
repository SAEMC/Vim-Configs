#!/bin/bash

ostype=$(echo "${OSTYPE}")
vim_check="/bin/bash -c 'vim --version >/dev/null 2>&1'"
sudo_check="/bin/bash -c 'sudo --version >/dev/null 2>&1'"
nvm_check="nvm --version >/dev/null 2>&1"
node_check="node --version >/dev/null 2>&1"

if [[ "$ostype" == "linux-gnu"* ]]; then
    eval "$vim_check"
    if [[ "$?" -eq 0 ]]; then
        echo "VIM has been installed in ${ostype}"
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y ppa:jonathonf/vim
        sudo apt-get update && sudo apt-get install -y vim
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

    eval "$nvm_check"
    if [[ "$?" -ne 0 ]]; then
        sudo git clone https://github.com/creationix/nvm.git /opt/nvm
        sudo mkdir /usr/local/nvm

        export NVM_DIR=/usr/local/nvm
        source /opt/nvm/nvm.sh

        cat >>${HOME}/.bashrc <<EOF

# NVM
export NVM_DIR=/usr/local/nvm
source /opt/nvm/nvm.sh
EOF

        file_name="/etc/profile.d/nvm.sh"
        if [[ ! -f "$file_name" ]]; then
            echo "#!/bin/bash" | sudo tee -a $file_name >/dev/null
            echo "VERSION=\`cat /usr/local/nvm/alias/default\`" | sudo tee -a $file_name >/dev/null
            echo "export PATH=\"/usr/local/nvm/versions/node/v\$VERSION/bin:\$PATH\"" | sudo tee -a $file_name >/dev/null
            sudo chmod +x $file_name 
        fi
    fi

    eval "$node_check"
    if [[ "$?" -ne 0 ]]; then
        (su - $USER -c 'export NVM_DIR=/usr/local/nvm && source /opt/nvm/nvm.sh && \
            nvm install --lts')
            # sudo nvm install --lts && sudo nvm alias default lts/* && sudo nvm use lts/*')
    fi

    sudo apt-get update && sudo apt-get install -y python3-venv universal-ctags

cat >>${HOME}/.bashrc <<EOF

# Python Alias
alias python=python3
EOF

elif [[ "$ostype" == "darwin"* ]]; then
    echo "VIM has been installed in ${ostype}"
    echo "But, Reinstall VIM into /opt/local/bin"
    echo "${USER} ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers >/dev/null
    sudo mkdir -p /opt/local/bin
    git clone https://github.com/vim/vim.git
    (cd ./vim; ./configure --prefix=/opt/local; make; sudo make install; cd ..)

    /bin/zsh -c "brew install universal-ctags"

    cat >>${HOME}/.zshrc <<EOF

# VIM PATH
export PATH="/opt/local/bin:\$PATH"

# History Timestamp Alias
alias history="history -i 0"

# Python Alias
alias python="python3"
EOF

    eval "$nvm_check"
    if [[ "$?" -ne 0 ]]; then
        /bin/zsh -c "brew install nvm"
        mkdir ${HOME}/.nvm

        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

        cat >>${HOME}/.zshrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
EOF
    fi

    eval "$node_check"
    if [[ "$?" -ne 0 ]]; then
        nvm install --lts
        nvm alias default lts/*
        nvm use lts/*
    fi
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

ctags_path=$(which ctags)

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
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'ap/vim-css-color'
Plugin 'preservim/tagbar'
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

set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set complete=.,i
set completeopt=menuone,noinsert
set encoding=utf-8
set expandtab
set fileencodings=utf8,cp949
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set re=0
set ruler
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set tabstop=4
set termwinsize=10x0

syntax on
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

let g:tagbar_ctags_bin='$ctags_path'
let g:tagbar_autoclose=0
let g:tagbar_autofocus=1

map <Leader>b <ESC>:NERDTreeToggle<CR>
map <Leader>d <ESC>:bp <BAR> bd #<CR>
map <Leader>[ <ESC>:bprevious!<CR>
map <Leader>] <ESC>:bnext!<CR>
map <Leader>x <ESC>:terminal<CR>
map <Leader>t <ESC>:TagbarToggle<CR>
map c <ESC>:set nonu<CR> \| <ESC>:noh<CR> \| <ESC>:set nolist<CR>

imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
EOF

exit 0
