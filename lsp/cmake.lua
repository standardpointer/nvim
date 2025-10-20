return {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    single_file_support = true,
    root_dir = vim.fs.root(0, { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }),
    init_options = { buildDirectory = "build" },
}
