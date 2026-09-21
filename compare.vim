if exists('g:loaded_spf13_compare')
    finish
endif
let g:loaded_spf13_compare = 1

function! s:ChooseFile(title, directory) abort
    if has('gui_running') && has('browse')
        return browse(0, a:title, a:directory, '')
    endif
    return input(a:title . ': ', a:directory . '/', 'file')
endfunction

function! Spf13CompareOpen(left, right) abort
    let l:left = fnamemodify(a:left, ':p')
    let l:right = fnamemodify(a:right, ':p')

    if !filereadable(l:left) || !filereadable(l:right)
        echoerr 'Compare: both paths must be readable files'
        return
    endif
    if resolve(l:left) ==# resolve(l:right)
        echoerr 'Compare: select two different files'
        return
    endif

    execute 'tabnew ' . fnameescape(l:left)
    execute 'rightbelow vertical diffsplit ' . fnameescape(l:right)
    let t:spf13_compare = 1
    windo setlocal nowrap
    silent! normal! ]c
    wincmd h
    silent! normal! ]c
endfunction

function! s:SelectTwoFiles() abort
    let l:left = s:ChooseFile('Select left file', getcwd())
    if empty(l:left)
        return
    endif

    let l:right = s:ChooseFile('Select right file', fnamemodify(l:left, ':h'))
    if empty(l:right)
        return
    endif
    call Spf13CompareOpen(l:left, l:right)
endfunction

function! s:CompareCurrentWith() abort
    let l:left = expand('%:p')
    if empty(l:left) || !filereadable(l:left)
        echoerr 'Compare: the current buffer is not a readable file'
        return
    endif

    let l:right = s:ChooseFile('Compare current file with', fnamemodify(l:left, ':h'))
    if !empty(l:right)
        call Spf13CompareOpen(l:left, l:right)
    endif
endfunction

function! s:CloseComparison() abort
    if !get(t:, 'spf13_compare', 0)
        echoerr 'Compare: this tab is not a comparison'
        return
    endif
    diffoff!
    tabclose
endfunction

function! s:CompareCommand(files) abort
    if len(a:files) != 2
        echoerr 'CompareOpen: expected exactly two files'
        return
    endif
    call Spf13CompareOpen(a:files[0], a:files[1])
endfunction

command! CompareFiles call <SID>SelectTwoFiles()
command! CompareWith call <SID>CompareCurrentWith()
command! -nargs=+ -complete=file CompareOpen call <SID>CompareCommand([<f-args>])
command! CompareClose call <SID>CloseComparison()

nnoremap <silent> <leader>dc :CompareFiles<CR>
nnoremap <silent> <leader>dw :CompareWith<CR>

if has('gui_running') && has('menu')
    set guioptions+=m
    silent! aunmenu Compare
    anoremenu 10.10 &Compare.Select\ Two\ Files\.\.\. :CompareFiles<CR>
    anoremenu 10.20 &Compare.Compare\ Current\ With\.\.\. :CompareWith<CR>
    anoremenu 10.30 &Compare.-Differences- <Nop>
    anoremenu 10.40 &Compare.Next\ Difference ]c
    anoremenu 10.50 &Compare.Previous\ Difference [c
    anoremenu 10.60 &Compare.Close\ Comparison :CompareClose<CR>
endif