return {
	require("luasnip").snippet(
		{ trig = "test", snippetType = "autosnippet" },
		{ require("luasnip").text_node("loaded !") }
	),
}
