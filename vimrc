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
autocmd FileType mojo setlocal tabstop=4 softtabstop=4 shiftwidth=4
set shiftround            " fix tab smartly
set ai                    " auto indent
set si                    " smart indent

set incsearch             " incremental search
set hlsearch              " highlight search, :noh to unhighlight
set ignorecase smartcase  " search case-sensitive only if there's upper-case

set showmatch             " briefly move back to the matching (
set matchtime=3

set laststatus=2          " always show status line
set shortmess-=S          " show the total number of matches

" customize statusline
set statusline=%f\ \|           " filename
set statusline+=\ %p%%          " current register
set statusline+=\ %{v:register} " current register

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

"""""""""""""""""""""""""""""""""""""
" key bindings
"""""""""""""""""""""""""""""""""""""
" use , as leader key
let mapleader = ";"

" de-highlight selection
nnoremap <leader><space> :noh<CR>

" move line downward
nnoremap - :move +1<CR>
nnoremap = :move -2<CR>

" make
nnoremap mk  :!make<CR>

" change directory
" nnoremap cd  :cd %:p:h<CR>

" tab
nnoremap tn  :tabnew<CR>
" go prev
tnoremap <c-h><c-h> <c-w>:tabprev<CR>
inoremap <c-h><c-h> <esc>:tabprev<CR>
nnoremap <c-h><c-h> :tabprev<CR>
" go next
tnoremap <c-l><c-l> <c-w>:tabnext<CR>
inoremap <c-l><c-l> <esc>:tabnext<CR>
nnoremap <c-l><c-l> :tabnext<CR>

" term
nnoremap <leader>t  :bel term<CR>
nnoremap <leader>vt :bel vert term<CR>
nnoremap <leader>nt :tab term<CR>

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
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" clean line number and hidden characters
nnoremap <leader>cl  :set nu! list!<CR>

" toggle spell check
nnoremap <leader>sp :set spell!<cr>

" sum lines of numbers
vnoremap sum :s/\n/+/<cr>$xyyddi<c-r>=<c-r>0<bs><cr><esc>

" goto file in new tab
nnoremap <silent> gf :let mycurf=expand("<cfile>")<cr>:execute("tabnew ".mycurf)<cr>

"""""""""""""""""""""""""""""""""""""
" vim-plug configuration
"""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" file tree with ctrl n
Plug 'scrooloose/nerdtree'
nnoremap <silent><c-n>  :NERDTreeFind<CR>
nnoremap <silent><c-n><c-n>  :NERDTreeToggle<CR>

" <leader><leader>w: go to word
" <leader><leader>f{char}: go to searched char
Plug 'easymotion/vim-easymotion'

" fuzzy find with ctrl p
Plug 'ctrlpvim/ctrlp.vim'

" automatically restoring file's cursor position and folding
Plug 'vim-scripts/restore_view.vim'

" comment out plugin with ctrl -
Plug 'tomtom/tcomment_vim'

" write html faster
Plug 'rstacruz/sparkup'

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

" cpp
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-Wall -std=c++11'
" python
" let g:syntastic_python_checkers = ['mypy']
" ctrl-s
nnoremap <silent> <c-x> :SyntasticToggleMode<CR>

" Language Server Protocol
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Rust
Plug 'rust-lang/rust.vim'

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

" cscope
Plug 'brookhong/cscope.vim'
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

Plug 'github/copilot.vim'

""""""""""""""""""""
" syntax highlight
""""""""""""""""""""
Plug 'elzr/vim-json'
" partial syntax highlight such as JS in HTML
Plug 'vim-scripts/SyntaxRange'

Plug 'idris-hackers/idris-vim'
Plug 'cespare/vim-toml'

Plug 'czheo/mojo.vim'

call plug#end()
