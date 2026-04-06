return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local sorters = require("telescope.sorters")
			local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

			local function custom_sorter()
				return sorters.Sorter:new({
					scoring_function = function(_, prompt, line)
						local score = sorters.get_fzy_sorter().scoring_function(_, prompt, line)
						if line:find("docs") then
							score = score + 1000 -- Add a large value to deprioritize "docs"
						end
						return score
					end,
				})
			end

			telescope.setup({
				defaults = {
					file_sorter = custom_sorter,
					file_ignore_patterns = {
						"__pycache__/",
            "venv/",
            ".venv/",
						"node_modules/",
						".git/",
						"undodir/",
						"target/debug/incremental",
						"target/debug/.fingerprint",
						"target/debug/deps",
						"target/debug/build",
            "worktrees/"
					},
          mappings = {
              i = {
                  ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                  ["dd"] = actions.delete_buffer,
                  ["<C-d>"] = actions.delete_buffer,
              },
          },
				},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
        buffers = {
          sort_mru = true,
          ignore_current_buffer = false,
          previewer = true,
          file_ignore_patterns = {}, -- disables global ignores
        },
			},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })
		end,
	},
}
