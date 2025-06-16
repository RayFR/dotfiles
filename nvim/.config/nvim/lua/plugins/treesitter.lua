return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = { "lua", "javascript", "python", "html", "css", "tsx" },
      indent = { enable = true },
      highlight = { enable = true },
    })
  end
}
