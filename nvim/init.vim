" Neovim configuration migrated from spf13-vim.
" This file intentionally contains only built-in Neovim/Vim features.

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set shell=/bin/bash

let mapleader = ','
let maplocalleader = '_'

filetype plugin indent on
syntax enable
set background=dark
silent! colorscheme gruvbox

set mouse=a
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
endif

set number
set showmode
set showcmd
set ruler
set cursorline
set laststatus=2
set hidden
set history=1000
set shortmess+=filmnrxoOtT
set scrolloff=3
set scrolljump=8
set virtualedit=onemore
set backspace=indent,eol,start
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set showmatch
set nospell
set nowrap
set lazyredraw
set splitright
set splitbelow
set tabpagemax=15
set wfh
set wfw

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set nojoinspaces
set foldmethod=syntax
set foldlevel=3
set foldenable
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set colorcolumn=80
set completeopt=menu,menuone,noselect

set nobackup
set nowritebackup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
    let &undodir = stdpath('state') . '/undo'
    call mkdir(&undodir, 'p')
endif

if executable('ctags')
    set tags=./tags;,tags
endif

" Restore the last position except for commit messages.
if !get(g:, 'spf13_no_restore_cursor', 0)
    augroup nvim_restore_cursor
        autocmd!
        autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute 'normal! g`"' | endif
    augroup END
endif

function! StripTrailingWhitespace() abort
    let l:view = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:view)
endfunction

augroup nvim_defaults
    autocmd!
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql if !get(g:, 'spf13_keep_trailing_whitespace', 0) | autocmd BufWritePre <buffer> call StripTrailingWhitespace() | endif
    autocmd BufNewFile,BufRead *.html.twig setfiletype html.twig
    autocmd BufNewFile,BufRead *.coffee setfiletype coffee
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType haskell,rust setlocal nospell
    autocmd FileType gitcommit autocmd BufEnter <buffer> call setpos('.', [0, 1, 1, 0])
    autocmd FileType c autocmd BufEnter <buffer> setlocal omnifunc=ccomplete#Complete
    autocmd FileType qf nnoremap <silent><buffer> <CR> <CR>
augroup END

" Window and tab navigation.
noremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <S-H> gT
nnoremap <S-L> gt
nnoremap <C-X> <C-W>

" Keep wrapped-line movement and common spf13-vim motions.
noremap j gj
noremap k gk
nnoremap Y y$
set whichwrap=b,s,h,l,<,>,[,]

" Correct common command typos.
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
cmap Tabe tabe

" Search, editing and layout helpers.
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <leader>q gwip
nnoremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
nnoremap <leader>ew :edit %%<CR>
nnoremap <leader>es :split %%<CR>
nnoremap <leader>ev :vsplit %%<CR>
nnoremap <leader>et :tabedit %<CR>
noremap <leader>= <C-W>=
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
vnoremap < <gv
vnoremap > >gv
vnoremap . :normal .<CR>
cnoremap w!! w !sudo tee % >/dev/null
nnoremap <F12> :set invpaste<CR>

" Quickfix navigation.
nnoremap <leader>c1 :cnext<CR>
nnoremap <leader>c2 :cprevious<CR>
nnoremap <leader>c3 :cnew<CR>
nnoremap <leader>c4 :colder<CR>
nnoremap <leader>c5 :botright copen<CR>
nnoremap <leader>c6 :cclose<CR>

" Built-in file browser settings.
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
nnoremap <C-E> :Explore<CR>

" Buffer helpers.
command! BcloseOthers call s:BufCloseOthers()
function! s:BufCloseOthers() abort
    let l:current = bufnr('%')
    for l:buf in range(1, bufnr('$'))
        if buflisted(l:buf) && l:buf != l:current
            execute 'bdelete! ' . l:buf
        endif
    endfor
endfunction
nnoremap <leader>b1 :bnext<CR>
nnoremap <leader>b2 :bprevious<CR>
nnoremap <leader>b6 :bdelete<CR>
nnoremap <leader>bq :bdelete!<CR>
nnoremap <leader>b7 :BcloseOthers<CR>

" Clipboard and current-path helpers.
function! CopyCurrentPath(kind) abort
    let l:value = a:kind ==# 'name' ? expand('%:t') : a:kind ==# 'relative' ? expand('%') : expand('%:p')
    let @+ = l:value
    let @" = l:value
    echo l:value
endfunction
nnoremap <leader>yf :call CopyCurrentPath('name')<CR>
nnoremap <leader>yp :call CopyCurrentPath('path')<CR>
nnoremap <leader>yr :call CopyCurrentPath('relative')<CR>

" Formatting helpers.
nnoremap <leader>f1 :set equalprg=<CR>
nnoremap <leader>f2 :set equalprg=astyle\ --style=java\ --style=attach\ -A2\ -s4\ -m3\ -k1\ -p\ -j\ -H\ -U\ -S\ -c\ -w\ -Y\ -xg\ -xe\ -xy\ -L\ -xC120\ --mode=c<CR>
nnoremap <leader>f3 :%s/\n\{2,\}/\r\r/<CR>
nnoremap <leader>jt :%!python3 -m json.tool<CR>:setfiletype json<CR>

" Use the Neovim config with the old config-editing habit.
nnoremap <leader>ii :edit ~/.config/nvim/init.vim<CR>

" Native cscope support, when Neovim was built with it and a database exists.
if has('cscope') && executable('cscope')
    set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-,a-
    set csto=1
    set cst
    if filereadable('cscope.out')
        silent! cs add cscope.out
    elseif !empty($CSCOPE_DB) && filereadable($CSCOPE_DB)
        silent! cs add $CSCOPE_DB
    endif
endif

" Keep the local preference from .vimrc.before.local.
let g:spf13_no_restore_cursor = 1
