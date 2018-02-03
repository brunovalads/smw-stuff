--------------------------------------------------------------------
--  Super Mario World Sprite Data Per Sprite -  for BizHawk only!!
--  
--  Author: BrunoValads 
--  Git repository: https://github.com/brunovalads/smw-stuff
--------------------------------------------------------------------

-- Sprite names
local SPRITE_NAMES = {
	[0x00] = "Green Koopa Troopa without shell",
	[0x01] = "Red Koopa Troopa without shell",
	[0x02] = "Blue Koopa Troopa without shell",
	[0x03] = "Yellow Koopa Troopa without shell",
	[0x04] = "Green Koopa Troopa",
	[0x05] = "Red Koopa Troopa",
	[0x06] = "Blue Koopa Troopa",
	[0x07] = "Yellow Koopa Troopa",
	[0x08] = "Green Koopa Troopa flying left",
	[0x09] = "Green Koopa Troopa bouncing",
	[0x0A] = "Red Koopa Troopa flying vertically",
	[0x0B] = "Red Koopa Troopa flying horizontally",
	[0x0C] = "Yellow Koopa Troopa with wings",
	[0x0D] = "Bob-Omb",
	[0x0E] = "Keyhole",
	[0x0F] = "Goomba",
	[0x10] = "Bouncing Goomba with wings",
	[0x11] = "Buzzy Beetle",
	[0x12] = "Unused",
	[0x13] = "Spiny",
	[0x14] = "Spiny falling",
	[0x15] = "Cheep Cheep swimming horizontally",
	[0x16] = "Cheep Cheep swimming vertically",
	[0x17] = "Cheep Cheep flying",
	[0x18] = "Cheep Cheep jumping to surface",
	[0x19] = "Display text from level message 1",
	[0x1A] = "Classic Piranha Plant",
	[0x1B] = "Bouncing Football in place",
	[0x1C] = "Bullet Bill",
	[0x1D] = "Hopping flame",
	[0x1E] = "Lakitu",
	[0x1F] = "Magikoopa",
	[0x20] = "Magikoopa's magic",
	[0x21] = "Moving coin",
	[0x22] = "Green vertical net Koopa",
	[0x23] = "Red vertical net Koopa",
	[0x24] = "Green horizontal net Koopa",
	[0x25] = "Red horizontal net Koopa",
	[0x26] = "Thwomp",
	[0x27] = "Thwimp",
	[0x28] = "Big Boo",
	[0x29] = "Koopa Kid",
	[0x2A] = "Upside-down Piranha Plant",
	[0x2B] = "Sumo Brother's lightning",
	[0x2C] = "Yoshi egg",
	[0x2D] = "Baby Yoshi",
	[0x2E] = "Spike Top",
	[0x2F] = "Portable springboard",
	[0x30] = "Dry Bones that throws bones",
	[0x31] = "Bony Beetle",
	[0x32] = "Dry Bones that stays on ledges",
	[0x33] = "Podoboo/vertical fireball",
	[0x34] = "Boss fireball",
	[0x35] = "Yoshi",
	[0x36] = "Unused",
	[0x37] = "Boo",
	[0x38] = "Eerie that moves straight",
	[0x39] = "Eerie that moves in a wave",
	[0x3A] = "Urchin that moves a fixed distance",
	[0x3B] = "Urchin that moves between walls",
	[0x3C] = "Urchin that follows walls",
	[0x3D] = "Rip Van Fish",
	[0x3E] = "P-switch",
	[0x3F] = "Para-Goomba",
	[0x40] = "Para-Bomb",
	[0x41] = "Dolphin that swims and jumps in one direction",
	[0x42] = "Dolphin that swims and jumps back and forth",
	[0x43] = "Dolphin that swims and jumps up and down",
	[0x44] = "Torpedo Ted",
	[0x45] = "Directional coins",
	[0x46] = "Diggin' Chuck",
	[0x47] = "Swimming/jumping fish",
	[0x48] = "Diggin' Chuck's rock",
	[0x49] = "Growing/shrinking pipe",
	[0x4A] = "Goal Point Question Sphere",
	[0x4B] = "Pipe-dwelling Lakitu",
	[0x4C] = "Exploding block",
	[0x4D] = "Monty Mole, ground-dwelling",
	[0x4E] = "Monty Mole, ledge-dwelling",
	[0x4F] = "Jumping Piranha Plant",
	[0x50] = "Jumping Piranha Plant that spits fireballs",
	[0x51] = "Ninji",
	[0x52] = "Moving hole in ghost house ledge",
	[0x53] = "Throw block sprite",
	[0x54] = "Revolving door for climbing net",
	[0x55] = "Checkerboard platform, horizontal",
	[0x56] = "Flying rock platform, horizontal",
	[0x57] = "Checkerboard platform, vertical",
	[0x58] = "Flying rock platform, vertical",
	[0x59] = "Turn block bridge, horizontal and vertical",
	[0x5A] = "Turn block bridge, horizontal",
	[0x5B] = "Floating brown platform",
	[0x5C] = "Floating checkerboard platform",
	[0x5D] = "Small orange floating platform",
	[0x5E] = "Large orange floating platform",
	[0x5F] = "Swinging brown platform",
	[0x60] = "Flat switch palace switch",
	[0x61] = "Floating skulls",
	[0x62] = "Brown line-guided platform",
	[0x63] = "Brown/checkered line-guided platform",
	[0x64] = "Line-guided rope mechanism",
	[0x65] = "Chainsaw (line-guided)",
	[0x66] = "Upside-down chainsaw (line-guided)",
	[0x67] = "Grinder, line-guided",
	[0x68] = "Fuzzy, line-guided",
	[0x69] = "Unused",
	[0x6A] = "Coin game cloud",
	[0x6B] = "Wall springboard (left wall)",
	[0x6C] = "Wall springboard (right wall)",
	[0x6D] = "Invisible solid block",
	[0x6E] = "Dino-Rhino",
	[0x6F] = "Dino-Torch",
	[0x70] = "Pokey",
	[0x71] = "Super Koopa with red cape",
	[0x72] = "Super Koopa with yellow cape",
	[0x73] = "Super Koopa on the ground",
	[0x74] = "Mushroom",
	[0x75] = "Flower",
	[0x76] = "Star",
	[0x77] = "Feather",
	[0x78] = "1-Up mushroom",
	[0x79] = "Growing vine",
	[0x7A] = "Firework",
	[0x7B] = "Goal tape",
	[0x7C] = "Peach (after Bowser fight)",
	[0x7D] = "P-Balloon",
	[0x7E] = "Flying red coin",
	[0x7F] = "Flying golden mushroom",
	[0x80] = "Key",
	[0x81] = "Changing item",
	[0x82] = "Bonus game sprite",
	[0x83] = "Flying question block that flies left",
	[0x84] = "Flying question block that flies back and forth",
	[0x85] = "Unused",
	[0x86] = "Wiggler",
	[0x87] = "Lakitu's cloud",
	[0x88] = "Winged cage (unused)",
	[0x89] = "Layer 3 Smash",
	[0x8A] = "Yoshi's House bird",
	[0x8B] = "Puff of smoke from Yoshi's House",
	[0x8C] = "Side exit enabler",
	[0x8D] = "Ghost house exit sign and door",
	[0x8E] = "Invisible warp hole",
	[0x8F] = "Scale platforms",
	[0x90] = "Large green gas bubble",
	[0x91] = "Chargin' Chuck",
	[0x92] = "Splittin' Chuck",
	[0x93] = "Bouncin' Chuck",
	[0x94] = "Whistlin' Chuck",
	[0x95] = "Chargin' Chuck",
	[0x96] = "Unused",
	[0x97] = "Puntin' Chuck",
	[0x98] = "Pitchin' Chuck",
	[0x99] = "Volcano Lotus",
	[0x9A] = "Sumo Brother",
	[0x9B] = "Amazing Flying Hammer Brother",
	[0x9C] = "Flying gray blocks for Hammer Brother",
	[0x9D] = "Sprite in a bubble",
	[0x9E] = "Ball 'n' Chain",
	[0x9F] = "Banzai Bill",
	[0xA0] = "Bowser battle activator",
	[0xA1] = "Bowser's bowling ball",
	[0xA2] = "Mecha-Koopa",
	[0xA3] = "Rotating gray platform",
	[0xA4] = "Floating spike ball",
	[0xA5] = "Wall-following Sparky/Fuzzy",
	[0xA6] = "Hothead",
	[0xA7] = "Iggy's ball projectile",
	[0xA8] = "Blargg",
	[0xA9] = "Reznor",
	[0xAA] = "Fishbone",
	[0xAB] = "Rex",
	[0xAC] = "Wooden spike pointing down",
	[0xAD] = "Wooden spike pointing up",
	[0xAE] = "Fishin' Boo",
	[0xAF] = "Boo Block",
	[0xB0] = "Reflecting stream of Boo Buddies",
	[0xB1] = "Creating/eating block",
	[0xB2] = "Falling spike",
	[0xB3] = "Bowser statue fireball",
	[0xB4] = "Grinder that moves on the ground",
	[0xB5] = "Unused",
	[0xB6] = "Reflecting fireball",
	[0xB7] = "Carrot Top Lift, upper right",
	[0xB8] = "Carrot Top Lift, upper left",
	[0xB9] = "Info Box",
	[0xBA] = "Timed Lift",
	[0xBB] = "Moving castle block",
	[0xBC] = "Bowser statue",
	[0xBD] = "Sliding Koopa",
	[0xBE] = "Swooper",
	[0xBF] = "Mega Mole",
	[0xC0] = "Sinking gray platform on lava",
	[0xC1] = "Flying gray turn blocks",
	[0xC2] = "Blurp",
	[0xC3] = "Porcu-Puffer",
	[0xC4] = "Gray platform that falls",
	[0xC5] = "Big Boo Boss",
	[0xC6] = "Spotlight/dark room sprite",
	[0xC7] = "Invisible mushroom",
	[0xC8] = "Light switch for dark room",
	[0xC9] = "Bullet Bill shooter",
	[0xCA] = "Torpedo Ted launcher",
	[0xCB] = "Eerie generator",
	[0xCC] = "Para-Goomba generator",
	[0xCD] = "Para-Bomb generator",
	[0xCE] = "Para-Goomba and Para-Bomb generator",
	[0xCF] = "Dolphin generator (left)",
	[0xD0] = "Dolphin generator (right)",
	[0xD1] = "Flying fish generator",
	[0xD2] = "Turn Off Generator 2",
	[0xD3] = "Super Koopa generator",
	[0xD4] = "Bubbled sprite generator",
	[0xD5] = "Bullet Bill generator",
	[0xD6] = "Multidirectional Bullet Bill generator",
	[0xD7] = "Multidirectional diagonal Bullet Bill generator",
	[0xD8] = "Bowser statue fire generator",
	[0xD9] = "Turn Off Generators",
	[0xDA] = "Green Koopa shell",
	[0xDB] = "Red Koopa shell",
	[0xDC] = "Blue Koopa shell",
	[0xDD] = "Yellow Koopa shell",
	[0xDE] = "Group of 5 wave-moving Eeries",
	[0xDF] = "Green Para-Koopa shell",
	[0xE0] = "3 rotating gray platforms",
	[0xE1] = "Boo Ceiling",
	[0xE2] = "Boo Ring moving counterclockwise",
	[0xE3] = "Boo Ring moving clockwise",
	[0xE4] = "Swooper Death Bat Ceiling",
	[0xE5] = "Appearing/disappearing Boos",
	[0xE6] = "Background candle flames",
	[0xE7] = "Unused",
	[0xE8] = "Special auto-scroll command",
	[0xE9] = "Layer 2 Smash",
	[0xEA] = "Layer 2 scrolling command",
	[0xEB] = "Unused",
	[0xEC] = "Unused",
	[0xED] = "Layer 2 Falls",
	[0xEE] = "Unused",
	[0xEF] = "Layer 2 sideways-scrolling command",
	[0xF0] = "Unused",
	[0xF1] = "Unused",
	[0xF2] = "Layer 2 on/off switch controller",
	[0xF3] = "Standard auto-scroll command",
	[0xF4] = "Fast background scroll",
	[0xF5] = "Layer 2 sink command",
	[0xF6] = "Unused",
	[0xF7] = "Unused",
	[0xF8] = "Unused",
	[0xF9] = "Unused",
	[0xFA] = "Unused",
	[0xFB] = "Unused",
	[0xFC] = "Unused",
	[0xFD] = "Unused",
	[0xFE] = "Unused",
	[0xFF] = "Unused"
}

