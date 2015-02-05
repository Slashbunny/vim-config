" Load all bundles (~/.vim/bundles) using Pathogen
filetype off
execute pathogen#infect()

" Do not run in Vi compatibility mode
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" 50 lines of command line history
set history=50

" Show cursor position all the time
set ruler

" Display incomplete commands at bottom of screen
set showcmd

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

    augroup END
else
    " always set autoindenting on
    set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

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

" General Options
"let g:zenburn_high_Contrast = 1
"colorscheme zenburn
"colorscheme molokai
colorscheme desert256
set t_Co=256
syntax on
set guioptions=aegimrLtb

if ( has( "win32" ) )
    "set guifont=Droid_Sans_Mono_Slashed:h8:cANSI
    set guifont=Source_Code_Pro_Semibold:h9:cANSI
else
    set guifont=Source\ Code\ Pro\ Bold\ 12
endif

set number
set wildmenu
set pastetoggle=<F11>
set wmh=0
set incsearch
set hlsearch

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
set nospell

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
"inoremap <C-P> <ESC>:call PhpDoc()<CR>i
"nnoremap <C-P> :call PhpDoc()<CR>
"vnoremap <C-P> :call PhpDoc()<CR>

" delimitMate Options
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_balance_matchpairs = 1

" Command-T Binding
if has("unix")
    nmap <silent> <Leader>t :CommandT<CR>
elseif has("win32")
    " Always set the root to projects directory when at work
    nmap <silent> <Leader>t :CommandT C:\gitrepos\<CR>
endif

let g:CommandTMaxFiles = 50000

" Show column markers at 80 and 120 columns
set colorcolumn=80,120

" Ctrl-P Options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 2

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|cache$\|vendor$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ }

let g:ctrlp_max_files = 50000

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
