--##################################################################################
--##                                                                              ## 
--##   Super Mario World (any version) Utility Script for BizHawk                 ## 
--##   http://tasvideos.org/Bizhawk.html                                          ## 
--##                                                                              ## 
--##   Authors: Bruno Valadão Cunha  (BrunoValads)  [9 april 2018 ~ today]        ##
--##            Rodrigo A. do Amaral (Amaraticando) [15 july 2014 ~ 8 april 2018] ##
--##                                                                              ## 
--##   Git repository: https://github.com/brunovalads/smw-stuff                   ## 
--##                                                                              ## 
--##################################################################################

--#############################################################################
-- CONFIG (YOU PROBABLY WANT TO EDIT THE SMW-BizHawk-config.ini FILE INSTEAD OF THIS)

local INI_CONFIG_NAME = "SMW-BizHawk-config.ini"

local config = {}

config.DEFAULT_OPTIONS = {
  -- Hotkeys  (look at the manual to see all the valid keynames)
  -- make sure that the hotkeys below don't conflict with previous bindings
  hotkey_increase_opacity = "equals",  -- to increase the opacity of the text: the '='/'+' key
  hotkey_decrease_opacity = "minus",  -- to decrease the opacity of the text: the '_'/'-' key

  -- Display -- TODO: ORGANIZE after all the Menu changes
  display_movie_info = true,
  display_lag_indicator = true,
  display_game_info = true,
  display_RNG_info = false,
  display_player_info = true,
  display_player_main_info = true,
  display_player_hitbox = true,
  display_player_block_interaction = true,
  display_cape_hitbox = true,
  display_debug_player_extra = false,
  display_sprite_info = true,
  display_sprite_main_table = true,
  display_sprite_hitbox = true,
  display_sprite_vs_sprite_hitbox = false,
  display_debug_sprite_tweakers = false,
  display_debug_sprite_extra = false,
  display_other_sprites_info = true,
  display_extended_sprite_info = true,
  display_extended_sprite_hitbox = true,
  display_debug_extended_sprite = false,
  display_cluster_sprite_info = true,
  display_cluster_sprite_hitbox = true,
  display_debug_cluster_sprite = false,
  display_minor_extended_sprite_info = true,
  display_minor_extended_sprite_hitbox = true,
  display_debug_minor_extended_sprite = false,
  display_bounce_sprite_info = true,
  display_debug_bounce_sprite = false,
  display_quake_sprite_info = true,
  display_level_info = true,
  display_level_main_info = true,
  display_level_boundary = false,
  display_sprite_vanish_area = true,
  display_sprite_spawning_areas = true,
  display_sprite_data = true,
  display_sprite_load_status = true,
  display_screen_info = false,
  display_yoshi_info = true,
  display_counters = true,
  display_overworld_info = true,
  display_event_table = true,
  display_controller_input = true,
  display_static_camera_region = false,
  register_player_position_changes = "simple",  -- valid options: false, "simple" and "complete"
  use_block_duplication_predictor = true,
  draw_tiles_with_click = true,
  display_mouse_coordinates = true,
  display_lagmeter = true,

  -- Some extra/debug info
  display_controller_data = false,
  debug_collision_routine = true,
  register_ACE_debug_callback = true,  -- helps to see when some A.C.E. addresses are executed
  display_misc_sprite_table = {
    [1] = false, 	[2] = false, 	[3] = false, 	[4] = true, 	[5] = false, 	[6] = false, 	[7] = false,
    [8] = false, 	[9] = false, 	[10] = false, 	[11] = false, 	[12] = true, 	[13] = true, 	[14] = true,
    [15] = true, 	[16] = true, 	[17] = true, 	[18] = true, 	[19] = true, 	[20] = true, 	[21] = true,
    [22] = true, 	[23] = true, 	[24] = true, 	[25] = false, 	[26] = true, 	[27] = false, 	[28] = false,
    [29] = true, 	[30] = false, 	[31] = false, 	[32] = false, 	[33] = true, 	[34] = true, 	[35] = false,
    [36] = false, 	[37] = false, 	[38] = true, 	[39] = false, 	[40] = false, 	[41] = false, 	[42] = false,
    [43] = false, 	[44] = false, 	[45] = false, 	[46] = true, 	[47] = false, 	[48] = false, 	[49] = false
  },

  -- Script settings
  load_comparison_ghost = false,
  show_comparison_ghost = true,
  ghost_filename = false,  -- use the smw-tas.ini to edit this setting
  make_lua_drawings_on_video = false,
  use_custom_fonts = true,
  text_background_type = "automatic",  -- valid options: "full", "outline" and "automatic"
  max_tiles_drawn = 20,  -- the max number of tiles to be drawn/registered by the script

  -- Timer and Idle callbacks frequencies
  timer_period = math.floor(1000000/30),  -- 30 hertz
  idle_period = math.floor(1000000/10),  -- 10 hertz

  -- Lateral gaps (initial values)
  left_gap = 8*(12 + 6),
  right_gap = (36*10/2)+2,  -- (36 maximum chars of the sprite info)*(10 pixels of BizHawk font width)/(2, the scale)+(2 to make it fit better)
  top_gap = 20,
  bottom_gap = 50,

  -- other stuff
  filter_opacity = 0
}

-- Colour settings
config.DEFAULT_COLOUR = {
  -- Text
  default_text_opacity = 1.0,
  default_bg_opacity = 0.4,
  text = "#ffffffff",
  background = "#000000ff",
  outline = "#000040ff",
  warning = "#ff0000ff",
  warning_bg = "#0000ffff",
  warning2 = "#ff00ffff",
  positive = "#00ff00ff",
  positive2 = "#00ffffff",
  weak = "#a9a9a9ff",
  very_weak = "#ffffff60",
  disabled = "#808080ff",
  joystick_input = "#ffff00ff",
  joystick_input_bg = "#ffffff30",
  button_text = "#300030ff",
  mainmenu_outline = "#ffffffc0",
  mainmenu_bg = "#000000c0",

  -- Counters
  counter_pipe = "#00ff00ff",
  counter_multicoin = "#ffff00ff",
  counter_gray_pow = "#a5a5a5ff",
  counter_blue_pow = "#4242deff",
  counter_dircoin = "#8c5a19ff",
  counter_pballoon = "#f8d870ff",
  counter_star = "#ffd773ff",
  counter_fireflower = "#ff8c00ff",

  -- hitbox and related text
  mario = "#ff0000ff",
  mario_bg = "#00000000",
  mario_mounted_bg = "#00000000",
  interaction = "#ffffffff",
  interaction_bg = "#00000020",
  interaction_nohitbox = "#000000a0",
  interaction_nohitbox_bg = "#00000070",
  mario_oam_hitbox = "#00ff80ff",
  cape = "#ffd700ff",
  cape_bg = "#ffd70060",

  -- Sprites
  sprites = {
    0xff80FFFF, -- cyan
    0xffA0A0FF, -- blue
    0xffFF6060, -- red
    0xffFF80FF, -- magenta
    0xffFFA100, -- orange
    0xffFFFF80, -- yellow
    0xff40FF40  -- green
  },
  sprites_interaction_pts = "#ffffffff",
  sprites_bg = "#0000b070",
  sprites_clipping_bg = "#000000a0",
  sprites_faint = "#00000010",
  sprite_vision_active = "#d00000ff",
  sprite_vision_active_bg = "#d0000020",
  sprite_vision_passive = "#00d0d0c0",
  extended_sprites = "#ff8000ff",
  extended_sprites_bg = "#00ff0050",
  special_extended_sprite_bg = "#00ff0060",
  goal_tape_bg = "#ffff0050",
  fireball = "#b0d0ffff",
  baseball = "#0040a0ff",
  cluster_sprites = "#ff80a0ff",
  sumo_brother_flame = "#0040a0ff",
  minor_extended_sprites = "#ff90b0ff",
  quake_sprite = "#00d0d0d0",
  quake_sprite_bg = "#d0000020",
  awkward_hitbox = "#204060ff",
  awkward_hitbox_bg = "#ff800060",

  -- Yoshi
  yoshi = "#00ffffff",
  yoshi_bg = "#00ffff40",
  yoshi_mounted_bg = "#00000000",
  tongue_line = "#ffa000ff",
  tongue_bg = "#00000060",

  -- Level related
  block = "#00008bff",
  blank_tile = "#ffffff70",
  block_bg = "#22cc88a0",
  layer2_line = "#ff2060ff",
  layer2_bg = "#ff206040",
  static_camera_region = "#40002040",
  screen_borders = "#0000FF80",

  -- other stuff
  filter_tonality = "#000000ff",
}

-- Input key names
local INPUT_KEYNAMES = {  -- BizHawk

  A=false, Add=false, Alt=false, Apps=false, Attn=false, B=false, Back=false, BrowserBack=false, BrowserFavorites=false,
  BrowserForward=false, BrowserHome=false, BrowserRefresh=false, BrowserSearch=false, BrowserStop=false, C=false,
  Cancel=false, Capital=false, CapsLock=false, Clear=false, Control=false, ControlKey=false, Crsel=false, D=false, D0=false,
  D1=false, D2=false, D3=false, D4=false, D5=false, D6=false, D7=false, D8=false, D9=false, Decimal=false, Delete=false,
  Divide=false, Down=false, E=false, End=false, Enter=false, EraseEof=false, Escape=false, Execute=false, Exsel=false,
  F=false, F1=false, F10=false, F11=false, F12=false, F13=false, F14=false, F15=false, F16=false, F17=false, F18=false,
  F19=false, F2=false, F20=false, F21=false, F22=false, F23=false, F24=false, F3=false, F4=false, F5=false, F6=false,
  F7=false, F8=false, F9=false, FinalMode=false, G=false, H=false, HanguelMode=false, HangulMode=false, HanjaMode=false,
  Help=false, Home=false, I=false, IMEAccept=false, IMEAceept=false, IMEConvert=false, IMEModeChange=false,
  IMENonconvert=false, Insert=false, J=false, JunjaMode=false, K=false, KanaMode=false, KanjiMode=false, KeyCode=false,
  L=false, LaunchApplication1=false, LaunchApplication2=false, LaunchMail=false, LButton=false, LControlKey=false,
  Left=false, LineFeed=false, LMenu=false, LShiftKey=false, LWin=false, M=false, MButton=false, MediaNextTrack=false,
  MediaPlayPause=false, MediaPreviousTrack=false, MediaStop=false, Menu=false, Modifiers=false, Multiply=false, N=false,
  Next=false, NoName=false, None=false, NumLock=false, NumPad0=false, NumPad1=false, NumPad2=false, NumPad3=false,
  NumPad4=false, NumPad5=false, NumPad6=false, NumPad7=false, NumPad8=false, NumPad9=false, O=false, Oem1=false,
  Oem102=false, Oem2=false, Oem3=false, Oem4=false, Oem5=false, Oem6=false, Oem7=false, Oem8=false, OemBackslash=false,
  OemClear=false, OemCloseBrackets=false, Oemcomma=false, OemMinus=false, OemOpenBrackets=false, OemPeriod=false,
  OemPipe=false, Oemplus=false, OemQuestion=false, OemQuotes=false, OemSemicolon=false, Oemtilde=false, P=false, Pa1=false,
  Packet=false, PageDown=false, PageUp=false, Pause=false, Play=false, Print=false, PrintScreen=false, Prior=false,
  ProcessKey=false, Q=false, R=false, RButton=false, RControlKey=false, Return=false, Right=false, RMenu=false, RShiftKey=false,
  RWin=false, S=false, Scroll=false, Select=false, SelectMedia=false, Separator=false, Shift=false, ShiftKey=false,
  Sleep=false, Snapshot=false, Space=false, Subtract=false, T=false, Tab=false, U=false, Up=false, V=false, VolumeDown=false,
  VolumeMute=false, VolumeUp=false, W=false, X=false, XButton1=false, XButton2=false, Y=false, Z=false, Zoom=false
}

--#############################################################################
-- INITIAL STATEMENTS

-- Clear console mesages
console.clear()

-- Load environment
package.path = "bizhawk/scripts/lib/?.lua" .. ";" .. package.path
local gui, input, joypad, emu, movie, memory, mainmemory, bit = gui, input, joypad, emu, movie, memory, mainmemory, bit
local unpack = unpack or table.unpack
local string, math, table, next, ipairs, pairs, io, os, type = string, math, table, next, ipairs, pairs, io, os, type

local fmt = string.format
local floor = math.floor

local INI_CONFIG_FILEPATH = "./" .. INI_CONFIG_NAME  -- relative to the folder of the script

local NTSC_FRAMERATE = 60.0988138974405
local PAL_FRAMERATE = 50.0069789081886

--############################################################################
-- MODULES (now unmodularized)

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- LUAP: General purpose lua extension

local luap = {}

function luap.get_emulator_name()
  if lsnes_features then return "lsnes"
  elseif bizstring then return "BizHawk"
  elseif snes9x then return "Snes9x"
  else return nil
  end
end

function luap.file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

function luap.unrequire(mod)
  package.loaded[mod] = nil
  _G[mod] = nil
end

