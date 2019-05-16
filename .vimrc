if !1 | finish | endif " finish when tiny vim

if &compatible | set nocompatible | endif

" .vim dir {{{
let s:vim_dir = $HOME . "/.vim"
if has("vim_starting")
  if !isdirectory(s:vim_dir)
    call system("mkdir " . s:vim_dir)
  endif
endif
" }}}

" dein.vim {{{
let s:dein_enabled  = 0
let s:dein_work_with_vim = 704
if v:version >= s:dein_work_with_vim
  let s:dein_enabled = 1
  let s:dein_dir = s:vim_dir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = "Shougo/dein.vim"
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
  if !isdirectory(s:dein_repo_dir)
    let s:dein_repo = "https://github.com/" . s:dein_repo_name
    call system("git clone " . s:dein_repo . " " . s:dein_repo_dir)
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir

  " vim plugins {{{
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add('Shougo/dein.vim')

    " git
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv', {
          \ 'depdens': ['tpope/vim-fugitive'],
          \ 'on_cmd': ['Gitv'],
          \ 'lazy': 1})

    " highlight
    call dein#add('t9md/vim-quickhl')

    " lightline
    call dein#add('itchyny/lightline.vim')

    call dein#end()

    call dein#save_state()
  endif

  " }}}

  if dein#check_install()
    call dein#install()
  endif

endif
" }}} dein.vim

syntax on

set background=light

set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp-ms,euc-jp,latin1
set fileformats=unix,dos,mac

set backspace=indent,eol,start
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
"set nu
set ruler
set incsearch
set hlsearch
set ignorecase
set smartcase
set display=lastline
set wrap
set pumheight=13
set showmatch
set matchtime=1
set list
"set listchars=tab:»-,eol:↲
"set listchars=tab:▸-,eol:↲
set listchars=tab:￫\ ,eol:↲
set ttyfast
set lazyredraw

set showcmd

:highlight zenkakuda ctermbg=7
:call matchadd("zenkakuda", '\%u3000')

nnoremap Y y$

let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
let g:sql_type_default = 'mysql'

" statusline
set laststatus=2

"pure statusline
"set statusline=%r%m@%{hostname()}\ 
"set statusline+=%=
"set statusline+=[%{&fileformat}]
"set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"set statusline+=%<%F
"set statusline+=\ %l/%L:\ %c

"lightline.vim
let g:lightline = {
\ 'colorscheme': 'PaperColor',
\ 'active': {
\   'left': [ [ 'hostname' ], [ 'mode', 'paste', ], [ 'readonly', 'modified', 'relativepath', ] ],
\   'right': [ [ 'fileformat', 'fileencoding', 'lineinfo' ], [ 'gittopdir', 'gitstatus' ] ],
\ },
\ 'component_function': {
\   'hostname': 'LightLineHostName',
\   'gitstatus': 'LightLineGitStatus',
\   'gittopdir': 'LightLineGitTopDir',
\ }
\ }

let g:lightline.component = {
\ 'lineinfo': '%l/%L: %-v',
\ 'readonly': '%r',
\ 'modified': '%m',
\ }

function! LightLineHostName()
  return '@' . hostname()
endfunction

function! LightLineGitStatus()
  return exists('*fugitive#statusline') ? '(' . fugitive#head(7) . ')' : ''
endfunction

function! LightLineGitTopDir()
  if !exists('*fugitive#extract_git_dir')
    return ''
  endif
  let dirpath = fugitive#extract_git_dir(expand('%:p'))
  if strlen(dirpath) == 0
    return ''
  endif
  let dirparts = split(dirpath, '/')
  let gittopdir = remove(dirparts, len(dirparts)-2)
  return gittopdir
endfunction

hi default DbgCurrentLine term=reverse ctermfg=22 ctermbg=10 guifg=#005f00 guibg=#00ff00
hi default DbgCurrentSign term=reverse ctermfg=22 ctermbg=10 guifg=#005f00 guibg=#00ff00
hi default DbgBreakptLine term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi default DbgBreakptSign term=reverse ctermfg=22 ctermbg=10 guifg=#005f00 guibg=#00ff00

