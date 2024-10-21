local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local menu_watcher = sbar.add("item", {
	drawing = false,
	updates = true,
})
sbar.add("event", "swap_menus_and_spaces")

local max_items = 15
local menu_items = {}
for i = 1, max_items, 1 do
	local menu = sbar.add("item", "menu." .. i, {
		padding_left = settings.paddings,
		padding_right = settings.paddings,
		drawing = false,
		icon = { drawing = false },
		label = {
			font = {
				style = settings.font.style_map[i == 1 and "Heavy" or "Semibold"],
			},
			padding_left = 6,
			padding_right = 6,
		},
		click_script = "$CONFIG_DIR/helpers/menu/bin/menus -s " .. i,
	})
	menu_items[i] = menu
end

sbar.add("bracket", { "/menu\\..*/" }, {
	background = { color = colors.bg1 },
})

local menu_padding = sbar.add("item", "menu.padding", {
	drawing = false,
	width = 5,
})

local function update_menus(env)
	sbar.exec("$CONFIG_DIR/helpers/menus/bin/menus -l", function(menus)
		sbar.set("/menu\\..*/", { drawing = false })
		menu_padding:set({ drawing = true })
		id = 1
		for menu in string.gmatch(menus, "[^\r\n]+") do
			if id < max_items then
				menu_items[id]:set({ label = menu, drawing = true })
			else
				break
			end
			id = id + 1
		end
	end)
end

return menu_watcher