local function copytable(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[copytable(orig_key)] = copytable(orig_value) -- possible stack overflow
    end
    setmetatable(copy, copytable(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end
luap.copytable = copytable

local function mergetable(source, t2)
  for key, value in pairs(t2) do
    if type(value) == "table" then
      if type(source[key] or false) == "table" then
        mergetable(source[key] or {}, t2[key] or {}) -- possible stack overflow
      else
        source[key] = value
      end
    else
      source[key] = value
    end
  end
  return source
end
luap.mergetable = mergetable

-- Creates a set from a list
function luap.make_set(list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- Sum of the digits of a integer
function luap.sum_digits(number)
  local sum = 0
  while number > 0 do
    sum = sum + number%10
    number = floor(number*0.1)
  end

  return sum
end

-- Returns the exact chosen digit of a number from the left to the right or from the right to the left, in a given base
-- E.g.: read_digit(654321, 2, 10, "left to right") -> 5; read_digit(0x4B7A, 3, 16, "right to left") -> 3
function luap.read_digit(number, digit, base, direction)
  if number == 0 then return 0 end -- exception

    local copy = number
    local digits_total = 0
    while copy >= 1 do
        copy = floor(copy/base)
        digits_total = digits_total + 1
    end

    if digit > digits_total then return false end

  local exponent
  if direction == "left to right" then
    exponent = digits_total - digit
  elseif direction == "right to left" then
    exponent = digit - 1
  end

    local result = floor(number/base^(exponent))%base
    return result
end

-- verify whether a point is inside a rectangle
function luap.inside_rectangle(xpoint, ypoint, x1, y1, x2, y2)
  -- From top-left to bottom-right
  if x2 < x1 then
    x1, x2 = x2, x1
  end
  if y2 < y1 then
    y1, y2 = y2, y1
  end

  if xpoint >= x1 and xpoint <= x2 and ypoint >= y1 and ypoint <= y2 then
    return true
  else
    return false
  end
end

-- unsigned to signed (based in <bits> bits)
function luap.signed16(num)
  local maxval = 32768
  if num < maxval then return num else return num - 2*maxval end
end

-- unsigned byte to signed in hex string
function luap.signed8hex(num, signal)
  local maxval = 128
  if signal == nil then signal = true end
  
  if num < maxval then -- positive
    return fmt("%s%02X", signal and "+" or "", num)
  else -- negative
    return fmt("%s%02X", signal and "-" or "", 2*maxval - num)
  end  
end

-- unsigned word to signed in hex string
function luap.signed16hex(num, signal)
  local maxval = 32768
  if signal == nil then signal = true end
  
  if num < maxval then -- positive
    return fmt("%s%04X", signal and "+" or "", num)
  else -- negative
    return fmt("%s%04X", signal and "-" or "", 2*maxval - num)
  end  
end

-- Returns a table of arguments from string, according to pattern
-- the default [pattern] splits the arguments separated with spaces
function luap.get_arguments(arg, pattern)
  if not arg or arg == "" then return end
  pattern = pattern or "%S+"

  local list = {}
  for word in string.gmatch(arg, pattern) do
    list[#list + 1] = word
  end

  local unpack = table.unpack or unpack  -- Lua compatibility
  return unpack(list)
end

-- Transform the binary representation of base into a string
-- For instance, if each bit of a number represents a char of base, then this function verifies what chars are on
function luap.decode_bits(data, base)
  local i = 1
  local size = base:len()
  local direct_concatenation = size <= 45  -- Performance: I found out that the .. operator is faster for 45 operations or less
  local result

  if direct_concatenation then
    result = ""
    for ch in base:gmatch(".") do
      if bit.test(data, size - i) then
        result = result .. ch
      else
        result = result .. " "
      end
      i = i + 1
    end
  else
    result = {}
    for ch in base:gmatch(".") do
      if bit.test(data, size-i) then
        result[i] = ch
      else
        result[i] = " "
      end
      i = i + 1
    end
    result = table.concat(result)
  end

  return result
end

if math.type then
  function luap.is_integer(num)
    return math.type(num) == "integer"
  end
else
  function luap.is_integer(num)
    return num%1 == 0
  end
end

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- JSON

-- This library is from: Jeffrey Friedl
-- Modified from original, according to the license below:

-- -*- coding: utf-8 -*-
--
-- Simple JSON encoding and decoding in pure Lua.
--
-- Copyright 2010-2014 Jeffrey Friedl
-- http://regex.info/blog/
--
-- Latest version: http://regex.info/blog/lua/json
--
-- This code is released under a Creative Commons CC-BY "Attribution" License:
-- http://creativecommons.org/licenses/by/3.0/deed.en_US
--
-- It can be used for any purpose so long as the copyright notice above,
-- the web-page links above, and the 'AUTHOR_NOTE' string below are
-- maintained. Enjoy.
--
local VERSION = 20141223.14 -- version history at end of file
local AUTHOR_NOTE = "-[ JSON.lua package by Jeffrey Friedl (http://regex.info/blog/lua/json) version 20141223.14 ]-"

--
-- The 'AUTHOR_NOTE' variable exists so that information about the source
-- of the package is maintained even in compiled versions. It's also
-- included in OBJDEF below mostly to quiet warnings about unused variables.
--
local OBJDEF = {
  VERSION    = VERSION,
  AUTHOR_NOTE  = AUTHOR_NOTE,
}


local default_pretty_indent  = "  "
local default_pretty_options = { pretty = true, align_keys = false, indent = default_pretty_indent }

local isArray  = { __tostring = function() return "JSON array"  end }   isArray.__index  = isArray
local isObject = { __tostring = function() return "JSON object" end }   isObject.__index = isObject


function OBJDEF:newArray(tbl)
  return setmetatable(tbl or {}, isArray)
end

function OBJDEF:newObject(tbl)
  return setmetatable(tbl or {}, isObject)
end

local function unicode_codepoint_as_utf8(codepoint)
  --
  -- codepoint is a number
  --
  if codepoint <= 127 then
    return string.char(codepoint)

  elseif codepoint <= 2047 then
    --
    -- 110yyyxx 10xxxxxx      <-- useful notation from http://en.wikipedia.org/wiki/Utf8
    --
    local highpart = floor(codepoint / 0x40)
    local lowpart  = codepoint - (0x40 * highpart)
    return string.char(0xC0 + highpart,
             0x80 + lowpart)

  elseif codepoint <= 65535 then
    --
    -- 1110yyyy 10yyyyxx 10xxxxxx
    --
    local highpart  = floor(codepoint / 0x1000)
    local remainder = codepoint - 0x1000 * highpart
    local midpart  = floor(remainder / 0x40)
    local lowpart  = remainder - 0x40 * midpart

    highpart = 0xE0 + highpart
    midpart  = 0x80 + midpart
    lowpart  = 0x80 + lowpart

    --
    -- Check for an invalid character (thanks Andy R. at Adobe).
    -- See table 3.7, page 93, in http://www.unicode.org/versions/Unicode5.2.0/ch03.pdf#G28070
    --
    if ( highpart == 0xE0 and midpart < 0xA0 ) or
     ( highpart == 0xED and midpart > 0x9F ) or
     ( highpart == 0xF0 and midpart < 0x90 ) or
     ( highpart == 0xF4 and midpart > 0x8F )
    then
     return "?"
    else
     return string.char(highpart,
              midpart,
              lowpart)
    end

  else
    --
    -- 11110zzz 10zzyyyy 10yyyyxx 10xxxxxx
    --
    local highpart  = floor(codepoint / 0x40000)
    local remainder = codepoint - 0x40000 * highpart
    local midA    = floor(remainder / 0x1000)
    remainder     = remainder - 0x1000 * midA
    local midB    = floor(remainder / 0x40)
    local lowpart  = remainder - 0x40 * midB

    return string.char(0xF0 + highpart,
             0x80 + midA,
             0x80 + midB,
             0x80 + lowpart)
  end
end

function OBJDEF:onDecodeError(message, text, location, etc)
  if text then
    if location then
     message = string.format("%s at char %d of: %s", message, location, text)
    else
     message = string.format("%s: %s", message, text)
    end
  end

  if etc ~= nil then
    message = message .. " (" .. OBJDEF:encode(etc) .. ")"
  end

  if self.assert then
    self.assert(false, message)
  else
    assert(false, message)
  end
end

OBJDEF.onDecodeOfNilError  = OBJDEF.onDecodeError
OBJDEF.onDecodeOfHTMLError = OBJDEF.onDecodeError

function OBJDEF:onEncodeError(message, etc)
  if etc ~= nil then
    message = message .. " (" .. OBJDEF:encode(etc) .. ")"
  end

  if self.assert then
    self.assert(false, message)
  else
    assert(false, message)
  end
end

local function grok_number(self, text, start, etc)
  --
  -- Grab the integer part
  --
  local integer_part = text:match('^-?[1-9]%d*', start)
           or text:match("^-?0",      start)

  if not integer_part then
    self:onDecodeError("expected number", text, start, etc)
  end

  local i = start + integer_part:len()

  --
  -- Grab an optional decimal part
  --
  local decimal_part = text:match('^%.%d+', i) or ""

  i = i + decimal_part:len()

  --
  -- Grab an optional exponential part
  --
  local exponent_part = text:match('^[eE][-+]?%d+', i) or ""

  i = i + exponent_part:len()

  local full_number_text = integer_part .. decimal_part .. exponent_part
  local as_number = tonumber(full_number_text)

  if not as_number then
    self:onDecodeError("bad number", text, start, etc)
  end

  return as_number, i
end


local function grok_string(self, text, start, etc)

  if text:sub(start,start) ~= '"' then
    self:onDecodeError("expected string's opening quote", text, start, etc)
  end

  local i = start + 1 -- +1 to bypass the initial quote
  local text_len = text:len()
  local VALUE = ""
  while i <= text_len do
    local c = text:sub(i,i)
    if c == '"' then
     return VALUE, i + 1
    end
    if c ~= '\\' then
     VALUE = VALUE .. c
     i = i + 1
    elseif text:match('^\\b', i) then
     VALUE = VALUE .. "\b"
     i = i + 2
    elseif text:match('^\\f', i) then
     VALUE = VALUE .. "\f"
     i = i + 2
    elseif text:match('^\\n', i) then
     VALUE = VALUE .. "\n"
     i = i + 2
    elseif text:match('^\\r', i) then
     VALUE = VALUE .. "\r"
     i = i + 2
    elseif text:match('^\\t', i) then
     VALUE = VALUE .. "\t"
     i = i + 2
    else
     local hex = text:match('^\\u([0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF])', i)
     if hex then
      i = i + 6 -- bypass what we just read

      -- We have a Unicode codepoint. It could be standalone, or if in the proper range and
      -- followed by another in a specific range, it'll be a two-code surrogate pair.
      local codepoint = tonumber(hex, 16)
      if codepoint >= 0xD800 and codepoint <= 0xDBFF then
        -- it's a hi surrogate... see whether we have a following low
        local lo_surrogate = text:match('^\\u([dD][cdefCDEF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF])', i)
        if lo_surrogate then
          i = i + 6 -- bypass the low surrogate we just read
          codepoint = 0x2400 + (codepoint - 0xD800) * 0x400 + tonumber(lo_surrogate, 16)
        else
          -- not a proper low, so we'll just leave the first codepoint as is and spit it out.
        end
      end
      VALUE = VALUE .. unicode_codepoint_as_utf8(codepoint)

     else

      -- just pass through what's escaped
      VALUE = VALUE .. text:match('^\\(.)', i)
      i = i + 2
     end
    end
  end

  self:onDecodeError("unclosed string", text, start, etc)
end

local function skip_whitespace(text, start)

  local _, match_end = text:find("^[ \n\r\t]+", start) -- [http://www.ietf.org/rfc/rfc4627.txt] Section 2
  if match_end then
    return match_end + 1
  else
    return start
  end
end

local grok_one -- assigned later

local function grok_object(self, text, start, etc)
  if text:sub(start,start) ~= '{' then
    self:onDecodeError("expected '{'", text, start, etc)
  end

  local i = skip_whitespace(text, start + 1) -- +1 to skip the '{'

  local VALUE = self.strictTypes and self:newObject { } or { }

  if text:sub(i,i) == '}' then
    return VALUE, i + 1
  end
  local text_len = text:len()
  while i <= text_len do
    local key, new_i = grok_string(self, text, i, etc)

    i = skip_whitespace(text, new_i)

    if text:sub(i, i) ~= ':' then
     self:onDecodeError("expected colon", text, i, etc)
    end

    i = skip_whitespace(text, i + 1)

    local new_val, new_i = grok_one(self, text, i)

    VALUE[key] = new_val

    --
    -- Expect now either '}' to end things, or a ',' to allow us to continue.
    --
    i = skip_whitespace(text, new_i)

    local c = text:sub(i,i)

    if c == '}' then
     return VALUE, i + 1
    end

    if text:sub(i, i) ~= ',' then
     self:onDecodeError("expected comma or '}'", text, i, etc)
    end

    i = skip_whitespace(text, i + 1)
  end

  self:onDecodeError("unclosed '{'", text, start, etc)
end

local function grok_array(self, text, start, etc)
  if text:sub(start,start) ~= '[' then
    self:onDecodeError("expected '['", text, start, etc)
  end

  local i = skip_whitespace(text, start + 1) -- +1 to skip the '['
  local VALUE = self.strictTypes and self:newArray { } or { }
  if text:sub(i,i) == ']' then
    return VALUE, i + 1
  end

  local VALUE_INDEX = 1

  local text_len = text:len()
  while i <= text_len do
    local val, new_i = grok_one(self, text, i)

    -- can't table.insert(VALUE, val) here because it's a no-op if val is nil
    VALUE[VALUE_INDEX] = val
    VALUE_INDEX = VALUE_INDEX + 1

    i = skip_whitespace(text, new_i)

    --
    -- Expect now either ']' to end things, or a ',' to allow us to continue.
    --
    local c = text:sub(i,i)
    if c == ']' then
     return VALUE, i + 1
    end
    if text:sub(i, i) ~= ',' then
     self:onDecodeError("expected comma or '['", text, i, etc)
    end
    i = skip_whitespace(text, i + 1)
  end
  self:onDecodeError("unclosed '['", text, start, etc)
end


grok_one = function(self, text, start, etc)
  -- Skip any whitespace
  start = skip_whitespace(text, start)

  if start > text:len() then
    self:onDecodeError("unexpected end of string", text, nil, etc)
  end

  if text:find('^"', start) then
    return grok_string(self, text, start, etc)

  elseif text:find('^[-0123456789 ]', start) then
    return grok_number(self, text, start, etc)

  elseif text:find('^%{', start) then
    return grok_object(self, text, start, etc)

  elseif text:find('^%[', start) then
    return grok_array(self, text, start, etc)

  elseif text:find('^true', start) then
    return true, start + 4

  elseif text:find('^false', start) then
    return false, start + 5

  elseif text:find('^null', start) then
    return nil, start + 4

  else
    self:onDecodeError("can't parse JSON", text, start, etc)
  end
end

function OBJDEF:decode(text, etc)
  if type(self) ~= 'table' or self.__index ~= OBJDEF then
    OBJDEF:onDecodeError("JSON:decode must be called in method format", nil, nil, etc)
  end

  if text == nil then
    self:onDecodeOfNilError(string.format("nil passed to JSON:decode()"), nil, nil, etc)
  elseif type(text) ~= 'string' then
    self:onDecodeError(string.format("expected string argument to JSON:decode(), got %s", type(text)), nil, nil, etc)
  end

  if text:match('^%s*$') then
    return nil
  end

  if text:match('^%s*<') then
    -- Can't be JSON... we'll assume it's HTML
    self:onDecodeOfHTMLError(string.format("html passed to JSON:decode()"), text, nil, etc)
  end

  --
  -- Ensure that it's not UTF-32 or UTF-16.
  -- Those are perfectly valid encodings for JSON (as per RFC 4627 section 3),
  -- but this package can't handle them.
  --
  if text:sub(1,1):byte() == 0 or (text:len() >= 2 and text:sub(2,2):byte() == 0) then
    self:onDecodeError("JSON package groks only UTF-8, sorry", text, nil, etc)
  end

  local success, value = pcall(grok_one, self, text, 1, etc)

  if success then
    return value
  else
    -- if JSON:onDecodeError() didn't abort out of the pcall, we'll have received the error message here as "value", so pass it along as an assert.
    if self.assert then
     self.assert(false, value)
    else
     assert(false, value)
    end
    -- and if we're still here, return a nil and throw the error message on as a second arg
    return nil, value
  end
end

local function backslash_replacement_function(c)
  if c == "\n" then
    return "\\n"
  elseif c == "\r" then
    return "\\r"
  elseif c == "\t" then
    return "\\t"
  elseif c == "\b" then
    return "\\b"
  elseif c == "\f" then
    return "\\f"
  elseif c == '"' then
    return '\\"'
  elseif c == '\\' then
    return '\\\\'
  else
    return string.format("\\u%04x", c:byte())
  end
end

local chars_to_be_escaped_in_JSON_string
  = '['
  ..   '"'   -- class sub-pattern to match a double quote
  ..   '%\\'  -- class sub-pattern to match a backslash
  ..   '%z'  -- class sub-pattern to match a null
  ..   '\001' .. '-' .. '\031' -- class sub-pattern to match control characters
  .. ']'

local function json_string_literal(value)
  local newval = value:gsub(chars_to_be_escaped_in_JSON_string, backslash_replacement_function)
  return '"' .. newval .. '"'
end

local function object_or_array(self, T, etc)
  --
  -- We need to inspect all the keys... if there are any strings, we'll convert to a JSON
  -- object. If there are only numbers, it's a JSON array.
  --
  -- If we'll be converting to a JSON object, we'll want to sort the keys so that the
  -- end result is deterministic.
  --
  local string_keys = { }
  local number_keys = { }
  local number_keys_must_be_strings = false
  local maximum_number_key

  for key in pairs(T) do
    if type(key) == 'string' then
     table.insert(string_keys, key)
    elseif type(key) == 'number' then
     table.insert(number_keys, key)
     if key <= 0 or key >= math.huge then
      number_keys_must_be_strings = true
     elseif not maximum_number_key or key > maximum_number_key then
      maximum_number_key = key
     end
    else
     self:onEncodeError("can't encode table with a key of type " .. type(key), etc)
    end
  end

  if #string_keys == 0 and not number_keys_must_be_strings then
    --
    -- An empty table, or a numeric-only array
    --
    if #number_keys > 0 then
     return nil, maximum_number_key -- an array
    elseif tostring(T) == "JSON array" then
     return nil
    elseif tostring(T) == "JSON object" then
     return { }
    else
     -- have to guess, so we'll pick array, since empty arrays are likely more common than empty objects
     return nil
    end
  end

  table.sort(string_keys)

  local map
  if #number_keys > 0 then
    --
    -- If we're here then we have either mixed string/number keys, or numbers inappropriate for a JSON array
    -- It's not ideal, but we'll turn the numbers into strings so that we can at least create a JSON object.
    --

    if self.noKeyConversion then
     self:onEncodeError("a table with both numeric and string keys could be an object or array; aborting", etc)
    end

    --
    -- Have to make a shallow copy of the source table so we can remap the numeric keys to be strings
    --
    map = { }
    for key, val in pairs(T) do
     map[key] = val
    end

    table.sort(number_keys)

    --
    -- Throw numeric keys in there as strings
    --
    for _, number_key in ipairs(number_keys) do
     local string_key = tostring(number_key)
     if map[string_key] == nil then
      table.insert(string_keys , string_key)
      map[string_key] = T[number_key]
     else
      self:onEncodeError("conflict converting table with mixed-type keys into a JSON object: key " .. number_key .. " exists both as a string and a number.", etc)
     end
    end
  end

  return string_keys, nil, map
end

--
-- Encode
--
-- 'options' is nil, or a table with possible keys:
--   pretty        -- if true, return a pretty-printed version
--   indent        -- a string (usually of spaces) used to indent each nested level
--   align_keys      -- if true, align all the keys when formatting a table
--
local encode_value -- must predeclare because it calls itself
function encode_value(self, value, parents, etc, options, indent)

  if value == nil then
    return 'null'

  elseif type(value) == 'string' then
    return json_string_literal(value)

  elseif type(value) == 'number' then
    if value ~= value then
     --
     -- NaN (Not a Number).
     -- JSON has no NaN, so we have to fudge the best we can. This should really be a package option.
     --
     return "null"
    elseif value >= math.huge then
     --
     -- Positive infinity. JSON has no INF, so we have to fudge the best we can. This should
     -- really be a package option. Note: at least with some implementations, positive infinity
     -- is both ">= math.huge" and "<= -math.huge", which makes no sense but that's how it is.
     -- Negative infinity is properly "<= -math.huge". So, we must be sure to check the ">="
     -- case first.
     --
     return "1e+9999"
    elseif value <= -math.huge then
     --
     -- Negative infinity.
     -- JSON has no INF, so we have to fudge the best we can. This should really be a package option.
     --
     return "-1e+9999"
    else
     return tostring(value)
    end

  elseif type(value) == 'boolean' then
    return tostring(value)

  elseif type(value) ~= 'table' then
    self:onEncodeError("can't convert " .. type(value) .. " to JSON", etc)

  else
    --
    -- A table to be converted to either a JSON object or array.
    --
    local T = value

    if type(options) ~= 'table' then
     options = {}
    end
    if type(indent) ~= 'string' then
     indent = ""
    end

    if parents[T] then
     self:onEncodeError("table " .. tostring(T) .. " is a child of itself", etc)
    else
     parents[T] = true
    end

    local result_value

    local object_keys, maximum_number_key, map = object_or_array(self, T, etc)
    if maximum_number_key then
     --
     -- An array...
     --
     local ITEMS = { }
     for i = 1, maximum_number_key do
      table.insert(ITEMS, encode_value(self, T[i], parents, etc, options, indent))
     end

     if options.pretty then
      result_value = "[ " .. table.concat(ITEMS, ", ") .. " ]"
     else
      result_value = "["  .. table.concat(ITEMS, ",")  .. "]"
     end

    elseif object_keys then
     --
     -- An object
     --
     local TT = map or T

     if options.pretty then

      local KEYS = { }
      local max_key_length = 0
      for _, key in ipairs(object_keys) do
        local encoded = encode_value(self, tostring(key), parents, etc, options, indent)
        if options.align_keys then
          max_key_length = math.max(max_key_length, #encoded)
        end
        table.insert(KEYS, encoded)
      end
      local key_indent = indent .. tostring(options.indent or "")
      local subtable_indent = key_indent .. string.rep(" ", max_key_length) .. (options.align_keys and "  " or "")
      local FORMAT = "%s%" .. string.format("%d", max_key_length) .. "s: %s"

      local COMBINED_PARTS = { }
      for i, key in ipairs(object_keys) do
        local encoded_val = encode_value(self, TT[key], parents, etc, options, subtable_indent)
        table.insert(COMBINED_PARTS, string.format(FORMAT, key_indent, KEYS[i], encoded_val))
      end
      result_value = "{\n" .. table.concat(COMBINED_PARTS, ",\n") .. "\n" .. indent .. "}"

     else

      local PARTS = { }
      for _, key in ipairs(object_keys) do
        local encoded_val = encode_value(self, TT[key],     parents, etc, options, indent)
        local encoded_key = encode_value(self, tostring(key), parents, etc, options, indent)
        table.insert(PARTS, string.format("%s:%s", encoded_key, encoded_val))
      end
      result_value = "{" .. table.concat(PARTS, ",") .. "}"

     end
    else
     --
     -- An empty array/object... we'll treat it as an array, though it should really be an option
     --
     result_value = "[]"
    end

    parents[T] = false
    return result_value
  end
end


function OBJDEF:encode(value, etc, options)
  if type(self) ~= 'table' or self.__index ~= OBJDEF then
    OBJDEF:onEncodeError("JSON:encode must be called in method format", etc)
  end
  return encode_value(self, value, {}, etc, options or nil)
end

function OBJDEF:encode_pretty(value, etc, options)
  if type(self) ~= 'table' or self.__index ~= OBJDEF then
    OBJDEF:onEncodeError("JSON:encode_pretty must be called in method format", etc)
  end
  return encode_value(self, value, {}, etc, options or default_pretty_options)
end

function OBJDEF.__tostring()
  return "JSON encode/decode package"
end

OBJDEF.__index = OBJDEF

function OBJDEF:new(args)
  local new = { }

  if args then
    for key, val in pairs(args) do
     new[key] = val
    end
  end

  return setmetatable(new, OBJDEF)
end

local json = OBJDEF

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- CONFIG: Configuration tools
  
-- Bitmap strings (base64 encoded)
config.BMP_STRINGS = {}
config.BMP_STRINGS.player_blocked_status = "iVBORw0KGgoAAAANSUhEUgAAAA4AAAAUBAMAAABPKxEfAAAAJ1BMVEUAAABQAAD40MD4cGiwKGCIWBj4+Pj4QHBAgJj42HDYoDiA2MggMIipQuZJAAAAfElEQVR4nGNgYGAQFBRgAFHllYVAirHcZWUikBYpcQCJMrqAKQZGBQYDAwMGBqEgZgUF1QAG4SAGJSUlVQYBIyYFY2NTBgZmI7A6BtZgY4gG19AYEC3i3rH7AJAWDW3LzgHSYWlhEDq1o3sPhD4BkmcNDQgAawyN5GSAAwCQmRc/s4Su8AAAAABJRU5ErkJggg=="
config.BMP_STRINGS.goal_tape = "iVBORw0KGgoAAAANSUhEUgAAABIAAAAGCAYAAADOic7aAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuNWWFMmUAAABYSURBVChTY5g5c6aGt7f3Jnt7+/+UYIaQkJB9u3bt+v/jxw+KMIOdnR1WCVIxg7m5+f8bN25QjBmA4bO3o6Pj/4YNGyjCDAsWLNC2sbFZp6Gh8Z98rPEfAKMNNFo8qFAoAAAAAElFTkSuQmCC"
config.BMP_STRINGS.interaction_points = {}
config.BMP_STRINGS.interaction_points[1] = "iVBORw0KGgoAAAANSUhEUgAAABwAAABCAgMAAAA5516AAAAACVBMVEUAAAD///////9zeKVjAAAAA3RSTlMA/2Ak4Fj0AAAANElEQVR4nGNgGAUMAWj0AgI0SYB1FQMD11IEjWkfaygqjSqPRT9pgIthARc+mpUhgBVOAwBC4Q4Ra52LZQAAAABJRU5ErkJggg=="
config.BMP_STRINGS.interaction_points[2] = "iVBORw0KGgoAAAANSUhEUgAAABwAAABCAQMAAAB+RyRQAAAABlBMVEUAAAD///+l2Z/dAAAAAnRSTlMA/1uRIrUAAAAnSURBVHicY2CgOjiAlyAOMH9g/gAhsJoMFodIkmoy8bZhAQaHcRMAxDoWseuRDbIAAAAASUVORK5CYII="
config.BMP_STRINGS.interaction_points[3] = "iVBORw0KGgoAAAANSUhEUgAAABwAAABiAQMAAAB56yFmAAAABlBMVEUAAAD///+l2Z/dAAAAAnRSTlMA/1uRIrUAAAAqSURBVHicY2AY4uAAXgIfYP7A/AFCEDAZrAKijDiTKQGEXIUXGBzGTQAAyrMWsYAl5OUAAAAASUVORK5CYII="
config.BMP_STRINGS.interaction_points[4] = "iVBORw0KGgoAAAANSUhEUgAAABwAAABiAQMAAAB56yFmAAAABlBMVEUAAAD///+l2Z/dAAAAAnRSTlMA/1uRIrUAAAAqSURBVHicY2AY9OAAXgIfYP7A/AFCEDAZrAKijDiTaQcIuRkvMDiMmwAAVq0WsankG3YAAAAASUVORK5CYII="

--[[ test
config.BMP_STRINGS.interaction_points[1] = gui.image.load_png("hitbox/interaction_points_1.png", images_folder)
config.BMP_STRINGS.interaction_points[2] = gui.image.load_png("hitbox/interaction_points_2.png", images_folder)
config.BMP_STRINGS.interaction_points[3] = gui.image.load_png("hitbox/interaction_points_3.png", images_folder)
config.BMP_STRINGS.interaction_points[4] = gui.image.load_png("hitbox/interaction_points_4.png", images_folder)
--]]

-- Symbols
config.LEFT_ARROW = "<-"
config.RIGHT_ARROW = "->"

-- Functions
local function color_number(str)
  local r, g, b, a = str:match("^#(%x+%x+)(%x+%x+)(%x+%x+)(%x+%x+)$")

  r, g, b, a = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16), tonumber(a, 16)
  
  return 0x1000000*a + 0x10000*r + 0x100*g + b
end

function interpret_color(data)
  for k, v in pairs(data) do
    if type(v) == "string" then
      data[k] = type(v) == "string" and color_number(v) or v
    elseif type(v) == "table" then
      interpret_color(data[k]) -- possible stack overflow
    end
  end
end

config.OPTIONS_LABEL = "BIZHAWK"

function config.load_options(filename)
  config.OPTIONS = luap.file_exists(filename)
  and config.retrieve(filename, {[config.OPTIONS_LABEL .. " OPTIONS"] = config.DEFAULT_OPTIONS})[config.OPTIONS_LABEL .. " OPTIONS"]
  or luap.copytable(config.DEFAULT_OPTIONS)

  config.COLOUR = luap.file_exists(filename)
  and config.retrieve(filename, {[config.OPTIONS_LABEL .. " COLOURS"] = config.DEFAULT_COLOUR})[config.OPTIONS_LABEL .. " COLOURS"]
  or luap.copytable(config.DEFAULT_COLOUR)

  config.save(filename, {
    [config.OPTIONS_LABEL .. " OPTIONS"] = config.OPTIONS,
    [config.OPTIONS_LABEL .. " COLOURS"] = config.COLOUR
  })

  interpret_color(config.COLOUR)
end

-- loads the encoded table stored on file <filename
function config.load_decoded_data(filename)
  if not luap.file_exists(filename) then return false end
  local handle = io.open(filename, "r")
  local text = handle:read("*a")

  handle:close()
  return (text == "") and {} or json:decode(text)
end

function config.retrieve(filename, previous_data)
  if type(previous_data) ~= "table" then error"data must be a table" end

  local file_data = config.load_decoded_data(filename)
  if not file_data then
    return previous_data
  else
    -- Adds previous values to the new ini
    previous_data = luap.copytable(previous_data)  -- don't overwrite previous data
    return luap.mergetable(previous_data, file_data)
  end
end

function config.save(filename, data)
  assert(type(data) == "table", "data must be a table")

  local file_data = config.load_decoded_data(filename)
  if not file_data then
    merge = data
  else
    -- Adds previous values to the new ini
    data = luap.copytable(data)  -- don't overwrite previous data
    merge = luap.mergetable(file_data, data)
  end

  local file = assert(io.open(filename, "w"), "Error loading file :" .. filename)
  file:write(json:encode_pretty(merge))
  file:close()
end

function config.save_options()
  local file, data = config.filename, config.raw_data
  if not file or not data then print"save_options: <file> and <data> required!"; return end

  config.save(file, data)
end


config.load_options(INI_CONFIG_FILEPATH)

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- BIZ: Tools for detecting BizHawk features and specific emulator functions

local biz = {}

biz.is_bizhawk = (tastudio ~= nil)

biz.minimum_supported_version = "1.11.0" -- TODO: CHANGE THIS, DOESN'T WORK

biz.is_old_version = (gui.drawAxis == nil) -- 1.11.0

-- Detect BizHawk features based on the changelog
-- http://tasvideos.org/BizHawk/ReleaseHistory.html
biz.features = {
  backcolor_default_arg = (emu.setislagged == nil), -- < 1.11.5 (should 1.11.4, but there's no way)
  gui_text_backcolor = (gui.DrawFinish == nil), -- < 1.11.7
  support_extra_padding = (client.SetGameExtraPadding ~= nil) and (gui.DrawFinish ~= nil), -- 1.11.7
}

-- Check if the emulator version is supported
function biz.check_emulator()
  if not biz.is_bizhawk then
    if gui.text then
      gui.text(0, 0, "This script works with BizHawk emulator.")
      gui.text(0, 32, "Visit http://tasvideos.org/Bizhawk.html to download the latest version.")
    end

    error("This script works with BizHawk emulator.")

  elseif biz.is_old_version then
    gui.text(0, 0, "This script works with BizHawk " .. biz.minimum_supported_version .. " or superior.")
    gui.text(0, 16, "Your version seems to be older.")
    gui.text(0, 32, "Visit http://tasvideos.org/Bizhawk.html to download the latest version.")
    error("This script works with BizHawk 1.11.0 or superior.")

  end
end

-- Check which SNES core is running -- TODO: keep checking if Snes9x core (or some other) added this
function biz.check_snes_core()
  local snes_core = ""
  local snes_registers = emu.getregisters()

  if snes_registers.A then
    snes_core = "bsnes"
  else
    snes_core = "Snes9x or Faust"
  end
  
  return snes_core
end

biz.snes_core = biz.check_snes_core()

-- Check the game name in ROM
function biz.game_name()
  local game_name = ""
  for i = 0, 15 do
    game_name = game_name .. string.char(memory.read_u8(0x7FC0 + i, "CARTROM"))
  end
  return game_name
end

-- Check the game map mode and the rom type (https://snesdev.mesen.ca/wiki/index.php?title=Internal_ROM_Header)
biz.map_mode_rom_type = memory.read_u16_be(0x007FD5, "CARTROM")


--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- DRAW: Gui drawing functions and tools

local draw = {}

local OPTIONS = config.OPTIONS
local COLOUR = config.COLOUR

-- Font settings
local BIZHAWK_FONT_WIDTH = 10
local BIZHAWK_FONT_HEIGHT = 14
draw.CUSTOM_FONTS = {
  [false] = { file = nil, height = BIZHAWK_FONT_HEIGHT, width = BIZHAWK_FONT_WIDTH }, -- this is the BizHawk default font

  --snes9xlua =     { file = [[data/snes9xlua.font]],      height = 14, width = 10 },
  --snes9xluaclever = { file = [[data/snes9xluaclever.font]],  height = 14, width = 08 }, -- quite pixelated
  --snes9xluasmall =  { file = [[data/snes9xluasmall.font]],  height = 07, width = 05 },
  --snes9xtext =    { file = [[data/snes9xtext.font]],     height = 09, width = 08 },
  --verysmall =     { file = [[data/verysmall.font]],      height = 06, width = 04 }, -- broken, unless for numerals
  --Uzebox6x8 =     { file = [[data/Uzebox6x8.font]],      height = 08, width = 06 },
  --Uzebox8x12 =    { file = [[data/Uzebox8x12.font]],     height = 12, width = 08 },
}

-- Text/Background_max_opacity is only changed by the player using the hotkeys
-- Text/Bg_opacity must be used locally inside the functions
draw.Text_max_opacity = COLOUR.default_text_opacity
draw.Background_max_opacity = COLOUR.default_bg_opacity
draw.Outline_max_opacity = 1
draw.Text_opacity = 1
draw.Bg_opacity = 1


-- Correct gui.text
local gui_text
if biz.features.gui_text_backcolor then
  if biz.features.backcolor_default_arg then
    function gui_text(x, y, text, forecolor, backcolor)
      gui.text(x, y, text, backcolor, forecolor)
    end
  else
    function gui_text(x, y, text, forecolor, backcolor)
      gui.text(x, y, text, forecolor, backcolor)
    end
  end
else
  function gui_text(x, y, text, forecolor, backcolor)
    gui.text(x, y, text, forecolor)
  end
end

-- Get screen values of the game and emulator areas
local function bizhawk_screen_info()
  draw.Left_gap = OPTIONS.left_gap
  draw.Top_gap = OPTIONS.top_gap
  draw.Right_gap = OPTIONS.right_gap
  draw.Bottom_gap = OPTIONS.bottom_gap

  draw.Screen_width = client.screenwidth()  -- Screen area
  draw.Screen_height = client.screenheight()
  draw.Buffer_width = client.bufferwidth()  -- Game area
  draw.Buffer_height = client.bufferheight()
  draw.Border_left = client.borderwidth()  -- Borders' dimensions
  draw.Border_top = client.borderheight()

  -- Derived dimensions
  draw.Buffer_middle_x = floor(draw.Buffer_width/2)
  draw.Buffer_middle_y = floor(draw.Buffer_height/2)
  draw.Border_right = draw.Screen_width - draw.Buffer_width - draw.Border_left
  draw.Border_bottom = draw.Screen_height - draw.Buffer_height - draw.Border_top
  draw.AR_x = draw.Screen_width/(draw.Buffer_width + draw.Left_gap + draw.Right_gap)
  draw.AR_y = draw.Screen_height/(draw.Buffer_height + draw.Top_gap + draw.Bottom_gap)
end


local function increase_opacity()
  if draw.Text_max_opacity <= 0.9 then draw.Text_max_opacity = draw.Text_max_opacity + 0.1
  else
    if draw.Background_max_opacity <= 0.9 then draw.Background_max_opacity = draw.Background_max_opacity + 0.1 end
  end
end


local function decrease_opacity()
  if  draw.Background_max_opacity >= 0.1 then draw.Background_max_opacity = draw.Background_max_opacity - 0.1
  else
    if draw.Text_max_opacity >= 0.1 then draw.Text_max_opacity = draw.Text_max_opacity - 0.1 end
  end
end


-- Changes transparency of a color: result is opaque original * transparency level (0.0 to 1.0)
local function change_transparency(color, transparency)
  -- Sane transparency
  if transparency >= 1 then return color end  -- no transparency
  if transparency <= 0 then return 0 end   -- total transparency

  -- Sane colour
  if color == 0 then return 0 end
  if type(color) ~= "number" then
    print(color)
    error"Wrong color"
  end

  local a = floor(color/0x1000000)
  local rgb = color - a*0x1000000
  local new_a = floor(a*transparency)
  return new_a*0x1000000 + rgb
end


-- Takes a position and dimensions of a rectangle and returns a new position if this rectangle has points outside the screen
local function put_on_screen(x, y, width, height)
  local x_screen, y_screen
  width = width or 0
  height = height or 0

  if x < - draw.Border_left then
    x_screen = - draw.Border_left
  elseif x > draw.Buffer_width + draw.Border_right - width then
    x_screen = draw.Buffer_width + draw.Border_right - width
  else
    x_screen = x
  end

  if y < - draw.Border_top then
    y_screen = - draw.Border_top
  elseif y > draw.Buffer_height + draw.Border_bottom - height then
    y_screen = draw.Buffer_height + draw.Border_bottom - height
  else
    y_screen = y
  end

  return x_screen, y_screen
end


-- draw a pixel given (x,y) with SNES' pixel sizes
local function pixel(x, y, color, shadow)
  gui.drawRectangle(x + draw.Left_gap - 1, y + draw.Top_gap - 1, 2, 2, shadow or 0, color)
end


-- draws a line given (x,y) and (x',y') with given scale and SNES' pixel thickness
-- not necessary to draw from top-left to bottom-right in BizHawk
local function line(x1, y1, x2, y2, color)
  gui.drawLine(x1 + draw.Left_gap, y1 + draw.Top_gap, x2 + draw.Left_gap, y2 + draw.Top_gap, color)
end


-- draws a box given (x,y) and (x',y') with SNES' pixel sizes
local function box(x1, y1, x2, y2, line, bg)
  gui.drawBox(x1 + draw.Left_gap, y1 + draw.Top_gap, x2 + draw.Left_gap, y2 + draw.Top_gap, line, bg)
end


-- draws a rectangle given (x,y) and dimensions, with SNES' pixel sizes
local function rectangle(x, y, w, h, line, bg)
  gui.drawRectangle(x + draw.Left_gap, y + draw.Top_gap, w, h, line, bg)
end

-- draws a cross sign given x, y, size[, and colour]
draw.cross = gui.drawAxis


-- returns the (x, y) position to start the text and its length:
-- number, number, number text_position(x, y, text, font_width, font_height[[[[, always_on_client], always_on_game], ref_x], ref_y])
-- x, y: the coordinates that the refereed point of the text must have
-- text: a string, don't make it bigger than the buffer area width and don't include escape characters
-- font_width, font_height: the sizes of the font
-- always_on_client, always_on_game: boolean
-- ref_x and ref_y: refer to the relative point of the text that must occupy the origin (x,y), from 0% to 100%
--            for instance, if you want to display the middle of the text in (x, y), then use 0.5, 0.5
local function text_position(x, y, text, font_width, font_height, always_on_client, always_on_game, ref_x, ref_y)
  -- Reads external variables
  local border_left    = draw.Border_left
  local border_right   = draw.Border_right
  local border_top     = draw.Border_top
  local border_bottom  = draw.Border_bottom
  local buffer_width   = draw.Buffer_width
  local buffer_height  = draw.Buffer_height

  -- text processing
  local text_length = text and string.len(text)*font_width or font_width  -- considering another objects, like bitmaps

  -- actual position, relative to game area origin
  x = (not ref_x and x) or (ref_x == 0 and x) or x - floor(text_length*ref_x)
  y = (not ref_y and y) or (ref_y == 0 and y) or y - floor(font_height*ref_y)

  -- adjustment needed if text is supposed to be on screen area
  local x_end = x + text_length
  local y_end = y + font_height

  if always_on_game then
    if x < 0 then x = 0 end
    if y < 0 then y = 0 end

    if x_end > buffer_width*draw.AR_x  then x = buffer_width*draw.AR_x - text_length end
    if y_end > buffer_height*draw.AR_y then y = buffer_height*draw.AR_y - font_height end

  elseif always_on_client then
    if x < -border_left then x = -border_left end
    if y < -border_top  then y = -border_top  end

    if x_end > buffer_width  + border_right  then x = buffer_width  + border_right  - text_length end
    if y_end > buffer_height + border_bottom then y = buffer_height + border_bottom - font_height end
  end

  return x, y, text_length
end


-- Complex function for drawing, that uses text_position
local function draw_text(x, y, text, ...)
  -- Reads external variables
  local font_width  = BIZHAWK_FONT_WIDTH
  local font_height = BIZHAWK_FONT_HEIGHT
  local bg_default_color = COLOUR.outline
  local text_color, bg_color, always_on_client, always_on_game, ref_x, ref_y
  local arg1, arg2, arg3, arg4, arg5, arg6 = ...

  if not arg1 or arg1 == true then

    text_color = COLOUR.text
    bg_color = bg_default_color
    always_on_client, always_on_game, ref_x, ref_y = arg1, arg2, arg3, arg4

  elseif not arg2 or arg2 == true then

    text_color = arg1
    bg_color = bg_default_color
    always_on_client, always_on_game, ref_x, ref_y = arg2, arg3, arg4, arg5

  else

    text_color, bg_color = arg1, arg2
    always_on_client, always_on_game, ref_x, ref_y = arg3, arg4, arg5, arg6

  end

  local x_pos, y_pos, length = text_position(x, y, text, font_width, font_height,
                      always_on_client, always_on_game, ref_x, ref_y)
  ;

  text_color = change_transparency(text_color, draw.Text_max_opacity * draw.Text_opacity)
  bg_color = change_transparency(bg_color, draw.Text_max_opacity * draw.Text_opacity)
  gui_text(x_pos + draw.Border_left, y_pos + draw.Border_top, text, text_color, bg_color)

  return x_pos + length, y_pos + font_height, length
end


local function alert_text(x, y, text, text_color, bg_color, always_on_game, ref_x, ref_y)
  -- Reads external variables
  local font_width  = BIZHAWK_FONT_WIDTH
  local font_height = BIZHAWK_FONT_HEIGHT

  local x_pos, y_pos, text_length = text_position(x, y, text, font_width, font_height, false, always_on_game, ref_x, ref_y)

  if not bg_color then bg_color = COLOUR.background end
  text_color = change_transparency(text_color, draw.Text_max_opacity * draw.Text_opacity)
  bg_color = change_transparency(bg_color, draw.Background_max_opacity * draw.Bg_opacity)

  box(x_pos/draw.AR_x, y_pos/draw.AR_y, (x_pos + text_length)/draw.AR_x + 2, (y_pos + font_height)/draw.AR_y + 1, 0, bg_color)
  gui_text(x_pos + draw.Border_left, y_pos + draw.Border_top, text, text_color, 0)
end


local function over_text(x, y, value, base, color_base, color_value, color_bg, always_on_client, always_on_game, ref_x, ref_y)
  value = luap.decode_bits(value, base)
  local x_end, y_end, length = draw_text(x, y, base,  color_base, color_bg, always_on_client, always_on_game, ref_x, ref_y)

  change_transparency(color_value or COLOUR.text, draw.Text_max_opacity * draw.Text_opacity)
  gui_text(x_end + draw.Border_left - length, y_end + draw.Border_top - BIZHAWK_FONT_HEIGHT, value, color_value, 0)

  return x_end, y_end, length
end


-- include functions and variables in draw.
draw.bizhawk_screen_info = bizhawk_screen_info
draw.change_transparency = change_transparency
draw.increase_opacity, draw.decrease_opacity = increase_opacity, decrease_opacity
draw.put_on_screen, draw.text_position, draw.text = put_on_screen, text_position, draw_text
draw.alert_text, draw.over_text = alert_text, over_text
draw.pixel, draw.line, draw.rectangle, draw.box = pixel, line, rectangle, box


--#############################################################################
-- MORE INITIAL STATEMENTS

local LEFT_ARROW = config.LEFT_ARROW
local RIGHT_ARROW = config.RIGHT_ARROW

config.filename = INI_CONFIG_FILEPATH
config.raw_data = {["BIZHAWK OPTIONS"] = OPTIONS}

-- Check if it's running in BizHawk
biz.check_emulator()

bit.test = bit.check -- Bizhawk

-- Compatibility of the memory read/write functions
local u8 =  mainmemory.read_u8
local s8 =  mainmemory.read_s8
local w8 =  mainmemory.write_u8
local u16 = mainmemory.read_u16_le
local s16 = mainmemory.read_s16_le
local w16 = mainmemory.write_u16_le
local u24 = mainmemory.read_u24_le
local s24 = mainmemory.read_s24_le
local w24 = mainmemory.write_u24_le
local u32 = mainmemory.read_u32_le
local s32 = mainmemory.read_s32_le
local w32 = mainmemory.write_u32_le

-- Check if it's Super Mario World (any SNES version)
local IS_SMW = false
if biz.game_name() == "SUPER MARIOWORLD" then IS_SMW = true end

-- Check if it's a SMW hack, by checking the Lunar Magic signature
local IS_HACK = false
local LM_signature = ""
for i = 0x0, 0xA do
  LM_signature = LM_signature .. string.char(memory.read_u8(0x07F0A0 + i, "CARTROM"))
end
if LM_signature == "Lunar Magic" then IS_HACK = true ; IS_SMW = true end -- if it's a Lunar Magic hack, definitely it's SMW

-- Failsafe to prevent script running with other games
if not IS_SMW then error("\n\nThis script is only for Super Mario World (any SNES version or hack)!\nIf you're sure this is a SMW hack, contact the script author here https://github.com/brunovalads/smw-stuff") end

-- Checks if hack has SA-1
local HAS_SA1 = false
if biz.map_mode_rom_type == 0x2334 or biz.map_mode_rom_type == 0x2335 then HAS_SA1 = true end -- TODO: RAM ramaps https://github.com/VitorVilela7/SA1-Pack/blob/master/docs/remap.asm


--#############################################################################
-- SMW ADDRESSES AND CONSTANTS

local WRAM = {
  -- I/O
  ctrl_1_1 = 0x0015,
  ctrl_1_2 = 0x0017,
  firstctrl_1_1 = 0x0016,
  firstctrl_1_2 = 0x0018,

  -- General
  game_mode = 0x0100,
  real_frame = 0x0013,
  effective_frame = 0x0014,
  lag_indicator = 0x01fe,
  timer_frame_counter = 0x0f30,
  RNG = 0x148d,
  RNG_input = 0x148b,
  timer = 0x0F31, -- 3 bytes, one for each digit
  sprite_data_pointer = 0x00CE, -- 3 bytes
  layer1_data_pointer = 0x0065, -- 3 bytes
  layer2_data_pointer = 0x0068, -- 3 bytes
  sprite_memory_header = 0x1692,
  lock_animation_flag = 0x009d, -- Most codes will still run if this is set, but almost nothing will move or animate.
  level_mode_settings = 0x1925,
  star_road_speed = 0x1df7,
  star_road_timer = 0x1df8,
  current_character = 0x0db3, -- #00 = Mario, #01 = Luigi
  exit_counter = 0x1F2E,
  event_flags = 0x1F02, -- 15 bytes (1 bit per exit)
  current_submap = 0x1F11,
  OW_tile_translevel = 0xD000, -- 0x800 bytes table
  OW_action_pointer = 0x13D9,
  OW_player_animation = 0x1F13, -- 2 bytes for Mario, 2 bytes for Luigi

  -- Camera
  layer1_x_mirror = 0x001a,
  layer1_y_mirror = 0x001c,
  layer1_VRAM_left_up = 0x004d,
  layer1_VRAM_right_down = 0x004f,
  camera_x = 0x1462,
  camera_y = 0x1464,
  camera_left_limit = 0x142c,
  camera_right_limit = 0x142e,
  screen_mode = 0x005B,
  screens_number = 0x005d,
  hscreen_number = 0x005e,
  vscreen_number = 0x005f,
  vertical_scroll_flag_header = 0x1412,  -- #$00 = Disable; #$01 = Enable; #$02 = Enable if flying/climbing/etc.
  vertical_scroll_enabled = 0x13f1,
  camera_scroll_timer = 0x1401,

  -- Player
  x = 0x0094,
  y = 0x0096,
  previous_x = 0x00d1,
  previous_y = 0x00d3,
  x_sub = 0x13da,
  y_sub = 0x13dc,
  x_speed = 0x007b,
  x_subspeed = 0x007a,
  y_speed = 0x007d,
  direction = 0x0076,
  is_ducking = 0x0073,
  p_meter = 0x13e4,
  take_off = 0x149f,
  powerup = 0x0019,
  cape_spin = 0x14a6,
  cape_fall = 0x14a5,
  cape_interaction = 0x13e8,
  flight_animation = 0x1407,
  cape_gliding_index = 0x1408,
  diving_status = 0x1409,
  diving_status_timer = 0x14a4,
  player_animation_trigger = 0x0071,
  climbing_status = 0x0074,
  spinjump_flag = 0x140d,
  player_blocked_status = 0x0077,
  item_box = 0x0dc2,
  cape_x = 0x13e9,
  cape_y = 0x13eb,
  on_ground = 0x13ef,
  on_ground_delay = 0x008d,
  on_air = 0x0072,
  on_water = 0x0075,
  can_jump_from_water = 0x13fa,
  carrying_item = 0x148f,
  player_pose_turning = 0x1499,
  mario_score = 0x0f34,
  player_coin = 0x0dbf,
  player_looking_up = 0x13de,
  OW_x = 0x1f17,
  OW_y = 0x1f19,

  -- Yoshi
  yoshi_riding_flag = 0x187a,  -- #$00 = No, #$01 = Yes, #$02 = Yes, and turning around.
  yoshi_tile_pos = 0x0d8c,
  yoshi_in_pipe = 0x1419,
  
  -- Sprites
  sprite_status = 0x14c8,
  sprite_number = 0x009e,
  sprite_x_high = 0x14e0,
  sprite_x_low = 0x00e4,
  sprite_y_high = 0x14d4,
  sprite_y_low = 0x00d8,
  sprite_x_sub = 0x14f8,
  sprite_y_sub = 0x14ec,
  sprite_x_speed = 0x00b6,
  sprite_y_speed = 0x00aa,
  sprite_y_offscreen = 0x186c,
  sprite_OAM_xoff = 0x0304,
  sprite_OAM_yoff = 0x0305,
  sprite_swap_slot = 0x1861,
  sprite_phase = 0x00c2,
  sprite_misc_1504 = 0x1504,
  sprite_misc_1510 = 0x1510,
  sprite_misc_151c = 0x151c,
  sprite_misc_1528 = 0x1528,
  sprite_misc_1534 = 0x1534,
  sprite_stun_timer = 0x1540,
  sprite_player_contact = 0x154c,
  sprite_misc_1558 = 0x1558,
  sprite_sprite_contact = 0x1564,
  sprite_animation_timer = 0x1570,
  sprite_horizontal_direction = 0x157c,
  sprite_blocked_status = 0x1588,
  sprite_misc_1594 = 0x1594,
  sprite_x_offscreen = 0x15a0,
  sprite_misc_15ac = 0x15ac,
  sprite_being_eaten_flag = 0x15d0,
  sprite_OAM_index = 0x15ea,
  sprite_misc_1602 = 0x1602,
  sprite_misc_160e = 0x160e,
  sprite_index_to_level = 0x161a,
  sprite_misc_1626 = 0x1626,
  sprite_behind_scenery = 0x1632,
  sprite_misc_163e = 0x163e,
  sprite_misc_187b = 0x187b,
  sprite_underwater = 0x164a,
  sprite_disable_cape = 0x1fe2,
  sprite_1_tweaker = 0x1656,
  sprite_2_tweaker = 0x1662,
  sprite_3_tweaker = 0x166e,
  sprite_4_tweaker = 0x167a,
  sprite_5_tweaker = 0x1686,
  sprite_6_tweaker = 0x190f,
  sprite_tongue_wait = 0x14a3,
  sprite_yoshi_squatting = 0x18af,
  sprite_buoyancy = 0x190e,
  sprite_load_status_table = 0x1938, -- 128 bytes
  bowser_attack_timers = 0x14b0, -- 9 bytes
  yoshi_slot = 0x18df,
  yoshi_loose_flag = 0x18e2,
  yoshi_overworld_flag = 0x0dc1,

  -- Extended sprites
  extspr_number = 0x170b,
  extspr_x_high = 0x1733,
  extspr_x_low = 0x171f,
  extspr_y_high = 0x1729,
  extspr_y_low = 0x1715,
  extspr_x_speed = 0x1747,
  extspr_y_speed = 0x173d,
  extspr_suby = 0x1751,
  extspr_subx = 0x175b,
  extspr_table = 0x1765,
  extspr_table2 = 0x176f,

  -- Cluster sprites
  cluspr_flag = 0x18b8,
  cluspr_number = 0x1892,
  cluspr_x_high = 0x1e3e,
  cluspr_x_low = 0x1e16,
  cluspr_y_high = 0x1e2a,
  cluspr_y_low = 0x1e02,
  cluspr_timer = 0x0f9a,
  cluspr_table_1 = 0x0f4a,
  cluspr_table_2 = 0x0f72,
  cluspr_table_3 = 0x0f86,
  reappearing_boo_counter = 0x190a,

  -- Minor extended sprites
  minorspr_number = 0x17f0,
  minorspr_x_high = 0x18ea,
  minorspr_x_low = 0x1808,
  minorspr_y_high = 0x1814,
  minorspr_y_low = 0x17fc,
  minorspr_xspeed = 0x182c,
  minorspr_yspeed = 0x1820,
  minorspr_x_sub = 0x1844,
  minorspr_y_sub = 0x1838,
  minorspr_timer = 0x1850,

  -- Bounce sprites
  bouncespr_number = 0x1699,
  bouncespr_x_high = 0x16ad,
  bouncespr_x_low = 0x16a5,
  bouncespr_y_high = 0x16a9,
  bouncespr_y_low = 0x16a1,
  bouncespr_timer = 0x16c5,
  bouncespr_last_id = 0x18cd,
  turn_block_timer = 0x18ce,

  -- Quake sprites
  quakespr_number = 0x16cd,
  quakespr_x_high = 0x16d5,
  quakespr_x_low = 0x16d1,
  quakespr_y_high = 0x16dd,
  quakespr_y_low = 0x16d9,
  quakespr_timer = 0x18f8,

  -- Timer
  --keep_mode_active = 0x0db1,
  pipe_entrance_timer = 0x0088,
  score_incrementing = 0x13d6,
  fadeout_radius = 0x1433,
  peace_image_timer = 0x1492,
  end_level_timer = 0x1493,
  multicoin_block_timer = 0x186b,
  gray_pow_timer = 0x14ae,
  blue_pow_timer = 0x14ad,
  dircoin_timer = 0x190c,
  pballoon_timer = 0x1891,
  star_timer = 0x1490,
  animation_timer = 0x1496,
  invisibility_timer = 0x1497,
  fireflower_timer = 0x149b,
  yoshi_timer = 0x18e8,
  swallow_timer = 0x18ac,
  lakitu_timer = 0x18e0,
  spinjump_fireball_timer = 0x13e2,
  game_intro_timer = 0x1df5,
  pause_timer = 0x13d3,
  bonus_timer = 0x14ab,
  disappearing_sprites_timer = 0x18bf,
  message_box_timer = 0x1b89,

  -- Cheats
  frozen = 0x13fb,
  level_paused = 0x13d4,
  translevel_index = 0x13bf,
  level_flag_table = 0x1ea2,
  level_exit_type = 0x0dd5,
  midway_point = 0x13ce,
  
  -- Layers
  layer2_x_nextframe = 0x1466,
  layer2_y_nextframe = 0x1468,
}

local SMW = {
  -- Game Modes
  game_mode_overworld = 0x0e,
  game_mode_fade_to_level = 0x0f,
  game_mode_level = 0x14,

  -- Sprites
  sprite_max = 12,
  extended_sprite_max = 10,
  cluster_sprite_max = 20,
  minor_extended_sprite_max = 12,
  bounce_sprite_max = 4,
  null_sprite_id = 0xff,

  -- Blocks
  blank_tile_map16 = 0x25,
}

SMW.flight_actions = {[0] = "air ", "down", "sink", " up ", "end!" }

SMW.debug_register_addresses = {
  {"BUS", 0x004016, "JOYSER0"},
  {"BUS", 0x004017, "JOYSER1"},
  {"BUS", 0x004218, "Hardware Controller1 Low"},
  {"BUS", 0x004219, "Hardware Controller1 High"},
  {"BUS", 0x00421a, "Hardware Controller2 Low"},
  {"BUS", 0x00421b, "Hardware Controller2 High"},
  {"BUS", 0x00421c, "Hardware Controller3 Low"},
  {"BUS", 0x00421d, "Hardware Controller3 High"},
  {"BUS", 0x00421e, "Hardware Controller4 Low"},
  {"BUS", 0x00421f, "Hardware Controller4 High"},
  {"BUS", 0x014a13, "Chuck $01:4a13"},
  {"BUS", 0xee4734, "Platform $ee:4734"}, -- this is in no way an extensive list, just common values
  {"BUS", 0xee4cb2, "Platform $ee:4cb2"},
  {"BUS", 0xee4f34, "Platform $ee:4f34"},
  {"WRAM", 0x0015, "RAM Controller Low"},
  {"WRAM", 0x0016, "RAM Controller Low (1st frame)"},
  {"WRAM", 0x0017, "RAM Controller High"},
  {"WRAM", 0x0018, "RAM Controller High (1st frame)"},

  active = {},
}

SMW.player_hitbox = {
  {xoff = 2, yoff = 0x14, width = 12, height = 12},
  {xoff = 2, yoff = 0x06, width = 12, height = 26},
  {xoff = 2, yoff = 0x18, width = 12, height = 24},
  {xoff = 2, yoff = 0x10, width = 12, height = 32}
}

SMW.x_interaction_points = {center = 0x8, left_side = 0x2 + 1, left_foot = 0x5, right_side = 0xe - 1, right_foot = 0xb}

SMW.y_interaction_points = {
  {head = 0x10, center = 0x18, shoulder = 0x16, side = 0x1a, foot = 0x20},
  {head = 0x08, center = 0x12, shoulder = 0x0f, side = 0x1a, foot = 0x20},
  {head = 0x13, center = 0x1d, shoulder = 0x19, side = 0x28, foot = 0x30},
  {head = 0x10, center = 0x1a, shoulder = 0x16, side = 0x28, foot = 0x30}
}

SMW.hitbox_sprite = {  -- sprites' hitbox against player and other sprites
  [0x00] = { xoff = 2, yoff = 3, width = 12, height = 10, oscillation = true },
  [0x01] = { xoff = 2, yoff = 3, width = 12, height = 21, oscillation = true },
  [0x02] = { xoff = 16, yoff = -2, width = 16, height = 18, oscillation = true },
  [0x03] = { xoff = 20, yoff = 8, width = 8, height = 8, oscillation = true },
  [0x04] = { xoff = 0, yoff = -2, width = 48, height = 14, oscillation = true },
  [0x05] = { xoff = 0, yoff = -2, width = 80, height = 14, oscillation = true },
  [0x06] = { xoff = 1, yoff = 2, width = 14, height = 24, oscillation = true },
  [0x07] = { xoff = 8, yoff = 8, width = 40, height = 48, oscillation = true },
  [0x08] = { xoff = -8, yoff = -2, width = 32, height = 16, oscillation = true },
  [0x09] = { xoff = -2, yoff = 8, width = 20, height = 30, oscillation = true },
  [0x0a] = { xoff = 3, yoff = 7, width = 1, height = 2, oscillation = true },
  [0x0b] = { xoff = 6, yoff = 6, width = 3, height = 3, oscillation = true },
  [0x0c] = { xoff = 1, yoff = -2, width = 13, height = 22, oscillation = true },
  [0x0d] = { xoff = 0, yoff = -4, width = 15, height = 16, oscillation = true },
  [0x0e] = { xoff = 6, yoff = 6, width = 20, height = 20, oscillation = true },
  [0x0f] = { xoff = 2, yoff = -2, width = 36, height = 18, oscillation = true },
  [0x10] = { xoff = 0, yoff = -2, width = 15, height = 32, oscillation = true },
  [0x11] = { xoff = -24, yoff = -24, width = 64, height = 64, oscillation = true },
  [0x12] = { xoff = -4, yoff = 16, width = 8, height = 52, oscillation = true },
  [0x13] = { xoff = -4, yoff = 16, width = 8, height = 116, oscillation = true },
  [0x14] = { xoff = 4, yoff = 2, width = 24, height = 12, oscillation = true },
  [0x15] = { xoff = 0, yoff = -2, width = 15, height = 14, oscillation = true },
  [0x16] = { xoff = -4, yoff = -12, width = 24, height = 24, oscillation = true },
  [0x17] = { xoff = 2, yoff = 8, width = 12, height = 69, oscillation = true },
  [0x18] = { xoff = 2, yoff = 19, width = 12, height = 58, oscillation = true },
  [0x19] = { xoff = 2, yoff = 35, width = 12, height = 42, oscillation = true },
  [0x1a] = { xoff = 2, yoff = 51, width = 12, height = 26, oscillation = true },
  [0x1b] = { xoff = 2, yoff = 67, width = 12, height = 10, oscillation = true },
  [0x1c] = { xoff = 0, yoff = 10, width = 10, height = 48, oscillation = true },
  [0x1d] = { xoff = 2, yoff = -3, width = 28, height = 27, oscillation = true },
  [0x1e] = { xoff = -32, yoff = -8, width = 48, height = 32, oscillation = true },
  [0x1f] = { xoff = -16, yoff = -4, width = 48, height = 18, oscillation = true },
  [0x20] = { xoff = -4, yoff = -24, width = 8, height = 24, oscillation = true },
  [0x21] = { xoff = -4, yoff = 16, width = 8, height = 24, oscillation = true },
  [0x22] = { xoff = 0, yoff = 0, width = 16, height = 16, oscillation = true },
  [0x23] = { xoff = -8, yoff = -24, width = 32, height = 32, oscillation = true },
  [0x24] = { xoff = -12, yoff = 32, width = 56, height = 56, oscillation = true },
  [0x25] = { xoff = -14, yoff = 4, width = 60, height = 20, oscillation = true },
  [0x26] = { xoff = 0, yoff = 88, width = 32, height = 8, oscillation = true },
  [0x27] = { xoff = -4, yoff = -4, width = 24, height = 24, oscillation = true },
  [0x28] = { xoff = -14, yoff = -24, width = 28, height = 40, oscillation = true },
  [0x29] = { xoff = -16, yoff = -4, width = 32, height = 27, oscillation = true },
  [0x2a] = { xoff = 2, yoff = -8, width = 12, height = 19, oscillation = true },
  [0x2b] = { xoff = 0, yoff = 2, width = 16, height = 76, oscillation = true },
  [0x2c] = { xoff = -8, yoff = -8, width = 16, height = 16, oscillation = true },
  [0x2d] = { xoff = 4, yoff = 4, width = 8, height = 4, oscillation = true },
  [0x2e] = { xoff = 2, yoff = -2, width = 28, height = 34, oscillation = true },
  [0x2f] = { xoff = 2, yoff = -2, width = 28, height = 32, oscillation = true },
  [0x30] = { xoff = 8, yoff = -14, width = 16, height = 28, oscillation = true },
  [0x31] = { xoff = 0, yoff = -2, width = 48, height = 18, oscillation = true },
  [0x32] = { xoff = 0, yoff = -2, width = 48, height = 18, oscillation = true },
  [0x33] = { xoff = 0, yoff = -2, width = 64, height = 18, oscillation = true },
  [0x34] = { xoff = -4, yoff = -4, width = 8, height = 8, oscillation = true },
  [0x35] = { xoff = 3, yoff = 0, width = 18, height = 32, oscillation = true },
  [0x36] = { xoff = 8, yoff = 8, width = 52, height = 46, oscillation = true },
  [0x37] = { xoff = 0, yoff = -8, width = 15, height = 20, oscillation = true },
  [0x38] = { xoff = 8, yoff = 16, width = 32, height = 40, oscillation = true },
  [0x39] = { xoff = 4, yoff = 3, width = 8, height = 10, oscillation = true },
  [0x3a] = { xoff = -8, yoff = 16, width = 32, height = 16, oscillation = true },
  [0x3b] = { xoff = 0, yoff = 0, width = 16, height = 13, oscillation = true },
  [0x3c] = { xoff = 12, yoff = 10, width = 3, height = 6, oscillation = true },
  [0x3d] = { xoff = 12, yoff = 21, width = 3, height = 20, oscillation = true },
  [0x3e] = { xoff = 16, yoff = 18, width = 254, height = 16, oscillation = true },
  [0x3f] = { xoff = 8, yoff = 8, width = 8, height = 24, oscillation = true }
}

SMW.obj_clipping_sprite = {  -- sprites' interaction points against objects
  [0x0] = {xright = 14, xleft =  2, xdown =  8, xup =  8, yright =  8, yleft =  8, ydown = 16, yup =  2},
  [0x1] = {xright = 14, xleft =  2, xdown =  7, xup =  7, yright = 18, yleft = 18, ydown = 32, yup =  2},
  [0x2] = {xright =  7, xleft =  7, xdown =  7, xup =  7, yright =  7, yleft =  7, ydown =  7, yup =  7},
  [0x3] = {xright = 14, xleft =  2, xdown =  8, xup =  8, yright = 16, yleft = 16, ydown = 32, yup = 11},
  [0x4] = {xright = 16, xleft =  0, xdown =  8, xup =  8, yright = 18, yleft = 18, ydown = 32, yup =  2},
  [0x5] = {xright = 13, xleft =  2, xdown =  8, xup =  8, yright = 24, yleft = 24, ydown = 32, yup = 16},
  [0x6] = {xright =  7, xleft =  0, xdown =  4, xup =  4, yright =  4, yleft =  4, ydown =  8, yup =  0},
  [0x7] = {xright = 31, xleft =  1, xdown = 16, xup = 16, yright = 16, yleft = 16, ydown = 31, yup =  1},
  [0x8] = {xright = 15, xleft =  0, xdown =  8, xup =  8, yright =  8, yleft =  8, ydown = 15, yup =  0},
  [0x9] = {xright = 16, xleft =  0, xdown =  8, xup =  8, yright =  8, yleft =  8, ydown = 16, yup =  0},
  [0xa] = {xright = 13, xleft =  2, xdown =  8, xup =  8, yright = 72, yleft = 72, ydown = 80, yup = 66},
  [0xb] = {xright = 14, xleft =  2, xdown =  8, xup =  8, yright =  4, yleft =  4, ydown =  8, yup =  0},
  [0xc] = {xright = 13, xleft =  2, xdown =  8, xup =  8, yright =  0, yleft =  0, ydown =  0, yup =  0},
  [0xd] = {xright = 16, xleft =  0, xdown =  8, xup =  8, yright =  8, yleft =  8, ydown = 16, yup =  0},
  [0xe] = {xright = 31, xleft =  0, xdown = 16, xup = 16, yright =  8, yleft =  8, ydown = 16, yup =  0},
  [0xf] = {xright =  8, xleft =  8, xdown =  8, xup = 16, yright =  4, yleft =  1, ydown =  2, yup =  4}
}

SMW.sprite_tweakers_info = { -- TODO: add this in the tweaker function
  [1] = {"Disappear in cloud of smoke", "Hop in/kick shells", "Dies when jumped on", "Can be jumped on", "Object clipping", "Object clipping", "Object clipping", "Object clipping"},
  [2] = {"Falls straight down when killed", "Use shell as death frame", "Sprite clipping", "Sprite clipping", "Sprite clipping", "Sprite clipping", "Sprite clipping", "Sprite clipping"},
  [3] = {"Don't interact with layer 2 (or layer 3 tides)", "Disable water splash", "Disable cape killing", "Disable fireball killing", "Palette", "Palette", "Palette", "Use second graphics page"},
  [4] = {"Don't use default interaction with player", "Gives power-up when eaten by Yoshi", "Process interaction with player every frame", "Can't be kicked like a shell", "Don't change into a shell when stunned", "Process while off screen", "Invincible to star/cape/fire/bouncing bricks", "Don't disable clipping when killed with star"},
  [5] = {"Don't interact with objects", "Spawns a new sprite", "Don't turn into a coin when goal passed", "Don't change direction if touched", "Don't interact with other sprites", "Weird ground behavior", "Stay in Yoshi's mouth", "Inedible"},
  [6] = {"Don't get stuck in walls (carryable sprites)", "Don't turn into a coin with silver POW", "Death frame 2 tiles high", "Can be jumped on with upward Y speed", "Takes 5 fireballs to kill. Clear means it's killed by one.", "Can't be killed by sliding", "Don't erase when goal passed", "Make platform passable from below"}
}

SMW.hitbox_extended_sprite = {
  -- To fill the slots...
  --[0] ={ xoff = 3, yoff = 3, width = 64, height = 64},  -- Free slot
  [0x01] ={ xoff = 3, yoff = 3, width =  0, height =  0},  -- Puff of smoke with various objects
  [0x0e] ={ xoff = 3, yoff = 3, width =  0, height =  0},  -- Wiggler's flower
  [0x0f] ={ xoff = 3, yoff = 3, width =  0, height =  0},  -- Trail of smoke
  [0x10] ={ xoff = 3, yoff = 3, width =  0, height =  0},  -- Spinjump stars
  [0x12] ={ xoff = 3, yoff = 3, width =  0, height =  0},  -- Water bubble
  -- extracted from ROM:
  [0x02] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.fireball},  -- Reznor fireball
  [0x03] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.fireball},  -- Flame left by hopping flame
  [0x04] = { xoff = 4, yoff = 4, width = 8, height = 8},  -- Hammer
  [0x05] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.fireball },  -- Player fireball
  [0x06] = { xoff = 4, yoff = 4, width = 8, height = 8},  -- Bone from Dry Bones
  [0x07] = { xoff = 0, yoff = 0, width = 0, height = 0},  -- Lava splash
  [0x08] = { xoff = 0, yoff = 0, width = 0, height = 0},  -- Torpedo Ted shooter's arm
  [0x09] = { xoff = 0, yoff = 0, width = 15, height = 15},  -- Unknown flickering object
  [0x0a] = { xoff = 4, yoff = 2, width = 8, height = 12},  -- Coin from coin cloud game
  [0x0b] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.fireball },  -- Piranha Plant fireball
  [0x0c] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.fireball },  -- Lava Lotus's fiery objects
  [0x0d] = { xoff = 3, yoff = 3, width = 1, height = 1, color_line = COLOUR.baseball},  -- Baseball
  -- got experimentally:
  [0x11] = { xoff = -0x1, yoff = -0x4, width = 11, height = 19},  -- Yoshi fireballs
}

SMW.hitbox_cluster_sprite = {  -- got experimentally
  --[0] -- Free slot
  [0x01] = { xoff = 2, yoff = 0, width = 17, height = 21, oscillation = 2, phase = 1, color = COLOUR.awkward_hitbox, bg = COLOUR.awkward_hitbox_bg},  -- 1-Up from bonus game (glitched hitbox area)
  [0x02] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Unused
  [0x03] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Boo from Boo Ceiling
  [0x04] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Boo from Boo Ring
  [0x05] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Castle candle flame (meaningless hitbox)
  [0x06] = { xoff = 2, yoff = 2, width = 12, height = 20, oscillation = 4, color = COLOUR.sumo_brother_flame},  -- Sumo Brother lightning flames
  [0x07] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Reappearing Boo
  [0x08] = { xoff = 4, yoff = 7, width = 7, height = 7, oscillation = 4},  -- Swooper bat from Swooper Death Bat Ceiling (untested)
}

SMW.hitbox_quake_sprite = {
--[0x00] = Free slot
  [0x01] = { xoff = -04, yoff = -4, width = 24, height = 24}, -- Bounce blocks
  [0x02] = { xoff = -32, yoff = -8, width = 80, height = 16}, -- Trail of smoke (Yoshi yellow power)
}

SMW.yoshi_tongue_x_offsets = {
  [0] = 0xf5, 0xf5, 0xf5, 0xf5, 0xf5, 0xf5, 0xf5, 0xf0,
  0x13, 0x13, 0x13, 0x13, 0x13, 0x13, 0x13, 0x18,
  0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x13,
  0xbd, 0x3e, 0x16, 0x05, 0x9d, 0xd0, 0x3e, 0xa0
}

SMW.yoshi_tongue_y_offsets = {
  [0] = 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x13,
  0xbd, 0x3e, 0x16, 0x05, 0x9d, 0xd0, 0x3e, 0xa0,
  0x0b, 0x8c, 0x95, 0x16, 0x98, 0x45, 0x13, 0x29
}

                    -- 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  10 11 12
SMW.sprite_memory_max = {[0] = 10, 6, 7, 6, 7, 5, 8, 5, 7, 9, 9, 4, 8, 6, 8, 9, 10, 6, 6}  -- the max of sprites in a room

-- from sprite number, returns oscillation flag
-- A sprite must be here iff it processes interaction with player every frame AND this bit is not working in the sprite_4_tweaker WRAM(0x167a)
SMW.oscillation_sprites = luap.make_set{0x0e, 0x21, 0x29, 0x35, 0x54, 0x74, 0x75, 0x76, 0x77, 0x78, 0x81, 0x83, 0x87}

-- BUS address of the end of this routine, might be different in ROMhacks
SMW.check_for_contact_routine = 0x03b75b

-- Sprites that have a custom hitbox drawing
SMW.abnormal_hitbox_sprites = luap.make_set{0x62, 0x63, 0x6b, 0x6c}

-- Sprites whose clipping interaction points usually matter
SMW.good_sprites_clipping = luap.make_set{
  0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xf, 0x10, 0x11, 0x13, 0x14, 0x18,
  0x1b, 0x1d, 0x1f, 0x20, 0x26, 0x27, 0x29, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
  0x32, 0x34, 0x35, 0x3d, 0x3e, 0x3f, 0x40, 0x46, 0x47, 0x48, 0x4d, 0x4e,
  0x51, 0x53, 0x6e, 0x6f, 0x70, 0x80, 0x81, 0x86,
  0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0xa1, 0xa2, 0xa5, 0xa6, 0xa7, 0xab, 0xb2,
  0xb4, 0xbb, 0xbc, 0xbd, 0xbf, 0xc3, 0xda, 0xdb, 0xdc, 0xdd, 0xdf
}

-- Extended sprites that don't interact with the player
SMW.uninteresting_extended_sprites = luap.make_set{0x01, 0x07, 0x08, 0x0e, 0x10, 0x12}

-- Sprites that naturally have their stun state AND stun timer -- TODO: see if needed
SMW.normal_stunnable = luap.make_set{0x04, 0x05, 0x06, 0x07, 0x0d, 0x0f, 0x11, 0x2c, 0x2d, 0x53, 0xa2}

-- Sprite names
SMW.sprite_names = {
  [0x00] = "Green Koopa Troopa without shell",     [0x40] = "Para-Bomb",                                     [0x80] = "Key",                                             [0xC0] = "Sinking gray platform on lava",                  
  [0x01] = "Red Koopa Troopa without shell",       [0x41] = "Dolphin that swims and jumps in one direction", [0x81] = "Changing item",                                   [0xC1] = "Flying gray turn blocks",                        
  [0x02] = "Blue Koopa Troopa without shell",      [0x42] = "Dolphin that swims and jumps back and forth",   [0x82] = "Bonus game sprite",                               [0xC2] = "Blurp",                                          
  [0x03] = "Yellow Koopa Troopa without shell",    [0x43] = "Dolphin that swims and jumps up and down",      [0x83] = "Flying question block that flies left",           [0xC3] = "Porcu-Puffer",                                   
  [0x04] = "Green Koopa Troopa",                   [0x44] = "Torpedo Ted",                                   [0x84] = "Flying question block that flies back and forth", [0xC4] = "Gray platform that falls",                       
  [0x05] = "Red Koopa Troopa",                     [0x45] = "Directional coins",                             [0x85] = "Unused",                                          [0xC5] = "Big Boo Boss",                                   
  [0x06] = "Blue Koopa Troopa",                    [0x46] = "Diggin' Chuck",                                 [0x86] = "Wiggler",                                         [0xC6] = "Spotlight/dark room sprite",                     
  [0x07] = "Yellow Koopa Troopa",                  [0x47] = "Swimming/jumping fish",                         [0x87] = "Lakitu's cloud",                                  [0xC7] = "Invisible mushroom",                             
  [0x08] = "Green Koopa Troopa flying left",       [0x48] = "Diggin' Chuck's rock",                          [0x88] = "Winged cage (unused)",                            [0xC8] = "Light switch for dark room",                     
  [0x09] = "Green Koopa Troopa bouncing",          [0x49] = "Growing/shrinking pipe",                        [0x89] = "Layer 3 Smash",                                   [0xC9] = "Bullet Bill shooter",                            
  [0x0A] = "Red Koopa Troopa flying vertically",   [0x4A] = "Goal Point Question Sphere",                    [0x8A] = "Yoshi's House bird",                              [0xCA] = "Torpedo Ted launcher",                           
  [0x0B] = "Red Koopa Troopa flying horizontally", [0x4B] = "Pipe-dwelling Lakitu",                          [0x8B] = "Puff of smoke from Yoshi's House",                [0xCB] = "Eerie generator",                                
  [0x0C] = "Yellow Koopa Troopa with wings",       [0x4C] = "Exploding block",                               [0x8C] = "Side exit enabler",                               [0xCC] = "Para-Goomba generator",                          
  [0x0D] = "Bob-Omb",                              [0x4D] = "Monty Mole, ground-dwelling",                   [0x8D] = "Ghost house exit sign and door",                  [0xCD] = "Para-Bomb generator",                            
  [0x0E] = "Keyhole",                              [0x4E] = "Monty Mole, ledge-dwelling",                    [0x8E] = "Invisible warp hole",                             [0xCE] = "Para-Goomba and Para-Bomb generator",            
  [0x0F] = "Goomba",                               [0x4F] = "Jumping Piranha Plant",                         [0x8F] = "Scale platforms",                                 [0xCF] = "Dolphin generator (left)",                       
  [0x10] = "Bouncing Goomba with wings",           [0x50] = "Jumping Piranha Plant that spits fireballs",    [0x90] = "Large green gas bubble",                          [0xD0] = "Dolphin generator (right)",                      
  [0x11] = "Buzzy Beetle",                         [0x51] = "Ninji",                                         [0x91] = "Chargin' Chuck",                                  [0xD1] = "Flying fish generator",                          
  [0x12] = "Unused",                               [0x52] = "Moving hole in ghost house ledge",              [0x92] = "Splittin' Chuck",                                 [0xD2] = "Turn Off Generator 2",                           
  [0x13] = "Spiny",                                [0x53] = "Throw block sprite",                            [0x93] = "Bouncin' Chuck",                                  [0xD3] = "Super Koopa generator",                          
  [0x14] = "Spiny falling",                        [0x54] = "Revolving door for climbing net",               [0x94] = "Whistlin' Chuck",                                 [0xD4] = "Bubbled sprite generator",                       
  [0x15] = "Cheep Cheep swimming horizontally",    [0x55] = "Checkerboard platform, horizontal",             [0x95] = "Chargin' Chuck",                                  [0xD5] = "Bullet Bill generator",                          
  [0x16] = "Cheep Cheep swimming vertically",      [0x56] = "Flying rock platform, horizontal",              [0x96] = "Unused",                                          [0xD6] = "Multidirectional Bullet Bill generator",         
  [0x17] = "Cheep Cheep flying",                   [0x57] = "Checkerboard platform, vertical",               [0x97] = "Puntin' Chuck",                                   [0xD7] = "Multidirectional diagonal Bullet Bill generator",
  [0x18] = "Cheep Cheep jumping to surface",       [0x58] = "Flying rock platform, vertical",                [0x98] = "Pitchin' Chuck",                                  [0xD8] = "Bowser statue fire generator",                   
  [0x19] = "Display text from level message 1",    [0x59] = "Turn block bridge, horizontal and vertical",    [0x99] = "Volcano Lotus",                                   [0xD9] = "Turn Off Generators",                            
  [0x1A] = "Classic Piranha Plant",                [0x5A] = "Turn block bridge, horizontal",                 [0x9A] = "Sumo Brother",                                    [0xDA] = "Green Koopa shell",                              
  [0x1B] = "Bouncing Football in place",           [0x5B] = "Floating brown platform",                       [0x9B] = "Amazing Flying Hammer Brother",                   [0xDB] = "Red Koopa shell",                                
  [0x1C] = "Bullet Bill",                          [0x5C] = "Floating checkerboard platform",                [0x9C] = "Flying gray blocks for Hammer Brother",           [0xDC] = "Blue Koopa shell",                               
  [0x1D] = "Hopping flame",                        [0x5D] = "Small orange floating platform",                [0x9D] = "Sprite in a bubble",                              [0xDD] = "Yellow Koopa shell",                             
  [0x1E] = "Lakitu",                               [0x5E] = "Large orange floating platform",                [0x9E] = "Ball 'n' Chain",                                  [0xDE] = "Group of 5 wave-moving Eeries",                  
  [0x1F] = "Magikoopa",                            [0x5F] = "Swinging brown platform",                       [0x9F] = "Banzai Bill",                                     [0xDF] = "Green Para-Koopa shell",                         
  [0x20] = "Magikoopa's magic",                    [0x60] = "Flat switch palace switch",                     [0xA0] = "Bowser battle activator",                         [0xE0] = "3 rotating gray platforms",                      
  [0x21] = "Moving coin",                          [0x61] = "Floating skulls",                               [0xA1] = "Bowser's bowling ball",                           [0xE1] = "Boo Ceiling",                                    
  [0x22] = "Green vertical net Koopa",             [0x62] = "Brown line-guided platform",                    [0xA2] = "Mecha-Koopa",                                     [0xE2] = "Boo Ring moving counterclockwise",               
  [0x23] = "Red vertical net Koopa",               [0x63] = "Brown/checkered line-guided platform",          [0xA3] = "Rotating gray platform",                          [0xE3] = "Boo Ring moving clockwise",                      
  [0x24] = "Green horizontal net Koopa",           [0x64] = "Line-guided rope mechanism",                    [0xA4] = "Floating spike ball",                             [0xE4] = "Swooper Death Bat Ceiling",                      
  [0x25] = "Red horizontal net Koopa",             [0x65] = "Chainsaw (line-guided)",                        [0xA5] = "Wall-following Sparky/Fuzzy",                     [0xE5] = "Appearing/disappearing Boos",                    
  [0x26] = "Thwomp",                               [0x66] = "Upside-down chainsaw (line-guided)",            [0xA6] = "Hothead",                                         [0xE6] = "Background candle flames",                       
  [0x27] = "Thwimp",                               [0x67] = "Grinder, line-guided",                          [0xA7] = "Iggy's ball projectile",                          [0xE7] = "Unused",                                         
  [0x28] = "Big Boo",                              [0x68] = "Fuzzy, line-guided",                            [0xA8] = "Blargg",                                          [0xE8] = "Special auto-scroll command",                    
  [0x29] = "Koopa Kid",                            [0x69] = "Unused",                                        [0xA9] = "Reznor",                                          [0xE9] = "Layer 2 Smash",                                  
  [0x2A] = "Upside-down Piranha Plant",            [0x6A] = "Coin game cloud",                               [0xAA] = "Fishbone",                                        [0xEA] = "Layer 2 scrolling command",                      
  [0x2B] = "Sumo Brother's lightning",             [0x6B] = "Wall springboard (left wall)",                  [0xAB] = "Rex",                                             [0xEB] = "Unused",                                         
  [0x2C] = "Yoshi egg",                            [0x6C] = "Wall springboard (right wall)",                 [0xAC] = "Wooden spike pointing down",                      [0xEC] = "Unused",                                         
  [0x2D] = "Baby Yoshi",                           [0x6D] = "Invisible solid block",                         [0xAD] = "Wooden spike pointing up",                        [0xED] = "Layer 2 Falls",                                  
  [0x2E] = "Spike Top",                            [0x6E] = "Dino-Rhino",                                    [0xAE] = "Fishin' Boo",                                     [0xEE] = "Unused",                                         
  [0x2F] = "Portable springboard",                 [0x6F] = "Dino-Torch",                                    [0xAF] = "Boo Block",                                       [0xEF] = "Layer 2 sideways-scrolling command",             
  [0x30] = "Dry Bones that throws bones",          [0x70] = "Pokey",                                         [0xB0] = "Reflecting stream of Boo Buddies",                [0xF0] = "Unused",                                         
  [0x31] = "Bony Beetle",                          [0x71] = "Super Koopa with red cape",                     [0xB1] = "Creating/eating block",                           [0xF1] = "Unused",                                         
  [0x32] = "Dry Bones that stays on ledges",       [0x72] = "Super Koopa with yellow cape",                  [0xB2] = "Falling spike",                                   [0xF2] = "Layer 2 on/off switch controller",               
  [0x33] = "Podoboo/vertical fireball",            [0x73] = "Super Koopa on the ground",                     [0xB3] = "Bowser statue fireball",                          [0xF3] = "Standard auto-scroll command",                   
  [0x34] = "Boss fireball",                        [0x74] = "Mushroom",                                      [0xB4] = "Grinder that moves on the ground",                [0xF4] = "Fast background scroll",                         
  [0x35] = "Yoshi",                                [0x75] = "Flower",                                        [0xB5] = "Unused",                                          [0xF5] = "Layer 2 sink command",                           
  [0x36] = "Unused",                               [0x76] = "Star",                                          [0xB6] = "Reflecting fireball",                             [0xF6] = "Unused",                                         
  [0x37] = "Boo",                                  [0x77] = "Feather",                                       [0xB7] = "Carrot Top Lift, upper right",                    [0xF7] = "Unused",                                         
  [0x38] = "Eerie that moves straight",            [0x78] = "1-Up mushroom",                                 [0xB8] = "Carrot Top Lift, upper left",                     [0xF8] = "Unused",                                         
  [0x39] = "Eerie that moves in a wave",           [0x79] = "Growing vine",                                  [0xB9] = "Info Box",                                        [0xF9] = "Unused",                                         
  [0x3A] = "Urchin that moves a fixed distance",   [0x7A] = "Firework",                                      [0xBA] = "Timed Lift",                                      [0xFA] = "Unused",                                         
  [0x3B] = "Urchin that moves between walls",      [0x7B] = "Goal tape",                                     [0xBB] = "Moving castle block",                             [0xFB] = "Unused",                                         
  [0x3C] = "Urchin that follows walls",            [0x7C] = "Peach (after Bowser fight)",                    [0xBC] = "Bowser statue",                                   [0xFC] = "Unused",                                         
  [0x3D] = "Rip Van Fish",                         [0x7D] = "P-Balloon",                                     [0xBD] = "Sliding Koopa",                                   [0xFD] = "Unused",                                         
  [0x3E] = "P-switch",                             [0x7E] = "Flying red coin",                               [0xBE] = "Swooper",                                         [0xFE] = "Unused",                                         
  [0x3F] = "Para-Goomba",                          [0x7F] = "Flying golden mushroom",                        [0xBF] = "Mega Mole",                                       [0xFF] = "Unused",                                         
}

-- Sprite table descriptions (from https://www.smwcentral.net/?p=nmap&m=smwram&u=0)
SMW.sprite_table_descr = {
  [0x009E] = "Sprite number, or Acts Like setting for custom sprites.",
  [0x00AA] = "Sprite Y speed table.",
  [0x00B6] = "Sprite X speed table.",
  [0x00C2] = "Miscellaneous sprite table. In SMW, it's commonly used as a pointer to different parts of a sprite. More information can be found here .",
  [0x00D8] = "Sprite Y position, low byte.",
  [0x00E4] = "Sprite X position, low byte.",
  [0x14C8] = "Sprite status table:    #$00 = Free slot, nonexistent sprite.  #$01 = Initial phase of sprite.  #$02 = Killed, falling off screen.  #$03 = Smushed. Rex and shellless Koopas can be in this state.  #$04 = Killed with a spinjump.  #$05 = Burning in lava; sinking in mud.  #$06 = Turn into coin at level end.  #$07 = Stay in Yoshi's mouth.  #$08 = Normal routine.  #$09 = Stationary / Carryable.  #$0A = Kicked.  #$0B = Carried.  #$0C = Powerup from being carried past goaltape.    States 08 and above are considered alive; sprites in other states are dead and should not be interacted with.",
  [0x14D4] = "Sprite Y position, high byte.",
  [0x14E0] = "Sprite X position, high byte.",
  [0x14EC] = "Accumulating fraction bits for fixed point sprite Y speed.",
  [0x14F8] = "Accumulating fraction bits for fixed point sprite X speed.",
  [0x1504] = "Miscellaneous sprite table. In SMW, it's used as e.g. throw timer. More information can be found here .",
  [0x1510] = "Miscellaneous sprite table. In SMW, it's used in the brown platform's graphics routine, but nowhere else in SMW's entire code. It is also not cleared in the sprite table clear routine, unlike every single other sprite table. More information can be found here .",
  [0x151C] = "Miscellaneous sprite table. In SMW, it's used for vertical directions, and Yoshi uses it to determine which sprite to spawn out of an egg.  $7E:1520$7E:1523 is a 'Reznor killed flag'. If a byte is set to #$01, the Reznor will disappear. Byte 1 is for Reznor 1, byte 2 for Reznor 2 and so on. More information can be found here .",
  [0x1528] = "Miscellaneous sprite table. In SMW, it's used for Chargin' Chuck HP, Thwomp's face expression, etc. More information can be found here .",
  [0x1534] = "Miscellaneous sprite table.  Certain powerups use this table as a blinkfall flag.  #$00 = Off; #$01 = On, powerup will blink and fall straight down.  The game stores #$01 here when it drops the reserved item from the item box. The blinkfall flag affects the Super Mushroom and the Fire Flower, but not the Cape Feather. The blinkfall flag also affects some other sprites, at least the Starman, the 1Up mushroom and the coin sprite, but these sprites might glitch if you set the flag.  One glitch is that the blinking spritecoin permanently occupies a sprite slot if it falls off the level, so that it might prevent the spawning of other common sprites.  Other than that, this address has many different purposes. More information can be found here .",
  [0x1540] = "Miscellaneous sprite table. Table decrements itself once per frame, except for carryable sprites, where it decrements every second frame.  Various sprites use this table as a stun timer. For example, this timer controls when flipped Goombas and squashed MechaKoopas decide to rise and walk. This table is also the sprite spinjump death frame counter  that is, how long to show the \"spinjumped\" image when the sprite is killed by a jump of such sorts. More information can be found here .",
  [0x154C] = "Miscellaneous sprite table. Used as a timer to disable sprite contact with the player. Table decrements itself once per frame. More information can be found here .",
  [0x1558] = "Miscellaneous sprite table. Used as a timer for how long a sprite is sinking in lava/mud. Table decrements itself once per frame. More information can be found here .",
  [0x1564] = "Miscellaneous sprite table. Used as a timer to disable sprite contact with other sprites. Table decrements itself once per frame. More information can be found here .",
  [0x1570] = "Miscellaneous sprite table. In SMW, it's used as a frame counter for timed lifts (amount of frames until it hits zero), a frame counter that indicates when sprites #$00#$13 that have the 'Follow player' flag set should turn, etc. More information can be found here .",
  [0x157C] = "Miscellaneous sprite table. It's most often used as a horizontal sprite direction table. #$00 = Right; #$01 = Left. More information can be found here .",
  [0x1588] = "Sprite blocked status table. Format: asb?udlr.  a = touching Layer 2 from above.  s = touching Layer 2 from the side.  b = touching Layer 2 from below.  ? = unknown, probably unused.  u = up.  d = down.  l = left.  r = right.",
  [0x1594] = "Miscellaneous sprite table. In classic Piranha Plants, it is used to check if the sprite should be made visible and have interaction with the player. If it's any nonzero value, that Piranha Plant will become invisible. More information can be found here .",
  [0x15A0] = "Sprite off screen flag table, horizontal.",
  [0x15AC] = "Miscellaneous sprite table. It's often used as a timer to determine how long it takes to turn around. Table decrements itself once per frame. More information can be found here .",
  [0x15B8] = "Determines what kind of slope a sprite is on.  Possible values:  #$FC = very steep slope left.  #$FD = steep slope left.  #$FE = normal slope left.  #$FF = gradual slope left.  #$00 = flat ground (or in the air).  #$01 = gradual slope right.  #$02 = normal slope right.  #$03 = steep slope right.  #$04 = very steep slope right.",
  [0x15C4] = "Flag set if a sprite is more than 4 tiles horizontally offscreen. Used by a few large sprites (e.g. turnblock bridges and chained platforms) to determine whether to draw any of the sprite at all.",
  [0x15D0] = "Flag for whether the sprite is on Yoshi's tongue. #$00 = No; #$01 = Yes.",
  [0x15DC] = "Flag to disable sprite interaction with objects. Ghost house ledges store their sprite index (plus one) to this to make sprites fall through the ground, but any nonzero value will work.",
  [0x15EA] = "Sprite index to the OAM table.",
  [0x15F6] = "Sprite YXPPCCCT table. Many sprites use it in their graphics routines.",
  [0x1602] = "Miscellaneous sprite table. Often used as graphics pointer. More information can be found here .",
  [0x160E] = "Miscellaneous sprite table. In SMW, it is used to keep track of things such as the green bouncing Koopa's Y speed and the sprite number of certain spawned, kicked, etc. sprites. More information can be found here .",
  [0x161A] = "Sprite index to the load status table (see $7E1938).",
  [0x1626] = "Miscellaneous sprite table. Consecutive enemies killed by a sprite table. Each byte is how many sprites that particular sprite has killed. In SMW, this applies to sprites that can be thrown, such as Koopa shells. More information can be found here .",
  [0x1632] = "\"Sprite is behind scenery\" flag. Used by, among others, the net Koopas.",
  [0x163E] = "Miscellaneous sprite table. Table decrements once per frame. In SMW, it's used as e.g. a timer that, when it's zero, makes Ludwig face the player, while he's spitting fireballs. More information can be found here .",
  [0x164A] = "Sprite is in liquid indicator table. #$00 = Sprite not in liquid; #$01 = Sprite in water; #$80 = Sprite in lava.    Also used in the Morton/Roy battle as an indicator that the walls have to close in, and in Bowser's fight to indicate the music after Bowser is defeated has already started.",
  [0x1656] = "Sprite properties, first Tweaker/MWR byte.  Format: sSjJcccc  s=Disappear in cloud of smoke  S=Hop in/kick shells  j=Dies when jumped on  J=Can be jumped on (false = player gets hurt if he jumps on the sprite, but can bounce off with a spin jump)  cccc=Object clipping",
  [0x1662] = "Sprite properties, second Tweaker/MWR byte.  Format: dscccccc  d=Falls straight down when killed  s=Use shell as death frame  cccccc=Sprite clipping",
  [0x166E] = "Sprite properties, third Tweaker/MWR byte.  Format: lwcfpppg  l=Don't interact with layer 2 (or layer 3 tides)  w=Disable water splash  c=Disable cape killing  f=Disable fireball killing  ppp=Palette  g=Use second graphics page",
  [0x167A] = "Sprite properties, fourth Tweaker/MWR byte.  Format: dpmksPiS  d=Don't use default interaction with player  p=Gives powerup when eaten by Yoshi  m=Process interaction with player every frame  k=Can't be kicked like a shell  s=Don't change into a shell when stunned  P=Process while off screen  i=Invincible to star/cape/fire/bouncing bricks  S=Don't disable clipping when killed with star",
  [0x1686] = "Sprite properties, fifth Tweaker/MWR byte.  Format: dnctswye  d=Don't interact with objects  n=Spawns a new sprite  c=Don't turn into a coin when goal passed  t=Don't change direction if touched  s=Don't interact with other sprites  w=Weird ground behavior  y=Stay in Yoshi's mouth  e=Inedible",
  [0x186C] = "Sprite off screen flag table, vertical. For sprites in bank 1, if the sprite is set to be two tiles high (with $190F), then bits 0 and 1 correspond to the top and bottom tiles respectively.    The routine that sets this address in bank 2 and 3 has an error, however; this address instead does the 2bit functionality if bit 5 of $1662 (which is one of the bits in the sprite clipping value). As a result, some sprites will register as vertically offscreen when they're actually just at the top of the screen.",
  [0x187B] = "Miscellaneous sprite table. Has the following purposes:    Sprite stomp immunity flag table  enables stomp immunity for sprites if the flag is set.  Additionally, the changing item sprite uses it to determine which sprite it is (#$00 = mushroom, #$40 = fire flower, #$80 = feather, #$C0 = star), the goal tape determines by this address whether it activates the normal or secret exit, the radius of rotating chain sprites is held by this address, certain Yoshi abilities are handled, etc. More information can be found here .    $7E:1884 is also used to determine what background should be used during the Morton/Roy/Ludwig battle scene. #$00 = Ludwig; #$01 = Morton/Roy.  There is also a bug with the background flames during the Ludwig battle, as they seem to change color upon this address not being #$01. This is responsible for a palette glitch in the original SMW, where the fire turns a greyish blue very briefly. Change $02:8380 to #$80 to fix the bug.",
  [0x190F] = "Sprite properties, sixth Tweaker/MWR byte.  Format: wcdj5sDp  w=Don't get stuck in walls (carryable sprites)  c=Don't turn into a coin with silver POW  d=Death frame 2 tiles high  j=Can be jumped on with upward Y speed  5=Takes 5 fireballs to kill. Clear means it's killed by one. The hit counter is at $7E:1528.  s=Can't be killed by sliding  D=Don't erase when goal passed  p=Make platform passable from below",
  [0x1FD6] = "Unused sprite table, cleared at individual sprite load. (1 slot each.)",
  [0x1FE2] = "Sprite table that decrements once per frame, and is used for multiple purposes. All standard sprites have it briefly set after spawning.    Primarily, it disables water splashes from showing when the sprite enter or exits water, and disables interaction for the sprite with capespins, quake sprites, cape smashes, and net punches. Some sprites use it for miscellaneous purposes, as well. More information can be found here .",
}

-- Level sprite data pointers ($05EC00)
SMW.sprite_data_pointers = {
  0x07C407, 0x07CE1C, 0x07CEBF, 0x07C4C5, 0x07C7B5, 0x07C7D9, 0x07C844, 0x07C904, 0x07C49D, 0x07C751, 0x07C948, 0x07CF06, 0x07D1F5, 0x07D25A, 0x07D0D7, 0x07CFAF,
  0x07D043, 0x07D157, 0x07E76D, 0x07C9CA, 0x07C446, 0x07C6D5, 0x07C6D5, 0x07C6D5, 0x07DC2D, 0x07E76D, 0x07DBBB, 0x07D95E, 0x07DB0F, 0x07DA93, 0x07E76D, 0x07D648,
  0x07D4CD, 0x07D74C, 0x07D6D9, 0x07D8BE, 0x07D7BF, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07C3DB, 0x07C3E3, 0x07C367, 0x07C359, 0x07C354, 0x07C34F, 0x07C34A, 0x07C345, 0x07C340, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07C3EE, 0x07D741, 0x07D02F,
  0x07DB95, 0x07D0CF, 0x07C9AA, 0x07C8EA, 0x07C3F5, 0x07C441, 0x07C3F0, 0x07C427, 0x07DDCF, 0x07C4C0, 0x07C44B, 0x07C3F0, 0x07D51D, 0x07D899, 0x07D84B, 0x07D7E5,
  0x07D6D9, 0x07D6D9, 0x07C8CD, 0x07DC22, 0x07DBF9, 0x07C414, 0x07D668, 0x07D956, 0x07CEBA, 0x07D152, 0x07C3EE, 0x07D111, 0x07D0F4, 0x07D304, 0x07C7BD, 0x07C414,
  0x07CF4D, 0x07CF4D, 0x07C414, 0x07C749, 0x07CA0C, 0x07C943, 0x07C3EE, 0x07C926, 0x07C915, 0x07C7A7, 0x07DADD, 0x07C40C, 0x07C9CA, 0x07C9DB, 0x07C9CA, 0x07D9B1,
  0x07C3F5, 0x07C9F2, 0x07C9DB, 0x07C3F0, 0x07C3EE, 0x07D6D9, 0x07D6D9, 0x07DC61, 0x07DC3B, 0x07C7BD, 0x07C3EE, 0x07C3F5, 0x07D799, 0x07C3EE, 0x07C7CB, 0x07C3F0,
  
  0x07C407, 0x07C66F, 0x07C5F4, 0x07C593, 0x07E759, 0x07C4CA, 0x07C532, 0x07CBDC, 0x07E76D, 0x07CDC8, 0x07CC25, 0x07CA17, 0x07E76D, 0x07C422, 0x07E19D, 0x07DF08,
  0x07DFB1, 0x07E032, 0x07E76D, 0x07DE4F, 0x07DE01, 0x07DD7B, 0x07DD14, 0x07D9EF, 0x07CB2A, 0x07CCD4, 0x07CA87, 0x07C450, 0x07CD68, 0x07D522, 0x07D30C, 0x07D577,
  0x07D380, 0x07C478, 0x07D5F5, 0x07D445, 0x07E76D, 0x07E6F4, 0x07E650, 0x07E5DF, 0x07E574, 0x07E76D, 0x07E3DC, 0x07E428, 0x07E466, 0x07E4F1, 0x07E76D, 0x07E76D,
  0x07E221, 0x07E76D, 0x07E29E, 0x07E76D, 0x07E1C5, 0x07E2AF, 0x07E335, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07C3E3, 0x07C3DB, 0x07C367, 0x07C359, 0x07C354, 0x07C34F, 0x07C34A, 0x07C345, 0x07C340, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D,
  0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07E76D, 0x07C3EE, 0x07C3EE, 0x07E19D, 0x07C661, 0x07DF94,
  0x07DA7F, 0x07D5CF, 0x07CCBA, 0x07CBC5, 0x07E402, 0x07E402, 0x07CA6D, 0x07E1C0, 0x07E4EC, 0x07C3EE, 0x07C57F, 0x07C3EE, 0x07E183, 0x07E160, 0x07E131, 0x07E114,
  0x07C422, 0x07E0E8, 0x07E0C5, 0x07E08D, 0x07E067, 0x07C3F0, 0x07C3F0, 0x07C498, 0x07C473, 0x07DE01, 0x07C3F5, 0x07DE3B, 0x07DE3B, 0x07DE0F, 0x07C414, 0x07D5C7,
  0x07C3EE, 0x07C3F0, 0x07DDB8, 0x07DDB3, 0x07C3EE, 0x07DD76, 0x07C3F5, 0x07C40C, 0x07D522, 0x07D522, 0x07CC11, 0x07E024, 0x07DA44, 0x07DA12, 0x07C3F0, 0x07CB01,
  0x07CE14, 0x07CE0C, 0x07CDC0, 0x07CD94, 0x07C3EE, 0x07CD63, 0x07C6D0, 0x07C3EE, 0x07D4C5, 0x07C3F5, 0x07D56C, 0x07CBDC, 0x07C6BF, 0x07C5EF, 0x07DFE0, 0x07C659,
}

SMW.trigonometry = { -- TODO: see if needed
  [0x00] = 0x00,  [0x01] = 0x03, [0x02] = 0x06, [0x03] = 0x09, [0x04] = 0x0c, [0x05] = 0x0f, [0x06] = 0x12, [0x07] = 0x15, [0x08] = 0x19, [0x09] = 0x1c, [0x0a] = 0x1f, [0x0b] = 0x22, [0x0c] = 0x25, [0x0d] = 0x28, [0x0e] = 0x2b, [0x0f] = 0x2e, 
  [0x10] = 0x31,  [0x11] = 0x35, [0x12] = 0x38, [0x13] = 0x3b, [0x14] = 0x3e, [0x15] = 0x41, [0x16] = 0x44, [0x17] = 0x47, [0x18] = 0x4a, [0x19] = 0x4d, [0x1a] = 0x50, [0x1b] = 0x53, [0x1c] = 0x56, [0x1d] = 0x59, [0x1e] = 0x5c, [0x1f] = 0x5f, 
  [0x20] = 0x61,  [0x21] = 0x64, [0x22] = 0x67, [0x23] = 0x6a, [0x24] = 0x6d, [0x25] = 0x70, [0x26] = 0x73, [0x27] = 0x75, [0x28] = 0x78, [0x29] = 0x7b, [0x2a] = 0x7e, [0x2b] = 0x80, [0x2c] = 0x83, [0x2d] = 0x86, [0x2e] = 0x88, [0x2f] = 0x8b, 
  [0x30] = 0x8e,  [0x31] = 0x90, [0x32] = 0x93, [0x33] = 0x95, [0x34] = 0x98, [0x35] = 0x9b, [0x36] = 0x9d, [0x37] = 0x9f, [0x38] = 0xa2, [0x39] = 0xa4, [0x3a] = 0xa7, [0x3b] = 0xa9, [0x3c] = 0xab, [0x3d] = 0xae, [0x3e] = 0xb0, [0x3f] = 0xb2, 
  [0x40] = 0xb5,  [0x41] = 0xb7, [0x42] = 0xb9, [0x43] = 0xbb, [0x44] = 0xbd, [0x45] = 0xbf, [0x46] = 0xc1, [0x47] = 0xc3, [0x48] = 0xc5, [0x49] = 0xc7, [0x4a] = 0xc9, [0x4b] = 0xcb, [0x4c] = 0xcd, [0x4d] = 0xcf, [0x4e] = 0xd1, [0x4f] = 0xd3, 
  [0x50] = 0xd4,  [0x51] = 0xd6, [0x52] = 0xd8, [0x53] = 0xd9, [0x54] = 0xdb, [0x55] = 0xdd, [0x56] = 0xde, [0x57] = 0xe0, [0x58] = 0xe1, [0x59] = 0xe3, [0x5a] = 0xe4, [0x5b] = 0xe6, [0x5c] = 0xe7, [0x5d] = 0xe8, [0x5e] = 0xea, [0x5f] = 0xeb, 
  [0x60] = 0xec,  [0x61] = 0xed, [0x62] = 0xee, [0x63] = 0xef, [0x64] = 0xf1, [0x65] = 0xf2, [0x66] = 0xf3, [0x67] = 0xf4, [0x68] = 0xf4, [0x69] = 0xf5, [0x6a] = 0xf6, [0x6b] = 0xf7, [0x6c] = 0xf8, [0x6d] = 0xf9, [0x6e] = 0xf9, [0x6f] = 0xfa, 
  [0x70] = 0xfb,  [0x71] = 0xfb, [0x72] = 0xfc, [0x73] = 0xfc, [0x74] = 0xfd, [0x75] = 0xfd, [0x76] = 0xfe, [0x77] = 0xfe, [0x78] = 0xfe, [0x79] = 0xff, [0x7a] = 0xff, [0x7b] = 0xff, [0x7c] = 0xff, [0x7d] = 0xff, [0x7e] = 0xff, [0x7f] = 0xff, 
  [0x80] = 0x100, [0x81] = 0xff, [0x82] = 0xff, [0x83] = 0xff, [0x84] = 0xff, [0x85] = 0xff, [0x86] = 0xff, [0x87] = 0xff, [0x88] = 0xfe, [0x89] = 0xfe, [0x8a] = 0xfe, [0x8b] = 0xfd, [0x8c] = 0xfd, [0x8d] = 0xfc, [0x8e] = 0xfc, [0x8f] = 0xfb, 
  [0x90] = 0xfb,  [0x91] = 0xfa, [0x92] = 0xf9, [0x93] = 0xf9, [0x94] = 0xf8, [0x95] = 0xf7, [0x96] = 0xf6, [0x97] = 0xf5, [0x98] = 0xf4, [0x99] = 0xf4, [0x9a] = 0xf3, [0x9b] = 0xf2, [0x9c] = 0xf1, [0x9d] = 0xef, [0x9e] = 0xee, [0x9f] = 0xed, 
  [0xa0] = 0xec,  [0xa1] = 0xeb, [0xa2] = 0xea, [0xa3] = 0xe8, [0xa4] = 0xe7, [0xa5] = 0xe6, [0xa6] = 0xe4, [0xa7] = 0xe3, [0xa8] = 0xe1, [0xa9] = 0xe0, [0xaa] = 0xde, [0xab] = 0xdd, [0xac] = 0xdb, [0xad] = 0xd9, [0xae] = 0xd8, [0xaf] = 0xd6, 
  [0xb0] = 0xd4,  [0xb1] = 0xd3, [0xb2] = 0xd1, [0xb3] = 0xcf, [0xb4] = 0xcd, [0xb5] = 0xcb, [0xb6] = 0xc9, [0xb7] = 0xc7, [0xb8] = 0xc5, [0xb9] = 0xc3, [0xba] = 0xc1, [0xbb] = 0xbf, [0xbc] = 0xbd, [0xbd] = 0xbb, [0xbe] = 0xb9, [0xbf] = 0xb7, 
  [0xc0] = 0xb5,  [0xc1] = 0xb2, [0xc2] = 0xb0, [0xc3] = 0xae, [0xc4] = 0xab, [0xc5] = 0xa9, [0xc6] = 0xa7, [0xc7] = 0xa4, [0xc8] = 0xa2, [0xc9] = 0x9f, [0xca] = 0x9d, [0xcb] = 0x9b, [0xcc] = 0x98, [0xcd] = 0x95, [0xce] = 0x93, [0xcf] = 0x90, 
  [0xd0] = 0x8e,  [0xd1] = 0x8b, [0xd2] = 0x88, [0xd3] = 0x86, [0xd4] = 0x83, [0xd5] = 0x80, [0xd6] = 0x7e, [0xd7] = 0x7b, [0xd8] = 0x78, [0xd9] = 0x75, [0xda] = 0x73, [0xdb] = 0x70, [0xdc] = 0x6d, [0xdd] = 0x6a, [0xde] = 0x67, [0xdf] = 0x64, 
  [0xe0] = 0x61,  [0xe1] = 0x5f, [0xe2] = 0x5c, [0xe3] = 0x59, [0xe4] = 0x56, [0xe5] = 0x53, [0xe6] = 0x50, [0xe7] = 0x4d, [0xe8] = 0x4a, [0xe9] = 0x47, [0xea] = 0x44, [0xeb] = 0x41, [0xec] = 0x3e, [0xed] = 0x3b, [0xee] = 0x38, [0xef] = 0x35, 
  [0xf0] = 0x31,  [0xf1] = 0x2e, [0xf2] = 0x2b, [0xf3] = 0x28, [0xf4] = 0x25, [0xf5] = 0x22, [0xf6] = 0x1f, [0xf7] = 0x1c, [0xf8] = 0x19, [0xf9] = 0x15, [0xfa] = 0x12, [0xfb] = 0x0f, [0xfc] = 0x0c, [0xfd] = 0x09, [0xfe] = 0x06, [0xff] = 0x03, 
}


--#############################################################################
-- SCRIPT UTILITIES:


-- Variables used in various functions
local Cheat = {}  -- family of cheat functions and variables
local Previous = {}
local User_input = INPUT_KEYNAMES
local Joypad = {}
local Layer1_tiles = {}
local Layer2_tiles = {}
local Is_lagged = nil
local Mario_boost_indicator = nil
local Display = {}  -- some temporary display options
local Sprites_info = {}  -- keeps track of useful sprite info that might be used outside the main sprite function
local Sprite_hitbox = {}  -- keeps track of what sprite slots must display the hitbox
local Options_form = {}
local Sprite_tables_form = {}
local Item_box_table = {}
local RNG = {}
local Lagmeter = {}

-- Initialization of some tables
for i = 0, SMW.sprite_max -1 do -- sprite_max = 12
  Sprites_info[i] = {}
end

for key = 0, SMW.sprite_max - 1 do -- sprite_max = 12
  Sprite_hitbox[key] = {}
  for number = 0, 0xff do
    Sprite_hitbox[key][number] = {["sprite"] = true, ["block"] = SMW.good_sprites_clipping[number]}
  end
end

for i = 1, 256 do
  Item_box_table[i] = fmt("$%02X - %s ($%02X)", i-1, SMW.sprite_names[(i-1+0x73)%256], (i-1+0x73)%256)
  if i == 1 then Item_box_table[i] = "$00 - Nothing" end
end

RNG.possible_values = {}
RNG.reverse_possible_values = {}


-- Register a function to be executed on key press or release
-- execution happens in the main loop
local Keys = {}
Keys.press = {}
Keys.release = {}
Keys.down, Keys.up, Keys.pressed, Keys.released = {}, {}, {}, {}
function Keys.registerkeypress(key, fn)
  Keys.press[key] = fn
end
function Keys.registerkeyrelease(key, fn)
  Keys.release[key] = fn
end


local Movie_active, Readonly, Framecount, Lagcount, Rerecords, Game_region
local Lastframe_emulated, Starting_subframe_last_frame, Size_last_frame, Final_subframe_last_frame
local Nextframe, Starting_subframe_next_frame, Starting_subframe_next_frame, Final_subframe_next_frame
local function bizhawk_status()
  Movie_active = movie.isloaded()  -- BizHawk
  Readonly = movie.getreadonly()  -- BizHawk
  if Movie_active then
    Framecount = movie.length()  -- BizHawk
    Rerecords = movie.getrerecordcount()  -- BizHawk
  end
  Lagcount = emu.lagcount()  -- BizHawk
  Is_lagged = emu.islagged()  -- BizHawk
  Game_region = emu.getdisplaytype()  -- BizHawk

  -- Last frame info
  Lastframe_emulated = emu.framecount()

  -- Next frame info (only relevant in readonly mode)
  Nextframe = Lastframe_emulated + 1
end


local function mouse_onregion(x1, y1, x2, y2)
  -- Reads external mouse coordinates
  local mouse_x = User_input.xmouse*draw.AR_x
  local mouse_y = User_input.ymouse*draw.AR_y

  -- From top-left to bottom-right
  if x2 < x1 then
    x1, x2 = x2, x1
  end
  if y2 < y1 then
    y1, y2 = y2, y1
  end

  if mouse_x >= x1 and mouse_x <= x2 and  mouse_y >= y1 and mouse_y <= y2 then
    return true
  else
    return false
  end
end


-- Returns frames-time conversion
local function frame_time(frame)
  local total_seconds = frame/(Game_region == "NTSC" and NTSC_FRAMERATE or PAL_FRAMERATE)
  local hours = floor(total_seconds/3600)
  local tmp = total_seconds - 3600*hours
  local minutes = floor(tmp/60)
  tmp = tmp - 60*minutes
  local seconds = floor(tmp)

  local miliseconds = 1000* (total_seconds%1)
  if hours == 0 then hours = "" else hours = string.format("%d:", hours) end
  local str = string.format("%s%.2d:%.2d.%03.0f", hours, minutes, seconds, miliseconds)
  return str
end


--#############################################################################
-- SMW FUNCTIONS:


-- Returns the id of Yoshi; if more than one, the lowest sprite slot
local function get_yoshi_id()
  for i = 0, SMW.sprite_max - 1 do -- sprite_max = 12
    local id = u8(WRAM.sprite_number + i)
    local status = u8(WRAM.sprite_status + i)
    if id == 0x35 and status ~= 0 then return i end
  end

  return nil
end


-- Converts the in-game (x, y) to SNES-screen coordinates
local function screen_coordinates(x, y, camera_x, camera_y)
  local x_screen = (x - camera_x)
  local y_screen = (y - camera_y)

  return x_screen, y_screen
end


local Previous_real_frame, Real_frame, Effective_frame, Game_mode, Current_character
local Translevel_index, LM_translevel_number, Level_index, Layer1_data_pointer, Level_flag
local Camera_x, Camera_y, Player_x, Player_y, Player_x_screen, Player_y_screen
local Is_paused, Lock_animation_flag, Player_powerup, Player_animation_trigger, Yoshi_riding_flag, Yoshi_id
local function scan_smw()
  -- General info
  Previous_real_frame = Real_frame or u8(WRAM.real_frame)
  Real_frame = u8(WRAM.real_frame)
  Effective_frame = u8(WRAM.effective_frame)
  Game_mode = u8(WRAM.game_mode)
  Current_character = u8(WRAM.current_character) == 0 and "Mario" or "Luigi"
  
  -- Level info
  Translevel_index = u8(WRAM.translevel_index)
  LM_translevel_number = Translevel_index
  if Translevel_index > 0x24 then LM_translevel_number = Translevel_index + 0xDC end
  Sprite_data_pointer = u24(WRAM.sprite_data_pointer)
  for i = 1, 512 do
    if Sprite_data_pointer == SMW.sprite_data_pointers[i] then
      Level_index = i - 1
      break
    end
  end
  if Level_index == nil then Level_index = 0 end
  Layer1_data_pointer = u24(WRAM.layer1_data_pointer)
  Level_flag = u8(WRAM.level_flag_table + Translevel_index)

  -- Common coordinates
  Camera_x = u16(WRAM.camera_x)
  Camera_y = u16(WRAM.camera_y)
  Player_x = s16(WRAM.x)
  Player_y = s16(WRAM.y)
  Player_x_screen, Player_y_screen = screen_coordinates(Player_x, Player_y, Camera_x, Camera_y)
  
  -- In level frequently used info
  Is_paused = u8(WRAM.level_paused) == 1
  Lock_animation_flag = u8(WRAM.lock_animation_flag)
  Player_powerup = u8(WRAM.powerup)
  Player_animation_trigger = u8(WRAM.player_animation_trigger)
  Yoshi_riding_flag = u8(WRAM.yoshi_riding_flag) ~= 0
  Yoshi_id = get_yoshi_id()
  Display.is_player_near_borders = Player_x_screen <= 32 or Player_x_screen >= 0xd0 or Player_y_screen <= -100 or Player_y_screen >= 224
end


-- Converts BizHawk/emu-screen coordinates to in-game (x, y)
local function game_coordinates(x_emu, y_emu, camera_x, camera_y)
  -- Sane values
  camera_x = camera_x or Camera_x or u8(WRAM.camera_x)
  camera_y = camera_y or Camera_y or u8(WRAM.camera_y)

  local x_game = x_emu + camera_x
  local y_game = y_emu + camera_y

  return x_game, y_game
end


-- Returns the extreme values that Mario needs to have in order to NOT touch a rectangular object
local function display_boundaries(x_game, y_game, width, height, camera_x, camera_y)
  -- Font
  draw.Text_opacity = 0.6
  draw.Bg_opacity = 0.4

  -- Coordinates around the rectangle
  local left = width*floor(x_game/width)
  local top = height*floor(y_game/height)
  left, top = screen_coordinates(left, top, camera_x, camera_y)
  local right = left + width - 1
  local bottom = top + height - 1

  -- Reads WRAM values of the player
  local is_ducking = u8(WRAM.is_ducking)
  local powerup = Player_powerup
  local is_small = is_ducking ~= 0 or powerup == 0

  -- Left
  local left_text = string.format("%04X.0", width*floor(x_game/width) - 13)
  draw.text(draw.AR_x*left, draw.AR_y*(top+bottom)/2, left_text, false, false, 1.0, 0.5)

  -- Right
  local right_text = string.format("%04X.f", width*floor(x_game/width) + 12)
  draw.text(draw.AR_x*right, draw.AR_y*(top+bottom)/2, right_text, false, false, 0.0, 0.5)

  -- Top
  local value = (Yoshi_riding_flag and y_game - 16) or y_game
  local top_text = fmt("%04X.0", width*floor(value/width) - 32)
  draw.text(draw.AR_x*(left+right)/2, draw.AR_y*top, top_text, false, false, 0.5, 1.0)

  -- Bottom
  value = height*floor(y_game/height)
  if not is_small and not Yoshi_riding_flag then
    value = value + 0x07
  elseif is_small and Yoshi_riding_flag then
    value = value - 4
  else
    value = value - 1  -- the 2 remaining cases are equal
  end

  local bottom_text = fmt("%04X.f", value)
  draw.text(draw.AR_x*(left+right)/2, draw.AR_y*bottom, bottom_text, false, false, 0.5, 0.0)

  return left, top
end


local function read_screens()
  local screen_mode = u8(WRAM.screen_mode)
  local level_type = bit.test(screen_mode, 0) and "Vertical" or "Horizontal"
  
  local screens_number = u8(WRAM.screens_number)
  
  local hscreen_current = u8(WRAM.x + 1)
  local hscreen_number = u8(WRAM.hscreen_number) - (level_type == "Horizontal" and 1 or 0)
  
  local vscreen_current = u8(WRAM.y + 1)
  local vscreen_number = u8(WRAM.vscreen_number) - (level_type == "Vertical" and 1 or 0)

  return level_type, screens_number, hscreen_current, hscreen_number, vscreen_current, vscreen_number
end


local function get_map16_value(x_game, y_game)
  local num_x = floor(x_game/16)
  local num_y = floor(y_game/16)
  if num_x < 0 or num_y < 0 then return end  -- 1st breakpoint

  local level_type, screens, _, hscreen_number, _, vscreen_number = read_screens()
  local max_x, max_y
  if level_type == "Horizontal" then
    max_x = 16*(hscreen_number + 1)
    max_y = 27
  else
    max_x = 32
    max_y = 16*(vscreen_number + 1)
  end

  if num_x > max_x or num_y > max_y then return end  -- 2nd breakpoint

  local num_id, kind, address
  if level_type == "Horizontal" then
    num_id = 16*27*floor(num_x/16) + 16*num_y + num_x%16
  else
    local nx = floor(num_x/16)
    local ny = floor(num_y/16)
    local n = 2*ny + nx
    num_id = 16*16*n + 16*(num_y%16) + num_x%16
  end
  if (num_id >= 0 and num_id <= 0x37ff) then
    address = fmt(" $%4.x", 0xc800 + num_id)
    kind = 256*u8(0x1c800 + num_id) + u8(0xc800 + num_id)
  end

  if kind then return  num_x, num_y, kind, address end
end


local function draw_layer1_tiles(camera_x, camera_y)
  local x_origin, y_origin = screen_coordinates(0, 0, camera_x, camera_y)
  local x_mouse, y_mouse = game_coordinates(User_input.xmouse, User_input.ymouse, camera_x, camera_y)
  x_mouse = 16*floor(x_mouse/16)
  y_mouse = 16*floor(y_mouse/16)
  local push_direction = Real_frame%2 == 0 and 0 or 7  -- block pushes sprites to left or right?

  for number, positions in ipairs(Layer1_tiles) do
    -- Calculate the emu coordinates
    local left = positions[1] + x_origin
    local top = positions[2] + y_origin
    local right = left + 15
    local bottom = top + 15
    local x_game, y_game = game_coordinates(left, top, camera_x, camera_y)

    -- Returns if block is way too outside the screen
    if left > - draw.Border_left - 32 and top  > - draw.Border_top - 32 and
    right < draw.Screen_width  + draw.Border_right + 32 and bottom < draw.Screen_height + draw.Border_bottom + 32 then

      -- Drawings
      draw.Text_opacity = 0.6
      local num_x, num_y, kind, address = get_map16_value(x_game, y_game)
      if kind then
        if kind >= 0x111 and kind <= 0x16d or kind == 0x2b then
          -- default solid blocks, don't know how to include custom blocks
          draw.rectangle(left + push_direction, top, 8, 15, 0, COLOUR.block_bg)
        end
        draw.rectangle(left, top, 15, 15, kind == SMW.blank_tile_map16 and COLOUR.blank_tile or COLOUR.block, 0)

        if Layer1_tiles[number][3] then
          display_boundaries(x_game, y_game, 16, 16, camera_x, camera_y)  -- the text around it
        end

        -- Draw Map16 id
        if kind and x_mouse == positions[1] and y_mouse == positions[2] then
          draw.text(draw.AR_x*(left + 4), draw.AR_y*top - BIZHAWK_FONT_HEIGHT, fmt("Map16 (%02X, %02X), %X%s", num_x, num_y, kind, address), true, false, 0.5, 1.0)
        end
      end

    end

  end

end


local function draw_layer2_tiles()
  local layer2x = s16(WRAM.layer2_x_nextframe)
  local layer2y = s16(WRAM.layer2_y_nextframe)

  for number, positions in ipairs(Layer2_tiles) do
    draw.rectangle(-layer2x + positions[1], -layer2y + positions[2], 15, 15, COLOUR.layer2_line, COLOUR.layer2_bg)
  end
end


-- if the user clicks in a tile, it will be be drawn
-- if click is onto drawn region, it'll be erased
-- there's a max of possible tiles
-- layer_table[n] is an array {x, y, [draw info?]}
local function select_tile(x, y, layer_table)
  if not OPTIONS.draw_tiles_with_click then return end
  if Game_mode ~= SMW.game_mode_level then return end

  for number, positions in ipairs(layer_table) do  -- if mouse points a drawn tile, erase it
    if x == positions[1] and y == positions[2] then
      -- Layer 1
      if layer_table == Layer1_tiles then
        if layer_table[number][3] == false then
          layer_table[number][3] = true
        else
          table.remove(layer_table, number)
        end
      -- Layer 2
      elseif layer_table == Layer2_tiles then
        table.remove(layer_table, number)
      end

      return
    end
  end

  -- otherwise, draw a new tile
  if #layer_table == OPTIONS.max_tiles_drawn then
    table.remove(layer_table, 1)
    layer_table[OPTIONS.max_tiles_drawn] = {x, y, false}
  else
    table.insert(layer_table, {x, y, false})
  end

end


-- uses the mouse to select an object
local function select_object(mouse_x, mouse_y, camera_x, camera_y)
  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 0.5

  local x_game, y_game = game_coordinates(mouse_x, mouse_y, camera_x, camera_y)
  local obj_id

  -- Checks if the mouse is over Mario
  local x_player = s16(WRAM.x)
  local y_player = s16(WRAM.y)
  if x_player + 0xe >= x_game and x_player + 0x2 <= x_game and y_player + 0x30 >= y_game and y_player + 0x8 <= y_game then
    obj_id = "Mario"
  end

  if not obj_id and OPTIONS.display_sprite_info then
    for id = 0, SMW.sprite_max - 1 do -- sprite_max = 12
      local sprite_status = u8(WRAM.sprite_status + id)
      if sprite_status ~= 0 and Sprites_info[id].x then  -- TODO: see why the script gets here without exporting Sprites_info
        -- Import some values
        local x_sprite, y_sprite = Sprites_info[id].x, Sprites_info[id].y
        local x_screen, y_screen = Sprites_info[id].x_screen, Sprites_info[id].y_screen
        local boxid = Sprites_info[id].hitbox_id
        local xoff, yoff = Sprites_info[id].hitbox_xoff, Sprites_info[id].hitbox_yoff
        local width, height = Sprites_info[id].hitbox_width, Sprites_info[id].hitbox_height

        if x_sprite + xoff + width >= x_game and x_sprite + xoff <= x_game and
        y_sprite + yoff + height >= y_game and y_sprite + yoff <= y_game then
          obj_id = id
          break
        end
      end
    end
  end

  if not obj_id then return end

  draw.text(draw.AR_x*User_input.xmouse, draw.AR_y*(User_input.ymouse - 8), obj_id, true, false, 0.5, 1.0)
  return obj_id, x_game, y_game
end


-- This function sees if the mouse if over some object, to change its hitbox mode
-- The order is: 1) player, 2) sprite.
local function right_click()
  local id = select_object(User_input.xmouse, User_input.ymouse, Camera_x, Camera_y)

  if tostring(id) == "Mario" then

    if OPTIONS.display_player_hitbox and OPTIONS.display_player_block_interaction then
      OPTIONS.display_player_block_interaction = false
      OPTIONS.display_player_hitbox = false
    elseif OPTIONS.display_player_hitbox then
      OPTIONS.display_player_block_interaction = true
      OPTIONS.display_player_hitbox = false
    elseif OPTIONS.display_player_block_interaction then
      OPTIONS.display_player_hitbox = true
    else
      OPTIONS.display_player_hitbox = true
    end

    return
  end

  local spr_id = tonumber(id)
  if spr_id and spr_id >= 0 and spr_id <= SMW.sprite_max - 1 then -- sprite_max = 12

    local number = Sprites_info[spr_id].number
    if Sprite_hitbox[spr_id][number].sprite and Sprite_hitbox[spr_id][number].block then
      Sprite_hitbox[spr_id][number].sprite = false
      Sprite_hitbox[spr_id][number].block = false
    elseif Sprite_hitbox[spr_id][number].sprite then
      Sprite_hitbox[spr_id][number].block = true
      Sprite_hitbox[spr_id][number].sprite = false
    elseif Sprite_hitbox[spr_id][number].block then
      Sprite_hitbox[spr_id][number].sprite = true
    else
      Sprite_hitbox[spr_id][number].sprite = true
    end

    return
  end

  -- Select layer 2 tiles
  local layer2x = s16(WRAM.layer2_x_nextframe)
  local layer2y = s16(WRAM.layer2_y_nextframe)
  local x_mouse, y_mouse = User_input.xmouse + layer2x, User_input.ymouse + layer2y
  select_tile(16*floor(x_mouse/16), 16*floor(y_mouse/16), Layer2_tiles)
end


-- Function to predict the next RNG values
function RNG.predict(seed1, seed2, rng1, rng2)
  local Y = 1
  local A, carry_flag

  local function tick_RNG()
    A = (4*seed1) % 0x100

    carry_flag = true
    A = (A + seed1 + 1)
    if A < 0x100 then carry_flag = false
    else A = A % 0x100; carry_flag = true end

    seed1 = A

    seed2 = 2*seed2
    if seed2 < 0x100 then carry_flag = false
    else seed2 = seed2 % 0x100; carry_flag = true end

    A = 0x20
    local tmp = bit.band(A, seed2)

    -- simplified branches
    if (carry_flag and tmp ~= 0) or (not carry_flag and tmp == 0) then
      seed2 = (seed2 + 1) % 0x100
    end
    A = seed2
    A = bit.bxor(A, seed1)

    -- set RNG byte
    if Y == 0 then
      rng1 = A
    else
      rng2 = A
    end
  end

  tick_RNG()
  Y = Y - 1
  tick_RNG()

  return seed1, seed2, rng1, rng2
end

-- Generate a list of all RNG states from the initial state until it loops
function RNG.create_lists()
  local seed1, seed2, rng1, rng2 = 0, 0, 0, 0
  local counter = 1
  while true do
    local RNG_index = seed1 + 0x100*seed2 + 0x10000*rng1 + 0x1000000*rng2
    if RNG.possible_values[RNG_index] then
      break
    end
    RNG.possible_values[RNG_index] = counter
    RNG.reverse_possible_values[counter] = RNG_index

    counter = counter + 1
    seed1, seed2, rng1, rng2 = RNG.predict(seed1, seed2, rng1, rng2)
  end
end

-- Get the master cycles for the Lagmeter
Lagmeter.master_cycles = 0
function Lagmeter.get_master_cycles()
  local v, h = emu.getregister("V"), emu.getregister("H")
  local master_cycles = v + 262 - 225

  Lagmeter.master_cycles = 1364*master_cycles + h
  if v >= 226 or (v == 225 and h >= 12) then
    Lagmeter.master_cycles = Lagmeter.master_cycles - 2620
    --print("Lagmeter (V, H):", v, h)
  end
  if v >= 248 then
    Lagmeter.master_cycles = Lagmeter.master_cycles - 262*1364
  end
end


local function show_movie_info()
  if not OPTIONS.display_movie_info then return end

  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0
  local y_text = - draw.Border_top
  local x_text = 0
  local width = BIZHAWK_FONT_WIDTH

  local rec_color = (Readonly or not Movie_active) and COLOUR.text or COLOUR.warning
  local recording_bg = (Readonly or not Movie_active) and COLOUR.background or COLOUR.warning_bg

  -- Read-only or read-write?
  local movie_type = (not Movie_active and "No movie ") or (Readonly and "Movie " or "REC")
  draw.alert_text(x_text, y_text, movie_type, rec_color, recording_bg)

  -- Frame count
  x_text = x_text + width*(string.len(movie_type) + 1)
  local movie_info
  if Movie_active and Readonly then
    movie_info = string.format("%d/%d", Lastframe_emulated, Framecount)
  else
    movie_info = string.format("%d", Lastframe_emulated)
  end
  draw.text(x_text, y_text, movie_info)  -- Shows the latest frame emulated, not the frame being run now

  if Movie_active then
    -- Rerecord count
    x_text = x_text + width*string.len(movie_info)
    local rr_info = string.format(" %d ", Rerecords)
    draw.text(x_text, y_text, rr_info, COLOUR.weak)

    -- Lag count
    x_text = x_text + width*string.len(rr_info)
    draw.text(x_text, y_text, Lagcount, COLOUR.warning)
  end

  -- Time
  local str = frame_time(Lastframe_emulated)   -- Shows the latest frame emulated, not the frame being run now
  draw.alert_text(draw.Buffer_width + draw.Border_right, draw.Buffer_height + draw.Border_bottom, str, COLOUR.text, recording_bg, false, 1.0, 1.0) 
end


local function show_game_info()
  if not OPTIONS.display_game_info then return end

  -- Font
  draw.Text_opacity = 0.8
  draw.Bg_opacity = 1.0

  -- Display
  local RNG = u16(WRAM.RNG)
  local main_info = string.format("Frame(%02X, %02X) RNG(%04X) Mode(%02X)",
                      Real_frame, Effective_frame, RNG, Game_mode)
  ;
  draw.text(draw.Buffer_width + draw.Border_right, -draw.Border_top, main_info, true, false)

  if Game_mode == SMW.game_mode_level then
    local x_cam_txt = draw.text(draw.Buffer_middle_x*draw.AR_x, 0, fmt("Camera (%04X, %04X)", Camera_x, Camera_y), COLOUR.text, true, false, 0.5)
    
    local vertical_scroll_flag_header = u8(WRAM.vertical_scroll_flag_header)
    local vertical_scroll_enabled = u8(WRAM.vertical_scroll_enabled)
    if vertical_scroll_flag_header ~=0 and vertical_scroll_enabled ~= 0 then
      draw.text(x_cam_txt + BIZHAWK_FONT_WIDTH, 0, vertical_scroll_enabled, COLOUR.warning2)
    end  
  
    -- Time frame counter of the clock
    draw.Text_opacity = 1.0
    local timer_frame_counter = u8(WRAM.timer_frame_counter)
    draw.text(draw.AR_x*161, draw.AR_y*15, fmt("%.2d", timer_frame_counter))

    -- Score: sum of digits, useful for avoiding lag
    draw.Text_opacity = 0.5
    local score = u24(WRAM.mario_score)
    draw.text(draw.AR_x*240, draw.AR_y*24, fmt("=%d", luap.sum_digits(score)), COLOUR.weak)
  end
end


-- diplay nearby RNG states: past, present a future values
function display_RNG()
  if not OPTIONS.display_RNG_info then
    if next(RNG.possible_values) ~= nil then
      RNG.possible_values = {}
      RNG.reverse_possible_values = {}
      collectgarbage()
    end

    return
  end

  -- create RNG lists if they are empty
  if next(RNG.possible_values) == nil then RNG.create_lists() end

  -- Font
  draw.Text_opacity = 0.8
  local x = -draw.Border_left
  local y = draw.Screen_height - draw.Border_top - 19*BIZHAWK_FONT_HEIGHT
  local height = BIZHAWK_FONT_HEIGHT
  local upper_rows = 8

  local index = u32(WRAM.RNG_input)
  local RNG_counter = RNG.possible_values[index]
  
  if RNG_counter then
    local min = math.max(RNG_counter - upper_rows, 1)
    local max = math.min(min + 2*upper_rows, 27777) -- todo: hardcoded constants are never a good idea
    
    draw.text(x, y - BIZHAWK_FONT_HEIGHT, "RNG:", COLOUR.text)
    for i = min, max do
      local seed1, seed2 = bit.band(RNG.reverse_possible_values[i], 0xff), bit.band(RNG.reverse_possible_values[i], 0xff00)/0x100
      local rng1, rng2 = bit.band(RNG.reverse_possible_values[i], 0xff0000)/0x10000, bit.band(RNG.reverse_possible_values[i], 0xff000000)/0x1000000  --bit.bfields(RNG.reverse_possible_values[i], 8, 8, 8, 8)
      local info = fmt("%02d: %.2X, %.2X, %.2X, %.2X\n", i, seed1, seed2, rng1, rng2)
      draw.text(x, y, info, i ~= RNG_counter and COLOUR.text or COLOUR.warning)
      y = y + height
    end
  else
    draw.text(x, y, "Glitched RNG! Report state/movie", "red")
  end
end


-- Display mouse coordinates right above it
local function show_mouse_info()
	if not OPTIONS.display_mouse_coordinates then return end
	
	-- Font
  draw.Text_opacity = 1.0
	local line_colour = COLOUR.weak
  local bg_colour = change_transparency(COLOUR.background, draw.Bg_opacity)
  
	local x, y = User_input.xmouse + OPTIONS.left_gap, User_input.ymouse + OPTIONS.top_gap
  local camera_x = Game_mode == SMW.game_mode_level and Camera_x or s16(WRAM.layer1_x_mirror)
  local camera_y = Game_mode == SMW.game_mode_level and Camera_y or s16(WRAM.layer1_y_mirror)
	local x_game, y_game = game_coordinates(User_input.xmouse, User_input.ymouse, camera_x, camera_y)
	if x_game < 0 then x_game = 0x10000 + x_game end
	if y_game < 0 then y_game = 0x10000 + y_game end
  
	if User_input.mouse_inwindow then
		-- Lines
    draw.line(0 - OPTIONS.left_gap, y - OPTIONS.top_gap, draw.Screen_width, y - OPTIONS.top_gap, line_colour)
    draw.line(x - OPTIONS.left_gap, 0 - OPTIONS.top_gap, x - OPTIONS.left_gap, draw.Screen_height, line_colour)
    draw.cross(x, y, 3, COLOUR.warning)
    -- Coordinates
    draw.text((x - OPTIONS.left_gap)*draw.AR_x, (y - OPTIONS.top_gap - 2*9)*draw.AR_y, fmt("emu (%d, %d)", x, y), COLOUR.text, bg_colour, true, false, 0.5)
		draw.text((x - OPTIONS.left_gap)*draw.AR_x, (y - OPTIONS.top_gap + 9)*draw.AR_y, fmt("game ($%04X, $%04X)", x_game, y_game), COLOUR.text, bg_colour, true, false, 0.5)
	end
end


-- Shows the controller input as the RAM and SNES registers store it
local function show_controller_data()
  if not OPTIONS.display_controller_data then return end

  -- Font
  draw.Text_opacity = 0.9
  local height = BIZHAWK_FONT_HEIGHT
  local x_pos, y_pos, x, y, _ = -draw.Border_left, 0, 0, BIZHAWK_FONT_HEIGHT

  x = draw.over_text(x_pos, y_pos, 256*u8(WRAM.ctrl_1_1) + u8(WRAM.ctrl_1_2), "BYsS^v<>AXLR0123", COLOUR.weak)
  _, y = draw.text(x, y_pos, " (RAM data)", COLOUR.weak)

  x = x_pos
  draw.over_text(x, y, 256*u8(WRAM.firstctrl_1_1) + u8(WRAM.firstctrl_1_2), "BYsS^v<>AXLR0123", 0, COLOUR.warning, 0)
end


-- Display Lagmeter
function Lagmeter.show_lagmeter()
  if OPTIONS.display_lagmeter then
    
    -- Failsafe to prevent event.onmemoryexecute on other SNES cores, since it's not yet implemented by the emu
    if biz.snes_core ~= "bsnes" then
      draw.text(draw.Buffer_middle_x*draw.AR_x, -OPTIONS.top_gap, fmt("Lagmeter feature only works on bsnes core, please change first!"), COLOUR.warning, 0, false, false, 0.5)
      return
    end
  
    event.unregisterbyname("Lagmeter.getmastercycles00") -- \ since this runs every frame if toggled, it will avoid having more than one registered event for this
    event.unregisterbyname("Lagmeter.getmastercycles80") -- / 
    event.onmemoryexecute(Lagmeter.get_master_cycles, 0x008075, "Lagmeter.getmastercycles00") -- 0x008075 is the IRQ/NMI wait for the original game
    event.onmemoryexecute(Lagmeter.get_master_cycles, 0x808075, "Lagmeter.getmastercycles80") -- 0x808075 is the IRQ/NMI wait for some hacks (including SA-1 apparently)
  else
    event.unregisterbyname("Lagmeter.getmastercycles00") -- \ to eliminate the event callbacks saving FPS
    event.unregisterbyname("Lagmeter.getmastercycles80") -- / 
    return
  end
  
  -- Font
  draw.Text_opacity = 0.9
  local x_pos, y_pos = draw.Buffer_middle_x*draw.AR_x + 40, -draw.Border_top
  
  -- Adjust display colour based on value
  local meter, colour = Lagmeter.master_cycles/3573.68
  if meter < 70 then colour = 0xff00FF00
  elseif meter < 90 then colour = 0xffFFFF00
  elseif meter <= 100 then colour = 0xffFF0000
  else colour = 0xffFF00FF end

  draw.text(x_pos, y_pos, fmt("Lagmeter: %.2f%%", meter), colour)
end


-- Display the sprite level info (data and load status)
local function sprite_level_info()
  if not OPTIONS.display_sprite_data and not OPTIONS.display_sprite_load_status then return end
  
  draw.Text_opacity = 0.5

  -- Sprite load status enviroment
  local indexes = {}
  for id = 0, 11 do
    local sprite_status = u8(WRAM.sprite_status + id)

    if sprite_status ~= 0 then
      local index = u8(WRAM.sprite_index_to_level + id)
      indexes[index] = true
    end
  end
  local status_table = mainmemory.readbyterange(WRAM.sprite_load_status_table, 0x80)

  local x_origin = 0
  local y_origin = OPTIONS.top_gap + draw.Buffer_height - 4*11
  local x, y = x_origin, y_origin
  local w, h = 9, 11

  -- Sprite data enviroment
  local pointer = Sprite_data_pointer
  
  -- Convert pointer from SNES address to PC address (to use "CARTROM" instead of "System Bus") -- TODO: maybe make a function for this, if this conversion become necessary in other instances
  local pointer_pc, pointer_pc_bank, pointer_pc_addr
  pointer_pc_bank = floor(pointer/0x20000)
  pointer_pc_addr = bit.band(pointer, 0xFFFF) - 0x8000*(floor(pointer/0x10000)+1)%2
  pointer_pc = pointer_pc_bank*0x10000 + pointer_pc_addr  
  
  -- Level scan
  local is_vertical = read_screens() == "Vertical"

  local sprite_counter = 0
  for id = 0, 0x80 - 1 do
    -- Sprite data
    local byte_1 = memory.readbyte(pointer_pc + 1 + id*3, "CARTROM")
    if byte_1==0xff then break end -- end of sprite data for this level
    local byte_2 = memory.readbyte(pointer_pc + 2 + id*3, "CARTROM")
    local byte_3 = memory.readbyte(pointer_pc + 3 + id*3, "CARTROM")

    local sxpos, sypos
    if is_vertical then -- vertical
      sxpos = bit.band(byte_1, 0xf0) + 256*bit.band(byte_1, 0x0d)
      sypos = bit.band(byte_2, 0xf0) + 256*(bit.band(byte_2, 0x0f) + 8*bit.band(byte_1, 0x02))
    else -- horizontal
      sxpos = bit.band(byte_2, 0xf0) + 256*(bit.band(byte_2, 0x0f) + 8*bit.band(byte_1, 0x02))
      sypos = bit.band(byte_1, 0xf0) + 256*bit.band(byte_1, 0x0d)
    end

    local status = status_table[id]
    local color = (status == 0 and COLOUR.disabled) or (status == 1 and COLOUR.text) or 0xffFFFF00
    if status ~= 0 and not indexes[id] then color = COLOUR.warning end

    if OPTIONS.display_sprite_data then
      if sxpos - Camera_x + 16 > -OPTIONS.left_gap and sxpos - Camera_x - 16 < 256 + OPTIONS.right_gap and -- to avoid printing the whole level data
         sypos - Camera_y + 16 > -OPTIONS.top_gap and sypos - Camera_y - 16 < 224 + OPTIONS.bottom_gap then

        draw.text((sxpos - Camera_x + 8)*draw.AR_x, (sypos - Camera_y - 2)*draw.AR_y - BIZHAWK_FONT_HEIGHT, fmt("%02X", id), color, false, false, 0.5)
        if color ~= COLOUR.text then -- don't display sprite ID if sprite is spawned
          draw.text((sxpos - Camera_x + 8)*draw.AR_x, (sypos - Camera_y + 4)*draw.AR_y, fmt("%02X", byte_3), color, false, false, 0.5)
        end

        draw.rectangle(sxpos - Camera_x, sypos - Camera_y, 15, 15, color)
        draw.cross(sxpos - Camera_x + OPTIONS.left_gap, sypos - Camera_y + OPTIONS.top_gap, 3, COLOUR.yoshi)
      end
    end

    -- Sprite load status
    if OPTIONS.display_sprite_load_status then
      gui.drawRectangle(x, y, w-1, h-1, color, 0x80000000)
      gui.pixelText(x+2, y+2, fmt("%X ", status), color, 0)
      x = x + w
      if id%16 == 15 then
        x = x_origin
        y = y + h
      end
    end

    sprite_counter = sprite_counter + 1
  end

  draw.Text_opacity = 0.6
  if OPTIONS.display_sprite_load_status then
    draw.text(-draw.Border_left + 1, (y_origin-OPTIONS.top_gap-10)*draw.AR_y, "Sprite load status", COLOUR.text)
    if sprite_counter == 0 then draw.text(-draw.Border_left - 1, (y-OPTIONS.top_gap)*draw.AR_y, fmt("(no sprites)", sprite_counter), COLOUR.text) end
  end
end


-- Creates lines showing where the real pit of death for sprites and Mario is, and lines showing the sprite spawning areas
local function draw_boundaries()
  if not OPTIONS.display_level_boundary then return end
  
  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0

  local is_vertical = read_screens() == "Vertical"

  -- Player borders
  local xmin = 8 - 1
  local ymin = -0x80 - 1
  local xmax = 0xe8 + 1
  local ymax = 0xfb  -- no increment, because this line kills by touch

  local no_powerup = (Player_powerup == 0)
  if no_powerup then ymax = ymax + 1 end
  if not Yoshi_riding_flag then ymax = ymax + 5 end

  draw.box(xmin, ymin, xmax, ymax, COLOUR.warning2, 2)
  if draw.Border_bottom >= 64 then
    local str = string.format("Death: %04X (%s/%s)", ymax + Camera_y, no_powerup and "No powerup" or "Big", Yoshi_riding_flag and "Yoshi" or "No Yoshi")
    draw.text(xmin + 4, draw.AR_y*ymax + 2, str, COLOUR.warning2, true)
  end
end


-- Display several level infos
local function level_info()
  if not OPTIONS.display_level_info then return end
  
  -- Font
  local x_pos = draw.Buffer_width + draw.Border_right
  local y_pos = - draw.Border_top + BIZHAWK_FONT_HEIGHT + 2
  draw.Text_opacity = 0.8
  draw.Bg_opacity = 1.0
  
  -- Scan level size
  local level_type, screens_number, hscreen_current, hscreen_number, vscreen_current, vscreen_number = read_screens()
  
  -- Level main info
  if OPTIONS.display_level_main_info then
    -- Level indexes and type
    draw.text(x_pos, y_pos, fmt("Translevel(%03X) Level(%03X) %.1s", LM_translevel_number, Level_index, level_type), COLOUR.text, true)
    y_pos = y_pos + BIZHAWK_FONT_HEIGHT
    
    -- Number of screens within the level
    draw.text(x_pos, y_pos, fmt("Screens(%02X/%02X, %02X/%02X)", hscreen_current, hscreen_number, vscreen_current, vscreen_number), true)
    y_pos = y_pos + BIZHAWK_FONT_HEIGHT
    
    -- Sprite buoyancy
    local sprite_buoyancy = u8(WRAM.sprite_buoyancy)
    if sprite_buoyancy ~= 0 then
      -- $7E190E has format "XY-- ----", with X = Enable sprite buoyancy and Y = Enable sprite buoyancy and disable sprite interaction with layer 2
      local layer2_disabled = bit.test(sprite_buoyancy, 6) and " (Layer 2 disabled)" or ""
      draw.text(x_pos, y_pos, fmt("Has buoyancy%s", layer2_disabled), COLOUR.warning, true)
      y_pos = y_pos + BIZHAWK_FONT_HEIGHT
    end
  end
  
  -- Player boundaries
  draw_boundaries()

  -- Sprite data and load status
  sprite_level_info()
  
  -- Screen info
  if OPTIONS.display_screen_info then
    draw.Text_opacity = 0.8
    
    local screen_x, screen_y
    local x_origin, y_origin = screen_coordinates(0, 0, Camera_x, Camera_y)
    local screen_str
    
    for screen_region_x = 0, hscreen_number do
      for screen_region_y = 0, vscreen_number do
        screen_x = x_origin + 256*screen_region_x
        screen_y = y_origin + 256*screen_region_y
        
        draw.rectangle(screen_x, screen_y, 255, 255, COLOUR.screen_borders, 0)
        
        if level_type == "Horizontal" then
          screen_str = fmt("%02X (%s)", screen_region_x, screen_region_y == 0 and "top" or "bottom")
        elseif level_type == "Vertical" then
          screen_str = fmt("%02X (%s)", screen_region_y, screen_region_x == 0 and "left" or "right")
        end
        draw.rectangle(screen_x + 1, screen_y + 1, (string.len(screen_str)*BIZHAWK_FONT_WIDTH)/draw.AR_x, (BIZHAWK_FONT_HEIGHT + 4)/draw.AR_y, COLOUR.screen_borders, COLOUR.screen_borders)
        draw.text((screen_x + 1)*draw.AR_x, (screen_y + 1)*draw.AR_y, screen_str, COLOUR.text, COLOUR.screen_borders)
      end
    end
  end
  
end


-- Draw player blocked status
function draw_blocked_status(x_text, y_text, player_blocked_status, x_speed, y_speed)
  local block_width  = 9 -- BizHawk
  local block_height = 9 -- BizHawk
  local block_str = "Blocked:"
  local str_len = string.len(block_str)
  local xoffset = (x_text + str_len*BIZHAWK_FONT_WIDTH)/draw.AR_x
  local yoffset = y_text/draw.AR_y
  local color_line = COLOUR.warning

  gui.drawRectangle(xoffset + draw.Left_gap, yoffset + draw.Top_gap, block_width - 1, block_height - 1, 0x40000000, 0x40ff0000)

  local was_boosted = false

  if bit.test(player_blocked_status, 0) then  -- Right
    draw.line(xoffset + block_width - 1, yoffset, xoffset + block_width - 1, yoffset + block_height - 1, color_line)
    if x_speed < 0 then was_boosted = true end
  end

  if bit.test(player_blocked_status, 1) then  -- Left
    draw.line(xoffset, yoffset, xoffset, yoffset + block_height - 1, color_line)
    if x_speed > 0 then was_boosted = true end
  end

  if bit.test(player_blocked_status, 2) then  -- Down
    draw.line(xoffset, yoffset + block_height - 1, xoffset + block_width - 1, yoffset + block_height - 1, color_line)
  end

  if bit.test(player_blocked_status, 3) then  -- Up
    draw.line(xoffset, yoffset, xoffset + block_width - 1, yoffset, color_line)
    if y_speed > 6 then was_boosted = true end
  end

  if bit.test(player_blocked_status, 4) then  -- Middle
    draw.cross(xoffset + floor(block_width/2) + draw.Left_gap, yoffset + floor(block_height/2) + draw.Top_gap,
    math.min(block_width/3, block_height/3), color_line)
  end

  draw.text(x_text, y_text, block_str, COLOUR.text, was_boosted and COLOUR.warning_bg or nil)

end


-- displays player's hitbox
local function player_hitbox(x, y, is_ducking, powerup, transparency_level)
  local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)
  local is_small = is_ducking ~= 0 or powerup == 0
  local hitbox_type = 2*(Yoshi_riding_flag and 1 or 0) + (is_small and 0 or 1) + 1

  -- Colors BizHawk
  local is_transparent = transparency_level == 1
  local interaction_bg = is_transparent and COLOUR.interaction_bg or 0
  local mario_bg = is_transparent and COLOUR.mario_bg or 0
  local mario_mounted_bg = is_transparent and COLOUR.mario_mounted_bg or 0
  local mario = is_transparent and COLOUR.mario or draw.change_transparency(COLOUR.mario, transparency_level)
  local interaction_nohitbox = is_transparent and COLOUR.interaction_nohitbox or draw.change_transparency(COLOUR.interaction_nohitbox, transparency_level)
  local interaction_nohitbox_bg = is_transparent and COLOUR.interaction_nohitbox_bg or 0
  local interaction = is_transparent and COLOUR.interaction or draw.change_transparency(COLOUR.interaction, transparency_level)

  -- Interaction points, offsets and dimensions
  local y_points_offsets = SMW.y_interaction_points[hitbox_type]
  local left_side = SMW.x_interaction_points.left_side
  local right_side = SMW.x_interaction_points.right_side
  local left_foot = SMW.x_interaction_points.left_foot
  local right_foot = SMW.x_interaction_points.right_foot
  local x_center = SMW.x_interaction_points.center
  local head = y_points_offsets.head
  local foot = y_points_offsets.foot
  local y_center = y_points_offsets.center
  local shoulder = y_points_offsets.shoulder
  local side =  y_points_offsets.side

  local hitbox_offsets = SMW.player_hitbox[hitbox_type]
  local xoff = hitbox_offsets.xoff
  local yoff = hitbox_offsets.yoff
  local width = hitbox_offsets.width
  local height = hitbox_offsets.height

  -- background for block interaction
  draw.box(x_screen + left_side, y_screen + head, x_screen + right_side, y_screen + foot,
      interaction_bg, interaction_bg)

    -- Collision with sprites
  if OPTIONS.display_player_hitbox then
    local mario_bg = (not Yoshi_riding_flag and mario_bg) or mario_mounted_bg
    draw.rectangle(x_screen + xoff, y_screen + yoff, width, height, mario, mario_bg)
  end

  -- interaction points (collision with blocks)
  if OPTIONS.display_player_block_interaction then

    if not OPTIONS.display_player_hitbox then
      draw.box(x_screen + left_side , y_screen + head,
           x_screen + right_side, y_screen + foot, interaction_nohitbox, interaction_nohitbox_bg)
    end

    draw.line(x_screen + left_side, y_screen + side, x_screen + left_foot, y_screen + side, interaction)  -- left side
    draw.line(x_screen + right_side, y_screen + side, x_screen + right_foot, y_screen + side, interaction)  -- right side
    draw.line(x_screen + left_foot, y_screen + foot - 2, x_screen + left_foot, y_screen + foot, interaction)  -- left foot bottom
    draw.line(x_screen + right_foot, y_screen + foot - 2, x_screen + right_foot, y_screen + foot, interaction)  -- right foot bottom
    draw.line(x_screen + left_side, y_screen + shoulder, x_screen + left_side + 2, y_screen + shoulder, interaction)  -- head left point
    draw.line(x_screen + right_side - 2, y_screen + shoulder, x_screen + right_side, y_screen + shoulder, interaction)  -- head right point
    draw.line(x_screen + x_center, y_screen + head, x_screen + x_center, y_screen + head + 2, interaction)  -- head point
    draw.line(x_screen + x_center - 1, y_screen + y_center, x_screen + x_center + 1, y_screen + y_center, interaction)  -- center point
    draw.line(x_screen + x_center, y_screen + y_center - 1, x_screen + x_center, y_screen + y_center + 1, interaction)  -- center point
  end

  -- That's the pixel that appears when Mario dies in the pit
  Display.show_player_point_position = Display.show_player_point_position or Display.is_player_near_borders or OPTIONS.display_debug_player_extra
  if Display.show_player_point_position then
    draw.pixel(x_screen, y_screen, COLOUR.text, COLOUR.interaction_bg)
    Display.show_player_point_position = false
  end

  return x_points, y_points
end


-- displays the hitbox of the cape while spinning
local function cape_hitbox(spin_direction)
  local cape_interaction = u8(WRAM.cape_interaction)
  if cape_interaction == 0 then return end

  local cape_x = u16(WRAM.cape_x)
  local cape_y = u16(WRAM.cape_y)

  local cape_x_screen, cape_y_screen = screen_coordinates(cape_x, cape_y, Camera_x, Camera_y)
  local cape_left = -2
  local cape_right = 0x12
  local cape_up = 0x01
  local cape_down = 0x11
  local cape_middle = 0x08
  local block_interaction_cape = (spin_direction < 0 and cape_left + 4) or cape_right - 4
  local active_frame_sprites = Real_frame%2 == 1  -- active iff the cape can hit a sprite
  local active_frame_blocks  = Real_frame%2 == (spin_direction < 0 and 0 or 1)  -- active iff the cape can hit a block

  if active_frame_sprites then bg_color = COLOUR.cape_bg else bg_color = 0 end
  draw.box(cape_x_screen + cape_left, cape_y_screen + cape_up, cape_x_screen + cape_right, cape_y_screen + cape_down, COLOUR.cape, bg_color)

  if active_frame_blocks then
    draw.pixel(cape_x_screen + block_interaction_cape, cape_y_screen + cape_middle, COLOUR.warning)
  else
    draw.pixel(cape_x_screen + block_interaction_cape, cape_y_screen + cape_middle, COLOUR.text)
  end
end


-- arguments: left and bottom pixels of a given block tile
-- return: string type of duplication that will happen
--         false otherwise
local function sprite_block_interaction_simulator(x_block_left, y_block_bottom)
  --local GOOD_SPEEDS = luap.make_set{-2.5, -2, -1.5, -1, 0, 0.5, 1.0, 1.5, 2.5, 3.0, 3.5, 4.0}

  -- get 1st carried sprite slot
  local slot
  for id = 0, SMW.sprite_max - 1 do -- sprite_max = 12
    if u8(WRAM.sprite_status + id) == 0x0b then
      slot = id
      break
    end
  end
  if not slot then return false end

  -- sprite properties
  local ini_x = luap.signed16(256*u8(WRAM.sprite_x_high + slot) + u8(WRAM.sprite_x_low + slot))
  local ini_y = luap.signed16(256*u8(WRAM.sprite_y_high + slot) + u8(WRAM.sprite_y_low + slot))
  local ini_y_sub = u8(WRAM.sprite_y_sub + slot)

  -- Sprite clipping vs objects
  local clip_obj = bit.band(u8(WRAM.sprite_1_tweaker + slot), 0xf)
  local ypt_right = SMW.obj_clipping_sprite[clip_obj].yright
  local ypt_left = SMW.obj_clipping_sprite[clip_obj].yleft
  local xpt_up = SMW.obj_clipping_sprite[clip_obj].xup
  local ypt_up = SMW.obj_clipping_sprite[clip_obj].yup

  -- Parameters that will vary each frame
  local left_direction = Real_frame%2 == 0
  local y_speed = -112
  local y = ini_y
  local x_head = ini_x + xpt_up
  local y_sub = ini_y_sub

  --print(fmt("Block: %d %d - Spr. ^%d <%d >%d", x_block_left, y_block_bottom, ypt_up, ypt_left, ypt_right))
  -- Predict each frame:
  while y_speed < 0 do
    -- Calculate next position.subpixel
    --print(fmt("prediction: (%d, %d.%.2x) %+d %s", x_head, y + ypt_up, y_sub, y_speed, left_direction and "left" or "right"))
    local next_total_subpixels = 256*y + y_sub + 16*y_speed
    y, y_sub = floor(next_total_subpixels/256), next_total_subpixels%256

    -- verify whether the block will be duplicated:
    -- if head is on block
    if y + ypt_up <= y_block_bottom and y + ypt_up >= y_block_bottom - 15 then
      -- lateral duplication
      -- if head is in the left-most 4 pixels
      if left_direction and x_block_left <= x_head and x_head - 4 < x_block_left then
        if y + ypt_left <= y_block_bottom then
          return "Left"
        end
      -- if head is in the right-most 4 pixels
      elseif not left_direction and x_head <= x_block_left + 15 and x_head + 4 > x_block_left + 15 then
        if y + ypt_right <= y_block_bottom then
          return "Right"
        end
      end

      -- Upward duplication
      if y + ypt_up <= y_block_bottom - 14 then  -- 2 pixels height
        return "Upward"
      end

      return false
    end

    -- Set next step
    y_speed = y_speed + 3
    left_direction = not left_direction
  end

  return false
end


-- verify nearby layer 1 tiles that are drawn
-- check whether they would allow a block duplication under ideal conditions
local function predict_block_duplications()
  if not OPTIONS.use_block_duplication_predictor then return end
  local delta_x, delta_y = 48, 128

  for number, positions in ipairs(Layer1_tiles) do
    if luap.inside_rectangle(positions[1], positions[2], Player_x - delta_x, Player_y - delta_y, Player_x + delta_x, Player_y + delta_y) then
      local dup_status = sprite_block_interaction_simulator(positions[1], positions[2] + 15)

      if dup_status then
        -- TODO: BizHawk stacks the messages. Fix it
        --local x, y = floor(positions[1]/16), floor(positions[2]/16)
        -- gui.addmessage(fmt("Duplication prediction: %d, %d", x, y))

        local xs, ys = screen_coordinates(positions[1] + 7, positions[2], Camera_x, Camera_y)
        draw.text(draw.AR_x*xs, draw.AR_y*ys - 4, fmt("%s duplication", dup_status),
          COLOUR.warning, COLOUR.warning_bg, true, false, 0.5, 1.0)
        break
      end

    end
  end
end


local function player()
  if not OPTIONS.display_player_info then
    return
  end

  -- Font
  draw.Text_opacity = 1.0

  -- Reads WRAM
  local x = s16(WRAM.x)
  local y = s16(WRAM.y)
  local previous_x = u16(WRAM.previous_x)
  local previous_y = u16(WRAM.previous_y)
  local x_sub = u8(WRAM.x_sub)
  local y_sub = u8(WRAM.y_sub)
  local x_speed = s8(WRAM.x_speed)
  local x_speed_u = u8(WRAM.x_speed) -- used to print a proper hex value
  local x_subspeed = u8(WRAM.x_subspeed)
  local y_speed = s8(WRAM.y_speed)
  local y_speed_u = u8(WRAM.y_speed) -- used to print a proper hex value
  local p_meter = u8(WRAM.p_meter)
  local take_off = u8(WRAM.take_off)
  local powerup = Player_powerup
  local direction = u8(WRAM.direction)
  local cape_spin = u8(WRAM.cape_spin)
  local cape_fall = u8(WRAM.cape_fall)
  local flight_animation = u8(WRAM.flight_animation)
  local diving_status = s8(WRAM.diving_status)
  local player_blocked_status = u8(WRAM.player_blocked_status)
  local item_box = u8(WRAM.item_box)
  local is_ducking = u8(WRAM.is_ducking)
  local on_ground = u8(WRAM.on_ground)
  local on_water = u8(WRAM.on_water)
  local spinjump_flag = u8(WRAM.spinjump_flag)
  local can_jump_from_water = u8(WRAM.can_jump_from_water)
  local carrying_item = u8(WRAM.carrying_item)
  local vertical_scroll_flag_header = u8(WRAM.vertical_scroll_flag_header)

  -- Transformations
  if direction == 0 then direction = LEFT_ARROW else direction = RIGHT_ARROW end
  local x_sub_simple, y_sub_simple-- = x_sub, y_sub
  if x_sub%0x10 == 0 then x_sub_simple = fmt("%x", x_sub/0x10) else x_sub_simple = fmt("%.2x", x_sub) end
  if y_sub%0x10 == 0 then y_sub_simple = fmt("%x", y_sub/0x10) else y_sub_simple = fmt("%.2x", y_sub) end

  local x_speed_int, x_speed_frac = math.modf(x_speed_u + x_subspeed/0x100)
  x_speed_frac = math.abs(x_speed_frac*0x100)

  local spin_direction = (Effective_frame)%8
  if spin_direction < 4 then
    spin_direction = spin_direction + 1
  else
    spin_direction = 3 - spin_direction
  end

  local is_caped = powerup == 0x2
  local is_spinning = cape_spin ~= 0 or spinjump_flag ~= 0

  -- Display info
  if OPTIONS.display_player_main_info then
  
    local i = 0
    local delta_x = BIZHAWK_FONT_WIDTH
    local delta_y = BIZHAWK_FONT_HEIGHT
    local table_x = - draw.Border_left
    local table_y = draw.AR_y*20
    local colour

    draw.text(table_x, table_y + i*delta_y, fmt("Pos (%04X.%s, %04X.%s)", bit.band(x, 0xFFFF), x_sub_simple, bit.band(y, 0xFFFF), y_sub_simple)) -- bit.band 0xFFFF to handle negative position
    i = i + 1

    if math.abs(x_speed) == 49 or math.abs(x_speed) == 51 then colour = COLOUR.positive -- max running and flying speed
    elseif (math.abs(x_speed) >= 35 and math.abs(x_speed) <= 37) or math.abs(x_speed) >= 47 then colour = "yellow" -- oscillating speeds
    else colour = COLOUR.text end
    draw.text(table_x, table_y + i*delta_y, fmt("Speed (   (      ), %s)", luap.signed8hex(y_speed_u, true)))
    draw.text(table_x, table_y + i*delta_y, fmt("       %s %s.%02x", luap.signed8hex(x_speed_u, true), luap.signed8hex(x_speed_int, true), x_speed_frac), colour)
    i = i + 1
    
    if on_water == 0 then -- Mario is not on water, where jumping is tied to swimming (TODO: maybe implement something about this)
      local jump_speed_table = { -- TODO: implement exactly what the game does in CODE_00D630 and CODE_00D663
        {A = -71, B = -77},
        {A = -73, B = -79},
        {A = -75, B = -82},
        {A = -77, B = -84},
        {A = -79, B = -87},
        {A = -82, B = -89},
        {A = -84, B = -92},
        {A = -87, B = -94},
        {A =   2, B =   3}
      }
      local jump_speed_index = floor(math.abs(x_speed)/8) + 1
      if jump_speed_index > 9 then jump_speed_index = 9 end -- TODO: this is just a temporary workaround, REMOVE!
      local jump_speed_A = jump_speed_table[jump_speed_index].A
      local jump_speed_B = jump_speed_table[jump_speed_index].B
      if Yoshi_riding_flag then 
        if on_ground == 1 then 
          jump_speed_A = -64
        else
          jump_speed_A = -96
        end
      end
      draw.text(table_x, table_y + i*delta_y, fmt("Jump speed(A:%s, B:%s)", luap.signed8hex(bit.band(jump_speed_A, 0xFF), true), luap.signed8hex(bit.band(jump_speed_B, 0xFF), true)))
      i = i + 1
    end
    
    if p_meter == 112 then colour = COLOUR.positive -- max pmeter
    elseif p_meter >= 106 then colour = "yellow" -- range of pmeter in a 6/5
    else colour = COLOUR.text end
    draw.text(table_x, table_y + i*delta_y, fmt("P-meter (  )  %s", direction))
    draw.text(table_x, table_y + i*delta_y, fmt("         %02X", p_meter), colour)
    draw.text(table_x + 18*delta_x, table_y + i*delta_y, fmt(" %+d", spin_direction), (is_spinning and COLOUR.text) or COLOUR.weak)
    i = i + 1
    
    draw.text(table_x, table_y + i*delta_y, fmt("Take-off timer (%d)", take_off))
    i = i + 1
    
    if is_caped then
      local cape_gliding_index = u8(WRAM.cape_gliding_index)
      local diving_status_timer = u8(WRAM.diving_status_timer)
      local action = SMW.flight_actions[cape_gliding_index] or "bug!"
      
      -- TODO: better name for this "glitched" state
      if cape_gliding_index == 3 and y_speed > 0 then
        action = "*up*"
      end

      draw.text(table_x, table_y + i*delta_y, fmt("Cape (%.2d, %.2d)/(%d, %d)", cape_spin, cape_fall, flight_animation, diving_status), COLOUR.cape)
      i = i + 1
      if flight_animation ~= 0 then
        draw.text(table_x + 10*delta_x, table_y + i*delta_y, action .. " ", COLOUR.cape)
        draw.text(table_x + 15*delta_x, table_y + i*delta_y, diving_status_timer, diving_status_timer <= 1 and COLOUR.warning or COLOUR.cape)
        i = i + 1
      end
    end

    draw_blocked_status(table_x, table_y + i*delta_y, player_blocked_status, x_speed, y_speed)
    i = i + 1

    draw.Text_opacity = 0.6
    
    local item_box_sprite = item_box ~= 0 and fmt("%02X", (item_box + 0x73)%256) or "--"
    draw.text(draw.Buffer_middle_x*draw.AR_x, 36*draw.AR_y, fmt("%02X(%s)", item_box, item_box_sprite), COLOUR.weak, false, false, 0.5) -- 226
    
  end
  
  draw.Text_opacity = 1.0
  
  if OPTIONS.display_static_camera_region then
    Display.show_player_point_position = true
    
    -- Horizontal scroll
    local left_cam, right_cam = u16(WRAM.camera_left_limit), u16(WRAM.camera_right_limit)
    local center_cam = floor((left_cam + right_cam)/2)
    draw.box(left_cam, 0, right_cam, 224, COLOUR.static_camera_region, COLOUR.static_camera_region)
    draw.line(center_cam, 0, center_cam, 224, "black")
    draw.text(draw.AR_x*left_cam, draw.Buffer_height*draw.AR_y, fmt("%02X", left_cam), COLOUR.text, 0x400020, false, false, 1, 0)
    draw.text(draw.AR_x*right_cam, draw.Buffer_height*draw.AR_y, fmt("%02X", right_cam), COLOUR.text, 0x400020)

    -- Vertical scroll
    if vertical_scroll_flag_header ~= 0 then
      draw.box(0, 100, 255, 124, COLOUR.static_camera_region, COLOUR.static_camera_region)
    end
  end

  -- Mario boost indicator (experimental)
  -- This looks for differences between the expected x position and the actual x position, after a frame advance
  -- Fails during a loadstate and has false positives if the game is paused or lagged
  Previous.player_x = 256*x + x_sub  -- the total amount of 256-based subpixels
  Previous.x_speed = 16*x_speed  -- the speed in 256-based subpixels

  if Mario_boost_indicator and not Cheat.under_free_move then
    local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)
    draw.text(draw.AR_x*(x_screen + 4), draw.AR_y*(y_screen + 60), Mario_boost_indicator, COLOUR.warning, 0x20000000)  -- unlisted color
  end

  -- Shows hitbox and interaction points for player
  cape_hitbox(spin_direction)
  player_hitbox(x, y, is_ducking, powerup, 1.0)

  -- Shows where Mario is expected to be in the next frame, if he's not boosted or stopped (DEBUG)
  if OPTIONS.display_debug_player_extra then
    player_hitbox(floor((256*x + x_sub + 16*x_speed)/256), floor((256*y + y_sub + 16*y_speed)/256), is_ducking, powerup, 0.3)
  end

