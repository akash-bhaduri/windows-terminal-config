-- This file is used to configure WezTerm, a terminal emulator.
-- pulling the wezterm api
local wezterm = require("wezterm")

--this will hold the configuration
local config = wezterm.config_builder()

config.default_prog = { "pwsh", "-NoLogo" }

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0 -- Slightly smaller for a cleaner look
config.line_height = 1.1

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Gruvbox Theme Configuration
config.color_scheme = "Gruvbox Dark (Gogh)"
config.window_background_opacity = 1.0 -- Restored to original opacity
config.win32_system_backdrop = "Acrylic"

-- UI Enhancements
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 25,
	right = 25,
	top = 20,
	bottom = 20,
}

-- Cursor Styling
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Miscellaneous
config.audible_bell = "Disabled"
config.send_composed_key_when_left_alt_is_pressed = false

-- Improved Tab Bar Aesthetics (Gruvbox style)
config.colors = {
	tab_bar = {
		background = "#1d2021",
		active_tab = {
			bg_color = "#32302f",
			fg_color = "#ebdbb2",
			intensity = "Bold",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#1d2021",
			fg_color = "#a89984",
		},
		inactive_tab_hover = {
			bg_color = "#32302f",
			fg_color = "#ebdbb2",
			italic = true,
		},
		new_tab = {
			bg_color = "#1d2021",
			fg_color = "#a89984",
		},
		new_tab_hover = {
			bg_color = "#32302f",
			fg_color = "#ebdbb2",
			italic = true,
		},
	},
}

-- Status Bar Update Logic
wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = "#ebdbb2" } },
		{ Background = { Color = "#32302f" } },
		{ Text = "  󱎫 " .. date .. "  " },
	}))
end)

-- Previous opacity setting commented out
-- config.window_background_opacity = 1

-- Previous color configuration commented out
-- config.colors = {
-- 	foreground = "#CDD6F4",
-- 	background = "#1E1E2E",
-- 	cursor_bg = "#CDD6F4",
-- 	cursor_border = "#CDD6F4",
-- 	cursor_fg = "#1E1E2E",
-- 	selection_bg = "#585B70",
-- 	selection_fg = "#CDD6F4",
-- 	ansi = {
-- 		"#45475A", -- black
-- 		"#F38BA8", -- red
-- 		"#A6E3A1", -- green
-- 		"#F9E2AF", -- yellow
-- 		"#89B4FA", -- blue
-- 		"#F5C2E7", -- purple
-- 		"#94E2D5", -- cyan
-- 		"#BAC2DE", -- white
-- 	},
-- 	brights = {
-- 		"#585B70", -- bright black
-- 		"#F38BA8", -- bright red
-- 		"#A6E3A1", -- bright green
-- 		"#F9E2AF", -- bright yellow
-- 		"#89B4FA", -- bright blue
-- 		"#F5C2E7", -- bright purple
-- 		"#94E2D5", -- bright cyan
-- 		"#A6ADC8", -- bright white
-- 	},
-- }

config.keys = {
	{
		key = "F11",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if window:get_selection_text_for_pane(pane) ~= "" then
				window:perform_action(wezterm.action.CopyTo("Clipboard"), pane)
			else
				window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
			end
		end),
	},
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{
		key = "CapsLock",
		action = wezterm.action.SendKey({ key = "Escape" }),
	},
}

-- keep adding more configuration options here

return config