-- Check if it's SMW
if gameinfo.getromhash() ~= "6B47BB75D16514B6A476AA0C73A683A2A4C18765" then error("This is not SMW nor a good ROM!") end

-- Prepare enviroment
os.execute("mkdir Sprite_by_sprite")
local Sprite_occu_table_full = {}
for i = 0, 0xff do
  Sprite_occu_table_full[i] = {}
  for j = 0, 0x1ff do
    Sprite_occu_table_full[i][j] = 0 -- i is the sprite id, j is the level id
  end
end
console.clear()

-- Renaming some functions
local fmt = string.format

-- Level scan loop
for level_id = 0, 0x1ff do

  -- Sprite data enviroment
  local pointer = 0x70000 + memory.read_u16_le(0x05EC00 + 2*level_id, "System Bus") -- $05EC00 is Ptrs05EC00 (Sprite Data pointer table)
  
  -- Read sprite data
  for id = 0, 0x7f do
    
    -- Read bytes
    local byte_1 = memory.readbyte(pointer + id*3 + 1, "System Bus")
    if byte_1 == 0xff then break end -- end of sprite data for this level
    local byte_3 = memory.readbyte(pointer + id*3 + 3, "System Bus") -- sprite ID

    -- Add the occurrences
    Sprite_occu_table_full[byte_3][level_id] = Sprite_occu_table_full[byte_3][level_id] + 1
  end
  
  print(fmt("Level %03X scanned!", level_id))

