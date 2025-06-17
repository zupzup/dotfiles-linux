vim.g.mapleader = ","

vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})


function ToggleQuickfix()
    local is_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "buftype") == "quickfix" then
            vim.cmd("cclose")
            is_open = true
            break
        end
    end
    if not is_open then
        vim.cmd("copen")
    end
end

vim.api.nvim_set_keymap("n", "<leader>Q", ":lua ToggleQuickfix()<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd(
'BufReadPost',
{
    pattern = '*',
    callback = function(ev)
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            if not vim.fn.expand('%:p'):find('.git', 1, true) then
                vim.cmd('exe "normal! g\'\\""')
            end
        end
    end
}
)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {'kien/ctrlp.vim'},
    {'preservim/nerdtree'},
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'jelera/vim-javascript-syntax'},
    {'pangloss/vim-javascript'},
    {'mxw/vim-jsx'},
    {'leafgarland/typescript-vim'},
    {'fatih/vim-go'},
    {
        'rust-lang/rust.vim',
        ft = { "rust" },
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require "lsp_signature".setup({
                doc_lines = 0,
                handler_opts = {
                    border = "none"
                },
            })
        end
    },
    {'cespare/vim-toml'},
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {'lervag/vimtex'},
    {'markonm/traces.vim'},
    {'Raimondi/delimitMate'},

    {
        'itchyny/lightline.vim',
        lazy = false,
        config = function()
            vim.o.showmode = false
            vim.g.lightline = {
                active = {
                    left = {
                        { 'mode', 'paste' },
                        { 'readonly', 'filename', 'modified' }
                    },
                    right = {
                        { 'lineinfo' },
                        { 'percent' },
                        { 'fileencoding', 'filetype' }
                    },
                },
                component_function = {
                    filename = 'LightlineFilename'
                },
            }
            function LightlineFilenameInLua(opts)
                if vim.fn.expand('%:t') == '' then
                    return '[No Name]'
                else
                    return vim.fn.getreg('%')
                end
            end
            vim.api.nvim_exec(
            [[
            function! g:LightlineFilename()
            return v:lua.LightlineFilenameInLua()
            endfunction
            ]],
            true
            )
        end
    },
    {'milkypostman/vim-togglelist'},
    {'humbertocarmona/kanagawa-mod.nvim',
        config = function()
            vim.cmd("colorscheme kanagawa") -- Use "kanagawa-wave" or "kanagawa-lotus" if preferred

            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#54546D", bg = "None" }) -- Change color if needed

            vim.defer_fn(function()
                vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7E9CD8", bg = "None" })
            end, 50)
        end,
    },
    {
        'junegunn/fzf.vim',
        dependencies = {
            { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
        },
        config = function()
            vim.g.fzf_layout = { down = '~20%' }
            function list_cmd()
                local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
                if base == '.' then
                    return 'fdfind --hidden --type file --follow'
                else
                    return vim.fn.printf('fdfind --hidden --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
                end
            end
            vim.api.nvim_create_user_command('Files', function(arg)
                vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--scheme=path --tiebreak=index' }, arg.bang)
            end, { bang = true, nargs = '?', complete = "dir" })
        end
    },
    {'tpope/vim-commentary'},

    -- LSP
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.ts_ls.setup {}

            lspconfig.gopls.setup({
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            lspconfig.rust_analyzer.setup {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            loadOutDirsFromCheck = true,
                            allFeatures = true,
                            targetDir = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        imports = {
                            group = {
                                enable = true,
                            },
                        },
                        completion = {
                            postfix = {
                                enable = false,
                            },
                        },
                        diagnostics = {
                            disabled = { "unresolved-proc-macro" }, -- Avoid slow diagnostics on macros
                        },
                    },
                },
            }

            local configs = require 'lspconfig.configs'
            if not configs.bash_lsp and vim.fn.executable('bash-language-server') == 1 then
                configs.bash_lsp = {
                    default_config = {
                        cmd = { 'bash-language-server', 'start' },
                        filetypes = { 'sh' },
                        root_dir = require('lspconfig').util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {}
                            }
                        }
                    }
                }
            end
            if configs.bash_lsp then
                lspconfig.bash_lsp.setup {}
            end

            -- Ruff for Python
            local configs = require 'lspconfig.configs'
            if not configs.ruff_lsp and vim.fn.executable('ruff-lsp') == 1 then
                configs.ruff_lsp = {
                    default_config = {
                        cmd = { 'ruff-lsp' },
                        filetypes = { 'python' },
                        root_dir = require('lspconfig').util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {}
                            }
                        }
                    }
                }
            end
            if configs.ruff_lsp then
                lspconfig.ruff_lsp.setup {}
            end

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                    vim.api.nvim_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>;', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            'neovim/nvim-lspconfig',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require'cmp'
            cmp.setup({
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", true)
                        end
                    end, { "i", "s" }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, 
                    { name = 'buffer' },
                    { name = 'path' },
                }),
            })

            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                })
            })
        end
    },
})


vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')

vim.keymap.set('n', '<leader><leader>', '<c-^>')
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ':bn<cr>')
vim.keymap.set('n', '<leader>N', ':bp<cr>')
vim.keymap.set('n', '<leader>f', '<cmd>Files<cr>')
vim.keymap.set('n', '<c-p>', '<cmd>Files<cr>')
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('n', '<leader>s', ':vsplit<cr>')
vim.keymap.set('n', '<leader>c', ':nohls<cr>')
vim.keymap.set('n', '<leader>y', '"*y')

vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')

vim.api.nvim_set_keymap('n', '<leader>vf', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>vb', '"zy:Telescope grep_string default_text=<C-r>z<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vv', ':Telescope grep_string<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ust', ':set softtabstop=2 <bar> :set shiftwidth=2 <bar> :set tabstop=2<cr>')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 3
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.vb = true
vim.opt.colorcolumn = '80'
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
vim.opt.syntax = 'on'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.splitright = false
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,target,*/target/*,*target,build'
vim.opt.guicursor = "n-v-c:block"
vim.opt.guicursor = "i:block-blinkon1"

vim.cmd('colorscheme kanagawa')
-- vim.cmd('colorscheme nazca')

-- NerdTree Keymaps
vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>T', ':NERDTreeFind<CR>', { noremap = true, silent = true })

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Status Line
vim.o.statusline = '%<%f (%{&ft}) %-4(%m%)%=%-19(%3l,%02c%03V%)'
