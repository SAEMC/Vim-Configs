# SAEMC Vim Settings

### 사용 플러그인

- `Plug 'airblade/vim-gitgutter'`
- `Plug 'ap/vim-css-color'`
- `Plug 'blueyed/vim-diminactive'`
- `Plug 'jiangmiao/auto-pairs'`
- `Plug 'jistr/vim-nerdtree-tabs'`
- `Plug 'luochen1990/rainbow'`
- `Plug 'nathanaelkane/vim-indent-guides'`
- `Plug 'navarasu/onedark.nvim'`
- `Plug 'neoclide/coc.nvim', {'branch': 'release'}`
- `Plug 'ojroques/vim-oscyank', {'branch': 'main'}`
- `Plug 'preservim/nerdcommenter'`
- `Plug 'preservim/tagbar'`
- `Plug 'scrooloose/nerdtree'`
- `Plug 'tpope/vim-fugitive'`
- `Plug 'tpope/vim-surround'`
- `Plug 'vim-airline/vim-airline'`
- `Plug 'vim-airline/vim-airline-themes'`

> 옵션: `~/.vimrc` 파일에서 주석 해제 후 `PlugInstall` 실행

- `Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }`
- `Plug 'jpalardy/vim-slime', { 'for': 'python' }`

---

### 준비 사항

- `sudo` 및 `git` 설치
  > Mac은 XCode 및 Homebrew가 이미 설치되어 있는 환경

```bash
$ (sudo) apt-get update && \
  (sudo) apt-get install -y sudo git
```

- SAEMC Vim-Settings 프로젝트 다운로드 및 실행
  > `$ ./vim_settings.sh -a` -> Dependencies/Plugins 설치 후 Scripts 작성 (권장)
  > `$ ./vim_settings.sh -d` -> Dependencies만 설치
  > `$ ./vim_settings.sh -p` -> Plugins만 설치 (작성되어 있는 Scripts 제거됨)
  > `$ ./vim_settings.sh -s` -> Scripts만 작성

```bash
$ git clone https://github.com/SAEMC/Vim-Settings && \
  cd ./Vim-Settings
$ ./vim_settings.sh [OPTIONS]
```

- Dependencies 설치 활성화 (Plugins만 설치 및 Scripts만 작성은 제외)

```bash
$ source ~/.bashrc (Linux인 경우)
$ source ~/.zshrc (Mac인 경우)
```

---

### 사용 방법

#### 매핑된 커맨드는 `~/.vimrc` 파일 확인

#### 이외의 커맨드는 Vim 기본 커맨드 (Vim 기본 커맨드 참조)

<br/>

##### [Normal]

- `<Space>` + `c` + `c`: CoC Check
- `<Space>` + `c` + `d`: CoC go to Definition
- `<Space>` + `c` + `i`: CoC go to Implementation
- `<Space>` + `c` + `o`: CoC 토글 (CoC On/Off)
- `<Space>` + `c` + `r`: CoC go to Reference
- `<Space>` + `c` + `s`: CoC Signature
- `<Space>` + `c` + `t`: CoC go to Type Definition
- `<Space>` + `c` + [[`[` or `]`]]: CoC Diagnostics 이동
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
- `<Space>` + `q`: 윈도우 나가기 (Quit)
- `<Space>` + `r`: 윈도우 새로고침 (Refresh)
- `<Space>` + `s`: 터미널 수평 분할 (Split)
- `<Space>` + `t` + `o`: Tagbar 토글 (Tagbar On/Off)
- `<Space>` + `v`: 터미널 수직 분할 (Vertical Split)
- `<Space>` + `w`: 검색 결과 지우기 (Wipe off)
- `<Space>` + [[`[` or `]`]]: 윈도우 이동
- `<Space>` + `=`: 윈도우 크기 동일하게 조절 (Equal)
- `<F2>`: CoC Rename

##### [Visual]

- `<Space>` + `f`: 코드 폴딩 토글 (Fold)
- `<Space>` + `m`: 선택 부분 수정 (Modify)
- `<Space>` + `s`: 선택 부분 서라운드 (Surround)
- `<Space>` + `y`: 클립보드(Vim -> Xterm -> OS)로 복사 (Yank)
- `<Space>` + `<Space>`: 주석 토글

##### [Insert]

- `<Ctrl>` + `d`: 다음 글자 제거 (Delete)
- `<Ctrl>` + [[`h` or `j` or `k` or `l`]]: 커서 이동

##### [Terminal]

- `<Ctrl>` + `w` + [[`h` or `j` or `k` or `l`]]: 윈도우 이동

##### [NerdTree]

- `<Space>` + `e`: 윈도우 확장 토글 (Extend)
- `<Space>` + `r`: 윈도우 새로고침 (Refresh)
- `<Space>` + `s`: 윈도우 수평 분할 (Split)
- `<Space>` + `v`: 윈도우 수직 분할 (Vertical Split)
- `<Space>` + `<Enter>`: 현재 디렉터리 변경

##### [Vim-Slime & Vim-iPython] (옵션: `~/.vimrc` 파일에서 관련 내용 주석 해제)

- `<F4>` + `a`: Vim-iPython 전체 셀 실행 (All Cells)
- `<F4>` + `c`: Vim-iPython Plot 닫기 (Close)
- `<F4>` + [[`j` or `k`]]: Vim-iPython 셀 이동
- `<F4>` + `l`: Vim-iPython 셀 클리어
- `<F4>` + `n`: Vim-iPython 셀 실행 후 다음 셀 이동 (Next Cell)
- `<F4>` + `q`: Vim-iPython 종료 (Quit)
- `<F4>` + `r`: Vim-iPython 재실행 (Restart)
- `<F4>` + `s`: Vim-iPython 실행 (Start)
