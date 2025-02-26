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
	-- SUPERSCRIPT
	s(
		{ trig = "([%w%)%]%}])^", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SUBSCRIPT
	s(
		{ trig = "([%w%)%]%}])_", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SUBSCRIPT AND SUPERSCRIPT
	s(
		{ trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- TEXT SUBSCRIPT
	s(
		{ trig = "sd", snippetType = "autosnippet", wordTrig = false },
		fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
		{ condition = _G.in_mathzone }
	),
	-- SUPERSCRIPT SHORTCUT
	-- Places the first alphanumeric character after the trigger into a superscript.
	s(
		{ trig = "([%w%)%]%}])'([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SUBSCRIPT SHORTCUT
	-- Places the first alphanumeric character after the trigger into a subscript.
	s(
		{ trig = "([%w%)%]%}])%.([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = _G.in_mathzone }
	),
	-- EULER'S NUMBER SUPERSCRIPT SHORTCUT
	s(
		{ trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>e^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- ZERO SUBSCRIPT SHORTCUT
	s(
		{ trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("0"),
		}),
		{ condition = _G.in_mathzone }
	),
	-- MINUS ONE SUPERSCRIPT SHORTCUT
	s(
		{ trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("-1"),
		}),
		{ condition = _G.in_mathzone }
	),
	-- COMPLEMENT SUPERSCRIPT
	s(
		{ trig = "([%a%)%]%}])TT", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<><>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("\\transp"),
		}),
		{ condition = _G.in_mathzone }
	),
	-- PLUS SUPERSCRIPT SHORTCUT
	-- s(
	-- 	{ trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta("<>^{<>}", {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		t("+"),
	-- 	}),
	-- 	{ condition = _G.in_mathzone }
	-- ),
	-- COMPLEMENT SUPERSCRIPT
	-- s(
	-- 	{ trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta("<>^{<>}", {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		t("\\complement"),
	-- 	}),
	-- 	{ condition = _G.in_mathzone }
	-- ),
	-- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
	-- s(
	-- 	{ trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta("<>^{<>}", {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		t("*"),
	-- 	}),
	-- 	{ condition = _G.in_mathzone }
	-- ),
	-- VECTOR, i.e. \vec
	s(
		{ trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\vec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
	s(
		{ trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\unitvector_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- UNIT VECTOR WITH HAT, i.e. \uvec{}
	-- s(
	-- 	{ trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
	-- 	fmta("<>\\uvec{<>}", {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		d(1, get_visual),
	-- 	}),
	-- 	{ condition = _G.in_mathzone }
	-- ),
	-- MATRIX, i.e. \vec
	s(
		{ trig = "([^%a])mt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\mat{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- FRACTION
	s(
		{ trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- ANGLE
	s(
		{ trig = "([^%a])gg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\ang{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- ABSOLUTE VALUE
	s(
		{ trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\left|<>\\right|", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SQUARE ROOT
	s(
		{ trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- BINOMIAL SYMBOL
	s(
		{ trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\binom{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- LOGARITHM WITH BASE SUBSCRIPT
	s(
		{ trig = "([^%a%\\])lg", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\log_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = _G.in_mathzone }
	),
	-- DERIVATIVE with denominator only
	s(
		{ trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dv{}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- DERIVATIVE with numerator and denominator
	s(
		{ trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- DERIVATIVE with numerator, denominator, and higher-order argument
	s(
		{ trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = _G.in_mathzone }
	),
	-- PARTIAL DERIVATIVE with denominator only
	s(
		{ trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdv{}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	-- PARTIAL DERIVATIVE with numerator and denominator
	s(
		{ trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
	s(
		{ trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SUM with lower limit
	s(
		{ trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = _G.in_mathzone }
	),
	-- SUM with upper and lower limit
	s(
		{ trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- INTEGRAL with upper and lower limit
	s(
		{ trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = _G.in_mathzone }
	),
	-- INTEGRAL from positive to negative infinity
	s(
		{ trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{\\infty}^{\\infty}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = _G.in_mathzone }
	),
	-- INFTY
	s({ trig = "inff", snippetType = "autosnippet" }, {
		t("\\infty"),
	}),
	-- BOXED command
	s(
		{ trig = "([^%a])bb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\boxed{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = _G.in_mathzone }
	),
	--
	-- BEGIN STATIC SNIPPETS
	--

	-- FORALL, i.e. \forall
	s({ trig = "ll", priority = 2000, snippetType = "autosnippet" }, {
		t("\\forall "),
	}, { condition = _G.in_mathzone }),
	-- EXISTS, i.e. \exists
	s({ trig = "ss", priority = 2000, snippetType = "autosnippet" }, {
		t("\\exists "),
	}, { condition = _G.in_mathzone }),
	-- DIFFERENTIAL, i.e. \mathrm{d}
	s({ trig = "dd", priority = 2000, snippetType = "autosnippet" }, {
		t("\\dd "),
	}, { condition = _G.in_mathzone }),
	-- DIVERGENCE OPERATOR, i.e. \divergence
	s({ trig = "DI", snippetType = "autosnippet" }, {
		t("\\div "),
	}, { condition = _G.in_mathzone }),
	-- LAPLACIAN OPERATOR, i.e. \laplacian
	s({ trig = "laa", snippetType = "autosnippet" }, {
		t("\\laplacian "),
	}, { condition = _G.in_mathzone }),
	-- PARALLEL SYMBOL, i.e. \parallel
	s({ trig = "||", snippetType = "autosnippet" }, {
		t("\\parallel "),
	}),
	-- CDOTS, i.e. \cdots
	s({ trig = "cdd", snippetType = "autosnippet" }, {
		t("\\cdots "),
	}),
	-- LDOTS, i.e. \ldots
	s({ trig = "ldd", snippetType = "autosnippet" }, {
		t("\\ldots "),
	}),
	-- EQUIV, i.e. \equiv
	s({ trig = "evv", snippetType = "autosnippet" }, {
		t("\\equiv "),
	}),
	-- SETMINUS, i.e. \setminus
	s({ trig = "stm", snippetType = "autosnippet" }, {
		t("\\setminus "),
	}),
	-- SUBSET, i.e. \subset
	s({ trig = "sbb", snippetType = "autosnippet" }, {
		t("\\subset "),
	}),
	-- APPROX, i.e. \approx
	s({ trig = "px", snippetType = "autosnippet" }, {
		t("\\approx "),
	}, { condition = _G.in_mathzone }),
	-- PROPTO, i.e. \propto
	s({ trig = "pt", snippetType = "autosnippet" }, {
		t("\\propto "),
	}, { condition = _G.in_mathzone }),
	-- IFF, i.e. \iff
	s({ trig = "<>", snippetType = "autosnippet" }, {
		t("\\iff "),
	}),
	-- IMPLIES, i.e. \implies
	s({ trig = ">>", snippetType = "autosnippet" }, {
		t("\\implies "),
	}),
	-- DOT PRODUCT, i.e. \cdot
	s({ trig = ",.", snippetType = "autosnippet" }, {
		t("\\cdot "),
	}),
	-- CROSS PRODUCT, i.e. \times
	s({ trig = "xx", snippetType = "autosnippet" }, {
		t("\\times "),
	}),
	-- FUNCTION (CUSTOM COMMAND)
	s(
		{ trig = "applic", regTrig = true, wordTrig = false },
		fmta("\\applic{<>}{<>}{<>}{<>}", {
			i(1, "start"),
			i(2, "end"),
			i(3, "variable"),
			i(4, "function"),
		}),
		{ condition = _G.in_mathzone }
	),
}
