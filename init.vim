" vim & neovim configuration
"
" Install:
"
"     neovim: Clone to ~/.config/nvim/
"     vim   : Clone to ~/vim/
"             ln -s ~/vim/init.vim ~/.vimrc
"
" Prerequisites:
"
"   * 'curl' in path (to install vim-plug)
"   * 'fzf' in path (for fuzzy finding files)
"
" Update Plugins:
"
"   :PlugUpdate
"

" *****************************************************************************
" Download vim-plug if it doesn't exist
" *****************************************************************************

if has('nvim')
    let vimplug_path=expand(stdpath('config') . '/autoload/plug.vim')
else
    let vimplug_path=expand('~/.vim/autoload/plug.vim')
endif

if !filereadable(vimplug_path)
    echo "Installing vim-plug..."
    silent exec "!\curl -fLo " . vimplug_path . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    " Run vim-plug Install after startup
    autocmd VimEnter * PlugInstall
endif


" *****************************************************************************
" Install Plugins
" *****************************************************************************
call plug#begin()

" Sensible Defaults
Plug 'tpope/vim-sensible'

" Misc Tools
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'yggdroot/indentline'

" Language/Format Support
Plug 'ledger/vim-ledger'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/rtorrent-syntax-file'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Status/Tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorschemes
Plug 'godlygeek/csapprox'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-scripts/desert256.vim'

call plug#end()


" *****************************************************************************
" Configuration
" *****************************************************************************

" Do not run in Vi compatibility mode
set nocompatible

" Detect type and load plugin/indent config when opening file
filetype plugin indent on

" Mouse config
if has('mouse')
    set mouse=a
    set mousemodel=popup
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Allow windows to be zero height
set winminheight=0

" Show special characters
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Fix backspace indent
set backspace=indent,eol,start

" Tab settings
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Show column markers at 80 and 120 columns
set colorcolumn=80,120

" Spelling Options
setlocal spell spelllang=en_us
set nospell

" Try all file formats when reading files
set fileformats=unix,dos,mac

" Visual
syntax on
set ruler
set number

" Fold Options
set foldmethod=indent
set foldcolumn=2
set foldlevel=99

" fzf / Menu
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__


" *****************************************************************************
" Plugin Configuration
" *****************************************************************************

" Disable Neovim Providers not used
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" Python3 should always just be "python" autodetection on Windows is broken
let g:python3_host_prog = 'python'

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" gVim Theme Compatibility
let g:CSApprox_loaded = 1

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_balance_matchpairs = 1

" Airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

" Golang
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

" Ledger
let g:ledger_align_at = 51
let g:ledger_commodity_sep = "$"
let g:ledger_extra_options = '--pedantic --explicit --check-payees'


" *****************************************************************************
" Auto Commands
" *****************************************************************************

" Ledger
autocmd BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

" Right Trim Non-Whitespace Lines on save
autocmd BufWrite * :silent! :%s:\(\S\+\)\s\+$:\1:g

" Replace Tabs with Spaces on save
autocmd BufWrite * :retab

" Word Documents
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

" Makefiles
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake

" Golang
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" Language-specific spacing
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype xml  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Force .pp files to be interpreted as puppet and wipe out the pascal autocmds
autocmd! filetypedetect BufNewFile,BufRead *.pp setfiletype puppet


" *****************************************************************************
" Mappings
" *****************************************************************************

" Leader
let mapleader=','

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Git
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" In Markdown, use ,\ in visual mode to align Markdown tables
autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Ledger
autocmd FileType ledger noremap <silent><buffer> <Space> :call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>


" *****************************************************************************
" Windows-specific
" *****************************************************************************
if has("win32")
    source $VIMRUNTIME/mswin.vim
endif


" *****************************************************************************
" Visual Colors/Themes
" *****************************************************************************

" Vim-Only Terminal Color Setting
set t_Co=256

" Main Colorscheme
silent! colorscheme gruvbox
set bg=dark

" Status/Tabline Theme
let g:airline_theme = 'gruvbox'

