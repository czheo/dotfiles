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

" support ctags
" ctags -R .
" ctrl ]
set autochdir
set tags=./tags,tags;$HOME

" highlight line column
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" show hidden characters
set list
set listchars=tab:▸\ ,eol:¬

" remember views
augroup RememberView
  au BufWritePost,BufLeave,WinLeave ?* mkview
  au BufWinEnter ?* silent loadview
augroup END

" change indent based on filetype
" au FileType python setl sw=4 sts=4 et

"""""""""""""""""""""""""""""""""""""
" key binding
"""""""""""""""""""""""""""""""""""""
" make
nnoremap mk  :!make<CR>

" change directory
nnoremap cd  :cd %:p:h<CR>

" tab
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" toggle line numbers
nnoremap nu  :set invnumber<CR>

"""""""""""""""""""""""""""""""""""""
" vundle configuration
"""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

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
nnoremap <silent> <c-m>  :NERDTreeFind<CR>
" open nerdtree on start
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

" fuzzy find with ctrl p
Bundle 'ctrlpvim/ctrlp.vim'

""""""""""""""""""""

" comment out plugin with ctrl -
Bundle 'tomtom/tcomment_vim.git'

""""""""""""""""""""
" open shell in vim
" shortcut: \sh
Bundle 'jewes/Conque-Shell'
nnoremap <leader>sh :ConqueTerm bash<CR>

""""""""""""""""""""
" syntax highlight
" Bundle 'kchmck/vim-coffee-script'
Plugin 'tomlion/vim-solidity'
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
Plugin 'fatih/vim-go'
Plugin 'vim-scripts/django.vim'
Plugin 'posva/vim-vue'
" Plugin 'vim-latex/vim-latex'

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
" lisp interactive mode
Plugin 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

""""""""""""""""""""
nnoremap <silent> tag  :TlistToggle<CR>
Plugin 'vim-scripts/taglist.vim'

""""""""""""""""""""
" partial syntax highlight such as JS in HTML
""""""""""""""""""""
Plugin 'vim-scripts/SyntaxRange'

""""""""""""""""""""
" binary editor
" :Vinarise binary.bin
" :VinariseDump object.obj
""""""""""""""""""""
Plugin 'shougo/vinarise.vim'


""""""""""""""""""""
" auto close () "" and etc.
""""""""""""""""""""
" Plugin 'vim-scripts/AutoClose'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
