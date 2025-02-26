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
	-- LEFT/RIGHT PARENTHESES
	s(
		{ trig = "lp", wordTrig = true, snippetType = "autosnippet" },
		fmta("\\left(<>\\right)", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- LEFT/RIGHT SQUARE BRACES
	s(
		{ trig = "lq", wordTrig = true, snippetType = "autosnippet" },
		fmta("\\left[<>\\right]", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- LEFT/RIGHT CURLY BRACES
	s(
		{ trig = "lc", snippetType = "autosnippet", wordTrig = true },
		fmta("\\left\\{<>\\right\\}", { d(1, get_visual) })
	),
	-- BIG PARENTHESES
	s(
		{ trig = "bp", wordTrig = true, snippetType = "autosnippet" },
		fmta("\\big(<>\\big)", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- BIG SQUARE BRACES
	s(
		{ trig = "bq", wordTrig = true, snippetType = "autosnippet" },
		fmta("\\big[<>\\big]", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- BIG CURLY BRACES
	s(
		{ trig = "bc", wordTrig = true, snippetType = "autosnippet" },
		fmta("\\big\\{<>\\big\\}", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- ESCAPED CURLY BRACES
	s(
		{ trig = "\\%{", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		fmta("\\{<>\\}", {
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
}
