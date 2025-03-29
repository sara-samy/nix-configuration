local vim = vim
local opt = vim.opt
local api = vim.api

-- Set colorscheme according to iTerm profile
local lualine_theme
local iterm_profile = os.getenv("ITERM_PROFILE")
if iterm_profile == '☀️  ' then
    vim.cmd('colorscheme catppuccin-latte')
    lualine_theme = 'ayu_light'
else
    vim.cmd('colorscheme catppuccin-mocha')
    lualine_theme = 'nightfly'
end


-- Buffer navigation using Alt+Arrows
api.nvim_set_keymap('n', '<A-Up>', '<C-w>k', { noremap = true })
api.nvim_set_keymap('n', '<A-Down>', '<C-w>j', { noremap = true })
api.nvim_set_keymap('n', '<A-Left>', '<C-w>h', { noremap = true })
api.nvim_set_keymap('n', '<A-Right>', '<C-w>l', { noremap = true })

-- Indent line
require('ibl').setup {}

-- Highlight colors
require("nvim-highlight-colors").setup {
    -- 'background'|'foreground'|'virtual'
    render = 'background',
    ---Set virtual symbol (requires render to be set to 'virtual')
    virtual_symbol = '🟂',
    ---Highlight named colors.
    enable_named_colors = false,
    ---Highlight tailwind colors.
    enable_tailwind = false,
}

-- Configure gitsigns
require('gitsigns').setup {
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', '<A-j>', "&diff ? '<A-j>' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
        map('n', '<A-k>', "&diff ? '<A-k>' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map('n', '<leader>0', '<cmd>Gitsigns reset_hunk<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
        map('n', '<leader>hU', '<cmd>Gitsigns reset_buffer<CR>')
        map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
        map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    end
};

-- Transparent
require("transparent").setup {
    extra_groups = {
        "NormalFloat",
        "BufferLineTab",
        "BufferLineFill",
        "BufferCurrent",
        "BufferInactive",
        "TelescopeNormal",
        "BufferLineFill"
    },
}

-- mini.nvim modules
-- animation
require('mini.animate').setup {
    -- Window open
    open = { enable = false },
    -- Cursor path
    cursor = { enable = true },
    -- Vertical scroll
    scroll = { enable = true },
    -- Window resize
    resize = { enable = true },
    -- Window close
    close = { enable = false }
}

-- Github copilot.lua
require("copilot").setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
        },
        layout = {
            position = "right", -- | top | left | bottom
            ratio = 0.5
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
            accept = "<M-CR>",
            accept_word = false,
            accept_line = "<M-l>",
            next = "<M-8>",
            prev = "<M-9>",
            dismiss = "<M-7>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
})

-- Github copilot chat
require("CopilotChat").setup {
    debug = false,
    context = 'buffers',

    question_header = '## Pilot 🦭 ', -- Header to use for user questions
    answer_header = '## Copilot 📟 ', -- Header to use for AI answers
    window = {
        layout = 'float', -- 'vertical', 'horizontal', 'replace'
        width = 0.7, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.7, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = 3, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'GitHub Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
    },
    show_help = false,
    show_folds = true,
    auto_insert_mode = false,
    auto_follow_cursor = true,
    highlight_selection = true,
    highlight_headers = true,
    insert_at_end = false,
    clear_chat_on_new_prompt = false
}

-- Bufferline
local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "tabs", -- set to "tabs" to only show tabpages instead
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        show_close_icon = false,
        tab_size = 18,
        diagnostics = "coc",
        diagnostics_update_in_insert = false,
        show_duplicate_prefix = false
    }
}

-- Lualine
-- Helper functions
local function trailing_whitespace()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and "👻 TW:" .. space or ""
end
local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = lualine_theme,
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', { 'diff', source = diff_source } },
        lualine_c = { { 'filename', file_status = false, path = 0 },
            { 'diagnostics',
                sources = { 'nvim_diagnostic', 'coc' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    error = 'DiagnosticError',
                    warn  = 'DiagnosticWarn',
                    info  = 'DiagnosticInfo',
                    hint  = 'DiagnosticHint',
                },
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype', trailing_whitespace },
        lualine_z = { 'progress' },
        lualine_y = { 'location' },
    },
}

-- Autopairs
require('nvim-autopairs').setup {
    map_cr = false
}

-- Boolean toggle
require('boole').setup({
    mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
    }
})

-- Aerial
require("aerial").setup({
    layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 60, 0.4 },
        width = nil,
        min_width = 30,
        default_direction = "prefer_left",
    },
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
})

-- Icons, lua fork of vim-devicons
require 'nvim-web-devicons'.setup {
    color_icons = true,
    default = true,
    strict = true,
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
        }
    },
    -- same as `override` but specifically for overrides by filename
    -- takes effect when `strict` is true
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        }
    },
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
        },
    },
}

-- Telescope main config
require('telescope').setup {
    pickers = {
        find_files = {
            path_display = { "truncate" }
        }
    },
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden'
        },
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close
            },
        },
        extensions = {
            coc = {
                theme = 'ivy',
                prefer_locations = true,
            }
        },
        color_devicons = true,
        prompt_prefix = '🔭 ',
        scroll_strategy = 'cycle',
        sorting_strategy = 'ascending',
        layout_strategy = 'flex',
        file_ignore_patterns = { '.git' },
        layout_config = {
            prompt_position = 'top',
            horizontal = {
                mirror = true,
                preview_cutoff = 100,
                preview_width = 0.5,
            },
            vertical = {
                mirror = true,
                preview_cutoff = 0.4,
            },
            flex = {
                flip_columns = 110,
            },
            height = 0.94,
            width = 0.86,
        },
    },
}

-- Load and setup fuzzy finder
require('telescope').load_extension('fzf')
require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

-- Load file browser
require('telescope').load_extension('file_browser')

-- Load coc search
require('telescope').load_extension('coc')

-- Load ultiSnips
require('telescope').load_extension('ultisnips')

-- Load aerial
require('telescope').load_extension('aerial')

-- Define keymappings
-- Defined also in init.vim
api.nvim_set_keymap('n', 'fc', '<cmd>Telescope coc<cr>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'fa', '<cmd>Telescope aerial<cr>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'fk', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'fb', '<cmd>Telescope file_browser<cr>', { noremap = true, silent = true })

-- Treesitter
require("nvim-treesitter.configs").setup {
    sync_install = false,
    ignore_install = { '' },   -- List of parsers to ignore installing
    highlight = {
        enable = true,         -- false will disable the whole extension
        disable = { 'latex' }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autopairs = {
        enable = false,
    },
    indent = {
        enable = false,
    },
    rainbow = {
        enable = false,
    }
}

-- Set up folding with treesitter
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Configure Treesitter text objects
require 'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ak'] = '@conditional.outer',
                ['ik'] = '@conditional.inner',
                ['ap'] = '@parameter.outer',
                ['ip'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['at'] = '@comment.outer',
                ['aC'] = '@class.outer',
                ['iC'] = '@class.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner'
            },
        },
    },
}
