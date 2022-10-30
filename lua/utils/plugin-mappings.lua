local M = {}

M.lspconfig = {
    plugin = true,

    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "lsp declaration",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "lsp implementation",
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "lsp signature_help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "lsp definition type",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "lsp references",
        },

        ["<leader>f"] = {
            function()
                vim.diagnostic.open_float()
            end,
            "floating diagnostic",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "diagnostic setloclist",
        },

        ["<leader>fm"] = {
            function()
                vim.lsp.buf.formatting {}
            end,
            "lsp formatting",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "list workspace folders",
        },
        -- lspsaga优化集成
        ["gh"] = {
            "<cmd>Lspsaga lsp_finder<CR>", { silent = true },
            "remove workspace folder",
        },
        ["<leader>ca"] = {
            "<cmd>Lspsaga code_action<CR>", { silent = true },
            "lsp code_action",
        },
        ["<leader>rn"] = {
            "<cmd>Lspsaga rename<CR>", { silent = true },
            "lsp rename",
        },
        ["gd"] = {
            "<cmd>Lspsaga peek_definition<CR>", { silent = true },
            "lsp definition",
        },
        ["<leader>cd"] = {
            "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true },
            "show line diagnostics",
        },
        ["<leader>cc"] = {
            "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true },
            "show cursor diagnostics",
        },
        ["e["] = {
            "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true },
            "jump to prev diagnostic",
        },
        ["e]"] = {
            "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true },
            "jump to next diagnostic",
        },
        ["E["] = {
            function()
                require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end,
            "jump to prev error",
        },
        ["E]"] = {
            function()
                require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            end,
            "jump to next error",
        },
        ["<leader>o"] = {
            "<cmd>LSoutlineToggle<CR>", { silent = true },
            "outline",
        },
        ["K"] = {
            "<cmd>Lspsaga hover_doc<CR>", { silent = true },
            "lsp hover",
        },

        --["gd"] = {
        --    function()
        --        vim.lsp.buf.definition()
        --    end,
        --    "lsp definition",
        --},

        --["K"] = {
        --    function()
        --        vim.lsp.buf.hover()
        --    end,
        --    "lsp hover",
        --},

        --["<leader>ra"] = {
        --    function()
        --        require("nvchad_ui.renamer").open()
        --    end,
        --    "lsp rename",
        --},

        --["<leader>ca"] = {
        --    function()
        --        vim.lsp.buf.code_action()
        --    end,
        --    "lsp code_action",
        --},
        --
--        ["d["] = {
--            function()
--                vim.diagnostic.goto_prev()
--            end,
--            "goto prev",
--        },
--
--        ["d]"] = {
--            function()
--                vim.diagnostic.goto_next()
--            end,
--            "goto_next",
--        },

        -- 浮动终端不好用，使用toggleterm
--        ["<A-d>"] = {
--            "<cmd>Lspsaga open_floaterm<CR>", { silent = true },
--            "open float terminal",
--        },
--        ["<A-c>"] = {
--            [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true },
--            "close float terminal",
--        },
    },
    v = {
        --["<leader>la"] = { function() vim.lsp.buf.range_code_action() end, "Range LSP code action" },
        ["<leader>rf"] = {
            function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
                vim.lsp.buf.range_formatting()
            end,
            "Range format code",
        },
        ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", { silent = true }, "Range LSP code action" },
    },
}

M.comment = {
    plugin = true,

    -- toggle comment in both modes
    n = {
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "toggle comment",
        },
    },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

return M
