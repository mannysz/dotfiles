syntax on
filetype plugin indent on

" ======= VimPlug Plugins ========

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Code style and linters
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
" Code search and indexing
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
" Language auto-complete support
Plug 'shougo/deoplete.nvim'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
" External plugin dependencies
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" JSX support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Git integration
Plug 'tpope/vim-fugitive'
" C-Sharp Integration
Plug 'OmniSharp/omnisharp-vim'
" Command execution
Plug 'tpope/vim-dispatch'
" Syntax Hightlight
Plug 'solarnz/thrift.vim'

call plug#end()


" Plugin Settings

" OmniSharp
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_server_use_mono = 1

" Vim JSX
let g:jsx_ext_required = 1

"Deoplete and Deoplete Jedi
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:jedi#show_call_signatures = '1'
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>D"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<leader>r"
let g:jedi#completions_enabled = 0

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'cs': ['OmniSharp'],
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

" fzf.vim
set tags=.git/tags
let g:fzf_tags_command = 'ctags -R'
let g:fzf_files_options = '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1

" ack
let g:ackprg = 'ag --vimgrep'

" neocomplete
let g:acp_enableAtStartup = 0
let g:deoplete#enable_at_startup = 1

" indentLine
let g:indentLine_char = '│'

" Mapping
let mapleader=","

" Setting python path to use current project bin
let $PYTHONPATH = getcwd().':'.$PYTHONPATH

" Preferences
filetype plugin indent on

set hidden
set nowrap
set backspace=indent,eol,start
set copyindent
set smartindent
set autoindent
set ts=4
set laststatus=2
set shiftwidth=4
set shiftround
set expandtab
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.pyc,*.bak,*.class,*.o,*.a
set title
set nobackup
set nowritebackup
set noswapfile
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list
set pastetoggle=<F2>
set number
set clipboard^=unnamed

" Auto Command General Settings
if has('autocmd')
    autocmd filetype python,php,c,cpp,golang,javascript,es6 set ai expandtab
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
vnoremap ; :w !pbcopy<CR><CR>

" Cleanup search 
nmap <silent> ,/ :nohlsearch<CR>

" Toggle Tagbar
noremap <leader>q :TagbarToggle<CR>

" Search CTags using FZF Files
nnoremap <leader>. :Tags<cr>
nnoremap <leader>/ :Ag<cr>
nnoremap <leader>b :call fzf#run({'source': map(range(1, bufnr('$')), 'bufname(v:val)'),'sink': 'e', 'down': '30%'})<cr>
nnoremap <leader>c :let @/ = ""<cr>
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Refresh Tags
map <f12> :!$HOME/.git_template/hooks/ctags <cr>

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
