local wezterm = require("wezterm")

return {
	-- window_background_opacity = 1,
	window_background_opacity = 0.95,
	macos_window_background_blur = 10,
	window_decorations = "RESIZE",
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("IosevkaTerm NFP", { weight = "DemiBold", stretch = "Normal", style = "Normal" }),
	-- font = wezterm.font("DepartureMono Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	font_size = 14,
	freetype_load_target = "Light",
	freetype_load_flags = "DEFAULT",
	freetype_render_target = "Light",
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = {
		hue = 5.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	native_macos_fullscreen_mode = true,
	use_dead_keys = false,
	window_background_image_hsb = {
		brightness = 0.8,
		hue = 1.0,
		saturation = 1.0,
	},
	audible_bell = "Disabled",
	visual_bell = {
		fade_in_duration_ms = 5,
		fade_out_duration_ms = 5,
	},
	colors = {
		visual_bell = "#f0f0f0",
	},
}
