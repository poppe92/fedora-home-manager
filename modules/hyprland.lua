-- Hyprland Lua config
-- Migrated from hyprland.conf (hyprlang) to Lua (Hyprland 0.55+)
-- The original hyprland.conf is kept alongside this file for reference.

-- ============================================================
-- Variables
-- ============================================================

local HOME = "/home/jesper"
local mainMod = "SUPER"

-- ============================================================
-- Monitors
-- ============================================================

-- Laptop screen
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1.6,
})
-- External screens two 27"
hl.monitor({
	output = "DP-5",
	mode = "preferred",
	position = "auto",
	scale = 1.25,
})
hl.monitor({
	output = "DP-7",
	mode = "preferred",
	position = "auto-right",
	scale = 1.25,
})
-- Home monitor
hl.monitor({
	output = "desc:WAM TYPE-C",
	mode = "preferred",
	position = "auto-right",
	scale = 1,
})
-- Work monitor inverted 32"
hl.monitor({
	output = "desc:Dell Inc. DELL U3223QE FLP7FH3",
	mode = "preferred",
	position = "auto-left",
	scale = 1.25,
})
-- Mirror laptop to the TV
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })
-- All other monitors (catch-all; also covers the FALLBACK case)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- ============================================================
-- Autostart (exec-once)
-- ============================================================

hl.on("hyprland.start", function()
	-- System / compositor helpers
	hl.dispatch(hl.dsp.exec_cmd("swww-daemon --format xrgb"))
	hl.dispatch(hl.dsp.exec_cmd("waybar & swaync"))
	hl.dispatch(hl.dsp.exec_cmd("blueman-applet"))
	hl.dispatch(hl.dsp.exec_cmd("waypaper --restore"))
	hl.dispatch(hl.dsp.exec_cmd("wl-paste --watch cliphist store"))
	hl.dispatch(hl.dsp.exec_cmd("hypridle"))
	hl.dispatch(hl.dsp.exec_cmd("nm-applet"))
	hl.dispatch(hl.dsp.exec_cmd("lxpolkit"))
	hl.dispatch(hl.dsp.exec_cmd("/usr/lib/kdeconnectd"))
	hl.dispatch(hl.dsp.exec_cmd("kdeconnect-indicator"))
	hl.dispatch(
		hl.dsp.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	)
	hl.dispatch(hl.dsp.exec_cmd("/usr/libexec/hyprpolkitagent &"))
	hl.dispatch(hl.dsp.exec_cmd(HOME .. "/.cargo/bin/hyprland-per-window-layout"))
	-- Startup apps
	hl.dispatch(hl.dsp.exec_cmd("zen-browser"))
	hl.dispatch(hl.dsp.exec_cmd("outlook-for-linux"))
	hl.dispatch(hl.dsp.exec_cmd("teams-for-linux"))
	hl.dispatch(hl.dsp.exec_cmd("flatpak run com.slack.Slack"))
	hl.dispatch(hl.dsp.exec_cmd(HOME .. "/git/appimages/Obsidian-1.9.12.AppImage"))
end)

-- ============================================================
-- Environment variables
-- ============================================================

hl.env("EDITOR", "nvim")
hl.env("XCURSOR_SIZE", "24")

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SCREENSHOTS_DIR", HOME .. "/Pictures/Screenshots")

-- Less hassle with electron apps in wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- For less lag on screen in wayland
hl.env("KWIN_DRM_USE_MODIFIERS", "0")

-- ============================================================
-- Config
-- ============================================================

