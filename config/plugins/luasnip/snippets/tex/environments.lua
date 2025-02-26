---@diagnostic disable: unused-local

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1, ""))
	end
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
		}),
		{ condition = _G.not_in_mathzone }
	),
	-- INLINE MATH ON NEW LINE
	s(
		{ trig = "^mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("$<>$", {
			i(1),
		}),
		{ condition = _G.not_in_mathzone }
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
	-- MATH BLOCK
	s(
		{ trig = "--", snippetType = "autosnippet" },
		fmta(
			[[
        \[
            <>
        \]
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- EQUATION
	s(
		{ trig = "dm", snippetType = "autosnippet" },
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
		{ trig = "spp", snippetType = "autosnippet" },
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
