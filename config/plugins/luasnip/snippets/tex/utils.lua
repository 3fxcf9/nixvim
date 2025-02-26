---@diagnostic disable: undefined-global

------------------------------------------------------------------------------
local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1, ""))
	end
end

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
	local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
	local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
	return line_begin or non_letter
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
	s({ trig = "qdd", snippetType = "autosnippet" }, {
		t("\\quad "),
	}),
	s({ trig = "qqdd", snippetType = "autosnippet" }, {
		t("\\qquad "),
	}),
	s(
		{ trig = "qdt", snippetType = "autosnippet" },
		fmta([[\quad\text{<>}]], {
			i(1),
		})
	),
	s(
		{ trig = "qdT", snippetType = "autosnippet" },
		fmta([[\quad\text{<>}\quad]], {
			i(1),
		})
	),
	s({ trig = "npp", snippetType = "autosnippet" }, {
		t({ "\\newpage", "" }),
	}, { condition = line_begin }),
}
