"""""""""""""""""""""""""""""""""""""
" quick memos
"""""""""""""""""""""""""""""""""""""
" viw   = select a word (i = inner)
" vi"   = select in quotes
" va"   = select including quotes (a = all?)
" U     = upper case in visual mode
" :term = open terminal
" term scroll: <c-w> N
" swap window: <c-w> x/r
" prev window: <c-w> p

"""""""""""""""""""""""""""""""""""""
" basic vim configuration
"""""""""""""""""""""""""""""""""""""
syntax on
set encoding=utf-8
colorscheme desert

set number " show line number
set wrap   " wrap long lines
set ruler  " show cursor position at bottom

set tabstop=2 softtabstop=2 shiftwidth=2 backspace=2 expandtab
set shiftround            " fix tab smartly
set ai                    " auto indent

set incsearch             " incremental search
set hlsearch              " highlight search, :noh to unhighlight
set ignorecase smartcase  " search case-sensitive only if there's upper-case

set showmatch             " briefly move back to the matching (
set matchtime=3

set laststatus=2          " always show status line

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
" use , as leader key
let mapleader = ","

" move line downward
nnoremap - :move +1<CR>
nnoremap = :move -2<CR>

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

" term
nnoremap tr  :term<CR>
nnoremap vt  :vert term<CR>

" delete a line in insert mode
inoremap <c-d> <esc>ddO

" quote a selected block
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>

" execute a line in terminal
nnoremap tt  "ryy<c-w>p<c-w>"r<c-w>p
" copy selection to terminal
vnoremap tp "ry<c-w>p<c-w>"r
" execute selection in terminal
vnoremap tt "ry<c-w>p<c-w>"r<CR><c-w>p

" source vimrc
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" toggle line numbers
nnoremap <leader>nu  :set nu!<CR>

" toggle spell check
nnoremap <leader>sp :set spell!<cr>

" sum lines of numbers
vnoremap sum :s/\n/+/<cr>$xyyddi<c-r>=<c-r>0<bs><cr><esc>

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
" vim-plug configuration
"""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" file tree with ctrl n
Plug 'scrooloose/nerdtree'
nnoremap <silent> <c-n>  :NERDTreeToggle<CR>
nnoremap <silent> <c-m>  :NERDTreeFind<CR>

" fuzzy find with ctrl p
Plug 'ctrlpvim/ctrlp.vim'

" comment out plugin with ctrl -
Plug 'tomtom/tcomment_vim'

" write html faster
Plug 'rstacruz/sparkup'
" set sparkup shortcut
let g:sparkupNextMapping = '<c-x>'

" Interactive Coq Proofs in Vim
Plug 'whonore/Coqtail'
Plug 'let-def/vimbufsync'

" align text
" :Tab /=
Plug 'godlygeek/tabular'

" edit Table 
" \tm = toggle table mode
" :Tableize /, = make csv to table
Plug 'dhruvasagar/vim-table-mode'

" syntax checker
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
" ctrl-s
nnoremap <silent> <c-x> :SyntasticToggleMode<CR>

" binary editor
" :Vinarise binary.bin
" :VinariseDump object.obj
Plug 'shougo/vinarise.vim'
nnoremap <leader>bin  :Vinarise<CR>

" surround selection
" cs"'  Change Surround from " to '
" ds"   Delete Surround of "
" S     in visual mode
Plug 'tpope/vim-surround'

""""""""""""""""""""
" syntax highlight
""""""""""""""""""""
Plug 'elzr/vim-json'
" partial syntax highlight such as JS in HTML
Plug 'vim-scripts/SyntaxRange'

call plug#end()
