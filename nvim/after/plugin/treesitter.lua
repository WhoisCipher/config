require'nvim-treesitter.configs'.setup {
  -- Disable specific language parsers
  disable = { "c", "rust" },

  -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,

  -- Ensure parsers are installed
  ensure_installed = { "javascript", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "c", "cpp", },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,

    -- Additional Vim regex highlighting
    additional_vim_regex_highlighting = false,
  },
}
