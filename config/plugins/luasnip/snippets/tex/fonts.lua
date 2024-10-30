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

local function in_text()
	return not tex_utils.in_mathzone()
end
------------------------------------------------------------------------------

return {
	-- TYPEWRITER i.e. \texttt
	s(
		{ trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\texttt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_text }
	),
	-- ITALIC i.e. \textit
	s(
		{ trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\textit{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- BOLD i.e. \textbf
	s(
		{ trig = "tbb", snippetType = "autosnippet" },
		fmta("\\textbf{<>}", {
			d(1, get_visual),
		})
	),
	-- MATH ROMAN i.e. \mathrm
	s(
		{ trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathrm{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH CALIGRAPHY i.e. \mathcal
	s(
		{ trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH BOLDFACE i.e. \mathbf
	s(
		{ trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH BLACKBOARD i.e. \mathbb
	s(
		{ trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- REGULAR TEXT i.e. \text (in math environments)
	s(
		{ trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\text{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
}
