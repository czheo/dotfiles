"""""""""""""""""""""""""""""""""""""
" vundle configuration
"""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git' " set default git protocol from https to git

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle.git'

" My Bundles here:
"
" original repos on github
Bundle 'scrooloose/nerdtree.git'
Bundle 'rstacruz/sparkup.git', {'rtp': 'vim/'} 
Bundle 'tomtom/tcomment_vim.git'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wookiehangover/jshint.vim'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"""""""""""""""""""""""""""""""""""""
" basic vim configuration
"""""""""""""""""""""""""""""""""""""
syntax on
set nu
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set ai
set ruler
set encoding=utf-8
set backspace=2
colorscheme desert

" key bindings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn :tabnew<CR>

" show hidden characters
" set list
" set listchars=tab:▸\ ,eol:¬

" remember views
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

" set sparkup shortcut
let g:sparkupNextMapping = '<c-x>'
