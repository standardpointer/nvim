local function get_language_id()
    local ext = vim.fn.expand("%:e")
    if ext == "ml" then return "ocaml" end
    if ext == "re" then return "reason" end
    return "plaintext"
end

return {
    cmd = { "ocamllsp" },
    get_language_id = get_language_id,
    filetypes = { "ocaml", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_dir = vim.fs.root(0, { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" }),
}
