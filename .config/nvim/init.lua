--[[
  Neovim Configuration (0.11+)
  
  Requirements:
    - pyright: pip install pyright
    - typescript-language-server: npm install -g typescript-language-server typescript
    - bash-language-server: npm install -g bash-language-server
    - vscode-html-language-server: npm install -g vscode-langservers-extracted
    - fzf: brew install fzf
    
  Optional:
    - django-stubs: pip install django-stubs (for Django projects)
    - celery-types: pip install celery-types (for Celery projects)
]]

--------------------------------------------------------------------------------
-- Leader Key (must be set before any mappings)
--------------------------------------------------------------------------------
vim.g.mapleader = ','

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

--------------------------------------------------------------------------------
-- Plugins (vim-plug)
--------------------------------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')
Plug('ibhagwan/fzf-lua')           -- Fuzzy finder with LSP integration
Plug('nvim-tree/nvim-web-devicons') -- File icons for fzf-lua
Plug('Yggdroot/indentLine')        -- Indentation guides
Plug('mxw/vim-jsx')                -- React/JSX support
Plug('tpope/vim-fugitive')         -- Git integration
Plug('solarnz/thrift.vim')         -- Thrift syntax
Plug('vim-airline/vim-airline')    -- Status bar
Plug('vim-airline/vim-airline-themes')
vim.call('plug#end')

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
local opt = vim.opt

-- Files and buffers
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undolevels = 1000
opt.history = 1000

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.autoindent = true
opt.copyindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Display
opt.number = true
opt.wrap = false
opt.showmatch = true
opt.title = true
opt.laststatus = 2
opt.list = true
opt.listchars = { tab = '>.', trail = '.', extends = '#', nbsp = '.' }

-- Editing
opt.backspace = { 'indent', 'eol', 'start' }
opt.clipboard = 'unnamed'
opt.wildignore = { '*.swp', '*.pyc', '*.bak', '*.class', '*.o', '*.a' }

-- Completion
opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }

--------------------------------------------------------------------------------
-- Plugin Settings
--------------------------------------------------------------------------------
-- Airline
vim.g.airline_theme = 'minimalist'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#left_sep'] = ' '
vim.g['airline#extensions#tabline#left_alt_sep'] = '|'
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'

-- indentLine
vim.g.indentLine_char = '│'

-- vim-jsx
vim.g.jsx_ext_required = 1

-- Python path
vim.env.PYTHONPATH = vim.fn.getcwd() .. ':' .. (vim.env.PYTHONPATH or '')

--------------------------------------------------------------------------------
-- Helper Functions
--------------------------------------------------------------------------------
local function get_python_path()
    -- Activated virtualenv
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
    end
    -- .venv in current directory
    local cwd_venv = vim.fn.getcwd() .. '/.venv/bin/python'
    if vim.fn.executable(cwd_venv) == 1 then
        return cwd_venv
    end
    -- uv-managed environment
    local uv_python = vim.fn.system('uv python find 2>/dev/null'):gsub('\n', '')
    if uv_python ~= '' and vim.fn.executable(uv_python) == 1 then
        return uv_python
    end
    -- System fallback
    return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

local function has_marker(markers)
    local cwd = vim.fn.getcwd()
    for _, marker in ipairs(markers) do
        local path = cwd .. '/' .. marker
        if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
            return true
        end
    end
    return false
end

--------------------------------------------------------------------------------
-- Diagnostics
--------------------------------------------------------------------------------
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
        },
        severity = { min = vim.diagnostic.severity.WARN },
    },
    virtual_text = false,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    float = { severity = { min = vim.diagnostic.severity.WARN }, border = 'rounded', source = true },
    update_in_insert = false,
    severity_sort = true,
})

--------------------------------------------------------------------------------
-- LSP Configuration
--------------------------------------------------------------------------------
-- Global on_attach for all LSP servers
vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        
        -- Navigation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
        
        -- Actions
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        
        -- Diagnostics
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    end,
})

-- Python (Pyright)
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.venv', '.git' },
    settings = {
        python = {
            pythonPath = get_python_path(),
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
            },
        },
    },
})

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

-- Bash
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash' },
    root_markers = { '.git' },
})

-- HTML
vim.lsp.config('html', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { 'package.json', '.git' },
})

-- Enable servers
vim.lsp.enable({ 'pyright', 'ts_ls', 'bashls', 'html' })

--------------------------------------------------------------------------------
-- Completion
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            
            -- Trigger completion after 2 characters
            vim.api.nvim_create_autocmd('InsertCharPre', {
                buffer = args.buf,
                callback = function()
                    if vim.v.char:match('[%w_]') then
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local line = vim.api.nvim_get_current_line():sub(1, col)
                        local word = line:match('[%w_]+$') or ''
                        if #word >= 1 and vim.fn.pumvisible() == 0 then
                            vim.schedule(function()
                                if vim.fn.pumvisible() == 0 then
                                    vim.lsp.completion.get()
                                end
                            end)
                        end
                    end
                end,
            })
        end
    end,
})

