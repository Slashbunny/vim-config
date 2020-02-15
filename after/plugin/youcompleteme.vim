au VimEnter * call s:customize_ycm_options()

function! s:customize_ycm_options()
    if exists('g:ycm_filetype_blacklist')
        let g:ycm_filetype_blacklist.ledger = 1
    endif
endfunction