end


local function extended_sprites()
  if not OPTIONS.display_other_sprites_info or not OPTIONS.display_extended_sprite_info then return end

  -- Font
  draw.Text_opacity = 0.8
  local height = BIZHAWK_FONT_HEIGHT

  local y_pos = draw.AR_y*144
  local counter = 0
  for id = 0, SMW.extended_sprite_max - 1 do -- extended_sprite_max = 10
    local extspr_number = u8(WRAM.extspr_number + id)

    if extspr_number ~= 0 then
      -- Read WRAM addresses
      local x = 256*u8(WRAM.extspr_x_high + id) + u8(WRAM.extspr_x_low + id)
      local y = 256*u8(WRAM.extspr_y_high + id) + u8(WRAM.extspr_y_low + id)
      local sub_x = bit.rshift(u8(WRAM.extspr_subx + id), 4)
      local sub_y = bit.rshift(u8(WRAM.extspr_suby + id), 4)
      local x_speed = s8(WRAM.extspr_x_speed + id)
      local y_speed = s8(WRAM.extspr_y_speed + id)
      local extspr_table = u8(WRAM.extspr_table + id)
      local extspr_table2 = u8(WRAM.extspr_table2 + id)

      -- Reduction of useless info
      local special_info = ""
      if OPTIONS.display_debug_extended_sprite and (extspr_table ~= 0 or extspr_table2 ~= 0) then
        special_info = fmt("(%x, %x) ", extspr_table, extspr_table2)
      end

      -- x speed for Fireballs
      if extspr_number == 5 then x_speed = 16*x_speed end

      -- Draw the table
      if OPTIONS.display_extended_sprite_info then
        draw.text(draw.Buffer_width + draw.Border_right, y_pos + counter*height, fmt("#%.2d %.2x %s(%04X.%x(%+.2d), %04X.%x(%+.2d))",
                                  id, extspr_number, special_info, x, sub_x, x_speed, y, sub_y, y_speed),
                                  COLOUR.extended_sprites, true, false)
      end

      if OPTIONS.display_debug_extended_sprite or not SMW.uninteresting_extended_sprites[extspr_number]
        or (extspr_number == 1 and extspr_table2 == 0xf)
      then
        local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)

        local t = SMW.hitbox_extended_sprite[extspr_number] or
          {xoff = 0, yoff = 0, width = 16, height = 16, color_line = COLOUR.awkward_hitbox, color_bg = COLOUR.awkward_hitbox_bg}
        local xoff = t.xoff
        local yoff = t.yoff
        local xrad = t.width
        local yrad = t.height

        local color_line = t.color_line or COLOUR.extended_sprites
        local color_bg = t.color_bg or COLOUR.extended_sprites_bg
        if extspr_number == 0x5 or extspr_number == 0x11 then
          color_bg = (Real_frame - id)%4 == 0 and COLOUR.special_extended_sprite_bg or 0
        end
        draw.rectangle(x_screen+xoff, y_screen+yoff, xrad, yrad, color_line, color_bg) -- regular hitbox

        -- Experimental: attempt to show Mario's fireball vs sprites
        -- this is likely wrong in some situation, but I can't solve this yet
        if extspr_number == 5 or extspr_number == 1 then
          local xoff_spr = x_speed >= 0 and -5 or  1
          local yoff_spr = - floor(y_speed/16) - 4 + (y_speed >= -40 and 1 or 0)
          local yrad_spr = y_speed >= -40 and 19 or 20
          draw.rectangle(x_screen + xoff_spr, y_screen + yoff_spr, 12, yrad_spr, color_line, color_bg)
        end
      end

      counter = counter + 1
    end
  end

  --draw.Text_opacity = 0.5
  local x_pos, y_pos, length = draw.text(draw.Buffer_width + draw.Border_right, y_pos, fmt("Extended sprites: %d", counter), COLOUR.weak, true, false, 0.0, 1.0)

  if u8(WRAM.spinjump_flag) ~= 0 and u8(WRAM.powerup) == 3 then
    local fireball_timer = u8(WRAM.spinjump_fireball_timer)
    draw.text(x_pos - length - BIZHAWK_FONT_WIDTH, y_pos, fmt("%d %s",
    fireball_timer%16, bit.test(fireball_timer, 4) and RIGHT_ARROW or LEFT_ARROW), COLOUR.extended_sprites, true, false, 1.0, 1.0)
  end

