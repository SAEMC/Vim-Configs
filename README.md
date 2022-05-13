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

---

### 준비 사항

- Linux  
> MAC은 XCode/Homebrew가 이미 설치되어 있는 환경  
```
$ (sudo) apt-get update && \
  (sudo) apt-get install -y sudo git
```

- SAEMC Vim-Settings 프로젝트 다운로드 및 실행  
> `$ ./vim_settings.sh -a` -> Dependencies/Plugins 설치 후 Scripts 작성  
> `$ ./vim_settings.sh -d` -> Dependencies만 설치  
> `$ ./vim_settings.sh -p` -> Plugins만 설치  
> `$ ./vim_settings.sh -s` -> Scripts만 작성  
```
$ git clone https://github.com/SAEMC/Vim-Settings.git && \
  cd ./Vim-Settings
$ ./vim_settings.sh [OPTIONS]
```

---

### 사용 방법 (대부분 Vim 기본 커맨드 유지)

#### [N: Normal] | [V: Visual] | [S: Select] | [O: Operator-pending] | [I: Insert]
#### 이외의 커맨드는 Vim 기본 커맨드

##### [N]

- `\` + `b`: NerdTree 토글 켜기/끄기  
- `\` + `d`: 버퍼 윈도우 닫기 (CLI out)  
- `\` + `[` or `]`: 버퍼 윈도우 이동  
- `\` + `t`: Tagbar 토글 켜기/끄기  
- `\` + `l`: `set nu` / `/search` / `set list` 끄기 (CLI clear)  
- `\` + `v`: OS 클립보드로 붙여넣기 (`Cmd` + `v`)  

##### [V]

- `\` + `c`: OS 클립보드로 복사 (`Cmd` + `c`)  
- `z` + `f` or `o`: 코드 접기/열기 (Fold/Open)  

##### [I]

- `Ctrl` + `h` or `j` or `k` or `l`: 커서 이동하기 (Vim moving)  
- `Ctrl` + `d`: 커서 기준 다음 글자 지우기 (Delete)  

##### [Extra]

- `s`: [NerdTree 윈도우] 윈도우 수직 분할  
- `i`: [NerdTree 윈도우] 윈도우 수평 분할  
- `r`: [NerdTree 윈도우] NerdTree 새로고침    

<br/>