hl.config({
	input = {
		kb_layout = "se,us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape",
		kb_rules = "",

		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},

		sensitivity = 0, -- -1.0 to 1.0, 0 means no modification
	},

	cursor = {
		no_hardware_cursors = false,
		enable_hyprcursor = true,
	},

	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
		allow_tearing = false,
	},

	decoration = {
		rounding = 10,
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	scrolling = {
		direction = "right",
		column_width = 1.0,
		follow_focus = true,
	},

	misc = {
		force_default_wallpaper = 0,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

-- ============================================================
-- Animations
-- ============================================================

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

-- ============================================================
-- Gestures
-- ============================================================

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- ============================================================
-- Workspace rules
-- ============================================================

hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-5" })
hl.workspace_rule({ workspace = "4", monitor = "DP-5", layout = "scrolling", layout_opts = { direction = "right" } })
hl.workspace_rule({ workspace = "5", monitor = "DP-5" })
hl.workspace_rule({ workspace = "8", monitor = "DP-7" })
hl.workspace_rule({ workspace = "9", monitor = "DP-7" })
hl.workspace_rule({ workspace = "10", monitor = "DP-7", layout = "scrolling", layout_opts = { direction = "right" } })

-- ============================================================
-- Window rules
-- ============================================================

hl.window_rule({ name = "zenWorkspace", match = { class = "zen" }, workspace = "3" })
hl.window_rule({ name = "outlookWorkspace", match = { class = "outlook-for-linux" }, workspace = "10" })
hl.window_rule({ name = "slackWorkspace", match = { class = "Slack" }, workspace = "10" })
hl.window_rule({ name = "teamsWorkspace", match = { class = "teams-for-linux" }, workspace = "10" })

-- 1Password: floating, centered, 70% of monitor
hl.window_rule({
	name = "1passwordWorkspace",
	match = { title = "(1Password)" },
	float = true,
	size = { "monitor_w*0.7", "monitor_h*0.7" },
	center = true,
})

-- Quick Access: centered, stays focused
hl.window_rule({
	name = "quickAccessWorkspace",
	match = { title = "^(Quick Access)(.*)$" },
	center = true,
	stay_focused = true,
})

-- GlobalProtect: floating, centered, 30% of monitor, stays focused
hl.window_rule({
	name = "gpWorkspace",
	match = { title = "(GlobalProtect)" },
	stay_focused = true,
	float = true,
	size = { "monitor_w*0.3", "monitor_h*0.3" },
	center = true,
	monitor = "current",
})

-- ============================================================
-- Keybinds
-- ============================================================

-- Basic
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(HOME .. "/.nix-profile/bin/rofi -show drun"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + W", hl.dsp.group.toggle()) -- dwindle

-- Custom binds
hl.bind("Print", hl.dsp.exec_cmd(HOME .. "/.nix-profile/bin/hyprshot -m window -o /home/jesper/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(HOME .. "/.nix-profile/bin/hyprshot -z -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wlogout --protocol layer-shell -b 5"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(
	mainMod .. " + SHIFT + C",
	hl.dsp.exec_cmd(
		HOME
			.. "/.nix-profile/bin/rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}' | wl-copy\""
	)
)
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("1password --quick-access"))

-- Duck sound bind
hl.bind("XF86Launch8", hl.dsp.exec_cmd("pw-play " .. HOME .. "/git/fedora-home-manager/sounds/duck-quacking-37392.mp3"))

-- Brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set 5%-"))

-- Temp binding
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(HOME .. "/git/fedora-home-manager/modules/waybar/launch.sh"))

-- Move focus with arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move focus with HJKL
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Move active window (SHIFT + HJKL)
-- Each direction gets two binds:
--   1. window.move({ direction }) — swap with neighbour (replaces swapwindow)
--   2. window.move({ x/y, relative }) — move by pixels, repeating (replaces moveactive)
-- NOTE: if window.move({ direction }) does not behave like swapwindow at runtime,
--       it may need to be replaced once the exact Lua swap API is confirmed.
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ x = 0, y = 50, relative = true }), { repeating = true })

-- Switch workspaces 1–10 (mainMod + [0-9])
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Switch to extended workspaces 11–20 (mainMod + CTRL + [0-9])
for i = 1, 9 do
	hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.focus({ workspace = 10 + i }))
end
hl.bind(mainMod .. " + CTRL + 0", hl.dsp.focus({ workspace = 20 }))

-- Move active window to workspace 1–10 (mainMod + SHIFT + [0-9])
for i = 1, 9 do
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Move active window to extended workspaces 11–20 (mainMod + CTRL + SHIFT + [0-9])
for i = 1, 9 do
	hl.bind(mainMod .. " + CTRL + SHIFT + " .. i, hl.dsp.window.move({ workspace = 10 + i }))
end
hl.bind(mainMod .. " + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = 20 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + Space", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
