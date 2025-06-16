return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        defaults = {
          hidden = true,
          file_ignore_patterns = {},
          layout_strategy = "horizontal",
          layout_config = {
            preview_cutoff = 0,
            preview_width = 0.6,
          },
          file_previewer   = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer   = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },

        pickers = {
          find_files = {
            hidden = true
          }
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', function()
        builtin.find_files({
          previewer = true,
        })
      end)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    end
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}

