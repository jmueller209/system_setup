hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")

	hl.exec_cmd("swww-daemon")

	hl.exec_cmd("waypaper --restore")

	hl.exec_cmd("ags")
end)
