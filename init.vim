" Original version :
" https://github.com/colbycheeze/dotfiles/blob/master/vimrc (around mai2018)
" Type :so % to refresh .vimrc after making changes

" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Leader - ( Comma )
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete command
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

"Set default font in mac vim and gvim
set cursorline    " highlight the current line
set visualbell    " stop that ANNOYING beeping
set wildmenu
set wildmode=list:longest,full

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
set hlsearch
nnoremap <silent> <leader><Space> :noh<cr> " Stop highlight after searching
set incsearch
set showmatch

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 80 characters is
set textwidth=79
" set formatoptions=cq
set formatoptions=qrn1
set wrapmargin=0
let &colorcolumn="80,".join(range(100,999),",")

" Numbers
set number
set numberwidth=5
"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
" THIS DOES NOT WORK PROPERLY
" function! ToggleNumbersOn()
"     set nu!
"     set rnu
" endfunction
" function! ToggleRelativeOn()
"     set rnu!
"     set nu
" endfunction
" autocmd FocusLost * call ToggleRelativeOn()
" autocmd FocusGained * call ToggleRelativeOn()
" autocmd InsertEnter * call ToggleRelativeOn()
" autocmd InsertLeave * call ToggleRelativeOn()
"
" folding
set foldenable
set foldlevelstart=10   " open most folds by default
" foldlevelstart is the starting fold level for opening a new buffer. If it is
" set to 0, all folds will be closed. Setting it to 99 would guarantee folds
" are always open. So, setting it to 10 here ensures that only very nested
" blocks of code are folded when opening a buffer.
set foldmethod=indent   " fold based on indent level
set foldnestmax=5      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
vnoremap <space> zf

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Auto resize Vim splits to active split
" set winwidth=100
" set winheight=5
" set winminheight=5
" set winheight=100
"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> O<Esc>j
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" disable arrow keys
noremap  <Up> <NOP>
noremap! <Up> <Esc>
noremap  <Down> <NOP>
noremap! <Down> <Esc>
noremap  <Left> <NOP>
noremap! <Left> <Esc>
noremap  <Right> <NOP>
noremap! <Right> <Esc>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" <c-h> is interpreted as <bs> in neovim
" This is a bandaid fix until the team decides how
" they want to handle fixing it...(https://github.com/neovim/neovim/issues/2048)
" nnoremap <silent> <bs> :TmuxNavigateLeft<cr>

" Navigate properly when lines are wrapped
" nnoremap j gj
" nnoremap k gk

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Always use vertical diffs
set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

""" MORE AWESOME HOTKEYS
"
"
" Run the w macro
nnoremap <leader>w @w

" bind K to grep word under cursor
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" Ag will search from project root
let g:ag_working_path_mode="r"

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Also map leader + s
map <leader>s <C-S>

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

" Close file without closing buffer
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

" zoom a vim pane, <leader>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" open new vertical buffer
nnoremap <leader>v :vnew<CR>
" open new horizontal buffer
nnoremap <leader>h :new<CR>

" open terminal window in insert mode vertical buffer to the right
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <leader>t :vnew<CR>:terminal<CR>i
" nnoremap <leader>ht :new<CR>:terminal<CR>i


" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Color scheme (terminal)
set background=dark
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Theme
syntax enable
" colorscheme
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox


" AUTOCOMMANDS - Do stuff

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  autocmd BufRead *.jsx set ft=jsx.html
  autocmd BufNewFile *.jsx set ft=jsx.html

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 100 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=100

  " Automatically wrap at 100 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=100
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END

" DEBUGGING
"
nnoremap <leader>b oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader>B Oimport pdb; pdb.set_trace()<Esc>


"  PLUGINS
"
call plug#begin('~/.local/share/nvim/plugged')

" autopep8
Plug 'morhetz/gruvbox'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'janko-m/vim-test'
Plug 'heavenshell/vim-pydocstring'
Plug 'tpope/vim-vinegar'
Plug 'mhinz/vim-grepper'
Plug 'ekalinin/Dockerfile.vim'
" Plug 'jeetsukumaran/vim-pythonsense'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autopep8
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd FileType python noremap <leader>p :call Autopep8()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive Configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete Configuration
let g:deoplete#enable_at_startup=1
" deoplete tab-complete. Supertab does this now.
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete-jedi Configuration
"
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<Leader>r'
let g:jedi#usages_command = '<Leader>u'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>w' " like in 'what?'
let g:jedi#auto_close_doc = 1
" Do not open a preview docstring window
let g:jedi#show_call_signatures = 2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neomake Configuration
let g:neomake_python_enabled_makers=['pylint']
let g:neomake_open_list = 2
let g:neomake_highlight_lines = 1

" autocmd! BufWritePost * Neomake

nnoremap <leader>l :Neomake<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" supertab configuration
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" quicker acces to toggle comment
nmap <leader><Tab> <leader>c<Space>
vmap <leader><Tab> <leader>c<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-p> :TmuxNavigatePrevious<cr>

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlP
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Where to start search : 1) first anacestor containing .git 2) pwd.
let g:ctrlp_working_path_mode = 'ra'
" if a file is already open, open it again in a new pane instead of switching
" to the existing pane
let g:ctrlp_switch_buffer = 'et'
" Files to ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" ignore files in gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tests
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pydocstrings
"
nmap <silent> <leader>D <Plug>(pydocstring)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown-composer
" 
let g:markdown_composer_external_renderer='pandoc --mathjax -f markdown -s -t html '