-- Completion keymaps
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = 'Trigger completion' })
vim.keymap.set('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, { expr = true })
vim.keymap.set('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true })
vim.keymap.set('i', '<CR>', function() return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>' end, { expr = true })
vim.keymap.set('i', '<C-e>', function() return vim.fn.pumvisible() == 1 and '<C-e>' or '<End>' end, { expr = true })

--------------------------------------------------------------------------------
-- Project Auto-detection (start LSP on VimEnter)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local cwd = vim.fn.getcwd()
        local bufname = vim.api.nvim_buf_get_name(0)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
        
        if bufname ~= '' or buftype ~= '' then return end
        
        vim.schedule(function()
            -- Python project
            if has_marker({ 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.venv', 'pyrightconfig.json' }) then
                vim.api.nvim_set_option_value('filetype', 'python', { buf = 0 })
            
            -- TypeScript/JavaScript project
            elseif has_marker({ 'tsconfig.json', 'jsconfig.json', 'package.json', 'bun.lockb', 'deno.json' }) then
                -- ts_ls needs a real file to index workspace
                local js_file = vim.fn.glob(cwd .. '/*.ts', false, true)[1]
                    or vim.fn.glob(cwd .. '/*.tsx', false, true)[1]
                    or vim.fn.glob(cwd .. '/*.js', false, true)[1]
                    or vim.fn.glob(cwd .. '/*.jsx', false, true)[1]
                    or vim.fn.glob(cwd .. '/src/*.ts', false, true)[1]
                    or vim.fn.glob(cwd .. '/src/*.tsx', false, true)[1]
                    or vim.fn.glob(cwd .. '/src/*.js', false, true)[1]
                    or vim.fn.glob(cwd .. '/src/*.jsx', false, true)[1]
                
                if js_file then
                    local buf = vim.fn.bufadd(js_file)
                    vim.fn.bufload(buf)
                    vim.api.nvim_set_option_value('buflisted', false, { buf = buf })
                end
                
                local ft = vim.fn.filereadable(cwd .. '/tsconfig.json') == 1 and 'typescript' or 'javascript'
                vim.api.nvim_set_option_value('filetype', ft, { buf = 0 })
            end
        end)
    end,
})

--------------------------------------------------------------------------------
-- fzf-lua
--------------------------------------------------------------------------------
require('nvim-web-devicons').setup()

local fzf = require('fzf-lua')

fzf.setup({
    winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.5,
        col = 0.5,
        border = 'rounded',
        preview = { layout = 'flex', flip_columns = 120 },
    },
    keymap = { fzf = { ['ctrl-q'] = 'select-all+accept' } },
    files = { git_icons = true, file_icons = true },
    grep = { git_icons = true, file_icons = true },
    lsp = {
        async_or_timeout = 5000,
        jump1 = true,
        symbols = {
            symbol_kinds = { 'Class', 'Method', 'Function', 'Variable', 'Constant', 'Field', 'Property', 'Constructor', 'Enum', 'Interface', 'Module' },
        },
    },
})

-- File navigation
vim.keymap.set('n', '<C-p>', fzf.git_files, { desc = 'Git files' })
vim.keymap.set('n', '<C-b>', fzf.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'All files' })
vim.keymap.set('n', '<leader>fh', fzf.oldfiles, { desc = 'Recent files' })

-- LSP symbols
vim.keymap.set('n', '<leader>.', fzf.lsp_live_workspace_symbols, { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>s', fzf.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>fr', fzf.lsp_references, { desc = 'References' })
vim.keymap.set('n', '<leader>fd', fzf.lsp_definitions, { desc = 'Definitions' })
vim.keymap.set('n', '<leader>fi', fzf.lsp_implementations, { desc = 'Implementations' })

-- Diagnostics
vim.keymap.set('n', '<leader>fe', fzf.diagnostics_document, { desc = 'Document diagnostics' })
vim.keymap.set('n', '<leader>fE', fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })

-- Git
vim.keymap.set('n', '<C-g>', fzf.git_bcommits, { desc = 'Buffer commits' })
vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = 'Commits' })
vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = 'Status' })
vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = 'Branches' })

-- Misc
vim.keymap.set('n', '<leader>:', fzf.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<F1>', fzf.helptags, { desc = 'Help' })

--------------------------------------------------------------------------------
-- Keymaps (General)
--------------------------------------------------------------------------------
-- Window navigation
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Down>', '<C-w>j')
vim.keymap.set('n', '<C-Up>', '<C-w>k')
vim.keymap.set('n', '<C-Right>', '<C-w>l')

-- Buffer navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { silent = true })
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = 'Alternate buffer' })
vim.keymap.set('n', '<leader>x', ':bd<CR>', { silent = true, desc = 'Close buffer' })

-- Tab management
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader><Tab>', ':tabclose<CR>', { silent = true })

-- Visual mode indentation
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Git blame
vim.keymap.set('n', '<leader>g', ':Git blame<CR>', { silent = true })

-- Clear search highlight
vim.keymap.set('n', '<leader>c', ':let @/ = ""<CR>', { silent = true })

-- Sudo write
vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null')

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = { 'python', 'c', 'cpp', 'go', 'javascript', 'typescript', 'lua', 'jsx' },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.autoindent = true
    end,
})

-- JSX filetype detection
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroup,
    pattern = '*.jsx',
    callback = function() vim.bo.filetype = 'javascript.jsx' end,
})

-- JSON: disable concealing
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'json',
    callback = function()
        vim.g.indentLine_setConceal = 0
        vim.g.vim_json_syntax_conceal = 0
    end,
})
