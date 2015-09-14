execute pathogen#infect()
syntax on
filetype plugin indent on
highlight ColorColumn ctermbg=8

" Mappings
let mapleader=","

" Editing VIMRC and Saving It
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" Preferences
set hidden
set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set ts=4
set shiftwidth=4
set shiftround
set expandtab
set colorcolumn=80
set term=xterm
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.pyc,*.bak,*.class,*.o,*.a
set title
set visualbell
set noerrorbells
set nobackup
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list
set pastetoggle=<F2>
set number

" Settings by FileTypes
filetype plugin indent on

" Python Settings
if has('autocmd')
    autocmd filetype python set expandtab
endif

" Easy window navigation
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-right> <C-w>l
map <C-up> <C-w>k

" Cleanup search hightlights
nmap <silent> ,/ :nohlsearch<CR>

" Shortcut for sudo tee on :w
cmap w!! w !sudo tee % >/dev/null
