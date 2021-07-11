syntax on
filetype plugin indent on

" ======= VimPlug Plugins ========

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

"Language server
Plug 'neovim/nvim-lspconfig'
"Auto completion plugin
Plug 'hrsh7th/nvim-compe'
"Fuzzy Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Code style
Plug 'Yggdroot/indentLine'
" Code search and indexing
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
" React and JSX
Plug 'mxw/vim-jsx'
"Git integration
Plug 'tpope/vim-fugitive'
" Syntax Hightlight
Plug 'solarnz/thrift.vim'
" Status Bar and Color scheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


" Plugin Settings

"Language Servers
lua << EOF
-- Python Support
require 'lspconfig'.pylsp.setup({})

-- Bash Script
require'lspconfig'.bashls.setup{}

-- HTML/CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- Auto completion

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

vim.o.completeopt = "menuone,noselect"

EOF

"Auto completion mapping
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Vim JSX
let g:jsx_ext_required = 1

" ack
let g:ackprg = 'ag --vimgrep'

" Airline
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" indentLine
let g:indentLine_char = '│'

" Mapping
let mapleader=","

" Setting python path to use current project bin
let $PYTHONPATH = getcwd().':'.$PYTHONPATH

" FZF Settings

" Close preview window when leaving insert mode (workaround deoplete bug)
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
set showmatch

" Auto Command General Settings
if has('autocmd')
    autocmd filetype python,c,cpp,golang,javascript,typescript,es6,lua,jsx set ai expandtab
endif

" Easy window navigation
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-right> <C-w>l
map <C-up> <C-w>k

" Project navigation
noremap <C-p> :GFiles<cr>
noremap <C-b> :Buffers<cr>
noremap <leader>/ :Ag<cr>

" Git (vim-fugitive)
map <C-g> :BCommits<cr>
map <leader>g :Git blame<cr>

" Tab window management
nnoremap <Tab> :tabn<cr>
nnoremap <S-Tab> :tabp<cr>
nnoremap <leader><Tab> :tabclose<cr>

" Indentation Block Bindings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Toggle Tagbar
noremap <leader>q :TagbarToggle<CR>

" Clear search buffer
nnoremap <leader>c :let @/ = ""<cr>

" Shortcut for sudo tee on :w
cmap w!! w !sudo tee % >/dev/null

" Auto Triggers 
autocmd VimEnter * command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
augroup FileTypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END
autocmd Filetype json
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0

" Color Scheme
let g:afterglow_italic_comments=0
