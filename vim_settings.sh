#!/bin/bash

target="$1"

function install_dependencies() {
  check_curl="curl --version >/dev/null 2>&1"
  check_nvm="nvm --version >/dev/null 2>&1"
  check_node="node --version >/dev/null 2>&1"

  # Check OS
  # If Ubuntu
  ostype=$(echo "${OSTYPE}")
  if [[ "$ostype" == "linux-gnu"* ]]; then
      # Install Default software
      sudo apt-get install -y software-properties-common
      # Add VIM into package
      sudo apt-add-repository -y ppa:jonathonf/vim
      # Install VIM
      sudo apt-get update
      sudo apt-get install -y vim

      # Check Curl
      eval "$check_curl"
      if [[ "$?" -ne 0 ]]; then
          # Install Curl
          sudo apt-get install -y curl
      fi

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
          # Install NVM manually
          export NVM_DIR="$HOME/.nvm" && (
          git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
          cd "$NVM_DIR"
          git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
          ) && \. "$NVM_DIR/nvm.sh"

          # Write NVM path into ~/.bashrc
          cat >>${HOME}/.bashrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"
EOF
      fi

      # Check Node
      eval "$check_node"
      if [[ "$?" -ne 0 ]]; then
          # Install Node LTS
          nvm install --lts
          nvm alias default lts/*
          nvm use lts/*
      fi

      # Install Python and Ctags
      # If cannot install pyls-all in VIM => Enter ':LspInstallServer pyls-ms' in VIM
      sudo apt-get update
      sudo apt-get install -y python3-venv python3-pip
      sudo apt-get install -y universal-ctags

      # If cannot install universal-ctags => Install exuberant-ctags
      if [[ "$?" -ne 0 ]]; then
          sudo apt-get install -y exuberant-ctags
      fi

  # Write Python alias into ~/.bashrc
  cat >>${HOME}/.bashrc <<EOF

# Python Alias
alias python=python3
EOF

  # If Mac
  elif [[ "$ostype" == "darwin"* ]]; then
      # Add current user into SUDO
      echo "${USER} ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers >/dev/null
      # Install VIM 'termguicolors' version
      sudo mkdir -p /opt/local/bin
      git clone https://github.com/vim/vim.git
      (cd ./vim; ./configure --prefix=/opt/local; make; sudo make install; cd ..)

      # Install Ctags
      /bin/zsh -c "brew install universal-ctags"

      # Write VIM path and History timestamp and Python alias into ~/.zshrc
      cat >>${HOME}/.zshrc <<EOF

# VIM PATH
export PATH="/opt/local/bin:\$PATH"

# History Timestamp Alias
alias history="history -i 0"

# Python Alias
alias python="python3"
EOF

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
          # Install NVM
          /bin/zsh -c "brew install nvm"
          mkdir ${HOME}/.nvm

          export NVM_DIR="$HOME/.nvm"
          [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
          [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

          # Write NVM path into ~/.zshrc
          cat >>${HOME}/.zshrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
EOF
      fi

      # Check Node
      eval "$check_node"
      if [[ "$?" -ne 0 ]]; then
          # Install Node LTS
          nvm install --lts
          nvm alias default lts/*
          nvm use lts/*
      fi

  # If not Ubuntu and Mac
  else
      echo "${ostype} is not supported!"
      exit 1
  fi
}

function install_plugins() {
  # Clear ~/.vim/bundle directory
  if [[ -d ${HOME}/.vim/bundle ]]; then
      sudo rm -r ${HOME}/.vim/bundle
  fi

  # Check Ctags path
  ctags_path=$(which ctags)

  # Clone VIM Vundle
  git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

  # Write Plugins into ~/.vimrc
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
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
call vundle#end()
filetype plugin indent on
EOF

  # Execute VIM PluginInstall
  vim +PluginInstall +qall

  # Write Config into ~/.vimrc
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
set complete+=k
set completeopt=menuone,noinsert
set encoding=utf-8
set expandtab
set fileencodings=utf8,cp949
set foldmethod=manual
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set re=0
set ruler
set shiftwidth=2
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\\
set tabstop=2
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
augroup Folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

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
map <Leader>h <ESC><C-y>,<CR>
map c <ESC>:set nonu<CR> \| <ESC>:noh<CR> \| <ESC>:set nolist<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"
inoremap " ""<left>
inoremap ' ''<left>
inoremap < <><left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O
EOF
}

if [[ "$target" == "" ]]; then
  install_dependencies
  install_plugins
elif [[ "$target" == "-d" ]]; then
  install_dependencies
elif [[ "$target" == "-p" ]]; then
  install_plugins
else
  echo "Nothing to install"
fi

exit 0
