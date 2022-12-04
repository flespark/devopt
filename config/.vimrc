" ban backspace for a better command edit habit
set nocompatible
set autoindent
set relativenumber number
syntax on
set showmatch
set ignorecase smartcase
set incsearch
colorscheme dracula
hi normal guibg=NONE ctermbg=NONE
hi endofbuffer guibg=NONE ctermbg=NONE
filetype plugin indent on
set cursorline
" show status line
set laststatus=2
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%)
" disable auto line feed
set nowrap
set hlsearch
set showmatch
" paste mode will obstruct auto-pairs, use shortkey
" set paste
" hide buffer when switch
set hidden
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
set tags=./.tags,.tags
" a faciler leader key
let mapleader = "\<space>"

set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevel=99

set undofile
set undodir=~/.vim/undo
set viminfo=%,<100,'10,/50,:100,h,f0,n~/.vim/.viminfo
" manually save/load view
" set viewoptions=folds,cursor,curdir
" manually save/load session
" set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
set directory=~/.vim/swap
set backup
set backupdir=~/.vim/backup

" get off arrow key
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>
noremap <left> <nop>

set ttimeout
set ttimeoutlen=300
nnoremap D "_d
inoremap jk <Esc>
inoremap kj <Esc>
" ban useless key prone to hit
noremap U <nop>
noremap K <nop>
" set undo breakpoint for unintentional C-w & C-u
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>
nnoremap <silent> <leader>p :set paste!<cr>
nnoremap <esc><esc> :nohlsearch<return><esc>

function Line_wrap_toggle()
    if &wrap
        setlocal nowrap
    else
        setlocal wrap
    endif
endfunction
nnoremap <leader>w :call Line_wrap_toggle()<cr>

function Mouse_select_toggle()
    if &signcolumn == "auto" || &signcolumn == "yes"
        set signcolumn=no
    else
        set signcolumn=auto
    endif
    if &number || &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
nnoremap <leader>t :call Mouse_select_toggle()<cr>

" clean trailing whitspace
nnoremap <silent> <F12> :let _s=@/ <bar> :%s/\s\+$//e <bar> :let @/=_s <bar> :nohl <bar> :unlet _s <cr>
inoremap jj <esc>
" not auto indent when comment
autocmd BufNewFile,BufReadPost * if &filetype == "python" | set indentkeys-=0# | endif
autocmd BufNewFile,BufReadPost * if &filetype == "yaml" | set expandtab shiftwidth=2 indentkeys-=0# | endif

" fzf-vim shortkey
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>

" ranger.vim
let g:ranger_map_keys = 0 " disable the default key mapping
let g:NERDTreeHijackNetrw = 0 " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
" open selected file in new tab
nnoremap <Leader>e :RangerNewTab<cr>

" air-line
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" ale
let g:ale_linters = {
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\   'sh': ['shellcheck'],
\   'python': ['pylint'],
\   'lua': ['luac'],
\}
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\}

let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_completion_delay = 200
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_set_highlights = 0
let g:ale_lint_on_insert_leave = 1
" TODO: add clangd toml config
let g:ale_c_clangd_options = '--query-driver=/usr/bin/*gcc --clang-tidy --completion-style=bundled --suggest-missing-includes'
let g:ale_cpp_clangd_options = '--query-driver=/usr/bin/*g++ --clang-tidy --completion-style=bundled --suggest-missing-includes'
let g:ale_c_parse_makefile = 1
let g:airline#extensions#ale#enabled = 1
" navigate between errors quickly, idk why noremap doesn't work
nmap <Leader>j <Plug>(ale_next_wrap)
nmap <Leader>k <Plug>(ale_previous_wrap)
nnoremap <Leader>d :ALEGoToDefinition<cr>
" autofix shortkey
nnoremap <Leader>f :ALECodeAction<cr>
nnoremap <Leader>r :ALEFindReferences<cr>
nnoremap <Leader>s :ALESymbolSearch<space>
nnoremap <Leader><Leader> :ALEHover<cr>

" Put these lines at the very end of your vimrc file.
"
" packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
