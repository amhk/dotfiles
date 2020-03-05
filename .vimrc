set nocompatible

set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set kp=man\ -P\ less

set visualbell
set ruler
set wildmenu
set background=dark

set autoread
set modeline
set enc=utf-8
set fenc=utf-8

" no double spaces when formatting lines with gq
set nojoinspaces

" filetype based stuff
autocmd VimEnter * :syntax on
let c_space_errors = 1

filetype plugin indent on

" key mappings
let mapleader = "\<space>"
noremap <silent> <c-n> :noh<cr>:match<cr>:cclose<cr>
nnoremap <bs> <c-^>
noremap ' `
nnoremap Q @q
vnoremap Y "+y
noremap <silent> <S-Insert> <MiddleMouse>
inoremap <silent> <S-Insert> <MiddleMouse>
nnoremap <c-j> :set spell!<cr>

command Q quit
command W write

" miscellaneous
au FileType gitcommit set spell

set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

au BufRead,BufNewFile *.aidl set filetype=java

function GitBlame()
	let l:path = expand('%')
	let l:line = line('.')
	let l:output = system("git blame --line-porcelain -L" . l:line . ",+1 " . l:path)
	let l:commit = split(l:output)[0]
	exec "!git show " . l:commit
endfunction
nnoremap gb :call GitBlame()<cr>

function! GitShow()
    let l:commitish = expand("<cword>")
	exec "!git show --stat -p " . l:commitish
endfunction
nnoremap gc :call GitShow()<cr>

set notitle

" cfile
set errorfile=/tmp/cfile
nnoremap <f1> :cfile /tmp/cfile<cr>
nnoremap <f2> :keepjumps :cnext<cr>
nnoremap <f3> :keepjumps :cprev<cr>
nnoremap <f4> :keepjumps :cc<cr>

" format according to Android
set ts=4
set sw=4
set path+=include
set expandtab
set cinoptions=


nnoremap å :tag <c-r>=expand("<cword>")<cr><cr>
autocmd FileType c    nnoremap ö :ClangFormat<cr>
autocmd FileType c    vnoremap ö :ClangFormat<cr>
autocmd FileType cpp  nnoremap ö :ClangFormat<cr>
autocmd FileType cpp  vnoremap ö :ClangFormat<cr>
autocmd FileType rust nnoremap ö :RustFmt<cr>

if executable('rls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'rls',
		\ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
		\ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
		\ 'whitelist': ['rust'],
		\ })
endif

" FZF
set rtp+=~/.fzf
noremap § :FZF<cr>
