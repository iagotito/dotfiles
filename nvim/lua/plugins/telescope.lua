local telescope = require('telescope')
local sorters = require('telescope.sorters')

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
            ".git"
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}

-- Keymaps
require'keymaps.util'

-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- Using lua functions
--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
