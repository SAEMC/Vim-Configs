#!/bin/bash

inputArg="$1"

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
      # Add NVIM into package
      sudo add-apt-repository -yu ppa:neovim-ppa/stable
      # Install NVIM
      sudo apt-get install -y neovim
      # Mkdir NVIM config directory
      mkdir -p $HOME/.config/nvim

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
      # Install NVIM 'termguicolors' version
      /bin/zsh -c "brew install neovim"
      # Install Ctags
      /bin/zsh -c "brew install universal-ctags"

      # Write History timestamp and Python alias into ~/.zshrc
      cat >>${HOME}/.zshrc <<EOF

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
  # Clear ~/.local/share directory
  if [[ -d ${HOME}/.local/share/nvim ]]; then
      sudo rm -r ${HOME}/.local/share/nvim
  fi

  # Check Ctags path
  ctags_path=$(which ctags)

  # Clone NVIM Plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Write Plugins into ~/.config/nvim/init.vim
  cat >${HOME}/.config/nvim/init.vim <<EOF
set nocompatible
filetype off
call plug#begin()
Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'blueyed/vim-diminactive'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
call plug#end()
EOF

  # Execute NVIM PlugInstall
  vim +PlugInstall +qall
}

function write_scripts() {
  # Write Config into ~/.config/nvim/init.vim
  cat >>${HOME}/.config/nvim/init.vim <<EOF

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
set completeopt=menuone,noinsert,noselect,preview
set cursorline
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
set tabstop=2

syntax on
colorscheme onedark

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g\`\"" |
\ endif
au BufEnter *
\ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
\ q | endif
au VimEnter *
\ :NERDTreeToggle |
\ wincmd p
augroup Folds
  au!
  au BufWinLeave * mkview
  au BufWinEnter * silent! loadview
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

let g:tagbar_ctags_bin = '$ctags_path'
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1

let s:left_line_enabled = 1
function! LeftLineToggle()
  if s:left_line_enabled
    call lsp#disable_diagnostics_for_buffer()
    :GitGutterBufferDisable
    let s:left_line_enabled = 0
  else
    call lsp#enable_diagnostics_for_buffer()
    :GitGutterBufferEnable
    let s:left_line_enabled = 1
  endif
:endfunction

nnoremap <silent> <Leader>b :NERDTreeToggle<CR>
nnoremap <silent> <Leader>d :bp <BAR> bd #<CR>
nnoremap <silent> <Leader>[ :bprevious!<CR>
nnoremap <silent> <Leader>] :bnext!<CR>
nnoremap <silent> <Leader>x :terminal<CR>
nnoremap <silent> <Leader>t :TagbarToggle<CR>
nnoremap <silent> <Leader>z <C-y>,<CR>
nnoremap <silent> <Leader>h :call LeftLineToggle()<CR>
nnoremap <silent> <Leader>l :set nonu<CR> \| :noh<CR> \| :set nolist<CR>
nnoremap <silent> <Leader>v "*p

vnoremap <silent> <Leader>c "*y

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : col('.') < col('$') ? "\<Right>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Left>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <expr> <C-d> col('.') < col('$') ? "\<C-o>x" : "\<Right>"
EOF
}

if [[ "$inputArg" == "-a" || "$inputArg" == "--all" ]]; then
  install_dependencies
  install_plugins
  write_scripts
elif [[ "$inputArg" == "-d" || "$inputArg" == "--dependencies" ]]; then
  install_dependencies
elif [[ "$inputArg" == "-p" || "$inputArg" == "--plugins" ]]; then
  install_plugins
elif [[ "$inputArg" == "-s" || "$inputArg" == "--scripts" ]]; then
  write_scripts
else
  echo "
The way you install SAEMC Vim Settings

Usage:  ./vim_settings.sh [OPTIONS]

Options:
  -a, --all            Install dependencies/plugins and Write ~/.config/nvim/init.vim
  -d, --dependencies   Install dependencies only
  -p, --plugins        Install plugins only
  -s, --scripts        Write ~/.config/nvim/init.vim only
  "
fi

exit 0
