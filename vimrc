source ~/.dotfiles/vimrc.d/common

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