end


local function cluster_sprites()
  if not OPTIONS.display_other_sprites_info or not OPTIONS.display_cluster_sprite_info or u8(WRAM.cluspr_flag) == 0 then return end

  -- Font
  draw.Text_opacity = 0.8
  local height = BIZHAWK_FONT_HEIGHT
  local x_pos, y_pos = draw.Border_right, draw.AR_y*45
  local counter = 0

  local reappearing_boo_counter

  for id = 0, SMW.cluster_sprite_max - 1 do -- cluster_sprite_max = 20
    local clusterspr_number = u8(WRAM.cluspr_number + id)

    if clusterspr_number ~= 0 then
      if not SMW.hitbox_cluster_sprite[clusterspr_number] then
        print("Warning: wrong cluster sprite number:", clusterspr_number)  -- should not happen without cheats
        return
      end

      -- Read WRAM addresses
      local x = luap.signed16(256*u8(WRAM.cluspr_x_high + id) + u8(WRAM.cluspr_x_low + id))
      local y = luap.signed16(256*u8(WRAM.cluspr_y_high + id) + u8(WRAM.cluspr_y_low + id))
      local clusterspr_timer, special_info, table_1, table_2, table_3

      -- Read cluster's table
      local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)
      local t = SMW.hitbox_cluster_sprite[clusterspr_number] or
        {xoff = 0, yoff = 0, width = 16, height = 16, color_line = COLOUR.awkward_hitbox, color_bg = COLOUR.awkward_hitbox_bg, oscillation = 1}
      local xoff = t.xoff
      local yoff = t.yoff
      local xrad = t.width
      local yrad = t.height
      local phase = t.phase or 0
      local oscillation = (Real_frame - id)%t.oscillation == phase
      local color = t.color or COLOUR.cluster_sprites
      local color_bg = t.bg or COLOUR.sprites_bg
      local invencibility_hitbox = nil

      -- Reduction of useless info
      local special_info = ""
      if OPTIONS.display_debug_cluster_sprite then
        table_1 = u8(WRAM.cluspr_table_1 + id)
        table_2 = u8(WRAM.cluspr_table_2 + id)
        table_3 = u8(WRAM.cluspr_table_3 + id)
        special_info = fmt(" (%d, %d, %d)", table_1, table_2, table_3)
      end
      
      -- Draw the table
      draw.text(x_pos, y_pos + counter*height, ("#%02d %X (%04X, %04X)%s"):format(id, clusterspr_number, x, y, special_info), color, false, true)
      special_info = ""
      
      -- Case analysis
      if OPTIONS.display_debug_cluster_sprite then
        if clusterspr_number == 3 or clusterspr_number == 8 then -- Boo from Boo Ceiling / Swooper Bat from Swooper Death Bat Ceiling
        
          clusterspr_timer = u8(WRAM.cluspr_timer + id)
          if clusterspr_timer ~= 0 then special_info = " " .. clusterspr_timer end
          
        elseif clusterspr_number == 6 then -- Sumo Brother lightning flames
        
          table_1 = table_1 or u8(WRAM.cluspr_table_1 + id)
          if table_1 >= 111 or (table_1 < 31 and table_1 >= 16) then
            yoff = yoff + 17
          elseif table_1 >= 103 or table_1 < 16 then
            invencibility_hitbox = true
          elseif table_1 >= 95 or (table_1 < 47 and table_1 >= 31) then
            yoff = yoff + 16
          end
          special_info = fmt(" (%d)", table_1)
          
        elseif clusterspr_number == 7 then -- 	Reappearing Boo
        
          reappearing_boo_counter = reappearing_boo_counter or u8(WRAM.reappearing_boo_counter)
          invencibility_hitbox = (reappearing_boo_counter > 0xde) or (reappearing_boo_counter < 0x3f)
          special_info = " " .. reappearing_boo_counter
          
        end
      end
      
      -- Hitbox and info next to the cluster sprite
      color = invencibility_hitbox and COLOUR.weak or color
      color_bg = (invencibility_hitbox and 0) or (oscillation and color_bg) or 0
      draw.rectangle(x_screen + xoff, y_screen + yoff, xrad, yrad, color, color_bg)
      draw.text(draw.AR_x*(x_screen + xoff) + xrad, draw.AR_y*(y_screen + yoff), special_info and id .. special_info or id,
      color, false, false, 0.5, 1.0)
      
      
      counter = counter + 1
      
    end
  end
  
  draw.text(x_pos, y_pos - height, "Cluster sprites: " .. counter, COLOUR.weak, false, true)
  
