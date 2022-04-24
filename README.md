# SAEMC Vim Settings - Ver_2_0

### 사용 플러그인

- `Plugin 'VundleVim/Vundle.vim'`  
- `Plugin 'tpope/vim-fugitive'`  
- `Plugin 'git://git.wincent.com/command-t.git'`  
- `Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}`  
- `Plugin 'joshdick/onedark.vim'`  
- `Plugin 'vim-airline/vim-airline'`  
- `Plugin 'vim-airline/vim-airline-themes'`  
- `Plugin 'scrooloose/nerdtree'`  
- `Plugin 'nathanaelkane/vim-indent-guides'`  
- `Plugin 'preservim/nerdcommenter'`  
- `Plugin 'blueyed/vim-diminactive'`  

---

### 준비 사항

- Linux  
> MAC은 Git과 Vim 모두 설치되어 있음
```
$ (sudo) apt-get update && \
  (sudo) apt-get install -y git
```

- SAEMC Vim-Settings 프로젝트 다운로드 및 실행  
```
$ git clone https://github.com/SAEMC/Vim-Settings.git && \
  cd ./Vim-Settings && ./vim_settings.sh
```

---

### 사용 방법

#### [N: Normal] | [V: Visual] | [S: Select] | [O: Operator-pending]

- `Ctrl` + `b`: [N/V/S/O] NerdTree 토글 켜기/끄기  
- `Ctrl` + `[h][l]`: [N/V/S/O] 버퍼 윈도우 이동  
- `Ctrl` + `d`: [N/V/S/O] 버퍼 윈도우 닫기 / 터미널 닫기  
- `Ctrl` + `x`: [N/V/S/O] 터미널 수평 열기  
- `Ctrl` + `w` + `[h][j][k][l]`: [N/V/S/O] 분할 윈도우 이동  
- `Ctrl` + `/`: [V] 주석 달기  
- `s`: [NerdTree 윈도우] 윈도우 수직 분할  
- `i`: [NerdTree 윈도우] 윈도우 수평 분할  
- `r`: [NerdTree 윈도우] NerdTree 새로고침  
- `c`: [N/V/S/O] `set nu` / `/search` / `set list` 끄기  
- `:set paste`: [N] 붙여넣기 정렬  
- `Ctrl` + `w` + `Ctrl` + `w`: 터미널에서 가장 왼쪽 윈도우로 가기  

<br/>

