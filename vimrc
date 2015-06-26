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

" highlight line column
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn

" tab key bindings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" show hidden characters
" set list
" set listchars=tab:▸\ ,eol:¬

" remember views
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

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
" Bundle 'wookiehangover/jshint.vim'
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
" vundle plugins
"""""""""""""""""""""""""""""""""""""

" file tree plugin
Bundle 'scrooloose/nerdtree.git'
nnoremap nt  :NERDTree<CR>

" fuzzy find 
Bundle 'kien/ctrlp.vim'

""""""""""""""""""""

" comment out plugin
Bundle 'tomtom/tcomment_vim.git'

""""""""""""""""""""

" syntax highlight
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

""""""""""""""""""""

" write html faster
Bundle 'rstacruz/sparkup.git', {'rtp': 'vim/'} 
" set sparkup shortcut
let g:sparkupNextMapping = '<c-x>'

""""""""""""""""""""

" syntax checker
" npm install -g jshint for javascript
Bundle 'scrooloose/syntastic'

""""""""""""""""""""
" code completion
" https://github.com/Valloric/YouCompleteMe
" Bundle 'Valloric/YouCompleteMe'
