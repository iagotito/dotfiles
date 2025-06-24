local def_pattern = [[\v^\s*(class|def|async def)>]]

-- Function to jump with count support (like the original Python_jump function)
local function python_jump(mode, pattern, flags, count)
	count = count or vim.v.count1

	if mode == "x" then
		vim.cmd("normal! gv")
	end

	-- Set mark
	vim.cmd("normal! m'")

	-- For backward search, move cursor one line up to avoid skipping current match
	if string.find(flags, "b") then
		vim.cmd("normal! k")
	end

	-- Jump count times
	for _ = 1, count do
		vim.fn.search(pattern, flags)
	end

	-- Move to beginning of line
	vim.cmd("normal! ^")
end

-- Function to jump to next method/class (like ]m)
local function jump_next_method()
	python_jump("n", def_pattern, "W")
end

-- Function to jump to previous method/class (like [m)
local function jump_prev_method()
	python_jump("n", def_pattern, "Wb")
end

-- Use vim.keymap.set directly with buffer-local mappings
vim.keymap.set("n", "))", jump_next_method, { buffer = true, desc = "Jump to next method/class" })
vim.keymap.set("n", "((", jump_prev_method, { buffer = true, desc = "Jump to previous method/class" })

-- Visual mode mappings
vim.keymap.set("v", "))", function()
	python_jump("x", def_pattern, "W")
end, { buffer = true })
vim.keymap.set("v", "((", function()
	python_jump("x", prev_pattern, "Wb")
end, { buffer = true })

-- Operator-pending mode mappings
vim.keymap.set("o", "))", function()
	python_jump("o", def_pattern, "W")
end, { buffer = true })
vim.keymap.set("o", "((", function()
	python_jump("o", prev_pattern, "Wb")
end, { buffer = true })
