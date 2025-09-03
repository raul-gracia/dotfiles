local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Tokyo Night color scheme
config.colors = {
	foreground = "#c0caf5",
	background = "#1a1b26",
	cursor_bg = "#c0caf5",
	cursor_fg = "#1a1b26",
	cursor_border = "#c0caf5",
	selection_fg = "#c0caf5",
	selection_bg = "#33467c",
	scrollbar_thumb = "#292e42",
	split = "#7aa2f7",

	ansi = {
		"#15161e", -- black
		"#f7768e", -- red
		"#9ece6a", -- green
		"#e0af68", -- yellow
		"#7aa2f7", -- blue
		"#bb9af7", -- magenta
		"#7dcfff", -- cyan
		"#a9b1d6", -- white
	},
	brights = {
		"#414868", -- bright black
		"#f7768e", -- bright red
		"#9ece6a", -- bright green
		"#e0af68", -- bright yellow
		"#7aa2f7", -- bright blue
		"#bb9af7", -- bright magenta
		"#7dcfff", -- bright cyan
		"#c0caf5", -- bright white
	},

	-- Tab bar colors
	tab_bar = {
		background = "#15161e",
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
		},
		inactive_tab = {
			bg_color = "#292e42",
			fg_color = "#545c7e",
		},
		inactive_tab_hover = {
			bg_color = "#292e42",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#15161e",
			fg_color = "#7aa2f7",
		},
		new_tab_hover = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
		},
	},
}

-- Background image configuration
config.background = {
	-- First layer: Solid color background matching Tokyo Night Storm
	{
		source = {
			Color = "#24283b",
		},
		width = "100%",
		height = "100%",
		opacity = 1,
	},
	-- Second layer: Background image with low opacity to blend with the color
	{
		source = {
			File = "/Users/raulgracia/dotfiles/others/iterm-wallpaper-2.jpg",
		},
		opacity = 0.1, -- Similar to Warp's opacity: 10
		hsb = {
			brightness = 0.3, -- Further darken the image
			saturation = 0.6, -- Reduce saturation for better blending
		},
		horizontal_align = "Center",
		vertical_align = "Middle",

		-- Stretch to fill the window
		width = "Cover",
		height = "Cover",
	},
}

-- Window configuration
config.window_background_opacity = 0.95
config.text_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 15,
	right = 15,
	top = 15,
	bottom = 15,
}

-- Font configuration
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"Fira Code",
	"JetBrains Mono",
	"Monaco",
})
config.font_size = 13.0
config.line_height = 1.2

-- Cursor configuration
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.tab_max_width = 25

-- Scrollback
config.scrollback_lines = 10000

-- Enable true colors
config.term = "wezterm"

-- Window blur (if supported by OS)
config.macos_window_background_blur = 20

-- Key bindings
config.keys = {
	-- Split panes
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Navigate panes
	{
		key = "LeftArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	-- Close pane
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Copy/Paste
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	-- New tab
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Navigate tabs
	{
		key = "[",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- Toggle fullscreen
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},

	-- Clear scrollback
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}

-- Mouse bindings
config.mouse_bindings = {
	-- Right click to paste
	{
		event = { Up = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	-- Ctrl-click to open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Hyperlink rules
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Shell
config.default_prog = { "/opt/homebrew/bin/fish" }

return config