end

-- CI2 extra levels
local CI2_extra = {
  {pointer = 0x07D7EA, level = "CI2 Rex level"},
  {pointer = 0x07D825, level = "CI2 Red Paratroopa level"},
  {pointer = 0x07D86E, level = "CI2 Dino-Rhino level"},
  {pointer = 0x07D888, level = "CI2 Secret exit level"},
  {pointer = 0x07D8A1, level = "CI2 Rex stack level"}
}
for i = 0, 0xff do
  for ext_level = 1, 5 do
    Sprite_occu_table_full[i][CI2_extra[ext_level].pointer] = 0
  end
end
for ext_level = 1, 5 do
  
  -- Read sprite data
  for id = 0, 0x7f do
    
    -- Read bytes
    local byte_1 = memory.readbyte(CI2_extra[ext_level].pointer + id*3 + 1, "System Bus")
    if byte_1 == 0xff then break end -- end of sprite data for this level
    local byte_3 = memory.readbyte(CI2_extra[ext_level].pointer + id*3 + 3, "System Bus") -- sprite ID

    -- Add the occurrences
    Sprite_occu_table_full[byte_3][CI2_extra[ext_level].pointer] = Sprite_occu_table_full[byte_3][CI2_extra[ext_level].pointer] + 1
  end
  
  print(fmt("%s scanned!", CI2_extra[ext_level].level))
  
