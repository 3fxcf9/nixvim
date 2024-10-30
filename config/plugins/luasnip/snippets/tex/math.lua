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
	-- SUPERSCRIPT
	s(
		{ trig = "([%w%)%]%}])^", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- TEXT SUBSCRIPT
	s(
		{ trig = "sd", snippetType = "autosnippet", wordTrig = false },
		fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- MINUS ONE SUPERSCRIPT SHORTCUT
	s(
		{ trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("-1"),
		}),
		{ condition = in_mathzone }
	),
	-- PLUS SUPERSCRIPT SHORTCUT
	s(
		{ trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("+"),
		}),
		{ condition = in_mathzone }
	),
	-- COMPLEMENT SUPERSCRIPT
	s(
		{ trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("\\complement"),
		}),
		{ condition = in_mathzone }
	),
	-- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
	s(
		{ trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("*"),
		}),
		{ condition = in_mathzone }
	),
	-- VECTOR, i.e. \vec
	s(
		{ trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\vec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- UNIT VECTOR WITH HAT, i.e. \uvec{}
	s(
		{ trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\uvec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
	-- MATRIX, i.e. \vec
	s(
		{ trig = "([^%a])mt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\mat{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- ABSOLUTE VALUE
	s(
		{ trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\abs{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- LOGARITHM WITH BASE SUBSCRIPT
	s(
		{ trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\log_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = in_mathzone }
	),
	-- DERIVATIVE with denominator only
	s(
		{ trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- PARTIAL DERIVATIVE with denominator only
	s(
		{ trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
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
		{ condition = in_mathzone }
	),
	-- INTEGRAL from positive to negative infinity
	s(
		{ trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{\\infty}^{\\infty}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = in_mathzone }
	),
	-- BOXED command
	s(
		{ trig = "([^%a])bb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\boxed{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
	--
	-- BEGIN STATIC SNIPPETS
	--

	-- DIFFERENTIAL, i.e. \diff
	s({ trig = "dd", snippetType = "autosnippet", priority = 2000, snippetType = "autosnippet" }, {
		t("\\dd"),
	}, { condition = in_mathzone }),
	-- DIVERGENCE OPERATOR, i.e. \divergence
	s({ trig = "DI", snippetType = "autosnippet" }, {
		t("\\div "),
	}, { condition = in_mathzone }),
	-- LAPLACIAN OPERATOR, i.e. \laplacian
	s({ trig = "laa", snippetType = "autosnippet" }, {
		t("\\laplacian "),
	}, { condition = in_mathzone }),
	-- PARALLEL SYMBOL, i.e. \parallel
	s({ trig = "||", snippetType = "autosnippet" }, {
		t("\\parallel"),
	}),
	-- CDOTS, i.e. \cdots
	s({ trig = "cdd", snippetType = "autosnippet" }, {
		t("\\cdots"),
	}),
	-- LDOTS, i.e. \ldots
	s({ trig = "ldd", snippetType = "autosnippet" }, {
		t("\\ldots"),
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
	}, { condition = in_mathzone }),
	-- PROPTO, i.e. \propto
	s({ trig = "pt", snippetType = "autosnippet" }, {
		t("\\propto "),
	}, { condition = in_mathzone }),
	-- COLON, i.e. \colon
	s({ trig = "::", snippetType = "autosnippet" }, {
		t("\\colon "),
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
}
