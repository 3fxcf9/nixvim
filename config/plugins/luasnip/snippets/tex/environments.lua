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
------------------------------------------------------------------------------

return {
	-- INLINE MATH
	s(
		{ trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- INLINE MATH ON NEW LINE
	s(
		{ trig = "^mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("$<>$", {
			i(1),
		})
	),
	-- GENERIC ENVIRONMENT
	s(
		{ trig = "beg", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENVIRONMENT WITH ONE EXTRA ARGUMENT
	s(
		{ trig = "beg2", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				i(2),
				d(3, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
	s(
		{ trig = "beg3", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}{<>}{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				i(2),
				i(3),
				d(4, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- EQUATION
	s(
		{ trig = "nn", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- SPLIT EQUATION
	s(
		{ trig = "ss", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{equation*}
            \begin{split}
                <>
            \end{split}
        \end{equation*}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- ALIGN
	s(
		{ trig = "all", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{align*}
            <>
        \end{align*}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- ITEMIZE
	s(
		{ trig = "itt", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{itemize}
            \item <>
        \end{itemize}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	-- ENUMERATE
	s(
		{ trig = "enn", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{enumerate}
            \item <>
        \end{enumerate}
      ]],
			{
				i(0),
			}
		)
	),
	-- ITEM
	s({ trig = "ii", snippetType = "autosnippet" }, {
		t("\\item "),
		-- f(function()
		-- 	return " "
		-- end, {}),
	}, {
		condition = line_begin,
		callbacks = { -- Prevent indentation
			[0] = {
				[events.enter] = function()
					vim.cmd("normal! ==")
					vim.cmd("normal! A")
				end,
			},
		},
	}),
	-- FIGURE
	s(
		{ trig = "fig" },
		fmta(
			[[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
			}
		),
		{ condition = line_begin }
	),
}
