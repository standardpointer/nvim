local status, fold_prev = pcall(require, "fold-preview")
if not status then
    return
end

fold_prev.setup({
    border = "single",
})
