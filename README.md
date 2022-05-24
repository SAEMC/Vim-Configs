# SAEMC Vim Settings

### 사용 플러그인

- `Plug 'navarasu/onedark.nvim'`
- `Plug 'vim-airline/vim-airline'`
- `Plug 'vim-airline/vim-airline-themes'`
- `Plug 'tpope/vim-fugitive'`
- `Plug 'airblade/vim-gitgutter'`
- `Plug 'scrooloose/nerdtree'`
- `Plug 'preservim/nerdcommenter'`
- `Plug 'preservim/tagbar'`
- `Plug 'nathanaelkane/vim-indent-guides'`
- `Plug 'blueyed/vim-diminactive'`
- `Plug 'neoclide/coc.nvim', {'branch': 'release'}`
- `Plug 'ap/vim-css-color'`
- `Plug 'jiangmiao/auto-pairs'`
- `Plug 'tpope/vim-surround'`
- `Plug 'ojroques/vim-oscyank', {'branch': 'main'}`

---

### 준비 사항

- `sudo` 및 `git` 설치
  > Mac은 XCode/Homebrew가 이미 설치되어 있는 환경

```bash
$ (sudo) apt-get update && \
  (sudo) apt-get install -y sudo git
```

- SAEMC Vim-Settings 프로젝트 다운로드 및 실행
  > `$ ./vim_settings.sh -a` -> Dependencies/Plugins 설치 후 Scripts 작성  
  > `$ ./vim_settings.sh -d` -> Dependencies만 설치  
  > `$ ./vim_settings.sh -p` -> Plugins만 설치 (작성되어 있는 Scripts 제거됨)  
  > `$ ./vim_settings.sh -s` -> Scripts만 작성

```bash
$ git clone https://github.com/SAEMC/Vim-Settings && \
  cd ./Vim-Settings
$ ./vim_settings.sh [OPTIONS]
```

- Dependencies 설치 활성화 (Plugins만 설치 및 Scripts만 작성은 제외)
  > Linux인 경우

```bash
$ source ~/.bashrc
```

> Mac인 경우

```bash
$ source ~/.zshrc
```

---

### 사용 방법

#### [N: Normal] | [V: Visual] | [S: Select] | [O: Operator-pending] | [I: Insert]

#### 매핑된 커맨드는 `~/.vimrc` 파일 확인

#### 이외의 커맨드는 Vim 기본 커맨드 (Vim 기본 커맨드 참조)

<br>

##### [N]

- `\` + `b`: NerdTree 토글 (VSCode Tree Open)
- `\` + `d`: 버퍼 윈도우 닫기 (CLI `Ctrl` + `d`)
- `\` + `f`: 코드 폴딩 토글 (Fold)
- `\` + `h`: 터미널 수평 분할 (Horizontal)
- `\` + `l`: `/search` / `:set list` 결과 끄기 (CLI `Ctrl` + `l`)
- `\` + `n`: 라인 넘버링 토글
- `\` + `p`: CoC 검사 / GitGutter 플러그인 표시 토글 (Plugins)
- `\` + `t`: Tagbar 토글 (Tagbar)
- `\` + `v`: 터미널 수직 분할 (Vertical)
- `\` + `[` or `]`: 버퍼 윈도우 이동
- `c`: 커서 기준 단어 수정 (Change)

##### [V]

- `\` + `f`: 코드 폴딩 토글 (Fold)
- `Ctrl` + `c`: OS 클립보드로 복사 (`Cmd` + `c`)
- `Ctrl` + `/`: 주석 토글 (VSCode `Cmd` + `/`)
- `c`: 선택된 부분 수정 (Change)
- `s`: 선택된 부분 서라운드 (Surround)

##### [I]

- `Ctrl` + `h` or `j` or `k` or `l`: 커서 이동하기 (Vim moving)
- `Ctrl` + `d`: 커서 기준 다음 글자 지우기 (Delete)

##### [NerdTree 윈도우]

- `\` + `e`: 윈도우 확장 토글 (Extend)
- `\` + `h`: 윈도우 수평 분할 (Horizontal)
- `\` + `r`: 윈도우 새로고침 (Refresh)
- `\` + `v`: 윈도우 수직 분할 (Vertical)

<br/>
