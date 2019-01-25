"""""""""""""""""""""""""""""""""""""
" quick memos
"""""""""""""""""""""""""""""""""""""
" viw = select a word
" U = upper case in visual mode

"""""""""""""""""""""""""""""""""""""
" basic vim configuration
"""""""""""""""""""""""""""""""""""""
syntax on
set encoding=utf-8
colorscheme desert

set number " show line number
set wrap " wrap long lines
set ruler " show cursor position at bottom

set tabstop=2 softtabstop=2 shiftwidth=2 backspace=2 expandtab
set shiftround " fix tab smartly
set ai " auto indent

set incsearch " incremental search
set hlsearch " highlight search, :noh to unhighlight
set ignorecase smartcase " search case-sensitive only if there's upper-case

set showmatch " briefly move back to the matching (
set matchtime=3

set laststatus=2 " always show status line

" support ctags
" ctags -R .
" ctrl ]
" set autochdir " change dir when open a file
set tags=./tags,tags;$HOME " search tags file

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
" key bindings
"""""""""""""""""""""""""""""""""""""
" move line downward
nnoremap - ddp
nnoremap = ddkkp

" make
nnoremap mk  :!make<CR>

" change directory
" nnoremap cd  :cd %:p:h<CR>

" tab
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" delete a line in insert mode
inoremap <c-d> <esc>ddi

" quote a selected block
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>

" source vimrc
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" toggle line numbers
nnoremap <leader>nu  :set nu!<CR>

" toggle spell check
nnoremap <leader>sp :set spell!<cr>

" BundleInstall/BundleClean
nnoremap <leader>bi :BundleInstall<cr>
nnoremap <leader>bc :BundleClean<cr>

"""""""""""""""""""""""""""""""""""""
" cscope helper
" reference: http://cscope.sourceforge.net/cscope_maps.vim
"""""""""""""""""""""""""""""""""""""
if has("cscope")
  """"""""""""" Standard cscope/vim boilerplate
  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0

  " add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif

  " show msg when any other cscope db added
  set cscopeverbose

  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nnoremap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
  nnoremap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
  nnoremap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

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
nnoremap <leader>sh :ConqueTerm bash<CR><ESC>:set nocursorline nolist<CR>a

""""""""""""""""""""
" syntax highlight
" Bundle 'kchmck/vim-coffee-script'
Plugin 'tomlion/vim-solidity'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
Bundle 'digitaltoad/vim-jade'
Bundle 'vim-scripts/vim-coffee-script'
Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
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
Bundle 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

""""""""""""""""""""
" code completion
" https://github.com/Valloric/YouCompleteMe
" Bundle 'Valloric/YouCompleteMe'

""""""""""""""""""""
" lisp interactive mode
""""""""""""""""""""
Plugin 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

""""""""""""""""""""
" list tags 
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
nnoremap <leader>bin  :Vinarise<CR>

""""""""""""""""""""
" auto close () "" and etc.
""""""""""""""""""""
" Plugin 'vim-scripts/AutoClose'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
