-------------------------------------------------------------------------------
--  Super Mario World (U) Rainbow Filter #LoveWins Script for Snes9x-rr version
--  https://github.com/snes9x-rr/snes9x
--  
--  Created by BrunoValads, checked in snes9x-rr 1.51 v7
--  http://github.com/brunovalads/smw-stuff
--
--  Just to show support for the gay marriage that is now guaranteed across all
--  the United States of America, as june 26, 2015!
-------------------------------------------------------------------------------

if not emu then
    error("This script runs only on Snes9x")
end

local gui_opacity = 0.6 -- Increase if you want a "difficulty"

function draw_rainbow_filter()
	gui.opacity(gui_opacity)
	local colour_table = {
		"#ff0000", -- red
        "#ffa100", -- orange
        "#f0ff00", -- yellow
        "#00ff00", -- green
        "#0000ff", -- blue        
        "#9900c9", -- purple
    }
	local x1 = -1
	local x2 = 256
	local y1 = -1
	local y2 = 36
	for i = 1, 7 do
		local colour = colour_table[i]
		gui.box(x1, y1, x2, y2, colour, colour)
		y1 = y1 + 38
		y2 = y2 + 38
	end
end

function draw_hashtag()
	gui.opacity(1)
	gui.text(2, 216, "#LoveWins")
end

gui.register(function()
    draw_rainbow_filter()
	draw_hashtag()
end)
