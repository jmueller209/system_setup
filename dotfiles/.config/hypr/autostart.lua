-- Autostart processes when Hyprland launches
hl.on("hyprland.start", function()
	-- 1. Fire up your status bar
	hl.exec_cmd("waybar")

	-- 2. Start the swww wallpaper background daemon
	hl.exec_cmd("swww-daemon")

	-- 3. Tell waypaper to automatically re-apply your last clicked wallpaper
	hl.exec_cmd("waypaper --restore")

	hl.exec_cmd("ags")
end)
