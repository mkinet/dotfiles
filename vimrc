" Don't try to be vi compatible
set nocompatible
" disable arrow keys
noremap  <Up> <NOP>
noremap! <Up> <Esc>
noremap  <Down> <NOP>
noremap! <Down> <Esc>
noremap  <Left> <NOP>
noremap! <Left> <Esc>
noremap  <Right> <NOP>
noremap! <Right> <Esc>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Helps force plugins to load correctly when it is turned back on below
filetype on
"""" START Vundle Configuration 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Syntax checking
Plugin 'vim-syntastic/syntastic'
" autopep8
Plugin 'tell-k/vim-autopep8'
" autocomplete
Plugin 'davidhalter/jedi-vim'

" Git support
Plugin 'tpope/vim-fugitive'

call vundle#end()            " required
filetype plugin indent on    " required
"""" END Vundle Configuration 

" Turn on syntax highlighting
let python_highlight_all=1
syntax on
" Don't syntax highlight super-long lines (for performance)
set synmaxcol=2048
" automatically indent lines and try to do it intelligently
set autoindent                    
set smartindent
" show matching bracket (briefly jump)
set showmatch

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set nohlsearch
map <leader><space> :let @/=''<cr> " clear search

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme gruvbox

" execute python script
autocmd FileType python nnoremap <buffer> <leader>py :exec '!clear; python' shellescape(@%, 1)<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic Configuration
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': [],
                          \ 'passive_filetypes': [] }
let g:syntastic_auto_loc_list=1
nnoremap <leader>p :SyntasticCheck<CR>

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_quiet_messages = {
        \ "level":  "warnings"}
"        \ "type":    "style"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autopep8
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd FileType python noremap <leader>p :call Autopep8()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi-vim
"
" Do not open a preview docstring window
autocmd FileType python setlocal completeopt-=preview
