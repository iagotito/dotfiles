local telescope = require('telescope')
local sorters = require('telescope.sorters')
local builtin = require('telescope.builtin')

local function custom_sorter()
  return sorters.Sorter:new {
    scoring_function = function(_, prompt, line)
      local score = sorters.get_fzy_sorter().scoring_function(_, prompt, line)
      if line:find('docs') then
        score = score + 1000  -- Add a large value to deprioritize "docs"
      end
      return score
    end
  }
end

telescope.setup{
  defaults = {
    file_sorter = custom_sorter,
    file_ignore_patterns = {
      "__pycache__",
      "venv",
      "node_modules",
      ".git",
      "undodir",
    }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

-- Keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
