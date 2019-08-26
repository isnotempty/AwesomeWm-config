local themes_path   = os.getenv("HOME") .. "/.config/awesome"
local theme 		= {}

theme.wallpaper     = themes_path .. "/wallpaper/img.png"

theme.color 		= {
	bg 		  = "#181818",
	black     = "#040404",
	black_gray= "#363333",
	dark 	  = "",
	blue	  = "#0EC3B8",
	gray      = "#404040",
	yellow	  = "#C0B738",
	red       = "#D60B17",
	green	  = "#032C2E",
	green_dark= "#091113",
	white	  = "#FFFFFF"
}



theme.font          				= "Industry-Light 10"
theme.fg_normal						= theme.color.highlight
theme.border_width					= 1
theme.bg_normal 					= theme.color.main
theme.border_normal					= "#000000"
theme.border_focus					= theme.color.green
theme.useless_gap 					= 2

-- wibar
theme.wibar_bg 						= theme.color.bg
theme.wibar_fg 						= theme.color.white


-- menubar\
theme.menubar_fg_normal 			= theme.color.white
theme.menubar_bg_normal 			= theme.color.bg
theme.menubar_border_width 			= 0
theme.menubar_fg_focus 				= "#FFFFFF"
theme.menubar_bg_focus 				= theme.color.black_gray

-- taglist
theme.taglist_bg_urgent				= theme.color.red
theme.taglist_fg_focus 				= theme.color.white
theme.taglist_bg_focus 				= theme.color.black_gray
theme.taglist_spacing				= 6

-- tasklist
theme.tasklist_font					= theme.font
theme.tasklist_disable_icon 		= true
theme.tasklist_plain_task_name 		= true
theme.tasklist_fg_normal			= theme.color.white
theme.tasklist_fg_focus				= theme.color.white
theme.tasklist_bg_normal			= theme.color.green_dark
theme.tasklist_bg_focus				= theme.color.black_gray


-- systray
theme.bg_systray 					= theme.color.bg

-- hotkey
theme.hotkeys_label_bg				= theme.color.white
theme.hotkeys_bg 					= theme.color.green
theme.hotkeys_fg 					= theme.color.text
theme.hotkeys_border_width 			= 0
theme.hotkeys_group_margin 			= 20

-- notification
theme.notification_bg				=  theme.color.bg
theme.notification_fg				=  theme.color.white
theme.notification_border_width		=  5
theme.notification_border_color		=  theme.color.black_gray
theme.notification_icon_size 		=  80
theme.notification_max_width        =  400
theme.notification_max_height       =  400
theme.notification_margin			=  80
theme.notification_padding 			=  100

-- exit screen
theme.exit_screen					= {
	border 	= theme.color.black_gray,
	bg 		= theme.color.bg,
	title 	= theme.color.yellow,
	message = theme.color.white,
	button 	= theme.color.black_gray,
	pressed = theme.color.red
}

--Layout
theme.layout_floating  				= themes_path.."/icons/layouts/floating.svg"
theme.layout_tile	  				= themes_path.."/icons/layouts/tile.svg"
theme.layout_fairv  				= themes_path.."/icons/layouts/fair.svg"

-- fullscreen
theme.fullscreen_hide_border 		= true

--  icon 
theme.alert_icon 					= themes_path .. "/icons/yellow.png"
theme.show_apps						= themes_path .. "/icons/apps.svg"

-- color battery
theme.bat 							= {
	normal 							=  theme.color.main
}

return theme

