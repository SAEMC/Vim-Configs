# SAEMC's Vim-Configs (Will be deprecated soon...)

## 1. 사용 플러그인

- `Plug 'airblade/vim-gitgutter'`
- `Plug 'ap/vim-css-color'`
- `Plug 'blueyed/vim-diminactive'`
- `Plug 'jiangmiao/auto-pairs'`
- `Plug 'jistr/vim-nerdtree-tabs'`
- `Plug 'nathanaelkane/vim-indent-guides'`
- `Plug 'navarasu/onedark.nvim'`
- `Plug 'neoclide/coc.nvim', {'branch': 'release'}`
- `Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}`
- `Plug 'ojroques/vim-oscyank', {'branch': 'main'}`
- `Plug 'preservim/nerdcommenter'`
- `Plug 'preservim/tagbar'`
- `Plug 'p00f/nvim-ts-rainbow'`
- `Plug 'scrooloose/nerdtree'`
- `Plug 'tpope/vim-fugitive'`
- `Plug 'tpope/vim-surround'`
- `Plug 'vim-airline/vim-airline'`
- `Plug 'vim-airline/vim-airline-themes'`

<br/>

## 2. 준비 사항

### 2-1. (Ubuntu만 해당) `sudo` 및 `git` 설치

> 최초 설치인 경우에만 다음 명령어 실행

```bash
apt-get update && apt-get install -y sudo git
```

### 2-2. SAEMC's Vim-Configs 다운로드 및 실행

```bash
git clone https://github.com/SAEMC/Vim-Configs && \
cd ./Vim-Configs
```

> `$ ./vim_configs.sh -a` -> Dependencies & Plugins 설치 후 Scripts 작성 (권장)
>
> `$ ./vim_configs.sh -d` -> Dependencies만 설치
>
> `$ ./vim_configs.sh -p` -> Plugins만 설치 (작성되어 있는 Scripts 제거됨)
>
> `$ ./vim_configs.sh -s` -> Scripts만 작성

```bash
./vim_configs.sh [OPTIONS]
```

<br/>

## 3. 플러그인 동기화 및 설정 적용

### 3-1. 디펜던시 설치 활성화

- Ubuntu인 경우

```bash
source ~/.bashrc
```

- Mac인 경우

```bash
source ~/.zshrc
```

<br/>

## 4. 사용 방법

### 4-1. 변경된 커맨드

#### 4-1-1. 매핑된 커맨드는 `~/.vimrc` 파일 확인

#### 4-1-2. 이외의 커맨드는 Vim 기본 커맨드 ([Vim](https://github.com/vim/vim) 기본 커맨드 참조)

#### 4-1-3. [Normal]

- `<Space>` + `c` + `c`: CoC Check
- `<Space>` + `c` + `d`: CoC go to Definition
- `<Space>` + `c` + `i`: CoC go to Implementation
- `<Space>` + `c` + `o`: CoC 토글 (CoC On/Off)
- `<Space>` + `c` + `r`: CoC go to Reference
- `<Space>` + `c` + `s`: CoC Signature
- `<Space>` + `c` + `t`: CoC go to Type Definition
- `<Space>` + `c` + `[`/`]`: CoC Diagnostics 이동
- `<Space>` + `g` + `a`: Git Add
- `<Space>` + `g` + `b`: Git Blame
- `<Space>` + `g` + `c`: Git Commit
- `<Space>` + `g` + `d`: Git Diff
- `<Space>` + `g` + `l`: Git Log
- `<Space>` + `g` + `o`: GitGutter 토글 (GitGutter On/Off)
- `<Space>` + `i`: 현재 버퍼 변경 내용 검사 (Inspect)
- `<Space>` + `m`: 단어 수정 (Modify)
- `<Space>` + `n` + `o`: 넘버링 토글 (Numbering On/Off)
- `<Space>` + `o`: NerdTree 토글 (On/Off)
- `<Space>` + `q`: 윈도우 종료 (Quit)
- `<Space>` + `r`: 윈도우 새로고침 (Refresh)
- `<Space>` + `s`: 터미널 수평 분할 (Split)
- `<Space>` + `t` + `o`: Tagbar 토글 (Tagbar On/Off)
- `<Space>` + `v`: 터미널 수직 분할 (Vertical Split)
- `<Space>` + `w`: 검색 결과 지우기 (Wipe off)
- `<Space>` + `[`/`]`: 윈도우 이동
- `<Space>` + `=`: 윈도우 크기 동일하게 조절 (Equal)
- `<F2>`: CoC Rename

#### 4-1-4. [Visual]

- `<Space>` + `f`: 코드 폴딩 토글 (Fold)
- `<Space>` + `m`: 선택 부분 수정 (Modify)
- `<Space>` + `s`: 선택 부분 서라운드 (Surround)
- `<Space>` + `y`: 클립보드(Vim -> Xterm -> OS)로 복사 (Yank)
- `<Space>` + `<Space>`: 주석 토글

#### 4-1-5. [Insert]

- `<Ctrl>` + `d`: 다음 글자 제거 (Delete)
- `<Ctrl>` + `h`/`j`/`k`/`l`: 커서 이동

#### 4-1-6. [Terminal]

- `<Ctrl>` + `w` + `h`/`j`/`k`/`l`: 윈도우 이동

#### 4-1-7. [NerdTree]

- `<Space>` + `e`: 윈도우 확장 토글 (Extend)
- `<Space>` + `r`: 윈도우 새로고침 (Refresh)
- `<Space>` + `s`: 윈도우 수평 분할 (Split)
- `<Space>` + `v`: 윈도우 수직 분할 (Vertical Split)
- `<Space>` + `<Enter>`: 현재 디렉터리 변경