end


local function minor_extended_sprites()
  if not OPTIONS.display_other_sprites_info or not OPTIONS.display_minor_extended_sprite_info then return end

  -- Font
  draw.Text_opacity = 0.8
  local height = BIZHAWK_FONT_HEIGHT
  local x_pos, y_pos = 0, draw.Buffer_height*draw.AR_y - height*SMW.minor_extended_sprite_max
  
  local counter = 0
  
  for id = 0, SMW.minor_extended_sprite_max - 1 do -- minor_extended_sprite_max = 12
    local minorspr_number = u8(WRAM.minorspr_number + id)

    if minorspr_number ~= 0 then
      -- Read WRAM addresses
      local x = luap.signed16(256*u8(WRAM.minorspr_x_high + id) + u8(WRAM.minorspr_x_low + id))
      local y = luap.signed16(256*u8(WRAM.minorspr_y_high + id) + u8(WRAM.minorspr_y_low + id))
      local xspeed, yspeed = s8(WRAM.minorspr_xspeed + id), s8(WRAM.minorspr_yspeed + id)
      local x_sub, y_sub = u8(WRAM.minorspr_x_sub + id), u8(WRAM.minorspr_y_sub + id)
      local timer = u8(WRAM.minorspr_timer + id)

      -- Only sprites 1 and 10 use the higher byte
      local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)
      if minorspr_number ~= 1 and minorspr_number ~= 10 then  -- Boo stream and Piece of brick block
        x_screen = x_screen%0x100
        y_screen = y_screen%0x100
      end
      
      -- Reduction of useless info
      local special_info = ""
      if OPTIONS.display_debug_minor_extended_sprite then
        special_info = fmt(" (%d)", timer)
      end
      
      -- Draw info next to the minor extended sprite
      local text = "#" .. id .. (timer ~= 0 and fmt(" (%d)",timer) or "")
      draw.text(draw.AR_x*(x_screen + 8), draw.AR_y*(y_screen + 4), fmt("#%02d%s", id, special_info), COLOUR.minor_extended_sprites, false, false, 0.5, 1.0)
      if minorspr_number == 10 then  -- Boo stream
        draw.rectangle(x_screen + 4, y_screen + 4, 8, 8, COLOUR.minor_extended_sprites, COLOUR.sprites_bg)
      end

      -- Draw the table
      draw.text(x_pos, y_pos + counter*height, ("#%02d %X%s (%04X.%x(%d), %04X.%x(%d))")
      :format(id, minorspr_number, special_info, x, floor(x_sub/16), xspeed, y, floor(y_sub/16), yspeed), COLOUR.minor_extended_sprites)
      
      counter = counter + 1
    end
  end
  
  draw.text(x_pos, y_pos - height, "Minor extended sprites: " .. counter, COLOUR.weak)
  
