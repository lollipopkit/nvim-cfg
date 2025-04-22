local o, g = vim.o, vim.g

o.number            = true
o.relativenumber    = true
o.termguicolors     = true
o.tabstop           = 4
o.shiftwidth        = 4
o.expandtab         = true
o.smartindent       = true
o.clipboard         = "unnamedplus"
o.splitright        = true
o.splitbelow        = true
o.updatetime        = 300
o.signcolumn        = "yes"
o.mouse             = "a"

-- Markdown 围栏代码块高亮
g.markdown_fenced_languages = {
  "bash", "fish", "go", "rust", "dart", "lua",
  "javascript", "typescript", "swift",
  "json", "yaml", "dockerfile",
}

-- 禁用部分内置插件以加快启动
for _, p in ipairs({
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "matchit", "matchparen",
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
}) do
  g["loaded_" .. p] = 1
end

