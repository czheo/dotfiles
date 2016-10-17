"""""""""""""""""""""""""""""""""""""
" basic vim configuration
"""""""""""""""""""""""""""""""""""""
syntax on
set nu
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set ai
set ruler
set encoding=utf-8
set backspace=2
colorscheme desert

" highlight line column
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" make binding
nnoremap <c-m>  :!make<CR>
nnoremap cd  :cd %:p:h<CR>
" tab key bindings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" show hidden characters
set list
set listchars=tab:▸\ ,eol:¬

" remember views
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

" change indent based on filetype
au FileType python setl sw=4 sts=4 et

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
nnoremap <silent> <c-n>  :NERDTreeToggle<CR>
" open nerdtree on start
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" fuzzy find 
Bundle 'ctrlpvim/ctrlp.vim'

""""""""""""""""""""

" comment out plugin
Bundle 'tomtom/tcomment_vim.git'

""""""""""""""""""""

" syntax highlight
" Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
Bundle 'digitaltoad/vim-jade'
Bundle 'vim-scripts/vim-coffee-script'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mxw/vim-jsx'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'rust-lang/rust.vim'
let g:vimrplugin_assign = 0
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

""""""""""""""""""""
Plugin 'fatih/vim-go'

""""""""""""""""""""
Plugin 'vim-latex/vim-latex'
Plugin 'vim-scripts/django.vim'

""""""""""""""""""""
" lisp interactive mode
Plugin 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

""""""""""""""""""""
Plugin 'vim-scripts/taglist.vim'

""""""""""""""""""""
Plugin 'vim-scripts/SyntaxRange'

Plugin 'shougo/vinarise.vim'
