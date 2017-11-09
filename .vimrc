syntax on
filetype plugin indent on

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'

call plug#end()


" Plugins Settings

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_pattern_options = {
\   '\.(js|jsx|vue)$': {
\       'ale_linters': {
\           'vue': ['eslint'],
\           'jsx': ['eslint'],
\           'js': ['eslint'],
\       },
\   },
\   '\.py$': {
\       'ale_linters': {'python': ['flake8']},
\   }
\}

" airline-vim
let g:airline#extensions#tabline#enabled = 1

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

" Tab window management
nnoremap <Tab> :tabn<cr>
nnoremap <S-Tab> :tabp<cr>
nnoremap <leader><Tab> :tabclose<cr>
nnoremap <leader><S-Tab> :tabonly<cr>

" Indentation Block Bindings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Cleanup search hightlights
nmap <silent> ,/ :nohlsearch<CR>

" Search CTags using FZF Files
nnoremap <leader>. :Tags<cr>
nnoremap <leader>/ :Ag<cr>
nnoremap <leader>b :call fzf#run({'source': map(range(1, bufnr('$')), 'bufname(v:val)'),'sink': 'e', 'down': '30%'})<cr>
nnoremap <leader>c :let @/ = ""<cr>
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Refresh Tags
map <f12> :!ctags --tag-relative --exclude='node_modules*' --exclude=.git --exclude='static' --exclude='static_files' --exclude='*.pyc' --exclude='__pycache__' --exclude='*\.min\.*' --exclude='*/migrations/*' --exclude='docs*' --exclude='logs*' -R .<cr>

" Shortcut for sudo tee on :w
cmap w!! w !sudo tee % >/dev/null

" Auto Triggers 
autocmd VimEnter * command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
augroup FileTypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    au BufNewFile,BufRead *.vue set filetype=javascript.jsx
augroup END

" Color Scheme
colorscheme default
