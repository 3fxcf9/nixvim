---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1, ""))
	end
end

local ts = require("vim.treesitter")

local MATH_ENVIRONMENTS = {
	displaymath = true,
	equation = true,
	eqnarray = true,
	align = true,
	math = true,
	array = true,
}

local MATH_NODES = {
	displayed_equation = true,
	inline_formula = true,
}

local function get_node_at_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cursor_range = { cursor[1] - 1, cursor[2] }
	local buf = vim.api.nvim_get_current_buf()
	local ok, parser = pcall(ts.get_parser, buf, "latex")
	if not ok or not parser then
		return nil
	end
	local root_tree = parser:parse()[1]
	local root = root_tree and root_tree:root()

	if not root then
		return nil
	end

	return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

local function in_comment()
	local node = get_node_at_cursor()
	while node do
		if node:type() == "comment" then
			return true
		end
		node = node:parent()
	end
	return false
end

local function in_mathzone()
	local buf = vim.api.nvim_get_current_buf()
	local node = get_node_at_cursor()
	while node do
		if MATH_NODES[node:type()] then
			return true
		elseif node:type() == "math_environment" or node:type() == "generic_environment" then
			local begin = node:child(0)
			local names = begin and begin:field("name")
			if names and names[1] then
				local name_text = vim.treesitter.get_node_text(names[1], buf)
				if name_text and MATH_ENVIRONMENTS[name_text:match("[A-Za-z]+")] then
					return true
				end
			end
		end
		node = node:parent()
	end
	return false
end
------------------------------------------------------------------------------

return {
	-- \frac
	s(
		{ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta([[\href{<>}{<>}]], {
			i(1, "url"),
			i(2, "display name"),
		})
	),
	s({ trig = "q" }, {
		t("\\quad "),
	}),
	s({ trig = "qq", snippetType = "autosnippet" }, {
		t("\\qquad "),
	}),
	s({ trig = "npp", snippetType = "autosnippet" }, {
		t({ "\\newpage", "" }),
	}, { condition = line_begin }),
	s({ trig = "inff", snippetType = "autosnippet" }, {
		t("\\infty"),
	}),
}
