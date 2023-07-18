require 'nvim-treesitter.configs'.setup({

  ensure_installed = 'all',
  auto_install = true,
  highlight = {
    enable = true            
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["ic"] = "@comment.inner",
          ["ac"] = "@comment.outer",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["am"] = "@class.outer",
          ["im"] = "@class.inner",
          ["ib"] = "@block.inner",
          ["ab"] = "@block.outer",
          ["a,"] = "@parameter.outer",
          ["i,"] = "@parameter.inner",
        }
      },
  },
  move = {
    enable = true,
    set_jumps = false,
    goto_next_start = {
      ["]]"] = "@function.outer",
      ["],"] = "@parameter.inner",
    },
    goto_next_end = {
      ["]["] = "@function.outer",
    },
    goto_previous_start = {
      ["[["] = "@function.outer",
      ["[,"] = "@parameter.inner",
    },
    goto_previous_end = {
      ["[]"] = "@function.outer",
    },
  },
  indent = {
    enable = true
  },
})