end

-- Open main file
local full_occu_file = io.open("SMW Sprite Data Per Sprite.txt", "w")

-- Sprite occurrence loop
for sprite_id = 0, 0xff do
  
  -- Open file
  local sprite_occu_file = io.open(fmt("Sprite_by_sprite\\Sprite $%02X Occurrences.txt", sprite_id), "w")
  
  -- Write sprite header
  sprite_occu_file:write(fmt("### Sprite $%02X - %s ###", sprite_id, SPRITE_NAMES[sprite_id]))
  full_occu_file:write(fmt("### Sprite $%02X - %s ###", sprite_id, SPRITE_NAMES[sprite_id]))
  
  -- Loop thru levels
  local occu_str
  local total_occu = 0
  for level_id = 0, 0x1ff do
    
    if Sprite_occu_table_full[sprite_id][level_id] > 0 then -- if occurs any
      
      -- Write occurrence
      occu_str = fmt("\n in level %03X: %d time(s)", level_id, Sprite_occu_table_full[sprite_id][level_id])
      sprite_occu_file:write(occu_str)
      full_occu_file:write(occu_str)
      
      total_occu = total_occu + Sprite_occu_table_full[sprite_id][level_id]
    end
  end
  -- CI2 extra levels
  for ext_level = 1, 5 do
    
    if Sprite_occu_table_full[sprite_id][CI2_extra[ext_level].pointer] > 0 then -- if occurs any
    
      -- Write occurrence
      occu_str = fmt("\n in %s: %d time(s)", CI2_extra[ext_level].level, Sprite_occu_table_full[sprite_id][CI2_extra[ext_level].pointer])
      sprite_occu_file:write(occu_str)
      full_occu_file:write(occu_str)

      total_occu = total_occu + Sprite_occu_table_full[sprite_id][CI2_extra[ext_level].pointer]
    end
  end
  
  -- Finalize
  sprite_occu_file:write(fmt("\n Total occurrences: %d", total_occu))
  full_occu_file:write(fmt("\n Total occurrences: %d\n\n", total_occu))
  sprite_occu_file:close()
  print(fmt("Sprite %02X done!", sprite_id))
  
end

full_occu_file:close()

print("\nSMW 100% DONE!!!")