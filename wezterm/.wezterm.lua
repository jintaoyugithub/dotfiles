-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Define font settings --
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Bold" },
    { family = "PingFang SC",             weight = "Regular" }, -- macos
    { family = "Microsoft YaHei",         weight = "Regular" }, -- windowos
    { family = "WenQuanYi Micro Hei",     weight = "Regular" },
})
config.font_size = 14.5
config.use_ime = true -- Enable Chinese input support

-- Appearance Settings --
config.window_background_opacity = 0.96
config.macos_window_background_blur = 1
config.colors = {
    background = "#262626",               -- Black background
}
config.color_scheme = 'Catppuccin Frappe' --or Mocha, Macchiato, Frappe, Latte

-- and finally, return the configuration to wezterm
return config
