vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("standardpointer.base")
local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
local server_for_ft = {}
for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", true, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r") -- get filename without extension

  -- Try to require it safely
  local ok, conf = pcall(require, "lsp." .. name)
  if ok then
    -- Check if the config defines its own filetypes or just use its name
    local fts = conf.filetypes or { name }

    for _, ft in ipairs(fts) do
      server_for_ft[ft] = name
    end
  else
    vim.notify("Failed to load LSP config: " .. name, vim.log.levels.WARN)
  end
end
-- Set default root markers for all clients
local lsp_flags = { debounce_flags = 250 }
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  cmp_capabilities = cmp_nvim_lsp.default_capabilities()
else
  cmp_capabilities = vim.lsp.protocol.make_client_capabilities()
end
cmp_capabilities.textDocument.completion.snippetSupport = true
local opts = { noremap = true, silent = true }
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
    local bufnr = args.buf
    -- Add buffer-local setup if needed later
  end,
})
-- Default LSP config
vim.lsp.config('*', {
  flags = lsp_flags,
  capabilities = cmp_capabilities,
  root_markers = { '.git' },
})

server_for_ft = require("standardpointer.lsp_map")
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

-- Preload your per-server configuration tables
local configs = {}
for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", true, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  local ok, def = pcall(dofile, file)
  if ok and type(def) == "table" then
    configs[name] = def
  end
end

-- Autocmd: enable + start only the matching LSP for each filetype
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("AutoStartLSP", { clear = true }),
  callback = function(event)
    local ft = event.match
    local server = server_for_ft[ft]
    if not server then
      return
    end

    local conf = configs[server] or {}

    -- Skip if already attached
    local active = vim.lsp.get_clients({ bufnr = event.buf, name = server })
    if #active > 0 then
      return
    end

    vim.lsp.enable(server)
    vim.defer_fn(function()
      vim.lsp.start(conf)
    end, 30)
  end,
})
