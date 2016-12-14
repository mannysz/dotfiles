"execute pathogen#infect()
syntax on
filetype plugin indent on

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'mileszs/ack.vim'

call plug#end()


" Plugins Settings
" let g:ctrlp_max_files=0

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_c_checkers = ['check']
let g:syntastic_cpp_checkers = ['check']
let g:syntastic_javascript_checkers = ['json_tool']
let g:syntastic_yaml_checkers = ['pyyaml']

" fzf.vim
let g:fzf_tags_command = 'ctags -R'
let g:fzf_files_options = '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1

" ack
let g:ackprg = 'ag --vimgrep'

" Mapping
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
set laststatus=2
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

highlight ColorColumn ctermbg=8

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
map <C-p> :Files<cr>

" Cleanup search hightlights
nmap <silent> ,/ :nohlsearch<CR>

" Search CTags using FZF Files
nnoremap <leader>. :Tags<cr>

" Refresh CTags buffers
map <f12> :!ctags --exclude=node_modules --exclude=.git --exclude=static --exclude=static_files --exclude=*.pyc -R .<cr>

" Shortcut for sudo tee on :w
cmap w!! w !sudo tee % >/dev/null

" Auto Triggers 
" autocmd BufWritePost *.py call Flake8()
autocmd VimEnter * command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
