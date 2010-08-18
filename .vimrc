" Load all bundles (~/.vim/bundles) using Pathogen
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Do not run in Vi compatability mode
set nocompatible
source $VIMRUNTIME/vimrc_example.vim

" Only load Windows stuff if running from within Windows
if has("win32")
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" Function to run PHP_CodeSniffer
function! RunPhpcs()
    let l:filename=@%

    if has("unix")
        let l:phpcs_output=system('phpcs --report=csv --standard=Zend '.l:filename)
    elseif has("win32")
        let l:phpcs_output=system('c:\\gitrepos\\vendor_libs\\PEAR\\phpcs.bat --report=csv -n --standard=LoVullo '.l:filename)
    endif

    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
endfunction

set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m
command! Phpcs execute RunPhpcs()<CR>:copen

filetype plugin on

" General Options
"let g:zenburn_high_Contrast = 1
"colorscheme zenburn
colorscheme molokai
set guioptions=aegimrLtb
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
set number
set wildmenu
set pastetoggle=<F11>
set wmh=0

" Tab/Space Options
set expandtab
set shiftwidth=4
set showtabline=2
set softtabstop=4
set tabpagemax=50
set tabstop=4

" Print Special Whitespace Characters
set list
set list listchars=tab:»·,trail:·

" Backup Settings
set backupdir=.\\_backup,.,C:\\tmp
set directory=.,.\\_backup,C:\\tmp
set nobackup
set nowritebackup

" Spelling Options
setlocal spell spelllang=en_us
set spell

" Fold Options
set foldmethod=indent
set foldcolumn=2
set foldlevel=99

" PHP Syntax Options
"let php_sql_query=1
"let php_htmlInStrings=1
"let php_baselib=1
let php_asp_tags=0
let php_parent_error_close=1
let php_parent_error_open=1
"let php_oldStyle=1
let php_noShortTags=1
let php_folding=0
let php_sync_method=-1
let php_special_functions=0
let php_alt_comparisons=1
let php_alt_assignByReference=1

" Omnicomplete for PHP
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Always use SQLAnywhere syntax for sql files
let b:sql_type_override = "sqlanywhere"
let g:sql_type_default  = "sqlanywhere"

" Debugger Options
let g:debuggerPort        = 9000
let g:debuggerMaxChildren = 128
let g:debuggerMaxData     = 2048
let g:debuggerMaxDepth    = 12

" Right Trim Non-Whitespace Lines on save
autocmd BufWrite * :silent! :%s:\(\S\+\)\s\+$:\1:g

" Replace Tabs with Spaces on save
autocmd BufWrite * :retab

" Keyboard Shortcuts
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Micro$soft Word Documents
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!

if has("unix")
    autocmd BufReadPost *.doc %!antiword "%"
elseif has("win32")
    autocmd BufReadPost *.doc %!C:\antiword\ANTIWORD.EXE "%"
endif

" Taglist Plugin
"let Tlist_Ctags_Cmd = 'c:\WINDOWS\ctags.exe'
"let Tlist_Use_Right_Window = 1
"let Tlist_File_Fold_Auto_Close = 1
"let Tlist_Inc_Winwidth = 1
"let tlist_php_settings = 'php;c:classes;d:constants;f:functions'
"nnoremap <silent> <C-C> :TlistToggle<CR>

" PHP Documenter Plugin
inoremap <C-P> <ESC>:call PhpDoc()<CR>i
nnoremap <C-P> :call PhpDoc()<CR>
vnoremap <C-P> :call PhpDoc()<CR>

" delimitMate Options
let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1

" Command-T Binding
if has("unix")
    nmap <silent> <Leader>t :CommandT<CR>
elseif has("win32")
    " Always set the root to projects directory when at work
    nmap <silent> <Leader>t :CommandT C:\gitrepos\<CR>
endif