end


local function bounce_sprite_info()
  if not OPTIONS.display_other_sprites_info or not OPTIONS.display_bounce_sprite_info then return end

  -- Font
  draw.Text_opacity = 0.8
  local height = BIZHAWK_FONT_HEIGHT
  local x_txt, y_txt = 0, draw.AR_y*45
  
  local counter = 0

  local stop_id = (u8(WRAM.bouncespr_last_id) - 1)%SMW.bounce_sprite_max
  for id = 0, SMW.bounce_sprite_max - 1 do -- bounce_sprite_max = 4
    local bounce_sprite_number = u8(WRAM.bouncespr_number + id)
    if bounce_sprite_number ~= 0 then
    
      -- Read WRAM addresses
      local x = luap.signed16(256*u8(WRAM.bouncespr_x_high + id) + u8(WRAM.bouncespr_x_low + id))
      local y = luap.signed16(256*u8(WRAM.bouncespr_y_high + id) + u8(WRAM.bouncespr_y_low + id))
      local bounce_timer = u8(WRAM.bouncespr_timer + id)

      -- Reduction of useless info
      local special_info = ""
      if OPTIONS.display_debug_bounce_sprite then
        special_info = fmt(" (%d)", bounce_timer)
      end
      
      -- Draw info next to the bounce sprite
      local x_screen, y_screen = screen_coordinates(x, y, Camera_x, Camera_y)
      x_screen, y_screen = draw.AR_x*(x_screen + 8), draw.AR_y*y_screen
      
      local color = id == stop_id and COLOUR.warning or COLOUR.text
      draw.text(x_screen , y_screen, fmt("#%d%s", id,  bounce_timer ~= 0 and special_info or ""), color, false, false, 0.5)  -- timer

      -- Turn blocks
      if bounce_sprite_number == 7 then
        turn_block_timer = u8(WRAM.turn_block_timer + id)
        draw.text(x_screen, y_screen + height, turn_block_timer, color, false, false, 0.5)
        if OPTIONS.display_debug_bounce_sprite then
          special_info = fmt(" (%d, %d)", bounce_timer, turn_block_timer)
        end
      end
      
      -- Draw the table
      draw.text(x_txt, y_txt + counter*height, fmt("#%d %X%s (%04X, %04X)", id, bounce_sprite_number, special_info, x, y))
      
      counter = counter + 1
    end
  end
  
  draw.text(x_txt, y_txt - height, "Bounce sprites: " .. counter, COLOUR.weak)
  
end


local function quake_sprite_info()
  if not OPTIONS.display_other_sprites_info or not OPTIONS.display_quake_sprite_info then return end

  -- Font
  draw.Text_opacity = 0.8
  local height = BIZHAWK_FONT_HEIGHT
  local x_txt, y_txt = draw.Buffer_width + draw.Border_right, draw.AR_y*144 + 12*height  
 
 local counter = 0
  
  local hitbox_tab = SMW.hitbox_quake_sprite
  for id = 0, 3 do
    local sprite_number = u8(WRAM.quakespr_number + id)
    local hitbox = hitbox_tab[sprite_number]

    if hitbox then
      
      -- Read WRAM addresses
      local x = luap.signed16(256*u8(WRAM.quakespr_x_high + id) + u8(WRAM.quakespr_x_low + id))
      local y = luap.signed16(256*u8(WRAM.quakespr_y_high + id) + u8(WRAM.quakespr_y_low + id))
      local quake_timer = u8(WRAM.quakespr_timer + id)
      local interact = quake_timer < 3 and COLOUR.quake_sprite_bg or 0
      
      -- Draw the hitbox
      draw.rectangle(x - Camera_x + hitbox.xoff, y - Camera_y + hitbox.yoff, hitbox.width, hitbox.height, COLOUR.quake_sprite, interact)
      
      -- Draw info next to the quake sprite
      draw.text(draw.AR_x*(x - Camera_x), draw.AR_x*(y - Camera_y), fmt("#%d", id), COLOUR.quake_sprite)
      
      -- Draw the table
      draw.text(x_txt, y_txt + counter*height, fmt("#%d %X (%d) (%04X, %04X)", id, sprite_number, quake_timer, x, y), COLOUR.quake_sprite, COLOUR.background, true)
      
      counter = counter + 1
    end
  end
  
  draw.text(x_txt, y_txt, "Quake sprites: " .. counter, COLOUR.weak, true, false, 0.0, 1.0)
end


