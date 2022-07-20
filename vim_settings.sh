#!/bin/bash

function installDependencies() {
  check_localtime="ls /etc/localtime >/dev/null 2>&1"
  check_curl="curl --version >/dev/null 2>&1"
  check_neovim="nvim --version >/dev/null 2>&1"
  check_nvm="nvm --version >/dev/null 2>&1"
  check_node="node --version >/dev/null 2>&1"
  check_ctags="ctags --version >/dev/null 2>&1"
  check_pip3="pip3 --version >/dev/null 2>&1"
  check_neovim_alias="grep -w 'alias vim=\"nvim\"' ~/.bashrc >/dev/null 2>&1"

  # Check OS
  os_type=$(echo "${OSTYPE}")
  echo -e "\n *** Check OSTYPE *** \n"

  # If Ubuntu
  if [[ "$os_type" == "linux-gnu"* ]]; then
    echo -e "\n *** Ubuntu detected *** \n"

    sudo apt-get update

    # Check Local time
    eval "$check_localtime"
    if [[ "$?" -ne 0 ]]; then
      # Install TZdata non-interactive mode
      echo -e "\n *** Install TZdata non-interactive mode *** \n"
      export DEBIAN_FRONTEND=noninteractive

      sudo ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
      sudo apt-get install -y tzdata
      sudo dpkg-reconfigure --frontend noninteractive tzdata
    fi

    # Install Default software
    echo -e "\n *** Install Default software *** \n"
    sudo apt-get update
    sudo apt-get install -y software-properties-common

    # Check Curl
    eval "$check_curl"
    if [[ "$?" -ne 0 ]]; then
      # Install Curl
      echo -e "\n *** Install Curl *** \n"
      sudo apt-get install -y curl
    fi

    # Check Neo VIM
    eval "$check_neovim"
    if [[ "$?" -ne 0 ]]; then
      # Add Neo VIM into package
      echo -e "\n *** Add Neo VIM (Stable) into package *** \n"
      sudo add-apt-repository -yu ppa:neovim-ppa/stable

      # Install Neo VIM (Stable)
      echo -e "\n *** Install Neo VIM (Stable) *** \n"
      sudo apt-get install -y neovim
    fi

    # If cannot install neovim/stable => Install neovim/unstable
    if [[ "$?" -ne 0 ]]; then
      echo -e "\n *** Add Neo VIM (Unstable) into package *** \n"
      sudo add-apt-repository -yu ppa:neovim-ppa/unstable

      # Install Neo VIM (Unstable)
      echo -e "\n *** Install Neo VIM (Unstable) *** \n"
      sudo apt-get install -y neovim
    fi

    # Check Neo VIM alias
    eval "$check_neovim_alias"
    if [[ "$?" -ne 0 ]]; then
      # Write Neo VIM alias into ~/.bashrc
      echo -e "\n *** Write Neo VIM alias into ~/.bashrc *** \n"
      cat >>${HOME}/.bashrc <<EOF

# Neo VIM Alias
alias vi="nvim"
alias vim="nvim"
EOF
    fi

    # Check Node
    eval "$check_node"
    if [[ "$?" -ne 0 ]]; then

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
        # Install NVM manually
        echo -e "\n *** Install NVM manually *** \n"
        export NVM_DIR="$HOME/.nvm" && (
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"

        # Write NVM path into ~/.bashrc
        echo -e "\n *** Write NVM path into ~/.bashrc *** \n"
        cat >>${HOME}/.bashrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"
EOF
      fi

      # Install Node LTS
      echo -e "\n *** Install Node LTS *** \n"
      nvm install --lts
      nvm alias default lts/*
      nvm use lts/*
    fi

    # Check Ctags
    eval "$check_ctags"
    if [[ "$?" -ne 0 ]]; then
      # Install Ctags
      echo -e "\n *** Install Ctags *** \n"
      sudo apt-get update
      sudo apt-get install -y universal-ctags

      # If cannot install universal-ctags => Install exuberant-ctags
      if [[ "$?" -ne 0 ]]; then
        echo -e "\n *** Install exuberant-ctags *** \n"
        sudo apt-get install -y exuberant-ctags
      fi
    fi

    # Check Pip3
    eval "$check_pip3"
    if [[ "$?" -ne 0 ]]; then
      # Install Pip3
      echo -e "\n *** Install Pip3 *** \n"
      sudo apt-get install -y python3-pip
    fi
    
    # Install Black
    echo -e "\n *** Install Black *** \n"
    pip3 install black

    # Install Pynvim
    # python3 -m pip install --user --upgrade pynvim

  # If Mac
  elif [[ "$os_type" == "darwin"* ]]; then
    echo -e "\n *** Mac detected *** \n"

    # Check Homebrew
    brew_path=$(which brew)
    if [[ "$?" -ne 0 ]]; then
      echo "Mac should install Homebrew first!"
      exit 1
    fi

    # Set Homebrew path
    export PATH="$brew_path:$PATH"

    # Clear Homebrew core repo
    sudo rm -rf $(brew --rep homebrew/repo)
    /bin/zsh -c "brew update"

    # Check Neo VIM
    eval "$check_neovim"
    if [[ "$?" -ne 0 ]]; then
      # Install Neo VIM
      echo -e "\n *** Install Neo VIM *** \n"
      /bin/zsh -c "brew install neovim"

      # Write Locale and Neo VIM alias into ~/.zshrc
      echo -e "\n *** Write Locale and Neo VIM alias into ~/.zshrc *** \n"
      cat >>${HOME}/.zshrc <<EOF

# Change Locale to en_US.UTF-8
export LANG=en_US.UTF-8

# Neo VIM Alias
alias vi="nvim"
alias vim="nvim"
EOF
    fi

    # Check Ctags
    eval "$check_ctags"
    if [[ "$?" -ne 0 ]]; then
      # Install Ctags
      echo -e "\n *** Install Ctags *** \n"
      /bin/zsh -c "brew install universal-ctags"
    fi

    #Check Node
    eval "$check_node"
    if [[ "$?" -ne 0 ]]; then

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
        # Install NVM
        echo -e "\n *** Install NVM *** \n"
        /bin/zsh -c "brew install nvm"
        mkdir ${HOME}/.nvm

        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

        # Write NVM path into ~/.zshrc
        echo -e "\n *** Write NVM path into ~/.zshrc *** \n"
        cat >>${HOME}/.zshrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
EOF
      fi

      # Install Node LTS
      echo -e "\n *** Install Node LTS *** \n"
      nvm install --lts
      nvm alias default lts/*
      nvm use lts/*
    fi

    # Check Pip3
    eval "$check_pip3"
    if [[ "$?" -ne 0 ]]; then
      # Install Pip3
      echo -e "\n *** Install Pip3 *** \n"
      /bin/zsh -c "brew install python3"
    fi

    # Install Black
    echo -e "\n *** Install Black *** \n"
    pip3_path=${brew_path/%brew/pip3}
    # Set Pip3 path
    export PATH="$pip3_path:$PATH"
    pip3 install black

    # Install Pynvim
    # python3 -m pip install --user --upgrade pynvim

  # If not Ubuntu and Mac
  else
    echo "${os_type} not supports!"
    exit 1
  fi
}

function installPlugins() {
  # Check OS
  os_type=$(echo "${OSTYPE}")
  # If not Ubuntu and Mac
  if [[ "$os_type" != "linux-gnu"* && "$os_type" != "darwin"* ]]; then
    echo "${os_type} not supports!"
    exit 1
  fi

  # Clear ~/.local/share directory
  if [[ -d ${HOME}/.local/share/nvim ]]; then
    echo -e "\n *** Clear ~/.local/share directory *** \n"
    sudo rm -rf ${HOME}/.local/share/nvim
  fi

  # Clear ~/.config/nvim directory
  if [[ -d ${HOME}/.config/nvim ]]; then
    echo -e "\n *** Clear ~/.config/nvim directory *** \n"
    sudo rm -rf ${HOME}/.config/nvim
  fi
    mkdir -p ${HOME}/.config/nvim

  # Clear ~/.vimrc file
  if [[ -f ${HOME}/.vimrc ]]; then
    echo -e "\n *** Clear ~/.vimrc file *** \n"
    sudo rm ${HOME}/.vimrc
  fi

  # Clone Neo VIM Plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Write ~/.vimrc location into ~/.config/nvim/init.vim
  echo -e "\n *** Write ~/.vimrc location into ~/.config/nvim/init.vim *** \n"
  cat >${HOME}/.config/nvim/init.vim <<EOF
set runtimepath^=\$HOME/.vim runtimepath+=\$HOME/.vim/after
let &packpath=&runtimepath
source \$HOME/.vimrc
EOF

  # Write Plugins into ~/.vimrc
  echo -e "\n *** Write Plugins into ~/.vimrc *** \n"
  cat >${HOME}/.vimrc <<EOF
" [[ Init ]]
set nocompatible
filetype off

" [[ Plugs ]]
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'blueyed/vim-diminactive'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'navarasu/onedark.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
" Plug 'jpalardy/vim-slime', { 'for': 'python' }
call plug#end()
EOF

  # Execute Neo VIM PlugInstall
  echo -e "\n *** Execute Neo VIM PlugInstall *** \n"
  nvim +PlugInstall +qall
}

function writeScripts() {
  # Clear All lines after 'call plug#end()'
  last_line="call plug#end()"
  # Check OS
  os_type=$(echo "${OSTYPE}")
  # If Ubuntu
  if [[ "$os_type" == "linux-gnu"* ]]; then
    sed -i "/^${last_line}*/q" ${HOME}/.vimrc
    
    black_path=$(which black)
    if [[ "$?" -ne 0 ]]; then
      black_path="/usr/local/bin/black"
    fi 
  # If Mac
  elif [[ "$os_type" == "darwin"* ]]; then
    # Check Homebrew
    brew_path=$(which brew)
    if [[ "$?" -ne 0 ]]; then
      echo "Mac should install Homebrew first!"
      exit 1
    fi

    sed -i '' "/^${last_line}*/q" ${HOME}/.vimrc

    black_path=$(which black)
    if [[ "$?" -ne 0 ]]; then
      black_path=${brew_path/%brew/black}
    fi 
  # If not Ubuntu and Mac
  else
    echo "${os_type} not supports!"
    exit 1
  fi

  # Clear ~/.config/nvim/coc-settings.json
  if [[ -f ${HOME}/.config/nvim/coc-settings.json ]]; then
    echo -e "\n *** Clear ~/.config/nvim/coc-settings.json *** \n"
    sudo rm ${HOME}/.config/nvim/coc-settings.json
  fi

  # Check Ctags path
  ctags_path=$(which ctags)

  # Write Config into ~/.vimrc
  echo -e "\n *** Write Config into ~/.vimrc *** \n"
  cat >>${HOME}/.vimrc <<EOF

" [[ Native Options ]]
set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf8,cp949
set foldmethod=manual
set hidden
set hlsearch
set incsearch
set laststatus=2
set nobackup
set nowritebackup
set number relativenumber
set re=0
set ruler
set shiftwidth=2
set shortmess+=c
set showmatch
set signcolumn=number
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set splitright
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set tabstop=2
set updatetime=300

if (has("termguicolors"))
  set termguicolors
endif

let mapleader = ' '
let \$NVIM_TUI_ENABLE_TRUE_COLOR=1
let \$NVIM_TUI_ENABLE_CURSOR_SHAPE=1
colorscheme onedark
syntax on

" [[ Native Commands ]]
command! -nargs=* T split | resize 10 | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" [[ Auto Commands ]]
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g\`\"" |
\ endif
au CursorHold * 
\ silent call CocActionAsync('highlight')
au FileType * 
\ silent set formatoptions-=cro
au VimEnter,VimResume *
\ silent set guicursor=n-o-i-r-c-ci-cr-sm:ver1,v-ve:hor1
au VimLeave,VimSuspend *
\ silent set guicursor=a:block
augroup FoldView
  au!
  au BufWinLeave * mkview
  au BufWinEnter * silent! loadview
augroup END
augroup NerdTreeMap
  au!
  au FileType nerdtree nmap <buffer> <silent> <Leader>e A
  au FileType nerdtree nmap <buffer> <silent> <Leader>r R
  au FileType nerdtree nmap <buffer> <silent> <Leader>s i
  au FileType nerdtree nmap <buffer> <silent> <Leader>v s
  au FileType nerdtree nmap <buffer> <silent> <Leader><CR> C
augroup END

" [[ Plug Options ]]
let g:AutoPairsMapCh = 0
let g:AutoPairsMapCR = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:indent_guides_default_mapping = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:nerdtree_tabs_open_on_console_startup = 1
" [iTerm2] -> [Preferences] -> [General] -> [Selection]
" Check up 'Applications in terminal may access clipboard'
" [oscyank_max_length] -> ASCII == 1 / Non-ASCII == 3
let g:oscyank_max_length = 1000000
let g:oscyank_silent = v:true
let g:oscyank_term = 'tmux'
let g:rainbow_active = 1
" Execute [python3 -m pip install --user --upgrade pynvim]
" let g:slime_default_config = {
" \ 'socket_name': get(split(\$TMUX, ','), 0),
" \ 'target_pane': '{top-right}' }
" let g:slime_dont_ask_default = 1
" let g:slime_python_ipython = 1
" let g:slime_target = 'tmux'
let g:surround_no_mappings = 1
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin = '$ctags_path'
" Check https://github.com/neoclide/coc.nvim/wiki/Language-servers
" If need 'coc-clangd', 'coc-css', 'coc-emmet', 'coc-html' -> Add those
let g:coc_global_extensions = [
  \ 'coc-docker',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ 'coc-tsserver',
  \ 'coc-yaml'
  \ ]

" [[ Functions ]]
function! EnterSelect()
  if pumvisible() && complete_info()["selected"] == -1
      return "\<C-y>"
  elseif pumvisible()
      return coc#_select_confirm()
  else
      return "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
  endif
endfunction
function! FoldCode()
  if foldclosed('.') != -1
    silent execute 'normal gv zo'
  else
    silent execute 'normal gv zf'
  endif
endfunction
function! ShowSignature()
  if CocAction('hasProvider', 'hover')
    silent call CocActionAsync('doHover')
  else
    silent call feedkeys('K', 'in')
  endif
endfunction
function! SurroundCode()
  let msg = execute(':verbose vmap <Plug>VSurround')
  silent call eval(printf(matchstr(msg, '<SNR>.*0)')))
endfunction

" [[ Key Mappings ]]
nnoremap <silent> <Space> <Nop>
nnoremap <silent> cb <Nop>
nnoremap <silent> cc <Nop>
nnoremap <silent> ce <Nop>
nnoremap <silent> ch <Nop>
nnoremap <silent> cj <Nop>
nnoremap <silent> ck <Nop>
nnoremap <silent> cl <Nop>
nnoremap <silent> cw <Nop>
nnoremap <silent> <expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-j>"
nnoremap <silent> <expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-k>"
nnoremap <silent> <Leader>cc :<C-u>call CocAction('diagnosticInfo')<CR>
nnoremap <silent> <Leader>cd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <Leader>ci :<C-u>call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent> <Leader>co :<C-u>call CocAction('diagnosticToggle')<CR>
nnoremap <silent> <Leader>cr :<C-u>call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> <Leader>cs :<C-u>call ShowSignature()<CR>
nnoremap <silent> <Leader>ct :<C-u>call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent> <Leader>c[ :<C-u>call CocActionAsync('diagnosticPrevious')<CR>
nnoremap <silent> <Leader>c] :<C-u>call CocActionAsync('diagnosticNext')<CR>
nnoremap <silent> <Leader>ga :<C-u>Git add .<CR>
nnoremap <silent> <Leader>gb :<C-u>Git blame<CR>
nnoremap <silent> <Leader>gc :<C-u>Git commit<CR>
nnoremap <silent> <Leader>gd :<C-u>Git diff<CR>
nnoremap <silent> <Leader>gl :<C-u>Git log<CR>
nnoremap <silent> <Leader>go :<C-u>GitGutterBufferToggle<CR>
nnoremap <silent> <Leader>i :<C-u>w !diff % -<CR>
nnoremap <silent> <Leader>m ciw
nnoremap <silent> <Leader>no :<C-u>set number! relativenumber!<CR>
nnoremap <silent> <Leader>o :<C-u>NERDTreeTabsToggle<CR>
nnoremap <silent> <Leader>q :<C-u>bp <BAR> bd #<CR>
nnoremap <silent> <Leader>r :<C-u>w<CR> \| <C-u>:edit<CR>
nnoremap <silent> <Leader>s :<C-u>T<CR>i
nnoremap <silent> <Leader>to :<C-u>TagbarToggle<CR>
nnoremap <silent> <Leader>v :<C-u>VT<CR>i
nnoremap <silent> <Leader>w :<C-u>noh<CR>
nnoremap <silent> <Leader>[ :<C-u>bprevious!<CR>
nnoremap <silent> <Leader>] :<C-u>bnext!<CR>
nnoremap <silent> <Leader>= <C-w>=
nnoremap <silent> <F2> :<C-u>call CocActionAsync('rename')<CR>

" nnoremap <silent> <F4>a :<C-u>IPythonCellRun<CR>
" nnoremap <silent> <F4>c :<C-u>IPythonCellClose<CR>
" nnoremap <silent> <F4>j :<C-u>IPythonCellExecuteCellVerboseJump<CR>
" nnoremap <silent> <F4>n :<C-u>IPythonCellNextCell<CR>
" nnoremap <silent> <F4>p :<C-u>IPythonCellPrevCell<CR>
" nnoremap <silent> <F4>q :<C-u>SlimeSend1 exit<CR>
" nnoremap <silent> <F4>r :<C-u>IPythonCellRestart<CR>
" nnoremap <silent> <F4>s :<C-u>SlimeSend1 ipython --matplotlib<CR>
" nnoremap <silent> <F4>w :<C-u>IPythonCellClear<CR>

vnoremap <silent> c <Nop>
vnoremap <silent> cd <Nop>
vnoremap <silent> cp <Nop>
vnoremap <silent> cs <Nop>
vnoremap <silent> cx <Nop>
vnoremap <silent> <expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-j>"
vnoremap <silent> <expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-k>"
vnoremap <silent> <Leader><Leader> :<C-u>call nerdcommenter#Comment("x", "Toggle")<CR>
vnoremap <silent> <Leader>f :<C-u>call FoldCode()<CR>
vnoremap <silent> <Leader>m c
vnoremap <silent> <Leader>s :<C-u>call SurroundCode()<CR>
vnoremap <silent> <Leader>y :<C-u>OSCYank<CR>

inoremap <silent> <expr> <C-d> col('.') < col('$') ? "\<C-o>x" : "\<Right>"
inoremap <silent> <expr> <C-j> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1, 1)\<CR>" : "\<C-o>j"
inoremap <silent> <expr> <C-k> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0, 1)\<CR>" : "\<C-o>k"
inoremap <silent> <expr> <C-_> coc#refresh()
inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<Left>"
inoremap <silent> <expr> <CR> EnterSelect()
inoremap <silent> <expr> <TAB> pumvisible() ? "\<C-n>" : col('.') < col('$') ? "\<Right>" : "\<Tab>"
inoremap <silent> <C-h> <C-o>h
inoremap <silent> <C-l> <C-o>l

tnoremap <silent> <C-w>h <C-\><C-n><C-w>h
tnoremap <silent> <C-w>j <C-\><C-n><C-w>j
tnoremap <silent> <C-w>k <C-\><C-n><C-w>k
tnoremap <silent> <C-w>l <C-\><C-n><C-w>l
EOF

  # Write Config into ~/.config/nvim/coc-settings.json
  echo -e "\n *** Write Config into ~/.config/nvim/coc-settings.json *** \n"
  cat >${HOME}/.config/nvim/coc-settings.json <<EOF
{
  "coc.preferences.formatOnSaveFiletypes": ["*"],
  "coc.preferences.formatOnType": true,
  "coc.preferences.promptInput": false,
  "diagnostic.autoRefresh": true,
  "diagnostic.enableMessage": "jump",
  "diagnostic.errorSign": "E>",
  "diagnostic.floatConfig": { "maxWidth": 30, "winblend": 10 },
  "diagnostic.hintSign": "H>",
  "diagnostic.infoSign": "I>",
  "diagnostic.refreshOnInsertMode": true,
  "diagnostic.warningSign": "W>",
  "hover.floatConfig": { "winblend": 10 },
  "python.formatting.blackPath": "${black_path}",
  "python.formatting.provider": "black",
  "signature.floatConfig": { "maxWidth": 30, "winblend": 10 },
  "suggest.enablePreselect": false,
  "suggest.floatConfig": { "maxWidth": 30, "winblend": 10 },
  "suggest.noselect": true
}
EOF
}

usage_msg="Usage:  $(basename $0) [-a] [-d] [-p] [-s]"
option_msg="Options:
  -a   Install dependencies/plugins and Write ~/.vimrc
  -d   Install dependencies only
  -p   Install plugins only
  -s   Write ~/.vimrc only"
invalid_msg="Invalid command option."
args=""

if [[ -z "$1" ]]; then
  echo "Need to enter command option."
  echo "$usage_msg"
  exit 1
fi

while getopts ':adps :h' opt; do
  case "$opt" in
    a | d | p | s)
      args+="${opt}"
      ;;
    h)
      echo -e "The way you install SAEMC Vim Settings.\n"
      echo -e "${usage_msg}\n"
      echo -e "$option_msg"
      exit 0
      ;;
    ?)
      echo "$invalid_msg"
      echo "$usage_msg"
      exit 1
      ;;
  esac
done

args=$(echo $args | grep -o . | sort | uniq | tr -d "\n")

for (( i = 0; i < ${#args}; i++ )); do
  arg="${args:$i:1}"

  if [[ "$arg" == "a" ]]; then
    installDependencies
    installPlugins
    writeScripts
    exit 0
  elif [[ "$arg" == "d" ]]; then
    installDependencies
  elif [[ "$arg" == "p" ]]; then
    installPlugins
  elif [[ "$arg" == "s" ]]; then
    writeScripts
  else
    echo "$invalid_msg"
    echo "$usage_msg"
    exit 1
  fi
done

exit 0
