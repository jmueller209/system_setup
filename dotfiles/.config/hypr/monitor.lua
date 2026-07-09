-- 1. Links: 4K Fernseher (HDMI-A-1) @ 120Hz bei Position 0x0
hl.monitor({
	output = "HDMI-A-1",
	mode = "3840x2160@120",
	position = "0x0",
	scale = 1,
})

-- 2. Mitte (MAIN): FullHD Gaming-Monitor (DP-3) @ 240Hz bei Position 3840x0
hl.monitor({
	output = "DP-3",
	mode = "1920x1080@240",
	position = "3840x0",
	scale = 1,
})

-- 3. Rechts: WQHD Monitor (DP-1) @ 144Hz bei Position 5760x0
hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144",
	position = "5760x0",
	scale = 1,
})

-- Fokus auf den mittleren Hauptbildschirm setzen
os.execute("hyprctl dispatch focusmonitor DP-3")