local function scan_sprite_info(lua_table, slot)
  local t = lua_table[slot]
  if not t then error"Wrong Sprite table" end

  t.status = u8(WRAM.sprite_status + slot)
  if t.status == 0 then
    return -- returns if the slot is empty
  end

  local x = 256*u8(WRAM.sprite_x_high + slot) + u8(WRAM.sprite_x_low + slot)
  local y = 256*u8(WRAM.sprite_y_high + slot) + u8(WRAM.sprite_y_low + slot)
  t.x_sub = u8(WRAM.sprite_x_sub + slot)
  t.y_sub = u8(WRAM.sprite_y_sub + slot)
  t.number = u8(WRAM.sprite_number + slot)
  t.stun = u8(WRAM.sprite_stun_timer + slot)
  t.x_speed = s8(WRAM.sprite_x_speed + slot)
  t.y_speed = s8(WRAM.sprite_y_speed + slot)
  t.contact_mario = u8(WRAM.sprite_player_contact + slot)
  t.underwater = u8(WRAM.sprite_underwater + slot)
  t.x_offscreen = s8(WRAM.sprite_x_offscreen + slot)
  t.y_offscreen = s8(WRAM.sprite_y_offscreen + slot)

  -- Transform some read values into intelligible content
  t.x = luap.signed16(x)
  t.y = luap.signed16(y)
  t.x_screen, t.y_screen = screen_coordinates(t.x, t.y, Camera_x, Camera_y)

  t.oscillation_flag = bit.test(u8(WRAM.sprite_4_tweaker + slot), 5) or SMW.oscillation_sprites[t.number]

  -- Sprite clipping vs mario and sprites
  local boxid = bit.band(u8(WRAM.sprite_2_tweaker + slot), 0x3f)  -- This is the type of box of the sprite
  t.hitbox_id = boxid
  t.hitbox_xoff = SMW.hitbox_sprite[boxid].xoff
  t.hitbox_yoff = SMW.hitbox_sprite[boxid].yoff
  t.hitbox_width = SMW.hitbox_sprite[boxid].width
  t.hitbox_height = SMW.hitbox_sprite[boxid].height

  -- Sprite clipping vs objects
  local clip_obj = bit.band(u8(WRAM.sprite_1_tweaker + slot), 0xf)  -- type of hitbox for blocks
  t.clipping_id = clip_obj
  t.xpt_right = SMW.obj_clipping_sprite[clip_obj].xright
  t.ypt_right = SMW.obj_clipping_sprite[clip_obj].yright
  t.xpt_left = SMW.obj_clipping_sprite[clip_obj].xleft
  t.ypt_left = SMW.obj_clipping_sprite[clip_obj].yleft
  t.xpt_down = SMW.obj_clipping_sprite[clip_obj].xdown
  t.ypt_down = SMW.obj_clipping_sprite[clip_obj].ydown
  t.xpt_up = SMW.obj_clipping_sprite[clip_obj].xup
  t.ypt_up = SMW.obj_clipping_sprite[clip_obj].yup

  -- Some HUD configurations
  -- calculate the correct color to use, according to slot
  if t.number == 0x35 then
    t.info_color = COLOUR.yoshi
    t.background_color = COLOUR.yoshi_bg
  else
    t.info_color = COLOUR.sprites[slot%(#COLOUR.sprites) + 1]
    t.background_color = COLOUR.sprites_bg
  end
  if (not t.oscillation_flag) and (Real_frame - slot)%2 == 1 then t.background_color = 0 end

  t.sprite_middle = t.x_screen + t.hitbox_xoff + floor(t.hitbox_width/2)
  t.sprite_top = t.y_screen + math.min(t.hitbox_yoff, t.ypt_up)
end


-- draw normal sprite vs Mario hitbox
local function draw_sprite_hitbox(slot)

  local t = Sprites_info[slot]
  -- Load values
  local number = t.number
  local x_screen = t.x_screen
  local y_screen = t.y_screen
  local xpt_left = t.xpt_left
  local ypt_left = t.ypt_left
  local xpt_right = t.xpt_right
  local ypt_right = t.ypt_right
  local xpt_up = t.xpt_up
  local ypt_up = t.ypt_up
  local xpt_down = t.xpt_down
  local ypt_down = t.ypt_down
  local xoff = t.hitbox_xoff
  local yoff = t.hitbox_yoff
  local width = t.hitbox_width
  local height = t.hitbox_height

  -- Settings
  local display_hitbox = Sprite_hitbox[slot][number].sprite and not SMW.abnormal_hitbox_sprites[number]
  local display_clipping = Sprite_hitbox[slot][number].block
  local alive_status = (t.status == 0x03 or t.status >= 0x08)
  local info_color = alive_status and t.info_color or COLOUR.very_weak
  local background_color = alive_status and t.background_color or 0

  -- That's the pixel that appears when the sprite vanishes in the pit
  if y_screen >= 224 or OPTIONS.display_debug_sprite_extra then
    draw.pixel(x_screen, y_screen, info_color, COLOUR.very_weak)
  end

  -- Display main sprite hitbox
  if OPTIONS.display_sprite_hitbox then
    
    if display_clipping then -- sprite clipping background
      draw.box(x_screen + xpt_left, y_screen + ypt_down, x_screen + xpt_right, y_screen + ypt_up,
        2, COLOUR.sprites_clipping_bg, display_hitbox and -1 or COLOUR.sprites_clipping_bg)
    end

    if display_hitbox then  -- show sprite-Mario hitbox
      draw.rectangle(x_screen + xoff, y_screen + yoff, width, height, info_color, background_color)
    end

    if display_clipping then  -- show sprite/object clipping
      local size, color = 1, COLOUR.sprites_interaction_pts
      draw.line(x_screen + xpt_right, y_screen + ypt_right, x_screen + xpt_right - size, y_screen + ypt_right, color) -- right
      draw.line(x_screen + xpt_left, y_screen + ypt_left, x_screen + xpt_left + size, y_screen + ypt_left, color)  -- left
      draw.line(x_screen + xpt_down, y_screen + ypt_down, x_screen + xpt_down, y_screen + ypt_down - size, color) -- down
      draw.line(x_screen + xpt_up, y_screen + ypt_up, x_screen + xpt_up, y_screen + ypt_up + size, color)  -- up
    end
  
  end

  -- Display sprite vs sprite hitbox
  if OPTIONS.display_sprite_vs_sprite_hitbox then
    if u8(WRAM.sprite_sprite_contact + slot) == 0 and u8(WRAM.sprite_being_eaten_flag + slot) == 0 and not bit.test(u8(WRAM.sprite_5_tweaker + slot), 3) then

      local boxid2 = bit.band(u8(WRAM.sprite_2_tweaker + slot), 0x0f)
      local yoff2 = boxid2 == 0 and 2 or 0xa  -- ROM data
      local bg_color = t.status >= 8 and 0x80ffffff or 0x80ff0000
      if Real_frame%2 == 0 then bg_color = 0x80808080 end

      -- if y1 - y2 + 0xc < 0x18
      draw.rectangle(x_screen, y_screen + yoff2, 0x10, 0x0c, 0xffffff)
      draw.rectangle(x_screen, y_screen + yoff2, 0x10-1, 0x0c - 1, info_color, bg_color)
    end
  end
end


-- Display sprite spawning and despawning areas
local function draw_sprite_spawn_despawn()
  if not OPTIONS.display_sprite_info then return end

  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0
  
  -- Sprite pit line
  if OPTIONS.display_sprite_vanish_area then
    local ydeath = is_vertical and Camera_y + 320 or 432
    local _, y_screen = screen_coordinates(0, ydeath, Camera_x, Camera_y)

    if y_screen < 224 + OPTIONS.bottom_gap then
      draw.line(-OPTIONS.left_gap, y_screen, 256 + OPTIONS.right_gap, y_screen, COLOUR.weak) -- x positions don't matter
    end
    local str = string.format("Sprite %s: %04X", is_vertical and "\"death\"" or "death", ydeath)
    draw.text(draw.Buffer_middle_x*draw.AR_x, draw.AR_y*y_screen + 2, str, COLOUR.weak, true, false, 0.5)
  end

  -- Sprite spawning lines
  if OPTIONS.display_sprite_spawning_areas and not is_vertical then
    local left_line, right_line = 63, 32

    draw.line(-left_line, -OPTIONS.top_gap, -left_line, 224 + OPTIONS.bottom_gap, COLOUR.weak)
    draw.line(-left_line + 15, -OPTIONS.top_gap, -left_line + 15, 224 + OPTIONS.bottom_gap, COLOUR.very_weak)

    draw.line(256 + right_line, -OPTIONS.top_gap, 256 + right_line, 224 + OPTIONS.bottom_gap, COLOUR.weak)
    draw.line(256 + right_line - 15, -OPTIONS.top_gap, 256 + right_line - 15, 224 + OPTIONS.bottom_gap, COLOUR.very_weak)
    
    draw.text(-left_line*draw.AR_x, draw.Buffer_height + draw.Border_bottom - 2*BIZHAWK_FONT_HEIGHT, "Spawn", COLOUR.weak, true, false, 1)
    draw.text(-left_line*draw.AR_x, draw.Buffer_height + draw.Border_bottom - 1*BIZHAWK_FONT_HEIGHT, fmt("%04X", bit.band(Camera_x - left_line, 0xFFFF)), COLOUR.weak, true, false, 1) -- bit.band 0xFFFF to handle negative values

    draw.text((256+right_line)*draw.AR_x, draw.Buffer_height + draw.Border_bottom - 2*BIZHAWK_FONT_HEIGHT, "Spawn", COLOUR.weak)
    draw.text((256+right_line)*draw.AR_x, draw.Buffer_height + draw.Border_bottom - 1*BIZHAWK_FONT_HEIGHT, fmt("%04X", Camera_x + 256 + right_line), COLOUR.weak)
  end
end


-- Sprite tweakers info
local function sprite_tweaker_editor(slot)
  if not OPTIONS.display_debug_sprite_tweakers then return end
  
  local t = Sprites_info[slot]
  local info_color = t.info_color
  local y_screen = t.y_screen
  local xoff = t.hitbox_xoff
  local yoff = t.hitbox_yoff

  local width, height = BIZHAWK_FONT_WIDTH, BIZHAWK_FONT_HEIGHT
  local x_ini, y_ini = draw.AR_x*t.sprite_middle - 4*width, draw.AR_y*(y_screen + yoff) - 7*height
  local x_txt, y_txt = x_ini, y_ini

  local tweaker_1 = u8(WRAM.sprite_1_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_1, "sSjJcccc", COLOUR.weak, info_color)
  y_txt = y_txt + height

  local tweaker_2 = u8(WRAM.sprite_2_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_2, "dscccccc", COLOUR.weak, info_color)
  y_txt = y_txt + height

  local tweaker_3 = u8(WRAM.sprite_3_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_3, "lwcfpppg", COLOUR.weak, info_color)
  y_txt = y_txt + height

  local tweaker_4 = u8(WRAM.sprite_4_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_4, "dpmksPiS", COLOUR.weak, info_color)
  y_txt = y_txt + height

  local tweaker_5 = u8(WRAM.sprite_5_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_5, "dnctswye", COLOUR.weak, info_color)
  y_txt = y_txt + height

  local tweaker_6 = u8(WRAM.sprite_6_tweaker + slot)
  draw.over_text(x_txt, y_txt, tweaker_6, "wcdj5sDp", COLOUR.weak, info_color)
end


-- A table of custom functions for special sprites
local special_sprite_property = {}

--[[
PROBLEMATIC ONES
  29  Koopa Kid
  54  Revolving door for climbing net, wrong hitbox area, not urgent
  5a  Turn block bridge, horizontal, hitbox only applies to central block and wrongly
  89  Layer 3 Smash, hitbox of generator outside
  9e  Ball 'n' Chain, hitbox only applies to central block, rotating ball
  a3  Rotating gray platform, wrong hitbox, rotating plataforms
--]]

special_sprite_property[0x1e] = function(slot) -- Lakitu
  if u8(WRAM.sprite_misc_151c + slot) ~= 0 or
  u8(WRAM.sprite_horizontal_direction + slot) ~= 0 then

    local OAM_index = 0xec
    local xoff = u8(0x304 + OAM_index) - 0x0c -- lots of unlisted WRAM
    local yoff = u8(0x305 + OAM_index) - 0x0c
    local width, height = 0x18 - 1, 0x18 - 1  -- instruction BCS

    draw.rectangle(xoff, yoff, width, height, COLOUR.awkward_hitbox, COLOUR.awkward_hitbox_bg)
    -- TODO: 0x7e and 0x80 are too important
    -- draw this point outside this function and add an option
    draw.pixel(s16(0x7e), s16(0x80), COLOUR.mario)
  end
end

special_sprite_property[0x3d] = function(slot) -- Rip Van Fish
  if u8(WRAM.sprite_phase + slot) == 0 then -- if sleeping
    local x_screen = Sprites_info[slot].x_screen
    local y_screen = Sprites_info[slot].y_screen
    local color = Sprites_info[slot].info_color
    local x1, y1, x2, y2 = -0x30, -0x30, 0x2e, 0x2e

    -- Draw central hitbox and 8 areas around due to overflow
    for horizontal = -1, 1 do
      local x = x_screen + 0x100*horizontal
      for vertical = -1, 1 do
        local y = y_screen + 0x100*vertical
        draw.box(x + x1, y + y1, x + x2, y + y2, color)
      end
    end

    Display.show_player_point_position = true -- Only Mario coordinates matter
  end
end

special_sprite_property[0x5f] = function(slot) -- Swinging brown platform (TODO fix it)
  --[[ TEST
  gui.text(0, 200, u8(0x4216))

  local px = u16(0x14b8)
  local py = u16(0x14ba)
  gui.text(0, 0, px.. ", ".. py, 'white', 'blue')
  local sx, sy = screen_coordinates(px, py, Camera_x, Camera_y)
  draw.rectangle(sx, sy, 2, 2)
  local table1 = s8(0x1504 + id) -- speed
  local table2 = u8(0x1510 + id) -- subpixle?
  local table3 = u8(0x151c + id)
  local table4 = u8(0x1528 + id) -- numero de voltas horario
  draw.text(0, 16, string.format("Tables: %4d, %4d.%x, %4d", table1, table3, table2>>4, table4))

  local is_up = table4%2 == 0 and 256 or 0
  -- test3
  platform_x = x + circle_values[256 - table3 + is_up][1]
  platform_y = y + circle_values[256 - table3 + is_up][2]

  sx, sy = screen_coordinates(platform_x, platform_y, Camera_x, Camera_y)
  --sx, sy = screen_coordinates(px, py, Camera_x, Camera_y)
  draw.rectangle(sx - 24, sy - 7, 64, 18, info_color, COLOUR.sprites_bg)
  draw.rectangle(sx, sy, 2, 2, info_color)  -- to test correctness
  draw.text(0, 32, "Platf. Calc: " .. platform_x .. ", " .. platform_y, "red", 0x40000000)

  -- test2
  local next_pos = (16*table3 + table2//16 + table1)//16
  local index = 256*256*256*table2 + 256*256*luap.signed16(table1, 8) + 256*table4 + table3--(next_pos + is_up)%512
  gui.text(0, 48, "Index: "..tostring(index), 'yellow', 'black')
  if Circle[index] then if Circle[index][1] ~= px - x then print("x erf", -px + x, -Circle[index][1]) end if Circle[index][2] ~= py - y then print"y erf" end end
  Circle[index] = Circle[index] or ({px - x, py - y})
  local count=0 ; for a,b in pairs(Circle) do count = count + 1  end
  gui.text(0, 400, count, "red", "brown")
  --]]

  local t = Sprites_info[slot]
  local x = t.x
  local x_screen = t.x_screen
  local y_screen = t.y_screen
  local xoff = t.hitbox_xoff
  local yoff = t.hitbox_yoff
  local sprite_width = t.hitbox_width
  local sprite_height = t.hitbox_height
  local color = t.info_color

  -- Powerup Incrementation helper
  local yoshi_right = 256*floor(x/256) - 58
  local yoshi_left  = yoshi_right + 32
  local x_text, y_text, height = draw.AR_x*(x_screen + xoff), draw.AR_y*(y_screen + yoff), BIZHAWK_FONT_HEIGHT

  if mouse_onregion(x_text, y_text, x_text + draw.AR_x*sprite_width, y_text + draw.AR_y*sprite_height) then
    local x_text, y_text = 0, 0
    gui.text(x_text, y_text, "Powerup Incrementation help", color, COLOUR.background)
    gui.text(x_text, y_text + height, "Yoshi must have: id = #4;", color, COLOUR.background)
    gui.text(x_text, y_text + 2*height, fmt("Yoshi x pos: (%s %04X) or (%s %04X)",
      LEFT_ARROW, yoshi_left, RIGHT_ARROW, yoshi_right), color, COLOUR.background)
  end
  --The status change happens when yoshi's id number is #4 and when (yoshi's x position) + Z mod 256 = 214,
  --where Z is 16 if yoshi is facing right, and -16 if facing left. More precisely, when (yoshi's x position + Z) mod 256 = 214,
  --the address 0x7E0015 + (yoshi's id number) will be added by 1.
  -- therefore: X_yoshi = 256*floor(x/256) + 32*yoshi_direction - 58
end

special_sprite_property[0x35] = function(slot) -- Yoshi
  local t = Sprites_info[slot]

  if not Yoshi_riding_flag and OPTIONS.display_sprite_hitbox and Sprite_hitbox[slot][t.number].sprite then
    draw.rectangle(t.x_screen + 4, t.y_screen + 20, 8, 8, COLOUR.yoshi)
  end
end

special_sprite_property[0x54] = function(slot) -- Revolving door for climbing net
  local t = Sprites_info[slot]

  -- draw custom hitbox for Mario
  if luap.inside_rectangle(Player_x, Player_y, t.x - 8, t.y - 24, t.x + 55, t.y + 55) then
    local extra_x, extra_y = screen_coordinates(Player_x, Player_y, Camera_x, Camera_y)
    draw.rectangle(t.x_screen - 8, t.y_screen - 8, 63, 63, COLOUR.very_weak)
    draw.rectangle(extra_x, extra_y, 0x10, 0x10, COLOUR.awkward_hitbox, COLOUR.awkward_hitbox_bg)
  end
end

special_sprite_property[0x62] = function(slot) -- Brown line-guided platform TODO: fix it
  local t = Sprites_info[slot]
  local xoff = t.hitbox_xoff - 24
  local yoff = t.hitbox_yoff - 8

  -- TODO: debug interaction for mario's image
  if OPTIONS.display_sprite_hitbox then
    draw.rectangle(t.x_screen + xoff, t.y_screen + yoff, t.hitbox_width, t.hitbox_height, t.info_color, t.background_color)
  end
end

special_sprite_property[0x63] = special_sprite_property[0x62] -- Brown/checkered line-guided platform

special_sprite_property[0x6b] = function(slot) -- Wall springboard (left wall)
  if not OPTIONS.display_sprite_hitbox then return end

  local t = Sprites_info[slot]
  local color = t.info_color

  -- HUD for the carry sprite cheat
  local xoff = t.hitbox_xoff
  local yoff = t.hitbox_yoff
  local x_screen = t.x_screen
  local y_screen = t.y_screen
  local sprite_width = t.hitbox_width
  local sprite_height = t.hitbox_height
  draw.rectangle(x_screen + xoff, y_screen + yoff, sprite_width, sprite_height, COLOUR.sprites_faint)

  -- Mario's image
  local xmario, ymario = u16(0x7e), u16(0x80)
  if floor(xmario/256) == 0 and floor(ymario/256) == 0 then
    local y1 = 0x08 + 0x08 + (Yoshi_riding_flag and 0x10 or 0)
    local y2 = 0x21 + (Yoshi_riding_flag and 0x10 or 0) + (Player_powerup == 0 and 2 or 0)
    draw.box(xmario - 6 + 0x8, ymario + y1,xmario + 0x0d, ymario + y2, COLOUR.mario_oam_hitbox, COLOUR.interaction_bg)
  end

  -- Spheres hitbox
  if t.x_offscreen == 0 and t.y_offscreen == 0 then
    local OAM_index = u8(WRAM.sprite_OAM_index + slot)
    for ball = 0, 4 do
      local x = u8(0x300 + OAM_index + 4*ball)
      local y = u8(0x301 + OAM_index + 4*ball)

      draw.rectangle(x, y, 8, 8, color, COLOUR.sprites_bg)
      draw.text(draw.AR_x*(x + 2), draw.AR_y*(y + 2), ball, COLOUR.text)
    end
  end
end

special_sprite_property[0x6c] = special_sprite_property[0x6b] -- Wall springboard (right wall)

special_sprite_property[0x6f] = function(slot) -- Dino-Torch: display flame hitbox
  local t = Sprites_info[slot]

  if OPTIONS.display_sprite_hitbox then
    if u8(WRAM.sprite_misc_151c + slot) == 0 then  -- if flame is hurting
      local active = (Real_frame - slot)%4 == 0 and COLOUR.sprites_bg or 0
      local vertical_flame = u8(WRAM.sprite_misc_1602 + slot) == 3
      local xoff, yoff, width, height

      if vertical_flame then
        xoff, yoff, width, height = 0x02, -0x24, 0x0c, 0x24
      else
        local facing_right = u8(WRAM.sprite_horizontal_direction + slot) == 0
        xoff = facing_right and 0x10 or -0x24
        yoff = 0x02
        width, height = 0x24, 0x0c
      end

      draw.rectangle(t.x_screen + xoff, t.y_screen + yoff, width, height, COLOUR.awkward_hitbox, active)
    end
  end
end

special_sprite_property[0x7b] = function(slot) -- Goal Tape
  local t = Sprites_info[slot]
  local y_screen = Sprites_info[slot].y_screen
  local info_color = Sprites_info[slot].info_color

  draw.Text_opacity = 0.8
  draw.Bg_opacity = 0.6

  -- This draws the effective area of a goal tape
  local x_effective = 256*u8(WRAM.sprite_misc_151c + slot) + u8(WRAM.sprite_phase + slot)
  local y_low = 256*u8(WRAM.sprite_misc_1534 + slot) + u8(WRAM.sprite_misc_1528 + slot)
  local _, y_high = screen_coordinates(0, 0, Camera_x, Camera_y)
  local x_s, y_s = screen_coordinates(x_effective, y_low, Camera_x, Camera_y)

  if OPTIONS.display_sprite_hitbox then
    draw.box(x_s, y_high, x_s + 15, y_s, info_color, COLOUR.goal_tape_bg)
  end
  draw.text(draw.AR_x*x_s, draw.AR_y*t.y_screen, fmt("Touch=%04X.0->%04X.f", x_effective, x_effective + 15), info_color, false, false)
end

special_sprite_property[0x86] = function(slot) -- Wiggler (segments)
  local OAM_index = u8(WRAM.sprite_OAM_index + slot)
  for seg = 0, 4 do
    local xoff = u8(0x304 + OAM_index) - 0x0a -- lots of unlisted WRAM
    local yoff = u8(0x305 + OAM_index) - 0x1b
    if Yoshi_riding_flag then yoff = yoff - 0x10 end
    local width, height = 0x17 - 1, 0x17
    local xend, yend = xoff + width, yoff + height

    -- TODO: fix draw.rectangle to display the exact dimensions; then remove the -1
    --draw.rectangle(xoff, yoff, width - 1, height - 1, COLOUR.awkward_hitbox, COLOUR.awkward_hitbox_bg)
    draw.box(xoff, yoff, xend, yend, COLOUR.awkward_hitbox, COLOUR.awkward_hitbox_bg)

    OAM_index = OAM_index + 4
  end

  draw.pixel(s16(0x7e), s16(0x80), COLOUR.mario, 0x80000000)
end

special_sprite_property[0xa9] = function(slot) -- Reznor
  local reznor
  local color
  for index = 0, SMW.sprite_max - 1 do -- sprite_max = 12
    reznor = u8(WRAM.sprite_misc_151c + index)
    if index >= 4 and index <= 7 then
      color = COLOUR.warning
    else
      color = color_weak
    end
    draw.text(3*BIZHAWK_FONT_WIDTH*index, draw.Buffer_height, fmt("%.2x", reznor), color, true, false, 0.0, 1.0)
  end
end

special_sprite_property[0x91] = function(slot) -- Chargin' Chuck
  if Sprites_info[slot].status ~= 0x08 then return end

  -- > spriteYLow - addr1 <= MarioYLow < spriteYLow + addr2 - addr1
  local routine_pointer = u8(WRAM.sprite_phase + slot)
  routine_pointer = floor(bit.band(routine_pointer, 0xff)/2)
  local facing_right = u8(WRAM.sprite_horizontal_direction + slot) == 0

  local x1, x2, y1, yoff, height
  local color, bg

  if routine_pointer == 0 then -- looking
    local active = bit.band(u8(WRAM.sprite_stun_timer + slot), 0x0f) == 0
    color = COLOUR.sprite_vision_passive
    bg = active and COLOUR.sprite_vision_active_bg or 0
    yoff = -0x28
    height = 0x50 - 1
    x1 = 0
    x2 = draw.Buffer_width - 1

  elseif routine_pointer == 2 then -- following
    color = COLOUR.sprite_vision_active
    bg = COLOUR.sprite_vision_active_bg
    yoff = -0x30
    height = 0x60 - 1
    x1 = Sprites_info[slot].x_screen + (facing_right and 1 or -1)
    x2 = facing_right and draw.Buffer_width - 1 or 0

  else -- inactive
    color = COLOUR.sprite_vision_passive
    bg = 0
    yoff = -0x28
    height = 0x50 - 1
    x1 = Sprites_info[slot].x_screen + (facing_right and 1 or -1)
    x2 = facing_right and draw.Buffer_width - 1 or 0
  end

  y1 = Sprites_info[slot].y_screen + yoff
  draw.box(x1, y1, x2, y1 + height, color, bg)

  y1 = y1 + 0x100 -- draw it again, 0x100 pixels below
  draw.box(x1, y1, x2, y1 + height, color, bg)
  Display.show_player_point_position = true
end

special_sprite_property[0x92] = function(slot) -- Splittin' Chuck
  if Sprites_info[slot].status ~= 0x08 then return end
  if u8(WRAM.sprite_phase + slot) ~= 5 then return end

  local xoff = -0x50
  local width = 0xa0 - 1

  local t = Sprites_info[slot]
  for i = -1, 1 do
    draw.rectangle(t.x_screen + xoff + i*0x100, -draw.Border_top, width,
      draw.Buffer_height + draw.Border_bottom, t.info_color, 0x10ffff00)
  end
  Display.show_player_point_position = true
end

special_sprite_property[0xa0] = function(slot) -- Bowser
  local height = BIZHAWK_FONT_HEIGHT
  local y_text = draw.Buffer_height - 10*height
  for index = 0, 9 do
    local value = u8(WRAM.bowser_attack_timers + index)
    draw.text(draw.Buffer_width + draw.Border_right, y_text + index*height,
      fmt("%$2X = %3d", value, value), Sprites_info[slot].info_color, true)
  end
end

special_sprite_property[0xae] = function(slot) -- Fishin' Boo
  if OPTIONS.display_sprite_hitbox then
    local x_screen = Sprites_info[slot].x_screen
    local y_screen = Sprites_info[slot].y_screen
    local direction = u8(WRAM.sprite_horizontal_direction + slot)
    local aux = u8(WRAM.sprite_misc_1602 + slot)
    local index = 2*direction + aux
    local offsets = {[0] = 0x1a, 0x14, -0x12, -0x08}
    local xoff = offsets[index]

    if not xoff then  -- possible exception
      xoff = 0
      draw.text(draw.AR_x*x_screen, draw.AR_y*(y_screen + 0x47),
        fmt("Glitched offset! dir:%.2x, aux:%.2x", direction, aux)
      )
    end

    draw.rectangle(x_screen + xoff, y_screen + 0x47, 4, 4, COLOUR.warning2, COLOUR.awkward_hitbox_bg)
  end
end


local function sprite_info(id, counter, table_position)
  draw.Text_opacity = 1.0

  local t = Sprites_info[id]
  local status = t.status
  if status == 0 then return 0 end -- returns if the slot is empty

  local x = t.x
  local y = t.y
  local x_sub = t.x_sub
  local y_sub = t.y_sub
  local number = t.number
  local stun = t.stun
  local x_speed = t.x_speed
  local y_speed = t.y_speed
  local contact_mario = t.contact_mario
  local underwater = t.underwater
  local x_offscreen = t.x_offscreen
  local y_offscreen = t.y_offscreen
  local x_screen = t.x_screen
  local y_screen = t.y_screen
  local xpt_left = t.xpt_left
  local xpt_right = t.xpt_right
  local ypt_up = t.ypt_up
  local ypt_down = t.ypt_down
  local xoff = t.hitbox_xoff
  local yoff = t.hitbox_yoff
  local sprite_width = t.hitbox_width
  local sprite_height = t.hitbox_height

  -- HUD elements
  local oscillation_flag = t.oscillation_flag
  local info_color = t.info_color
  local color_background = t.background_color

  draw_sprite_hitbox(id)

  -- Special sprites analysis:
  local fn = special_sprite_property[number]
  if fn then fn(id) end
  
  ---**********************************************
  -- Print those informations next to the sprite
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0

  if x_offscreen ~= 0 or y_offscreen ~= 0 then
    draw.Text_opacity = 0.6
  end

  local contact_str = contact_mario == 0 and "" or " " .. contact_mario

  local sprite_middle = t.sprite_middle
  local sprite_top = t.sprite_top
  if OPTIONS.display_sprite_info then
    draw.text(draw.AR_x*sprite_middle, draw.AR_y*sprite_top, fmt("#%.2d%s", id, contact_str), info_color, true, false, 0.5, 1.0)
    if Player_powerup == 2 then
      local contact_cape = u8(WRAM.sprite_disable_cape + id)
      if contact_cape ~= 0 then
        draw.text(draw.AR_x*sprite_middle, draw.AR_y*sprite_top - 2*BIZHAWK_FONT_HEIGHT, contact_cape, COLOUR.cape, true)
      end
    end
  end

  -- Sprite tweakers info
  sprite_tweaker_editor(id)

  -- The sprite table:
  if OPTIONS.display_sprite_main_table then
    local x_speed_u = u8(WRAM.sprite_x_speed + id) -- used to print a proper hex value
    local y_speed_u = u8(WRAM.sprite_y_speed + id) -- used to print a proper hex value
    local x_speed_water = ""
    if underwater ~= 0 then  -- if sprite is underwater
      local correction = floor(3*floor(x_speed/2)/2)
      x_speed_water = string.format("%+.2d=%+.2d", correction - x_speed, correction)
    end
    local sprite_str = fmt("#%02d %02X (%X %d) %04X.%1x(%s%s) %04X.%1x(%s)",
            id, number, status, stun, bit.band(x, 0xFFFF), floor(x_sub/16), luap.signed8hex(x_speed_u, true), x_speed_water, bit.band(y, 0xFFFF), floor(y_sub/16), luap.signed8hex(y_speed_u, true)) --  bit.band( , 0xFFFF) to handle negative positions

    draw.text(draw.Buffer_width + draw.Border_right, table_position + counter*BIZHAWK_FONT_HEIGHT, sprite_str, info_color, true)
  end
  
  -- Miscellaneous sprite table -- TODO
  if OPTIONS.display_misc_sprite_table then
    --[[
    -- Font
    draw.Text_opacity = 0.6
    local x_mis, y_mis = -draw.Border_left - 2*BIZHAWK_FONT_WIDTH, draw.AR_y*171 + counter*BIZHAWK_FONT_HEIGHT
    
    local miscs = {
      WRAM.sprite_phase, WRAM.sprite_misc_1504, WRAM.sprite_misc_1510, WRAM.sprite_misc_151c, WRAM.sprite_misc_1528,
      WRAM.sprite_misc_1534, WRAM.sprite_misc_1558, WRAM.sprite_blocked_status, WRAM.sprite_animation_timer,
      WRAM.sprite_misc_1594, WRAM.sprite_misc_15ac, WRAM.sprite_misc_1602, WRAM.sprite_misc_160e,
      WRAM.sprite_misc_1626, WRAM.sprite_misc_163e, WRAM.sprite_misc_187b,
    }

    local text = ""
    for i = 1, #miscs do
      text = string.format("%s   %02X", text, u8(miscs[i] + id))
    end
    
    draw.text(x_mis, y_mis, text, info_color)]]
  
    --[[

    local t = OPTIONS.miscellaneous_sprite_table_number
    local misc, text = nil, fmt("#%.2d", id)
    for num = 1, 19 do
      misc = t[num] and u8(WRAM["sprite_miscellaneous" .. num] + id) or false
      text = misc and fmt("%s %3d", text, misc) or text
    end

    draw.text(x_mis, y_mis, text, info_color)]]
  end

  return 1
end


local function sprites()
  if not OPTIONS.display_sprite_info then return end

  local counter = 0
  local table_position = draw.AR_y*48
  for id = 0, SMW.sprite_max - 1 do -- sprite_max = 12
    scan_sprite_info(Sprites_info, id)
    counter = counter + sprite_info(id, counter, table_position)
  end

  -- Font
  draw.Text_opacity = 0.6

  local swap_slot = u8(WRAM.sprite_swap_slot)
  local smh = u8(WRAM.sprite_memory_header)
  draw.text(draw.Buffer_width + draw.Border_right, table_position - 2*BIZHAWK_FONT_HEIGHT, fmt("Sprites: %d", counter), COLOUR.weak, true)
  draw.text(draw.Buffer_width + draw.Border_right, table_position - BIZHAWK_FONT_HEIGHT, fmt("1st div: %d. Swap: %d",
                                    SMW.sprite_memory_max[smh] or 0, swap_slot), COLOUR.weak, true)
end


special_sprite_property.yoshi_tongue_offset = function(xoff, tongue_length)
  if (xoff % 0x100) < 0x80 then
    xoff = xoff + tongue_length
  else
    xoff = (xoff + bit.bxor(tongue_length, 0xff) % 0x100 + 1) % 0x100
    if (xoff % 0x100) >= 0x80 then
      xoff = xoff - 0x100
    end
  end

  return xoff
end


special_sprite_property.yoshi_tongue_time_predictor = function(len, timer, wait, out, eat_id)
  local info, color
  if wait > 9 then info = wait - 9; color = COLOUR.tongue_line  -- not ready yet

  elseif out == 1 then info = 17 + wait; color = COLOUR.text  -- tongue going out

  elseif out == 2 then  -- at the max or tongue going back
    info = math.max(wait, timer) + floor((len + 7)/4) - (len ~= 0 and 1 or 0)
    color = eat_id == SMW.null_sprite_id and COLOUR.text or COLOUR.warning

  elseif out == 0 then info = 0; color = COLOUR.text  -- tongue in

  else info = timer + 1; color = COLOUR.tongue_line -- item was just spat out
  end

  return info, color
end


local function yoshi()
  if not OPTIONS.display_player_info then return end
  if not OPTIONS.display_yoshi_info then return end

  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0
  local x_text = -draw.Border_left
  local y_text = draw.AR_y*80

  local yoshi_id = get_yoshi_id()
  if yoshi_id ~= nil then
    local tongue_len = u8(WRAM.sprite_misc_151c + yoshi_id)
    local tongue_timer = u8(WRAM.sprite_misc_1558 + yoshi_id)
    local yoshi_direction = u8(WRAM.sprite_horizontal_direction + yoshi_id)
    local tongue_out = u8(WRAM.sprite_misc_1594 + yoshi_id)
    local turn_around = u8(WRAM.sprite_misc_15ac + yoshi_id)
    local tile_index = u8(WRAM.sprite_misc_1602 + yoshi_id)
    local eat_id = u8(WRAM.sprite_misc_160e + yoshi_id)
    local mount_invisibility = u8(WRAM.sprite_misc_163e + yoshi_id)
    local eat_type = u8(WRAM.sprite_number + eat_id)
    local tongue_wait = u8(WRAM.sprite_tongue_wait)
    local tongue_height = u8(WRAM.yoshi_tile_pos)
    local yoshi_in_pipe = u8(WRAM.yoshi_in_pipe)
    local wings_timer = u8(WRAM.cape_fall)
    local has_wings = u8(0x1410) == 0x02

    local eat_type_str = eat_id == SMW.null_sprite_id and "-" or string.format("%02X", eat_type)
    local eat_id_str = eat_id == SMW.null_sprite_id and "-" or string.format("#%02d", eat_id)

    -- Yoshi's direction and turn around
    local direction_symbol
    if yoshi_direction == 0 then direction_symbol = RIGHT_ARROW else direction_symbol = LEFT_ARROW end

    draw.text(x_text, y_text, fmt("Yoshi %s %d", direction_symbol, turn_around), COLOUR.yoshi)
    local h = BIZHAWK_FONT_HEIGHT

    draw.text(x_text, y_text + h, fmt("(%0s, %0s) %02X, %d, %d",
              eat_id_str, eat_type_str, tongue_len, tongue_wait, tongue_timer), COLOUR.yoshi)
    ;

    -- Wings timer (is the same as the cape)
    if has_wings then
      draw.text(x_text, y_text + 2*h, fmt("Wings: %.2d", wings_timer), COLOUR.yoshi)
    end
    
    -- more WRAM values
    local yoshi_x = 256*s8(WRAM.sprite_x_high + yoshi_id) + u8(WRAM.sprite_x_low + yoshi_id)
    local yoshi_y = 256*s8(WRAM.sprite_y_high + yoshi_id) + u8(WRAM.sprite_y_low + yoshi_id)
    local x_screen, y_screen = screen_coordinates(yoshi_x, yoshi_y, Camera_x, Camera_y)

    -- invisibility timer
    if mount_invisibility ~= 0 then
      draw.text(draw.AR_x*(x_screen + 4), draw.AR_x*(y_screen - 12), mount_invisibility, COLOUR.yoshi)
    end

    -- Tongue hitbox and timer
    if tongue_wait ~= 0 or tongue_out ~=0 or tongue_height == 0x89 then  -- if tongue is out or appearing
      -- Color
      local tongue_line
      if tongue_wait <= 9 then
        tongue_line = COLOUR.tongue_line
      else tongue_line = COLOUR.tongue_bg
      end

      -- Tongue Hitbox
      local actual_index = tile_index
      if yoshi_direction == 0 then actual_index = tile_index + 8 end
      actual_index = yoshi_in_pipe ~= 0 and u8(0x0d) or SMW.yoshi_tongue_x_offsets[actual_index] or 0

      local xoff = special_sprite_property.yoshi_tongue_offset(actual_index, tongue_len)

       -- tile_index changes midframe, according to yoshi_in_pipe address
      local yoff = yoshi_in_pipe ~= 0 and 3 or SMW.yoshi_tongue_y_offsets[tile_index] or 0
      yoff = yoff + 2
      draw.rectangle(x_screen + xoff, y_screen + yoff, 8, 4, tongue_line, COLOUR.tongue_bg)
      draw.pixel(x_screen + xoff, y_screen + yoff, COLOUR.text, COLOUR.tongue_bg) -- hitbox point vs berry tile

      -- glitched hitbox for Layer Switch Glitch
      if yoshi_in_pipe ~= 0 then
        local xoff = special_sprite_property.yoshi_tongue_offset(0x40, tongue_len) -- from ROM
        draw.rectangle(x_screen + xoff, y_screen + yoff, 8, 4, 0x80ffffff, 0x40000000)

        draw.text(x_text, y_text + 3*h, fmt("$1a: %.4x $1c: %.4x", u16(WRAM.layer1_x_mirror), u16(WRAM.layer1_y_mirror)), COLOUR.yoshi)
        draw.text(x_text, y_text + 4*h, fmt("$4d: %.4x $4f: %.4x", u16(WRAM.layer1_VRAM_left_up), u16(WRAM.layer1_VRAM_right_down)), COLOUR.yoshi)
      end

      -- tongue out: time predictor
      local info, color =
      special_sprite_property.yoshi_tongue_time_predictor(tongue_len, tongue_timer, tongue_wait, tongue_out, eat_id)
      draw.text(draw.AR_x*(x_screen + xoff + 4), draw.AR_y*(y_screen + yoff + 5), info, color, false, false, 0.5)
    end
  end
end


local function display_fadeout_timers()
  if not OPTIONS.display_counters then return end

  local end_level_timer = u8(WRAM.end_level_timer)
  if end_level_timer == 0 then return end

  -- Load
  local peace_image_timer = u8(WRAM.peace_image_timer)
  local fadeout_radius = u8(WRAM.fadeout_radius)
  local zero_subspeed = u8(WRAM.x_subspeed) == 0

  -- Display
  local height = BIZHAWK_FONT_HEIGHT
  local x, y = 0, draw.Buffer_height*draw.AR_y - 3*height -- 3 max lines
  local text = 2*end_level_timer + (Real_frame)%2
  draw.text(x, y, fmt("End timer: %d(%d) -> real frame", text, end_level_timer), COLOUR.text)
  y = y + height
  draw.text(x, y, fmt("Peace %d, Fadeout %d/60", peace_image_timer, 60 - floor(fadeout_radius/4)), COLOUR.text)
  if end_level_timer >= 0x28 then
    if (zero_subspeed and Real_frame%2 == 0) or (not zero_subspeed and Real_frame%2 ~= 0) then
      y = y + height
      draw.text(x, y, "Bad subspeed?", COLOUR.warning)
    end
  end
end


local function show_counters()
  if not OPTIONS.display_counters then return end

  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0
  local height = BIZHAWK_FONT_HEIGHT
  local text_counter = 0

  local pipe_entrance_timer = u8(WRAM.pipe_entrance_timer)
  local multicoin_block_timer = u8(WRAM.multicoin_block_timer)
  local gray_pow_timer = u8(WRAM.gray_pow_timer)
  local blue_pow_timer = u8(WRAM.blue_pow_timer)
  local dircoin_timer = u8(WRAM.dircoin_timer)
  local pballoon_timer = u8(WRAM.pballoon_timer)
  local star_timer = u8(WRAM.star_timer)
  local invisibility_timer = u8(WRAM.invisibility_timer)
  local animation_timer = u8(WRAM.animation_timer)
  local fireflower_timer = u8(WRAM.fireflower_timer)
  local yoshi_timer = u8(WRAM.yoshi_timer)
  local swallow_timer = u8(WRAM.swallow_timer)
  local lakitu_timer = u8(WRAM.lakitu_timer)
  local score_incrementing = u8(WRAM.score_incrementing)
  local pause_timer = u8(WRAM.pause_timer)
  local bonus_timer = u8(WRAM.bonus_timer)
  local disappearing_sprites_timer = u8(WRAM.disappearing_sprites_timer)
  local message_box_timer = floor(u8(WRAM.message_box_timer)/4)
  local game_intro_timer = u8(WRAM.game_intro_timer)
  local scroll_timer = u8(WRAM.camera_scroll_timer)
  
  local display_counter = function(label, value, default, mult, frame, color)
    if value == default then return end
    text_counter = text_counter + 1
    local color = color or COLOUR.text

    draw.text(- draw.Border_left, draw.AR_y*108 + (text_counter * height), fmt("%s: %d", label, (value * mult) - frame), color)
  end

  if Player_animation_trigger == 5 or Player_animation_trigger == 6 then
    display_counter("Pipe", pipe_entrance_timer, -1, 1, 0, COLOUR.counter_pipe)
  end
  display_counter("Multi Coin", multicoin_block_timer, 0, 1, 0, COLOUR.counter_multicoin)
  display_counter("Pow", gray_pow_timer, 0, 4, Effective_frame % 4, COLOUR.counter_gray_pow)
  display_counter("Pow", blue_pow_timer, 0, 4, Effective_frame % 4, COLOUR.counter_blue_pow)
  display_counter("Dir Coin", dircoin_timer, 0, 4, Real_frame % 4, COLOUR.counter_dircoin)
  display_counter("P-Balloon", pballoon_timer, 0, 4, Real_frame % 4, COLOUR.counter_pballoon)
  display_counter("Star", star_timer, 0, 4, (Effective_frame - 1) % 4, COLOUR.counter_star)
  display_counter("Invisibility", invisibility_timer, 0, 1, 0)
  display_counter("Fireflower", fireflower_timer, 0, 1, 0, COLOUR.counter_fireflower)
  display_counter("Yoshi", yoshi_timer, 0, 1, 0, COLOUR.yoshi)
  display_counter("Swallow", swallow_timer, 0, 4, (Effective_frame - 1) % 4, COLOUR.yoshi)
  display_counter("Lakitu", lakitu_timer, 0, 4, Effective_frame % 4)
  display_counter("Score incrementing", score_incrementing, 0x50, 1, 0)
  display_counter("Pause", pause_timer, 0, 1, 0)  -- new  -- level
  display_counter("Bonus", bonus_timer, 0, 1, 0)
  display_counter("Message", message_box_timer, 0, 1, 0) -- level and overworld
  display_counter("Intro", game_intro_timer, 0, 4, Real_frame % 4)  -- TODO: check whether it appears only during the intro level
  display_counter("Camera scroll", 16 - scroll_timer, 16, 1, 0, COLOUR.warning)

  display_fadeout_timers()

  if Lock_animation_flag ~= 0 then display_counter("Animation", animation_timer, 0, 1, 0) end  -- shows when player is getting hurt or dying

end


-- Main function to run inside a level
local function level_mode()
  if SMW.game_mode_fade_to_level <= Game_mode and Game_mode <= SMW.game_mode_level then

    -- Draws/Erases the tiles if user clicked
    draw_layer1_tiles(Camera_x, Camera_y)

    draw_layer2_tiles()

    level_info()

    sprites()
    
    draw_sprite_spawn_despawn()

    extended_sprites()

    cluster_sprites()

    minor_extended_sprites()

    bounce_sprite_info()

    quake_sprite_info()

    player()

    yoshi()

    show_counters()

    predict_block_duplications()

    -- Draws/Erases the hitbox for objects
    if User_input.mouse_inwindow then
      select_object(User_input.xmouse, User_input.ymouse, Camera_x, Camera_y)
    end

  end
end


local function overworld_mode()
  if Game_mode ~= SMW.game_mode_overworld then return end
  if not OPTIONS.display_overworld_info then return end

  -- Font
  draw.Text_opacity = 1.0
  draw.Bg_opacity = 1.0

  local height = BIZHAWK_FONT_HEIGHT
  local y_text = BIZHAWK_FONT_HEIGHT

  -- OW camera (Note: the script uses $7E1462 and $7E1464 (layer 1 position next frame) for Camera_x and Camera_y, but the OW doesn't use these addresses)
  local OW_camera_x = s16(WRAM.layer1_x_mirror)
  local OW_camera_y = s16(WRAM.layer1_y_mirror)
  
  -- Real frame modulo 8
  local real_frame_8 = Real_frame%8
  draw.text(draw.Buffer_width + draw.Border_right, y_text, fmt("Real Frame = %02X = %d(mod 8)", Real_frame, real_frame_8), true)
  y_text = y_text + height
  
  -- Star Road info
  local star_speed = u8(WRAM.star_road_speed)
  local star_timer = u8(WRAM.star_road_timer)
  draw.text(draw.Buffer_width + draw.Border_right, y_text, fmt("Star Road(%x %x)", star_speed, star_timer), COLOUR.cape, true)

  -- Player's position
  local offset = 0
  if Current_character == "Luigi" then offset = 4 end

  local OW_x = s16(WRAM.OW_x + offset)
  local OW_y = s16(WRAM.OW_y + offset)
  draw.text(-draw.Border_left, y_text, fmt("Pos(%04X, %04X)", OW_x, OW_y), true)
  y_text = y_text + 2*height

  -- Exit counter (events tiggered)
  local exit_counter = u8(WRAM.exit_counter)
  draw.text(-draw.Border_left, y_text, fmt("Exits: %d", exit_counter), true)
  y_text = y_text + 2*height

  -- Beaten exits table
  for byte_off = 0, 14 do
    local event_flags = u8(WRAM.event_flags + byte_off)

    draw.text(-draw.Border_left, y_text + byte_off*BIZHAWK_FONT_HEIGHT*1.5, fmt("%02X %02X %02X %02X %02X %02X %02X %02X ",
      8*byte_off + 0, 8*byte_off + 1, 8*byte_off + 2, 8*byte_off + 3, 8*byte_off + 4, 8*byte_off + 5, 8*byte_off + 6, 8*byte_off + 7), COLOUR.disabled)
    
    local triggered_str = ""
    for i = 0, 7 do
      if bit.test(event_flags, i) then
        triggered_str = triggered_str .. fmt("%02X ", 8*byte_off + i)
      else
        triggered_str = triggered_str .. "   "
      end
    end
    draw.text(-draw.Border_left, y_text + byte_off*BIZHAWK_FONT_HEIGHT*1.5, triggered_str, COLOUR.yoshi)
  end

  -- Level tiles info
  draw.Text_opacity = 0.7
  local level_x, level_y
  local x_origin, y_origin = screen_coordinates(0, 0, OW_camera_x, OW_camera_y)
  local offset
  local parity256
  
  local is_submap = u8(WRAM.current_submap + u8(WRAM.current_character)) > 0
  
  for i = 0, 0x400 - 1 do
    local address = WRAM.OW_tile_translevel + (is_submap and 0x400 or 0)
    local level = u8(address + i)
    
    if level ~= 0 then -- is a valid level
      
      parity256 = (floor(i/0x100))%2
      
      -- Level coordinates relative to the camera, due x/y_origin
      level_x = x_origin + 16*(i%0x10 + parity256*0x10)
      level_y = y_origin + 16*(floor(i/0x10)%0x10 + (floor(i/0x200)%0x200)*0x10)      
      
      -- Submap correction
      if floor(i/0x100) >= 4 then -- is a submap
        level_y = level_y - 0x200
      end
      
      -- Draw only if inside the game screen
      if luap.inside_rectangle(level_x, level_y, 0, 0, 256 - 16, 224 - 16) then
        draw.rectangle(level_x, level_y, 15, 15, COLOUR.block, 0)
        draw.text(level_x*draw.AR_x, level_y*draw.AR_y - BIZHAWK_FONT_HEIGHT, fmt("%03X", level + (is_submap and 0xDC or 0)), COLOUR.text)
      end
    end
  end  
  
  --[[
  
  for i = 0, 0x800 - 1 do
    
    if u8(0xD000 + i) ~= 0 then -- is a level -- TODO: unlisted ram
      
      parity256 = (floor(i/0x100))%2
      
      level_x = x_origin + 16*(i%0x10 + parity256*0x10)
      level_y = y_origin + 16*(floor(i/0x10)%0x10 + (floor(i/0x200)%0x200)*0x10)      
      
      if floor(i/0x100) >= 4 then -- is a submap
        level_y = level_y - 0x200
      end
      
      draw.rectangle(level_x, level_y, 15, 15, COLOUR.block, 0)
      draw.text(level_x*draw.AR_x, level_y*draw.AR_y - 10, fmt("%03X", u8(0xD000 + i)), COLOUR.text, 0)
    end
  end
  
  ]]
  
end

-- layer 1 tiles = 0xC800 ---------------------------------------------------------
-- tile translevels = 0xD000
--[[
local tile_table = {}
tile_table[0] = {}
tile_table[1] = {}
local parity

for i = 0, 0x800 - 1 do
  parity = (floor(i/0x100))%2
  
  table.insert(tile_table[parity], fmt("%02X ", u8(0xD000 + i)))
end


local str = ""
for i = 1, 0x40 do

  str = ""
  
  for j = 1, 0x10 do
    
    str = str .. tile_table[0][(i-1)*0x10 + j]
    
  end
  
  print(str)
  
  if i%16 == 0 then print(" ") end
end
]]
--------------------------


local function left_click()
  -- Call options menu if the form is closed
  if Options_form.is_form_closed and mouse_onregion(0, 0, 0 + 14*BIZHAWK_FONT_WIDTH, 0 + 2*BIZHAWK_FONT_HEIGHT - 1) then -- bizhawk
    Options_form.create_window()
    return
  end

  -- Drag and drop sprites
  if Cheat.allow_cheats then
    local id = select_object(User_input.xmouse, User_input.ymouse, Camera_x, Camera_y)
    if type(id) == "number" and id >= 0 and id < SMW.sprite_max then -- sprite_max = 12
      Cheat.dragging_sprite_id = id
      Cheat.is_dragging_sprite = true
      return
    end
  end

  -- Layer 1 tiles
  local x_mouse, y_mouse = game_coordinates(User_input.xmouse, User_input.ymouse, Camera_x, Camera_y)
  x_mouse = 16*floor(x_mouse/16)
  y_mouse = 16*floor(y_mouse/16)
  if User_input.mouse_inwindow then
    select_tile(x_mouse, y_mouse, Layer1_tiles)
  end
end


-- This function runs at the end of paint callback
-- Specific for info that changes if the emulator is paused and idle callback is called
local function mouse_actions()
  -- Font
  draw.Text_opacity = 1.0

  -- Drag and drop sprites with the mouse
  if Cheat.is_dragging_sprite then
    Cheat.drag_sprite(Cheat.dragging_sprite_id)
    Cheat.is_cheating = true
  end

end


local function read_raw_input()
  -- User input data
  Previous.User_input = luap.copytable(User_input)
  local tmp = input.get()
  for entry, value in pairs(User_input) do
    User_input[entry] = tmp[entry] or false
  end
  -- Mouse input
  tmp = input.getmouse()
  User_input.xmouse = tmp.X
  User_input.ymouse = tmp.Y
  User_input.leftclick = tmp.Left
  User_input.rightclick = tmp.Right
  -- BizHawk, custom field
  User_input.mouse_inwindow = mouse_onregion(-draw.Border_left, -draw.Border_top, draw.Buffer_width + draw.Border_right, draw.Buffer_height + draw.Border_bottom)

  -- Detect if a key was just pressed or released
  for entry, value in pairs(User_input) do
    if (value ~= false) and (Previous.User_input[entry] == false) then Keys.pressed[entry] = true
      else Keys.pressed[entry] = false
    end
    if (value == false) and (Previous.User_input[entry] ~= false) then Keys.released[entry] = true
      else Keys.released[entry] = false
    end
  end

  -- Key presses/releases execution:
  for entry, value in pairs(Keys.press) do
    if Keys.pressed[entry] then
      value()
    end
  end
  for entry, value in pairs(Keys.release) do
    if Keys.released[entry] then
      value()
    end
  end

end



--#############################################################################
-- CHEATS

-- This signals that some cheat is activated, or was some short time ago
Cheat.allow_cheats = false
Cheat.is_cheating = false
function Cheat.is_cheat_active()
  if Cheat.is_cheating then
    draw.Text_opacity = 1.0
    draw.Bg_opacity = 1.0
    
    local cheat_str = " CHEAT "
    if Cheat.under_free_move then cheat_str = cheat_str .. "- Free movement" end
    
    draw.alert_text(draw.Buffer_middle_x*draw.AR_x, -2, cheat_str, COLOUR.warning, COLOUR.warning_bg, false, 0.5, 1.0)
    Previous.is_cheating = true
  else
    if Previous.is_cheating then
      gui.addmessage("Script applied cheat") -- BizHawk
      Previous.is_cheating = false
    end
  end
  
  -- Warning
  if Cheat.allow_cheats then
    gui.drawText(OPTIONS.left_gap + draw.Buffer_middle_x - 56, OPTIONS.top_gap + draw.Buffer_height, "Cheats allowed!", COLOUR.warning, 0xA00040FF) --draw.Border_bottom
    if Movie_active then
      gui.drawText(OPTIONS.left_gap + draw.Buffer_middle_x - 124, OPTIONS.top_gap + draw.Buffer_height + 20, "Disable it while recording movies", COLOUR.warning, 0xA00040FF)
    end
  end
end


-- Called from Cheat.beat_level()
function Cheat.activate_next_level(secret_exit)
  if u8(WRAM.level_exit_type) == 0x80 and u8(WRAM.midway_point) == 1 then
    if secret_exit then
      w8(WRAM.level_exit_type, 0x2)
    else
      w8(WRAM.level_exit_type, 1)
    end
  end

  Cheat.is_cheating = true
end


-- allows start + select + X to activate the normal exit
--      start + select + A to activate the secret exit
--      start + select + B to exit the level without activating any exits
function Cheat.beat_level()
  if Is_paused and Joypad["Select"] and (Joypad["X"] or Joypad["A"] or Joypad["B"]) then
    w8(WRAM.level_flag_table + Translevel_index, bit.bor(Level_flag, 0x80))

    local secret_exit = Joypad["A"]
    if not Joypad["B"] then
      w8(WRAM.midway_point, 1)
    else
      w8(WRAM.midway_point, 0)
    end

    Cheat.activate_next_level(secret_exit)
  end
end


-- This function makes Mario's position free
-- Press L+R+up to activate and L+R+down to turn it off.
-- While active, press directionals to fly free and Y or X to boost him up
Cheat.under_free_move = false
function Cheat.free_movement()
  -- Check cheat controller command
  if (Joypad["L"] and Joypad["R"] and Joypad["Up"]) then Cheat.under_free_move = true end
  if (Joypad["L"] and Joypad["R"] and Joypad["Down"]) then Cheat.under_free_move = false end
  
  -- Make sure to check/uncheck the cheat option in the Menu
  if not Options_form.is_form_closed then
    forms.setproperty(Options_form.free_movement, "Checked", Cheat.under_free_move)
  end
  
  if not Cheat.under_free_move then
    if Previous.under_free_move then w8(WRAM.frozen, 0) end
    return
  end

  -- For levels
  if Game_mode == SMW.game_mode_level then
  
    -- Get position and "speed"
    local x_pos, y_pos = u16(WRAM.x), u16(WRAM.y)
    local movement_mode = u8(WRAM.player_animation_trigger)
    local pixels = (Joypad["Y"] and 7) or (Joypad["X"] and 4) or 1  -- how many pixels per frame

    -- Interpret the movement
    if Joypad["Left"] then x_pos = x_pos - pixels end
    if Joypad["Right"] then x_pos = x_pos + pixels end
    if Joypad["Up"] then y_pos = y_pos - pixels end
    if Joypad["Down"] then y_pos = y_pos + pixels end

    -- Freeze player to avoid deaths
    if movement_mode == 0 then
      w8(WRAM.frozen, 1)
      w8(WRAM.x_speed, 0)
      w8(WRAM.y_speed, 0)

      -- animate sprites by incrementing the effective frame
      w8(WRAM.effective_frame, (u8(WRAM.effective_frame) + 1) % 256)
    else
      w8(WRAM.frozen, 0)
    end

    -- Store the values
    w16(WRAM.x, x_pos)
    w16(WRAM.y, y_pos)
    w8(WRAM.invisibility_timer, 127)
    w8(WRAM.vertical_scroll_flag_header, 1)  -- free vertical scrolling
    w8(WRAM.vertical_scroll_enabled, 1)
  
  -- For the overworld
  elseif Game_mode == SMW.game_mode_overworld then
    
    -- Get character offset
    local offset = 0
    if Current_character == "Luigi" then offset = 4 end
    
    -- Get position and "speed"
    local x_pos, y_pos = u16(WRAM.OW_x + offset), u16(WRAM.OW_y + offset)
    local pixels = 16 -- how many pixels per frame

    -- Interpret the movement
    if Joypad["Left"] then x_pos = x_pos - pixels end
    if Joypad["Right"] then x_pos = x_pos + pixels end
    if Joypad["Up"] then y_pos = y_pos - pixels end
    if Joypad["Down"] then y_pos = y_pos + pixels end
    
    -- Prevent normal level walking
    w8(WRAM.OW_action_pointer, 3) -- #$03 = Standing still on a level tile
    
    -- Store the values
    --if u16(WRAM.OW_x + offset) ~= x_pos
    if Effective_frame % 4 == 0 then
      w16(WRAM.OW_x + offset, x_pos)
      w16(WRAM.OW_y + offset, y_pos)
    end
    
  end
  
  Cheat.is_cheating = true
  Previous.under_free_move = true
end


-- Drag and drop sprites with the mouse, if the cheats are activated and mouse is over the sprite
-- Right clicking and holding: drags the sprite
-- Releasing: drops it over the latest spot
function Cheat.drag_sprite(id)
  if Game_mode ~= SMW.game_mode_level then Cheat.is_dragging_sprite = false ; return end

  local xoff, yoff = Sprites_info[id].hitbox_xoff, Sprites_info[id].hitbox_yoff
  local xgame, ygame = game_coordinates(User_input.xmouse - xoff, User_input.ymouse - yoff, Camera_x, Camera_y)

  local sprite_xhigh = floor(xgame/256)
  local sprite_xlow = xgame - 256*sprite_xhigh
  local sprite_yhigh = floor(ygame/256)
  local sprite_ylow = ygame - 256*sprite_yhigh

  w8(WRAM.sprite_x_high + id, sprite_xhigh)
  w8(WRAM.sprite_x_low + id, sprite_xlow)
  w8(WRAM.sprite_y_high + id, sprite_yhigh)
  w8(WRAM.sprite_y_low + id, sprite_ylow)
end


function Cheat.score()
  if not Cheat.allow_cheats then
    print("Cheats not allowed.")
    return
  end

  local num = forms.gettext(Options_form.score_number)
  local is_hex = num:sub(1,2):lower() == "0x"
  num = tonumber(num)

  if not num or num%1 ~= 0 or num < 0
  or num > 9999990 or (not is_hex and num%10 ~= 0) then
    print("Enter a valid score: hexadecimal representation or decimal ending in 0.")
    return
  end

  num = is_hex and num or num/10
  w24(WRAM.mario_score, num)

  print(fmt("Cheat: score set to %d0.", num))
  Cheat.is_cheating = true
end


function Cheat.timer()
  if not Cheat.allow_cheats then
    print("Cheats not allowed.")
    return
  end

  local num = tonumber(forms.gettext(Options_form.timer_number))

  if not num or num > 999 then
    print("Enter a valid integer (0-999).")
    return
  end

  w16(WRAM.timer, 0)
  if num >= 0 then w8(WRAM.timer + 2, luap.read_digit(num, 1, 10, "right to left")) end
  if num > 9  then w8(WRAM.timer + 1, luap.read_digit(num, 2, 10, "right to left")) end
  if num > 99 then w8(WRAM.timer + 0, luap.read_digit(num, 3, 10, "right to left")) end

  print(fmt("Cheat: timer set to %03d", num))
  Cheat.is_cheating = true
end


-- BizHawk: modifies address <address> value from <current> to <current + modification>
-- [size] is the optional size in bytes of the address
-- TODO: [is_signed] is untrue if the value is unsigned, true otherwise
function Cheat.change_address(address, value_form, size, is_hex, criterion, error_message, success_message)
  if not Cheat.allow_cheats then
    print("Cheats not allowed.")
    return
  end

  size = size or 1
  local max_value = 256^size - 1
  local value = Options_form[value_form] and forms.gettext(Options_form[value_form]) or value_form
  local default_criterion = function(value)
    if type(value) == "string" then
      local number = string.match(value, is_hex and "%x+" or "%d+")
      if not number then return false end

      value = tonumber(number, is_hex and 16 or 10) -- take first number of the string
    else
      value = tonumber(value, is_hex and 16 or 10)
    end

    if not value or value%1 ~= 0 or value < 0 or value > max_value then
      return false
    else
      return value
    end
  end

  local new = default_criterion(value)
  if criterion and new then
    new = criterion(new) and new or false
  end
  if not new then
    print(error_message or "Enter a valid value.")
    return
  end

  local memoryf = (size == 1 and w8) or (size == 2 and w16) or (size == 3 and w24) or error"size is too big"
  memoryf(address, new)
  print(fmt("Cheat: %s set to %d.", success_message, new) or fmt("Cheat: set WRAM 0x%X to %d.", address, new))
  Cheat.is_cheating = true
end


--#############################################################################
-- MAIN --


-- Key presses:
Keys.registerkeypress("rightclick", right_click)
Keys.registerkeypress("leftclick", left_click)

-- Key releases:
Keys.registerkeyrelease("mouse_inwindow", function() Cheat.is_dragging_sprite = false end)
Keys.registerkeyrelease("leftclick", function() Cheat.is_dragging_sprite = false end)

-- Lateral gaps:
if biz.features.support_extra_padding then
  client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  client.SetClientExtraPadding(0, 0, 0, 0)
end

-- Script menu forms
function Options_form.create_window()

  -- Create form
  local form_width, form_height = 512, 692
  Options_form.form = forms.newform(form_width, form_height, "SMW Script Options")
  
  local xform, yform, delta_x, delta_y = 200, 4, 120, 20
  
  --- SHOW/HIDE ---
  
  forms.label(Options_form.form, "Show/hide options", xform, yform, 96, 20)
  xform = 4
  forms.label(Options_form.form, "------------------------------------------------------------------------------------------------------------------------------------------------------------------", xform - 2, yform, form_width, 20)
  
  yform = yform + 1.5*delta_y
  local y_section = yform
  local y_bigger = yform
  
  -- Player info
  Options_form.player_info = forms.checkbox(Options_form.form, "Player", xform + 20, yform)
  forms.setproperty(Options_form.player_info, "Checked", OPTIONS.display_player_info)
  forms.setproperty(Options_form.player_info, "Width", 55)
  forms.setproperty(Options_form.player_info, "TextAlign", "TopRight")
  forms.setproperty(Options_form.player_info, "CheckAlign", "TopRight")

  yform = yform + delta_y
  Options_form.player_main_info = forms.checkbox(Options_form.form, "Main info", xform, yform)
  forms.setproperty(Options_form.player_main_info, "Checked", OPTIONS.display_player_main_info)
  forms.setproperty(Options_form.player_main_info, "Enabled", OPTIONS.display_player_info)
  
  yform = yform + delta_y
  Options_form.yoshi_info = forms.checkbox(Options_form.form, "Yoshi info", xform, yform)
  forms.setproperty(Options_form.yoshi_info, "Checked", OPTIONS.display_yoshi_info)
  forms.setproperty(Options_form.yoshi_info, "Enabled", OPTIONS.display_player_info)

  yform = yform + delta_y
  Options_form.player_interaction_label = forms.label(Options_form.form, "Interaction:", xform, yform + 4, 60, 15)
  forms.setproperty(Options_form.player_interaction_label, "Enabled", OPTIONS.display_player_info)
  yform = yform + delta_y
  Options_form.player_hitbox = forms.dropdown(Options_form.form, {"1. Hitbox + Blocks", "2. Hitbox", "3. Blocks", "4. None"}, xform, yform - 1, 110, 20)
  forms.setproperty(Options_form.player_hitbox, "Enabled", OPTIONS.display_player_info)

  yform = yform + delta_y
  Options_form.static_camera_region = forms.checkbox(Options_form.form, "Camera region", xform, yform)
  forms.setproperty(Options_form.static_camera_region, "Checked", OPTIONS.display_static_camera_region)
  forms.setproperty(Options_form.static_camera_region, "Enabled", OPTIONS.display_player_info)
  
  yform = yform  + delta_y
  Options_form.debug_player_extra = forms.checkbox(Options_form.form, "Extra info", xform, yform)
  forms.setproperty(Options_form.debug_player_extra, "Checked", OPTIONS.display_debug_player_extra)
  forms.setproperty(Options_form.debug_player_extra, "Enabled", OPTIONS.display_player_info)
  
  forms.addclick(Options_form.player_info, function() -- to enable/disable child options on click
    OPTIONS.display_player_info = forms.ischecked(Options_form.player_info) or false
    
    forms.setproperty(Options_form.player_main_info, "Enabled", OPTIONS.display_player_info)
    forms.setproperty(Options_form.yoshi_info, "Enabled", OPTIONS.display_player_info)
    forms.setproperty(Options_form.player_interaction_label, "Enabled", OPTIONS.display_player_info)
    forms.setproperty(Options_form.player_hitbox, "Enabled", OPTIONS.display_player_info)
    forms.setproperty(Options_form.static_camera_region, "Enabled", OPTIONS.display_player_info)
    forms.setproperty(Options_form.debug_player_extra, "Enabled", OPTIONS.display_player_info)
  end)
  
  if yform > y_bigger then y_bigger = yform end
  
  -- Level info
  yform = yform + 2*delta_y
  Options_form.level_info = forms.checkbox(Options_form.form, "Level", xform + 20, yform)
  forms.setproperty(Options_form.level_info, "Checked", OPTIONS.display_level_info)
  forms.setproperty(Options_form.level_info, "Width", 55)
  forms.setproperty(Options_form.level_info, "TextAlign", "TopRight")
  forms.setproperty(Options_form.level_info, "CheckAlign", "TopRight")

  yform = yform + delta_y
  Options_form.level_main_info = forms.checkbox(Options_form.form, "Main info", xform, yform)
  forms.setproperty(Options_form.level_main_info, "Checked", OPTIONS.display_level_main_info)
  forms.setproperty(Options_form.level_main_info, "Enabled", OPTIONS.display_level_info)

  yform = yform + delta_y
  Options_form.level_boundary = forms.checkbox(Options_form.form, "Boundaries", xform, yform)
  forms.setproperty(Options_form.level_boundary, "Checked", OPTIONS.display_level_boundary)
  forms.setproperty(Options_form.level_boundary, "Enabled", OPTIONS.display_level_info)

  yform = yform + delta_y
  Options_form.sprite_data = forms.checkbox(Options_form.form, "Sprite data", xform, yform)
  forms.setproperty(Options_form.sprite_data, "Checked", OPTIONS.display_sprite_data)
  forms.setproperty(Options_form.sprite_data, "Enabled", OPTIONS.display_level_info)

  yform = yform + delta_y
  Options_form.sprite_load_status = forms.checkbox(Options_form.form, "Sprite load status", xform, yform)
  forms.setproperty(Options_form.sprite_load_status, "Checked", OPTIONS.display_sprite_load_status)
  forms.setproperty(Options_form.sprite_load_status, "Width", 110)
  forms.setproperty(Options_form.sprite_load_status, "Enabled", OPTIONS.display_level_info)

  yform = yform + delta_y
  Options_form.screen_info = forms.checkbox(Options_form.form, "Screen info", xform, yform)
  forms.setproperty(Options_form.screen_info, "Checked", OPTIONS.display_screen_info)
  forms.setproperty(Options_form.screen_info, "Enabled", OPTIONS.display_level_info)
  
  forms.addclick(Options_form.level_info, function() -- to enable/disable child options on click
    OPTIONS.display_level_info = forms.ischecked(Options_form.level_info) or false
    
    forms.setproperty(Options_form.level_main_info, "Enabled", OPTIONS.display_level_info)
    forms.setproperty(Options_form.level_boundary, "Enabled", OPTIONS.display_level_info)
    forms.setproperty(Options_form.sprite_data, "Enabled", OPTIONS.display_level_info)
    forms.setproperty(Options_form.sprite_load_status, "Enabled", OPTIONS.display_level_info)
    forms.setproperty(Options_form.screen_info, "Enabled", OPTIONS.display_level_info)
  end)
  
  if yform > y_bigger then y_bigger = yform end
  
  -- Sprite info
  xform, yform = xform + delta_x, y_section
  Options_form.sprite_info = forms.checkbox(Options_form.form, "Sprites", xform + 20, yform)
  forms.setproperty(Options_form.sprite_info, "Checked", OPTIONS.display_sprite_info)
  forms.setproperty(Options_form.sprite_info, "Width", 60)
  forms.setproperty(Options_form.sprite_info, "TextAlign", "TopRight")
  forms.setproperty(Options_form.sprite_info, "CheckAlign", "TopRight")

  yform = yform + delta_y
  Options_form.sprite_main_table = forms.checkbox(Options_form.form, "Main table", xform, yform)
  forms.setproperty(Options_form.sprite_main_table, "Checked", OPTIONS.display_sprite_main_table)
  forms.setproperty(Options_form.sprite_main_table, "Enabled", OPTIONS.display_sprite_info)

  yform = yform + delta_y
  Options_form.sprite_hitbox = forms.checkbox(Options_form.form, "Hitbox", xform, yform)
  forms.setproperty(Options_form.sprite_hitbox, "Checked", OPTIONS.display_sprite_hitbox)
  forms.setproperty(Options_form.sprite_hitbox, "Enabled", OPTIONS.display_sprite_info)
  
  yform = yform + 1.2*delta_y
  Options_form.sprite_vs_sprite_hitbox = forms.checkbox(Options_form.form, "Sprite vs sprite\nhitbox", xform, yform)
  forms.setproperty(Options_form.sprite_vs_sprite_hitbox, "Checked", OPTIONS.display_sprite_vs_sprite_hitbox)
  forms.setproperty(Options_form.sprite_vs_sprite_hitbox, "Enabled", OPTIONS.display_sprite_info)
  forms.setproperty(Options_form.sprite_vs_sprite_hitbox, "AutoSize", true)
  
  yform = yform + 1.4*delta_y
  Options_form.sprite_spawning_areas = forms.checkbox(Options_form.form, "Spawning areas", xform, yform)
  forms.setproperty(Options_form.sprite_spawning_areas, "Checked", OPTIONS.display_sprite_spawning_areas)
  forms.setproperty(Options_form.sprite_spawning_areas, "Enabled", OPTIONS.display_sprite_info)

  yform = yform + delta_y
  Options_form.sprite_vanish_area = forms.checkbox(Options_form.form, "Pit line", xform, yform)
  forms.setproperty(Options_form.sprite_vanish_area, "Checked", OPTIONS.display_sprite_vanish_area)
  forms.setproperty(Options_form.sprite_vanish_area, "Enabled", OPTIONS.display_sprite_info)

  yform = yform + delta_y
  Options_form.sprite_tables_button = forms.button(Options_form.form, "Sprite tables", Sprite_tables_form.create_window, xform, yform + 3)
  forms.setproperty(Options_form.sprite_tables_button, "Enabled", OPTIONS.display_sprite_info)

  yform = yform + 1.3*delta_y
  Options_form.debug_sprite_tweakers = forms.checkbox(Options_form.form, "Tweakers", xform, yform)
  forms.setproperty(Options_form.debug_sprite_tweakers, "Checked", OPTIONS.display_debug_sprite_tweakers)
  forms.setproperty(Options_form.debug_sprite_tweakers, "Enabled", OPTIONS.display_sprite_info)

  yform = yform + delta_y
  Options_form.debug_sprite_extra = forms.checkbox(Options_form.form, "Extra info", xform, yform)
  forms.setproperty(Options_form.debug_sprite_extra, "Checked", OPTIONS.display_debug_sprite_extra)
  forms.setproperty(Options_form.debug_sprite_extra, "Enabled", OPTIONS.display_sprite_info)
  
  forms.addclick(Options_form.sprite_info, function() -- to enable/disable child options on click
    OPTIONS.display_sprite_info = forms.ischecked(Options_form.sprite_info) or false
    
    forms.setproperty(Options_form.sprite_main_table, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.sprite_hitbox, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.sprite_vs_sprite_hitbox, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.sprite_spawning_areas, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.sprite_vanish_area, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.sprite_tables_button, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.debug_sprite_tweakers, "Enabled", OPTIONS.display_sprite_info)
    forms.setproperty(Options_form.debug_sprite_extra, "Enabled", OPTIONS.display_sprite_info)
  end)
  
  if yform > y_bigger then y_bigger = yform end
  
  -- General info
  xform, yform = xform + delta_x, y_section
  forms.label(Options_form.form, "General", xform + 52 - 45/2, yform, 45, 20)

  yform = yform + delta_y
  Options_form.game_info = forms.checkbox(Options_form.form, "Game info", xform, yform)
  forms.setproperty(Options_form.game_info, "Checked", OPTIONS.display_game_info)

  yform = yform + delta_y
  Options_form.movie_info = forms.checkbox(Options_form.form, "Movie info", xform, yform)
  forms.setproperty(Options_form.movie_info, "Checked", OPTIONS.display_movie_info)
  
  yform = yform + delta_y
  Options_form.counters_info = forms.checkbox(Options_form.form, "Counters/Timers", xform, yform)
  forms.setproperty(Options_form.counters_info, "Checked", OPTIONS.display_counters)

  yform = yform + delta_y
  Options_form.overworld_info = forms.checkbox(Options_form.form, "Overworld info", xform, yform)
  forms.setproperty(Options_form.overworld_info, "Checked", OPTIONS.display_overworld_info)

  yform = yform + delta_y
  Options_form.block_duplication_predictor = forms.checkbox(Options_form.form, "Block duplication", xform, yform)
  forms.setproperty(Options_form.block_duplication_predictor, "Checked", OPTIONS.use_block_duplication_predictor)
  forms.setproperty(Options_form.block_duplication_predictor, "Width", 110)

  yform = yform + delta_y
  Options_form.RNG_info = forms.checkbox(Options_form.form, "RNG predictor", xform, yform)
  forms.setproperty(Options_form.RNG_info, "Checked", OPTIONS.display_RNG_info)

  yform = yform + delta_y
  Options_form.controller_data = forms.checkbox(Options_form.form, "Controller data", xform, yform)
  forms.setproperty(Options_form.controller_data, "Checked", OPTIONS.display_controller_data)

  yform = yform + delta_y
  Options_form.lagmeter = forms.checkbox(Options_form.form, "Lagmeter", xform, yform)
  forms.setproperty(Options_form.lagmeter, "Checked", OPTIONS.display_lagmeter)

  if yform > y_bigger then y_bigger = yform end
  
  -- Other sprites info
  xform, yform = xform + delta_x, y_section
  Options_form.other_sprites_info = forms.checkbox(Options_form.form, "Other sprites", xform + 52 - 85/2, yform)
  forms.setproperty(Options_form.other_sprites_info, "Checked", OPTIONS.display_other_sprites_info)
  forms.setproperty(Options_form.other_sprites_info, "Width", 85)
  forms.setproperty(Options_form.other_sprites_info, "TextAlign", "TopRight")
  forms.setproperty(Options_form.other_sprites_info, "CheckAlign", "TopRight")
  
  yform = yform + delta_y
  Options_form.extended_sprite_info = forms.checkbox(Options_form.form, "Extended", xform, yform)
  forms.setproperty(Options_form.extended_sprite_info, "Checked", OPTIONS.display_extended_sprite_info)
  forms.setproperty(Options_form.extended_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.cluster_sprite_info = forms.checkbox(Options_form.form, "Cluster", xform, yform)
  forms.setproperty(Options_form.cluster_sprite_info, "Checked", OPTIONS.display_cluster_sprite_info)
  forms.setproperty(Options_form.cluster_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.minor_extended_sprite_info = forms.checkbox(Options_form.form, "Minor extended", xform, yform)
  forms.setproperty(Options_form.minor_extended_sprite_info, "Checked", OPTIONS.display_minor_extended_sprite_info)
  forms.setproperty(Options_form.minor_extended_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.bounce_sprite_info = forms.checkbox(Options_form.form, "Bounce", xform, yform)
  forms.setproperty(Options_form.bounce_sprite_info, "Checked", OPTIONS.display_bounce_sprite_info)
  forms.setproperty(Options_form.bounce_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.quake_sprite_info = forms.checkbox(Options_form.form, "Quake", xform, yform)
  forms.setproperty(Options_form.quake_sprite_info, "Checked", OPTIONS.display_quake_sprite_info)
  forms.setproperty(Options_form.quake_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.debug_extended_sprite = forms.checkbox(Options_form.form, "Extended extra", xform, yform)
  forms.setproperty(Options_form.debug_extended_sprite, "Checked", OPTIONS.display_debug_extended_sprite)
  forms.setproperty(Options_form.debug_extended_sprite, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.debug_cluster_sprite = forms.checkbox(Options_form.form, "Cluster extra", xform, yform)
  forms.setproperty(Options_form.debug_cluster_sprite, "Checked", OPTIONS.display_debug_cluster_sprite)
  forms.setproperty(Options_form.debug_cluster_sprite, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.debug_minor_extended_sprite = forms.checkbox(Options_form.form, "Minor ext. extra", xform, yform)
  forms.setproperty(Options_form.debug_minor_extended_sprite, "Checked", OPTIONS.display_debug_minor_extended_sprite)
  forms.setproperty(Options_form.debug_minor_extended_sprite, "Enabled", OPTIONS.display_other_sprites_info)

  yform = yform + delta_y
  Options_form.debug_bounce_sprite = forms.checkbox(Options_form.form, "Bounce extra", xform, yform)
  forms.setproperty(Options_form.debug_bounce_sprite, "Checked", OPTIONS.display_debug_bounce_sprite)
  forms.setproperty(Options_form.debug_bounce_sprite, "Enabled", OPTIONS.display_other_sprites_info)
  
  forms.addclick(Options_form.other_sprites_info, function() -- to enable/disable child options on click
    OPTIONS.display_other_sprites_info = forms.ischecked(Options_form.other_sprites_info) or false
    
    forms.setproperty(Options_form.extended_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.cluster_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.minor_extended_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.bounce_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.quake_sprite_info, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.debug_extended_sprite, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.debug_cluster_sprite, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.debug_minor_extended_sprite, "Enabled", OPTIONS.display_other_sprites_info)
    forms.setproperty(Options_form.debug_bounce_sprite, "Enabled", OPTIONS.display_other_sprites_info)
  end)
  
  if yform > y_bigger then y_bigger = yform end
  
  --- CHEATS ---
  
  y_section = y_bigger + 2*delta_y
  xform, yform = 4, y_section
  Options_form.allow_cheats = forms.checkbox(Options_form.form, "Cheats", xform + 214, yform)
  forms.setproperty(Options_form.allow_cheats, "Checked", Cheat.allow_cheats)
  forms.setproperty(Options_form.allow_cheats, "TextAlign", "TopRight")
  forms.setproperty(Options_form.allow_cheats, "CheckAlign", "TopRight")
  forms.setproperty(Options_form.allow_cheats, "AutoSize", true)
  forms.label(Options_form.form, "------------------------------------------------------------------------------------------  ----------------------------------------------------------------------", xform - 2, yform, form_width, 20)
  
  -- Powerup cheat
  yform = yform + 1.5*delta_y
  Options_form.cheat_powerup = forms.button(Options_form.form, "Powerup", function() Cheat.change_address(WRAM.powerup, "powerup_number", 1, false,
    nil, "Enter a valid integer (0-255).", "powerup")
  end, xform, yform, 57, 24)
  forms.setproperty(Options_form.cheat_powerup, "Enabled", Cheat.allow_cheats)

  xform = xform + 59
  Options_form.powerup_number = forms.textbox(Options_form.form, "", 30, 16, "UNSIGNED", xform, yform + 2, false, false)
  forms.setproperty(Options_form.powerup_number, "Enabled", Cheat.allow_cheats)

  -- Timer cheat
  xform = xform + 60
  Options_form.cheat_timer = forms.button(Options_form.form, "Timer", Cheat.timer, xform, yform, 43, 24)
  forms.setproperty(Options_form.cheat_timer, "Enabled", Cheat.allow_cheats)

  xform = xform + 45
  Options_form.timer_number = forms.textbox(Options_form.form, "", 30, 16, "UNSIGNED", xform, yform + 2, false, false)
  forms.setproperty(Options_form.timer_number, "Enabled", Cheat.allow_cheats)

  -- Coin cheat
  xform = xform + 60
  Options_form.cheat_coin = forms.button(Options_form.form, "Coin", function() Cheat.change_address(WRAM.player_coin, "coin_number", 1, false,
    function(num) return num < 100 end, "Enter an integer between 0 and 99.", "coin")
  end, xform, yform, 43, 24)
  forms.setproperty(Options_form.cheat_coin, "Enabled", Cheat.allow_cheats)

  xform = xform + 45
  Options_form.coin_number = forms.textbox(Options_form.form, "", 24, 16, "UNSIGNED", xform, yform + 2, false, false)
  forms.setproperty(Options_form.coin_number, "Enabled", Cheat.allow_cheats)

  -- Score cheat
  xform = xform + 60
  Options_form.cheat_score = forms.button(Options_form.form, "Score", Cheat.score, xform, yform, 43, 24)
  forms.setproperty(Options_form.cheat_score, "Enabled", Cheat.allow_cheats)

  xform = xform + 45
  Options_form.score_number = forms.textbox(Options_form.form, fmt("0x%X", u24(WRAM.mario_score)), 48, 16, nil, xform, yform + 2, false, false)
  forms.setproperty(Options_form.score_number, "Enabled", Cheat.allow_cheats)

  -- Item box cheat
  xform = 4
  yform = yform + 28
  Options_form.cheat_item_box = forms.button(Options_form.form, "Item box", function() Cheat.change_address(WRAM.item_box, "item_box_number", 1, true,
    nil, "Enter a valid integer (0-255).", "Item box")
  end, xform, yform, 60, 24)
  forms.setproperty(Options_form.cheat_item_box, "Enabled", Cheat.allow_cheats)

  xform = xform + 62
  Options_form.item_box_number = forms.dropdown(Options_form.form, Item_box_table, xform, yform + 1, 300, 10)
  forms.setproperty(Options_form.item_box_number, "Enabled", Cheat.allow_cheats)

  -- Positon cheat
  xform = 4
  yform = yform + 28
  Options_form.cheat_position = forms.button(Options_form.form, "Position", function()
    Cheat.change_address(WRAM.x, "player_x", 2, false, nil, "Enter a valid x position", "x position")
    Cheat.change_address(WRAM.x_sub, "player_x_sub", 1, true, nil, "Enter a valid x subpixel", "x subpixel")
    Cheat.change_address(WRAM.y, "player_y", 2, false, nil, "Enter a valid y position", "y position")
    Cheat.change_address(WRAM.y_sub, "player_y_sub", 1, true, nil, "Enter a valid y subpixel", "y subpixel")
  end, xform, yform, 60, 24)
  forms.setproperty(Options_form.cheat_position, "Enabled", Cheat.allow_cheats)

  yform = yform + 2
  xform = xform + 62
  Options_form.player_x = forms.textbox(Options_form.form, "", 32, 16, "UNSIGNED", xform, yform, false, false)
  xform = xform + 33
  Options_form.player_x_sub = forms.textbox(Options_form.form, "", 28, 16, "HEX", xform, yform, false, false)
  xform = xform + 34
  Options_form.player_y = forms.textbox(Options_form.form, "", 32, 16, "UNSIGNED", xform, yform, false, false)
  xform = xform + 33
  Options_form.player_y_sub = forms.textbox(Options_form.form, "", 28, 16, "HEX", xform, yform, false, false)
  forms.setproperty(Options_form.player_x, "Enabled", Cheat.allow_cheats)
  forms.setproperty(Options_form.player_x_sub, "Enabled", Cheat.allow_cheats)
  forms.setproperty(Options_form.player_y, "Enabled", Cheat.allow_cheats)
  forms.setproperty(Options_form.player_y_sub, "Enabled", Cheat.allow_cheats)
  
  -- Free movement cheat
  xform = xform + 60
  Options_form.free_movement = forms.checkbox(Options_form.form, "Free movement", xform, yform)
  forms.setproperty(Options_form.free_movement, "Checked", Cheat.under_free_move)
  forms.setproperty(Options_form.free_movement, "Enabled", Cheat.allow_cheats)
  
  forms.addclick(Options_form.allow_cheats, function() -- to enable/disable child options on click
    Cheat.allow_cheats = forms.ischecked(Options_form.allow_cheats) or false
    
    forms.setproperty(Options_form.cheat_powerup, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.powerup_number, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.cheat_timer, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.timer_number, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.cheat_coin, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.coin_number, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.cheat_score, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.score_number, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.cheat_item_box, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.item_box_number, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.cheat_position, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.player_x, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.player_x_sub, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.player_y, "Enabled", Cheat.allow_cheats)
    forms.setproperty(Options_form.player_y_sub, "Enabled", Cheat.allow_cheats)
    
    forms.setproperty(Options_form.free_movement, "Enabled", Cheat.allow_cheats)
  end)
  
  --- SCRIPT SETTINGS ---
  
  xform, yform = 4, yform + 2*delta_y
  Options_form.script_settings_label = forms.label(Options_form.form, "Script settings", xform, yform)
  forms.setproperty(Options_form.script_settings_label, "AutoSize", true)
  forms.setlocation(Options_form.script_settings_label, (form_width-16)/2 - forms.getproperty(Options_form.script_settings_label, "Width")/2, yform)
  forms.label(Options_form.form, "------------------------------------------------------------------------------------------------------------------------------------------------------------------", xform - 2, yform, form_width, 20)
  
  -- Select tiles
  yform = yform + 1.5*delta_y
  y_section = yform
  Options_form.draw_tiles_with_click = forms.checkbox(Options_form.form, "Select tiles", xform, yform)
  forms.setproperty(Options_form.draw_tiles_with_click, "Checked", OPTIONS.draw_tiles_with_click)
  forms.setproperty(Options_form.draw_tiles_with_click, "AutoSize", true)
  
  yform = yform + delta_y
  Options_form.erase_tiles = forms.button(Options_form.form, "Erase all tiles", function() Layer1_tiles = {}; Layer2_tiles = {} end, xform, yform, 80, 25)
  
  -- Text opacity
  xform, yform = xform + 100, y_section
  Options_form.text_opacity = forms.label(Options_form.form, ("Text opacity:\n(%.0f%%, %.0f%%)"):
    format(100*draw.Text_max_opacity, 100*draw.Background_max_opacity), xform, yform, 75, 30)
  ;
  xform = xform + 75
  Options_form.opacity_button_minus = forms.button(Options_form.form, "-", function() draw.decrease_opacity()
    forms.settext(Options_form.text_opacity, ("Text opacity: (%.0f%%, %.0f%%)"):format(100*draw.Text_max_opacity, 100*draw.Background_max_opacity))
  end, xform, yform, 24, 24)
  xform = xform + 24
  forms.button(Options_form.form, "+", function() draw.increase_opacity()
    forms.settext(Options_form.text_opacity, ("Text opacity: (%.0f%%, %.0f%%)"):format(100*draw.Text_max_opacity, 100*draw.Background_max_opacity))
  end, xform, yform, 24, 24)
  
  -- Mouse coordinates
  xform = xform + 50
  Options_form.mouse_coordinates = forms.checkbox(Options_form.form, "Mouse\ncoordinates", xform, yform)
  forms.setproperty(Options_form.mouse_coordinates, "Checked", OPTIONS.display_mouse_coordinates)
  forms.setproperty(Options_form.mouse_coordinates, "AutoSize", true)
  
  -- Emu gaps (lateral gaps)
  xform = xform + 140
  -- top gap
  forms.button(Options_form.form, "-", function()
    if OPTIONS.top_gap - 10 >= BIZHAWK_FONT_HEIGHT then OPTIONS.top_gap = OPTIONS.top_gap - 10 end
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  xform = xform + 24
  forms.button(Options_form.form, "+", function()
    OPTIONS.top_gap = OPTIONS.top_gap + 10
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  -- left gap
  xform, yform = xform - 3*24, yform + 24
  forms.button(Options_form.form, "-", function()
    if OPTIONS.left_gap - 10 >= BIZHAWK_FONT_HEIGHT then OPTIONS.left_gap = OPTIONS.left_gap - 10 end
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  xform = xform + 24
  forms.button(Options_form.form, "+", function()
    OPTIONS.left_gap = OPTIONS.left_gap + 10
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  -- right gap
  xform = xform + 3*24
  forms.button(Options_form.form, "-", function()
    if OPTIONS.right_gap - 10 >= BIZHAWK_FONT_HEIGHT then OPTIONS.right_gap = OPTIONS.right_gap - 10 end
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  xform = xform + 24
  forms.button(Options_form.form, "+", function()
    OPTIONS.right_gap = OPTIONS.right_gap + 10
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  -- bottom gap
  xform, yform = xform - 3*24, yform + 24
  forms.button(Options_form.form, "-", function()
    if OPTIONS.bottom_gap - 10 >= BIZHAWK_FONT_HEIGHT then OPTIONS.bottom_gap = OPTIONS.bottom_gap - 10 end
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  xform = xform + 24
  forms.button(Options_form.form, "+", function()
    OPTIONS.bottom_gap = OPTIONS.bottom_gap + 10
    client.SetGameExtraPadding(OPTIONS.left_gap, OPTIONS.top_gap, OPTIONS.right_gap, OPTIONS.bottom_gap)
  end, xform, yform, 24, 24)
  xform, yform = xform - 26, yform - 20
  forms.label(Options_form.form, "Emu gaps", xform, yform, 70, 20)
  
  -- Help
  xform, yform = (form_width-16)/2 - 73/2, form_height - 70
  Options_form.write_help_handle = forms.button(Options_form.form, "Help", Options_form.write_help, xform, yform) -- TODO: maybe make a window instead of writing in the console
  
  --- ETC ---
  --forms.label(Options_form.form, "You can close this menu at any time", form_width - 200, form_height - 60, 190, 20) -- TODO: remove maybe
  
  -- Background for dev tests
  --Options_form.picture_box = forms.pictureBox(Options_form.form, 0, 0, form_width, form_height)
  --forms.clear(Options_form.picture_box, 0xffFF0000)
  
end


function Sprite_tables_form.create_window()
  if not Sprite_tables_form.is_form_closed then return end

  -- Create sprite tables form
  local default_width, default_height = 700, 476
  if Sprite_tables_form.width == nil and Sprite_tables_form.height == nil then
    Sprite_tables_form.width, Sprite_tables_form.height = default_width, default_height
  end
  Sprite_tables_form.form = forms.newform(Sprite_tables_form.width, Sprite_tables_form.height, "SMW Sprite Tables", function () Sprite_tables_form.is_form_closed = true end )
  forms.setlocation(Sprite_tables_form.form, 10, 100)
  
  -- Font
  local xform, yform, delta_y = 4, 22, 20
  Sprite_tables_form.colour_changed = forms.createcolor(0xFF, 0x00, 0x00, 0xFF) -- red
  Sprite_tables_form.colour_same = forms.createcolor(0x00, 0x00, 0x00, 0xFF) -- black

  
  -- Evaluate which sprite tables should be displayed
  Sprite_tables_form.tables = {
    0x009E, 0x00AA, 0x00B6, 0x00C2, 0x00D8, 0x00E4, 0x14C8, 0x14D4, 0x14E0, 0x14EC, 0x14F8, 0x1504, 0x1510, 0x151C,
    0x1528, 0x1534, 0x1540, 0x154C, 0x1558, 0x1564, 0x1570, 0x157C, 0x1588, 0x1594, 0x15A0, 0x15AC, 0x15B8, 0x15C4,
    0x15D0, 0x15DC, 0x15EA, 0x15F6, 0x1602, 0x160E, 0x161A, 0x1626, 0x1632, 0x163E, 0x164A, 0x1656, 0x1662, 0x166E,
    0x167A, 0x1686, 0x186C, 0x187B, 0x190F, 0x1FD6, 0x1FE2
  }
  Sprite_tables_form.display = {}
  Sprite_tables_form.display_count = 0
  for i = 1, #Sprite_tables_form.tables do
    if OPTIONS.display_misc_sprite_table[i] then 
      Sprite_tables_form.display_count = Sprite_tables_form.display_count + 1
      Sprite_tables_form.display[Sprite_tables_form.display_count] = Sprite_tables_form.tables[i]
    end
  end
  
  
  -- Resize the window based on the amount of displayed tables
  if Sprite_tables_form.display_count > 21 then
    Sprite_tables_form.width = 55 + 30*Sprite_tables_form.display_count
  else
    Sprite_tables_form.width = default_width
  end
  forms.setproperty(Sprite_tables_form.form, "Width", Sprite_tables_form.width)
  
  
  -- Display sprite tables
  Sprite_tables_form.values = {}
  
  for i = 0, 11 do -- i = sprite slot
    
    forms.label(Sprite_tables_form.form, fmt("#%02d:", i), xform, yform, 30, delta_y)
    xform = xform + 4
    
    Sprite_tables_form.values[i] = {}
    
    for j = 1, #Sprite_tables_form.display do -- j = sprite table to be displayed index
    
      if i == 1 then -- to print this once per sprite table, could be any i
        forms.label(Sprite_tables_form.form, fmt("%04X", Sprite_tables_form.display[j]), xform - 6 + j*30, yform - 2*delta_y, 34, delta_y)
      end
      Sprite_tables_form.values[i][j] = forms.label(Sprite_tables_form.form, fmt("%02X", u8(Sprite_tables_form.display[j] + i)), xform + j*30, yform, 22, delta_y)
      forms.setproperty(Sprite_tables_form.values[i][j], "ForeColor", Sprite_tables_form.colour_same) -- set pure black colour to be used later at Sprite_tables_form.evaluate_form()
      
    end
    
    yform = yform + delta_y
    xform = 4
  end
  
  
  -- Options
  forms.label(Sprite_tables_form.form, "     Check/uncheck the sprite tables you want to be displayed/hidden, then\n<-- click UPDATE to reload this window", xform + 75, yform, 400, 30)
  forms.button(Sprite_tables_form.form, "UPDATE", Sprite_tables_form.update_options, xform, yform + 2)
  
  yform = yform + 1.5*delta_y
  Sprite_tables_form.display_checkbox = {}
  
  for i = 1, #Sprite_tables_form.tables do
    --Sprite_tables_form.display_checkbox[i] = forms.checkbox(Sprite_tables_form.form, fmt("$%04X", Sprite_tables_form.tables[i]), xform, yform) -- REMOVE
    Sprite_tables_form.display_checkbox[i] = forms.checkbox(Sprite_tables_form.form, "", xform, yform)
    forms.setproperty(Sprite_tables_form.display_checkbox[i], "Checked", OPTIONS.display_misc_sprite_table[i])
    forms.setproperty(Sprite_tables_form.display_checkbox[i], "Width", 14)
    
    forms.button(Sprite_tables_form.form, fmt("$%04X", Sprite_tables_form.tables[i]), function ()
      forms.settext(Sprite_tables_form.description, fmt("$7E%04X: \n %s", Sprite_tables_form.tables[i], SMW.sprite_table_descr[Sprite_tables_form.tables[i]])) end, xform + 16, yform + 2, 48, 19)
    
    xform = xform + 70
    if i%7 == 0 then yform = yform + delta_y ; xform = 4 end
  end
  
  -- Info box with table description
  xform, yform = xform + 7*70, yform - 8.5*delta_y
  forms.label(Sprite_tables_form.form, "Click the address buttons on the left to\nsee the respective description here", xform, yform, 200, 30)
  yform = yform + 1.5*delta_y
  --xform, yform = 498, 302
  
  Sprite_tables_form.description = forms.textbox(Sprite_tables_form.form, "", Sprite_tables_form.width - xform - 20, Sprite_tables_form.height - yform - 44, "", xform, yform, true, false, "Vertical")
  forms.setproperty(Sprite_tables_form.description, "ReadOnly", true)
  
  Sprite_tables_form.is_form_closed = false
end


function Options_form.evaluate_form() -- TODO: ORGANIZE after all the menu changes
  -- Option form's buttons
  Cheat.allow_cheats = forms.ischecked(Options_form.allow_cheats) or false
  Cheat.under_free_move = forms.ischecked(Options_form.free_movement) or false
  -- Show/hide
  OPTIONS.display_movie_info = forms.ischecked(Options_form.movie_info) or false
  OPTIONS.display_game_info = forms.ischecked(Options_form.game_info) or false
  OPTIONS.display_player_info = forms.ischecked(Options_form.player_info) or false
  OPTIONS.display_player_main_info = forms.ischecked(Options_form.player_main_info) or false
  OPTIONS.display_yoshi_info = forms.ischecked(Options_form.yoshi_info) or false
  OPTIONS.display_sprite_info = forms.ischecked(Options_form.sprite_info) or false
  OPTIONS.display_sprite_main_table = forms.ischecked(Options_form.sprite_main_table) or false
  OPTIONS.display_sprite_hitbox = forms.ischecked(Options_form.sprite_hitbox) or false
  OPTIONS.display_sprite_vs_sprite_hitbox = forms.ischecked(Options_form.sprite_vs_sprite_hitbox) or false
  --OPTIONS.display_misc_sprite_table =  forms.ischecked(Options_form.sprite_tables) or false
  OPTIONS.display_sprite_data =  forms.ischecked(Options_form.sprite_data) or false
  OPTIONS.display_sprite_load_status =  forms.ischecked(Options_form.sprite_load_status) or false
  OPTIONS.display_sprite_spawning_areas = forms.ischecked(Options_form.sprite_spawning_areas) or false
  OPTIONS.display_sprite_vanish_area = forms.ischecked(Options_form.sprite_vanish_area) or false
  OPTIONS.display_other_sprites_info = forms.ischecked(Options_form.other_sprites_info) or false
  OPTIONS.display_extended_sprite_info = forms.ischecked(Options_form.extended_sprite_info) or false
  OPTIONS.display_cluster_sprite_info = forms.ischecked(Options_form.cluster_sprite_info) or false
  OPTIONS.display_minor_extended_sprite_info = forms.ischecked(Options_form.minor_extended_sprite_info) or false
  OPTIONS.display_bounce_sprite_info = forms.ischecked(Options_form.bounce_sprite_info) or false
  OPTIONS.display_quake_sprite_info = forms.ischecked(Options_form.quake_sprite_info) or false
  OPTIONS.display_level_info = forms.ischecked(Options_form.level_info) or false
  OPTIONS.display_level_main_info = forms.ischecked(Options_form.level_main_info) or false
  OPTIONS.display_counters = forms.ischecked(Options_form.counters_info) or false
  OPTIONS.display_static_camera_region = forms.ischecked(Options_form.static_camera_region) or false
  OPTIONS.use_block_duplication_predictor = forms.ischecked(Options_form.block_duplication_predictor) or false
  OPTIONS.display_level_boundary = forms.ischecked(Options_form.level_boundary) or false
  OPTIONS.display_screen_info = forms.ischecked(Options_form.screen_info) or false
  OPTIONS.display_RNG_info = forms.ischecked(Options_form.RNG_info) or false
  OPTIONS.display_overworld_info = forms.ischecked(Options_form.overworld_info) or false
  -- Debug/Extra
  OPTIONS.display_debug_player_extra = forms.ischecked(Options_form.debug_player_extra) or false
  OPTIONS.display_debug_sprite_extra = forms.ischecked(Options_form.debug_sprite_extra) or false
  OPTIONS.display_debug_sprite_tweakers = forms.ischecked(Options_form.debug_sprite_tweakers) or false
  OPTIONS.display_debug_extended_sprite = forms.ischecked(Options_form.debug_extended_sprite) or false
  OPTIONS.display_debug_cluster_sprite = forms.ischecked(Options_form.debug_cluster_sprite) or false
  OPTIONS.display_debug_minor_extended_sprite = forms.ischecked(Options_form.debug_minor_extended_sprite) or false
  OPTIONS.display_debug_bounce_sprite = forms.ischecked(Options_form.debug_bounce_sprite) or false
  OPTIONS.display_controller_data = forms.ischecked(Options_form.controller_data) or false
  OPTIONS.display_lagmeter = forms.ischecked(Options_form.lagmeter) or false
  -- Other buttons
  OPTIONS.draw_tiles_with_click = forms.ischecked(Options_form.draw_tiles_with_click) or false
  OPTIONS.display_mouse_coordinates = forms.ischecked(Options_form.mouse_coordinates) or false
  local button_text = forms.gettext(Options_form.player_hitbox)
  OPTIONS.display_player_hitbox = button_text == "1. Hitbox + Blocks" or button_text == "2. Hitbox"
  OPTIONS.display_player_block_interaction = button_text == "1. Hitbox + Blocks" or button_text == "3. Blocks"
end


function Sprite_tables_form.evaluate_form()
  
  -- Sprite tables
  for i = 0, 11 do -- i = sprite slot
    
    for j = 1, #Sprite_tables_form.display do -- j = sprite table to be displayed index
      
      if forms.getproperty(Sprite_tables_form.values[i][j], "Text") ~= fmt("%02X", u8(Sprite_tables_form.display[j] + i)) then -- value changed in this frame
        
        forms.settext(Sprite_tables_form.values[i][j], fmt("%02X", u8(Sprite_tables_form.display[j] + i)))
        forms.setproperty(Sprite_tables_form.values[i][j], "ForeColor", Sprite_tables_form.colour_changed)
        
      else -- value didn't change in this frame
        
        local colour_same_str = string.sub(tostring(Sprite_tables_form.colour_same), 1, string.find(tostring(Sprite_tables_form.colour_same), ":") - 1) -- because colours created with forms.createcolor are userdatas with a pattern like "Color [A=255, R=0, G=255, B=0]: -16580862"
        
        if forms.getproperty(Sprite_tables_form.values[i][j], "ForeColor") ~= colour_same_str then
          forms.setproperty(Sprite_tables_form.values[i][j], "ForeColor", Sprite_tables_form.colour_same)
        end
        
      end
      
    end
    
  end
  
  -- Options
  for i = 1, #Sprite_tables_form.tables do
    OPTIONS.display_misc_sprite_table[i] = forms.ischecked(Sprite_tables_form.display_checkbox[i]) or false
  end
  
end


function Options_form.write_help()
  print(" - - - TIPS - - - ")
  print("MOUSE:")
  print("Use the left click to draw blocks and to see the Map16 properties.")
  print("Use the right click to toogle the hitbox mode of Mario and sprites.")
  print("\n")

  print("CHEATS(better turn off while recording a movie):")
  print("L+R+up: stop gravity for Mario fly / L+R+down to cancel")
  print("Use the mouse to drag and drop sprites")
  print("While paused: B+select to get out of the level")
  print("          X+select to beat the level (main exit)")
  print("          A+select to get the secret exit (don't use it if there isn't one)")

  print("\n")
  print("OTHERS:")
  print("If performance suffers, disable some options that are not needed at the moment.")
  print(" - - - end of tips - - - ")
end


function Sprite_tables_form.update_options()

  Sprite_tables_form.evaluate_form()
  forms.destroy(Sprite_tables_form.form)
  Sprite_tables_form.create_window()
  
end

-- Initialize forms
forms.destroyall() -- to prevent more than one forms (usually happens when script has an error)
Options_form.create_window()
Options_form.is_form_closed = false
Sprite_tables_form.is_form_closed = true

-- Functions to run when script is stopped or reset
event.unregisterbyname("smw-bizhawk-onexit") -- to avoid having more than one registered event for this
event.onexit(function()
  forms.destroyall()

  client.SetGameExtraPadding(0, 0, 0, 0)
  client.SetClientExtraPadding(0, 0, 0, 0)

  config.save_options()

  print("\nFinishing Super Mario World script.\n------------------------------------")
end, "smw-bizhawk-onexit")


-- Script load success message
print("\n\nSuper Mario World script loaded successfully at " .. os.date("%X") .. ".\n") -- %c for date and time

-- SMW hack warning message
if IS_HACK then print("Caution: this is a SMW hack, thus the script might not support all its modifications and features!!") end

-- Main script loop
while true do
  if emu.getsystemid() ~= "SNES" then
    gui.text(0, 0, "WRONG CORE: " .. emu.getsystemid(), "black", "red", "bottomright")

  else

    Options_form.is_form_closed = forms.gettext(Options_form.player_hitbox) == ""
    if not Options_form.is_form_closed then Options_form.evaluate_form() end

    if not Sprite_tables_form.is_form_closed then Sprite_tables_form.evaluate_form() end
    
    bizhawk_status()
    draw.bizhawk_screen_info()
    read_raw_input()
    
    -- Drawings are allowed now
    scan_smw()
    level_mode()
    overworld_mode()
    show_movie_info()
    if Is_lagged then
      gui.drawText(OPTIONS.left_gap + draw.Buffer_middle_x, 0, "LAG", COLOUR.warning, COLOUR.warning_bg, 12, "Courier New", "regular", "center") -- TODO: formalize function "draw.drawText"
    end
    show_game_info()
    display_RNG()
    show_controller_data()
    show_mouse_info()
    Lagmeter.show_lagmeter()
    
    Cheat.is_cheat_active()

    mouse_actions()

    -- Checks if options form exits and create a button in case it doesn't
    if Options_form.is_form_closed then
      if User_input.mouse_inwindow then
        draw.rectangle(0, 0, 14*BIZHAWK_FONT_WIDTH/draw.AR_x, 2*BIZHAWK_FONT_HEIGHT/draw.AR_y - 1, "white", 0xffb0b0b0)
        draw.line(0, 2*BIZHAWK_FONT_HEIGHT/draw.AR_y - 1, 14*BIZHAWK_FONT_WIDTH/draw.AR_x, 2*BIZHAWK_FONT_HEIGHT/draw.AR_y - 1, 0xff606060)
        draw.line(14*BIZHAWK_FONT_WIDTH/draw.AR_x, 0, 14*BIZHAWK_FONT_WIDTH/draw.AR_x, 2*BIZHAWK_FONT_HEIGHT/draw.AR_y - 1, 0xff606060)
        gui.text(draw.Border_left, draw.Border_top + BIZHAWK_FONT_HEIGHT/2 - 1, " Options Menu ")
      end
    end
    
    -- INPUT MANIPULATION
    Joypad = joypad.get(1)
    if Cheat.allow_cheats then
      Cheat.is_cheating = false

      Cheat.beat_level()
      Cheat.free_movement()
    else
      -- Cancel any continuous cheat
      Cheat.under_free_move = false

      Cheat.is_cheating = false
    end
    
    -- Prints SA-1 hack warning
    if HAS_SA1 then
      draw.alert_text(draw.Border_left + draw.Buffer_middle_x*draw.AR_x, draw.Buffer_height*draw.AR_y, "ROM hack with SA-1 enhancement chip, currently not supported\n     by this script. Contact the script author about it.", COLOUR.warning, 0, false, 0.5)
    end
  end

  -- Frame advance: don't use emu.yield() righ now, as the drawings aren't erased correctly
  emu.frameadvance()
end


--[[#############################################################################
-- TODO

- Add RAM remaps for SA-1 hacks
- Add function to check sprite data pointer against the table for hacks (pointer low and high byte at $05EC00 (2 bytes per level), pointer bank at $0EF100 (1 byte per level))
- Add onmemoryexecute check to know exactly the level/room, instead of using sprite data pointer comparison
- Script is not running with Super Demo World

- Add "warp to level" cheat: a dropdown list in the menu to select any level (by name, in the original game) and Mario warps directly into it. You just need to set the game_mode to 0x0B, set the respective submap, and set the OW player position accordingly
- Add level editor (in real time): select a block, choose a Map16 index to replace the selected block, and maybe force a graphical reload by writing on VRAM
- Add option for cape hitbox (using display_cape_hitbox), and with this changing the "Interaction" dropdown list to just a bunch of options
- Decide if will implement encoded sprite images ("Sprite HEX to PNG.lua")
- Add Generators info (me + Amaraticando https://github.com/rodamaral/smw-tas/commit/28747de755219968f39ad06455dab5701aef770a)
- Add Yoshi cheats (Amaraticando https://github.com/rodamaral/smw-tas/commit/4854ea769a498606a395bf7fc0885318968a6e19)
- Add cheat to stun sprites (Amaraticando https://github.com/rodamaral/smw-tas/commit/e3f3013761d0774cfe4323b472202ed94c23b7b0)
- Add new figures to show when a sprite was licked or swallowed by Yoshi (Amaraticando https://github.com/rodamaral/smw-tas/commit/0f4e22c4088d237d7960002b25c5ce2f9d9c001e)
- Add other sprites, like Score, Coin, etc (and change Menu options after that)
- Add exceptions/warnings for older BizHawk versions




]]
