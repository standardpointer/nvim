return {
    capabilities = cmp_capabilities,
    cmd = { "bash-language-server", "start" },
    cmd_env = { GLOB_PATTERN = "*@(.sh|.zshrc)" },
    root_dir = vim.fs.root(0, { ".git" }) or vim.fn.getcwd(),
    single_file_support = true,
}
