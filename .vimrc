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

    " Basic tools {{{
    call dein#add('Shougo/vimproc', {'build': 'make'})
    call dein#add('tpope/vim-repeat')
    call dein#add('mattn/webapi-vim')
    " }}}

    " Unite {{{
    call dein#add('Shougo/unite.vim', {
          \ 'depends': ['vimproc'],
          \ 'on_cmd': ['Unite'],
          \ 'lazy': 1})

    call dein#add('Shougo/neomru.vim', {'depdens': ['unite.vim']})
    call dein#add('tacroe/unite-mark', {'depdens': ['unite.vim']})
    call dein#add('tsukkee/unite-help', {'depdens': ['unite.vim']})
    call dein#add('thinca/vim-unite-history', {'depdens': ['unite.vim']})
    call dein#add('Shougo/neoyank.vim', {'depdens': ['unite.vim']})
    call dein#add('tsukkee/unite-tag', {'depdens': ['unite.vim']})
    call dein#add('Shougo/unite-outline', {'depdens': ['unite.vim']})
    " }}}

    " neocomplete {{{
    if has('lua')
      call dein#add('Shougo/neocomplete.vim', {
            \ 'on_i': 1,
            \ 'lazy': 1})
      call dein#add('ujihisa/neco-look', {
            \ 'depends': ['neocomplete.vim']})
    endif
    " }}}

    " neosnippet {{{
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets', {'depdens': ['neosnippet']})
    call dein#add('honza/vim-snippets', {'depdens': ['neosnippet']})
    " }}}

    " sass
    call dein#add('hail2u/vim-css3-syntax.git')

    " markdown {{{
    call dein#add('junegunn/vader.vim')
    call dein#add('godlygeek/tabular')
    call dein#add('joker1007/vim-markdown-quote-syntax')
    call dein#add('rcmdnk/vim-markdown')
    " }}}

    " syntax checking
    call dein#add('scrooloose/syntastic', {'depends': ['vimproc']})

    " diff {{{
    call dein#add('AndrewRadev/linediff.vim', {
          \ 'on_cmd': ['Linediff'],
          \ 'lazy': 1})
    call dein#add('rickhowe/diffchar.vim')
    call dein#add('chrisbra/vim-diff-enhanced')
    " }}}

    " file Explorer
    call dein#add('scrooloose/nerdtree', {
          \ 'on_cmd': ['NERDTreeToggle'],
          \ 'lazy': 1})

    " source Explorer
    call dein#add('wesleyche/SrcExpl', {
          \ 'on_cmd': ['SrcExplToggle'],
          \ 'lazy': 1})

    " tags
    call dein#add('majutsushi/tagbar', {
          \ 'on_cmd': ['TagbarToggle'],
          \ 'lazy': 1})
    call dein#add('soramugi/auto-ctags.vim')
    let g:auto_ctags = 1
    let g:auto_ctags_tags_name = '.tags'
    " let g:auto_ctags_directory_list = ['.git'] " この指定をするとtagsがうまくつくられない
    " let g:auto_ctags_tags_args = '--langmap=PHP:.php.inc.tpl --php-kinds=cfd' " ここでの指定が効かないので~/.ctagsを利用

    " git
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv', {
          \ 'depdens': ['tpope/vim-fugitive'],
          \ 'on_cmd': ['Gitv'],
          \ 'lazy': 1})

    " gist
    call dein#add('mattn/gist-vim', {
          \ 'depdens': ['mattn/webapi-vim'],
          \ 'on_cmd': ['Gist'],
          \ 'lazy': 1})

    " highlight
    call dein#add('t9md/vim-quickhl')

    " multiple-cursors
    call dein#add('terryma/vim-multiple-cursors')

    " easy to change surround
    call dein#add('tpope/vim-surround')

    " easymotion
    call dein#add('easymotion/vim-easymotion', {
          \ 'on_map': ['<Plug>(easymotion-sn)', '<Plug>(easymotion-bd-W)',
          \            '<Plug>(easymotion-bd-w)'],
          \ 'lazy': 1})

    " vim-ref
    call dein#add('thinca/vim-ref', {
          \ 'on_cmd': ['Ref'],
          \ 'lazy': 1})

    let s:vim_ref_library_dir = s:vim_dir . '/vim-ref-library'
    let g:ref_phpmanual_path = s:vim_ref_library_dir . '/php-chunked-xhtml'

    " grammer check
    call dein#add('rhysd/vim-grammarous', {
          \ 'on_cmd': ['GrammarousCheck'],
          \ 'lazy': 1})

    " google translate
    call dein#add('daisuzu/translategoogle.vim', {
          \ 'on_cmd': ['TranslateGoogle', 'TranslateGoogleCmd'],
          \ 'lazy': 1})

    " comment out support
    call dein#add('tomtom/tcomment_vim')

    " splitjoin
    call dein#add('AndrewRadev/splitjoin.vim')

    " vdebug
    call dein#add('joonty/vdebug')

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
set laststatus=2

:highlight zenkakuda ctermbg=7
:call matchadd("zenkakuda", '\%u3000')

nnoremap Y y$

let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
let g:sql_type_default = 'mysql'

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

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
\   'left': [ ['hostname'], ['mode', 'paste', ], ['readonly', 'modified', 'relativepath',] ],
\   'right': [ [ 'fileformat', 'fileencoding', 'lineinfo' ], ['fugitive'] ],
\ },
\ 'component_function': {
\   'hostname': 'LightLineHostName',
\   'fugitive': 'LightLineFugitive',
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

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

