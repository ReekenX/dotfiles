-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cf", function()
  local abs_path = vim.fn.expand("%:p")
  local home = vim.fn.expand("$HOME")

  local function rewrite_via_symlink(real_path, scan_root, depth)
    local handle = vim.loop.fs_scandir(scan_root)
    if not handle then
      return nil
    end
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then
        break
      end
      local entry = scan_root .. "/" .. name
      if type == "link" then
        local target = vim.loop.fs_realpath(entry)
        if target and (real_path == target or real_path:sub(1, #target + 1) == target .. "/") then
          return entry .. real_path:sub(#target + 1)
        end
      elseif type == "directory" and depth > 0 then
        local nested = rewrite_via_symlink(real_path, entry, depth - 1)
        if nested then
          return nested
        end
      end
    end
    return nil
  end

  local scan_roots = { vim.fn.getcwd() }
  do
    local parent = vim.fn.fnamemodify(scan_roots[1], ":h")
    while parent ~= "/" and parent ~= "" and parent ~= scan_roots[#scan_roots] do
      table.insert(scan_roots, parent)
      if parent == home then
        break
      end
      parent = vim.fn.fnamemodify(parent, ":h")
    end
  end

  for _, root in ipairs(scan_roots) do
    local via = rewrite_via_symlink(abs_path, root, 2)
    if via then
      abs_path = via
      break
    end
  end

  local path = abs_path
  local dir = vim.fn.fnamemodify(abs_path, ":h")
  local git_root
  while dir ~= "/" and dir ~= "" do
    if vim.fn.isdirectory(dir .. "/.git") == 1 or vim.fn.filereadable(dir .. "/.git") == 1 then
      git_root = dir
      break
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  if git_root and abs_path:sub(1, #git_root + 1) == git_root .. "/" then
    path = abs_path:sub(#git_root + 2)
  elseif abs_path:sub(1, #home + 1) == home .. "/" then
    path = abs_path:sub(#home + 2)
  end

  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy File Path" })

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fg", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })
