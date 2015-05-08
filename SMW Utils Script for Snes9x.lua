--[[

 Super Mario World (U) Utility Script
 Operation check done by using snes9x-rr 1.43 v17 svn
 http://code.google.com/p/snes9x-rr/

 Contributers: gocha, Mr.
 
 Edited by BrunoValads and checked in snes9x-rr 1.51 v7
 github.com/brunovalads/smw-stuff

 === Cheat Keys ===

 Level:
 up+select         Increment powerup (0 - 255)
 down+select       Decrement powerup (0 - 255)
 up+select(hold)   Increment powerup quickly
 down+select(hold) Decrement powerup quickly
 L+A               Change move method (normal.P-meter,free)
 pause+select      Exit the current level, with activating the next level
 pause+(A+select)  Exit the current level, with activating the next level (secret goal)
 pause+(B+select)  Exit the current level, without activating the next level

 Note: color blocks can't be activated if you beat a switch palace with the pause-exit cheat.

 === Other Features ===

 - Cut powerup / powerdown animation
 - Display P-meter, sprite info, and some other useful info

 All of these features can be enabled / disabled by modifying the following option settings.

]]--

-- option start here >>

local smwRegularDebugFuncOn = true
local smwCutPowerupAnimationOn = false
local smwCutPowerdownAnimationOn = false
local smwDragAndDropOn = true

-- Move speed definitions for free move mode.
-- I guess you usually won't need to modify these.
local smwFreeMoveSpeed = 2.0 -- px/f
local smwFreeMoveSpeedupMax = 4.0 -- px/f
local smwFreeMovePMeterLength = 1 -- frame(s)

local guiOpacity = 0.8
local showPMeter = false
local showSpriteInfo = true
local showMainInfo = true
local showYoshiInfo = true
local showSpeedVector = false

-- << options end here

-- [ generic utility functions ] -----------------------------------------------

if not emu then
    error("This script runs under snes9x")
end

if not bit then
    require("bit")
end

-- [ gameemu lua utility functions ] -------------------------------------------

function gui.edgelessbox(x1, y1, x2, y2, colour)
    gui.line(x1+1, y1, x2-1, y1, colour) -- top
    gui.line(x2, y1+1, x2, y2-1, colour) -- right
    gui.line(x1+1, y2, x2-1, y2, colour) -- bottom
    gui.line(x1, y1+1, x1, y2-1, colour) -- left
end

local pad_max = 2
local pad_press, pad_down, pad_up, pad_prev, pad_send = {}, {}, {}, {}, {}
local pad_presstime = {}
for player = 1, pad_max do
    pad_press[player] = {}
    pad_presstime[player] = { start=0, select=0, up=0, down=0, left=0, right=0, A=0, B=0, X=0, Y=0, L=0, R=0 }
end

local dev_press, dev_down, dev_up, dev_prev = input.get(), {}, {}, {}
local dev_presstime = {
    xmouse=0, ymouse=0, leftclick=0, rightclick=0, middleclick=0,
    shift=0, control=0, alt=0, capslock=0, numlock=0, scrolllock=0,
    ["0"]=0, ["1"]=0, ["2"]=0, ["3"]=0, ["4"]=0, ["5"]=0, ["6"]=0, ["7"]=0, ["8"]=0, ["9"]=0,
    A=0, B=0, C=0, D=0, E=0, F=0, G=0, H=0, I=0, J=0, K=0, L=0, M=0, N=0, O=0, P=0, Q=0, R=0, S=0, T=0, U=0, V=0, W=0, X=0, Y=0, Z=0,
    F1=0, F2=0, F3=0, F4=0, F5=0, F6=0, F7=0, F8=0, F9=0, F10=0, F11=0, F12=0,
    F13=0, F14=0, F15=0, F16=0, F17=0, F18=0, F19=0, F20=0, F21=0, F22=0, F23=0, F24=0,
    backspace=0, tab=0, enter=0, pause=0, escape=0, space=0,
    pageup=0, pagedown=0, ["end"]=0, home=0, insert=0, delete=0,
    left=0, up=0, right=0, down=0,
    numpad0=0, numpad1=0, numpad2=0, numpad3=0, numpad4=0, numpad5=0, numpad6=0, numpad7=0, numpad8=0, numpad9=0,
    ["numpad*"]=0, ["numpad+"]=0, ["numpad-"]=0, ["numpad."]=0, ["numpad/"]=0,
    tilde=0, plus=0, minus=0, leftbracket=0, rightbracket=0,
    semicolon=0, quote=0, comma=0, period=0, slash=0, backslash=0
}

-- scan button presses
function scanJoypad()
    for i = 1, pad_max do
        pad_prev[i] = copytable(pad_press[i])
        pad_press[i] = joypad.get(i)
        pad_send[i] = copytable(pad_press[i])
        -- scan keydowns, keyups
        pad_down[i] = {}
        pad_up[i] = {}
        for k in pairs(pad_press[i]) do
            pad_down[i][k] = (pad_press[i][k] and not pad_prev[i][k])
            pad_up[i][k] = (pad_prev[i][k] and not pad_press[i][k])
        end
        -- count press length
        for k in pairs(pad_press[i]) do
            if not pad_press[i][k] then
                pad_presstime[i][k] = 0
            else
                pad_presstime[i][k] = pad_presstime[i][k] + 1
            end
        end
    end
end
-- scan keyboard/mouse input
function scanInputDevs()
    dev_prev = copytable(dev_press)
    dev_press = input.get()
    -- scan keydowns, keyups
    dev_down = {}
    dev_up = {}
    for k in pairs(dev_presstime) do
        dev_down[k] = (dev_press[k] and not dev_prev[k])
        dev_up[k] = (dev_prev[k] and not dev_press[k])
    end
    -- count press length
    for k in pairs(dev_presstime) do
        if not dev_press[k] then
            dev_presstime[k] = 0
        else
            dev_presstime[k] = dev_presstime[k] + 1
        end
    end
end
-- send button presses
function sendJoypad()
    for i = 1, pad_max do
        joypad.set(i, pad_send[i])
    end
end

-- [ game-specific utility functions ] -----------------------------------------

local moveMethod_normal = 0
local moveMethod_pmeter = 1
local moveMethod_free = 2
local moveMethod_max = 3

local smwMoveMethod = moveMethod_normal
local smwFreeMovePMeter = 0

local RAM_frameCount = 0x7e0013
local RAM_frameCountAlt = 0x7e0014
local RAM_gameMode = 0x7e0100
local RAM_player = 0x7e0db3
local RAM_powerup = 0x7e0019
local RAM_pMeter = 0x7e13e4
local RAM_takeOffMeter = 0x7e149f
local RAM_starInvCount = 0x7e1490
local RAM_hurtInvCount = 0x7e1497
local RAM_cameraX = 0x7e001a
local RAM_cameraY = 0x7e001c
local RAM_xSpeed = 0x7e007b
local RAM_ySpeed = 0x7e007d
local RAM_xSubSpeed = 0x7e007a
local RAM_xPos = 0x7e0094
local RAM_yPos = 0x7e0096
local RAM_xSubPos = 0x7e13da
local RAM_ySubPos = 0x7e13dc
local RAM_facingDirection = 0x7e0076
local RAM_flightAnimation = 0x7e1407
local RAM_capeSlowFallCount = 0x7e14a5
local RAM_capeSpinTimer = 0x7e14a6
local RAM_movement = 0x7e0071
local RAM_lockSpritesTimer = 0x7e009d
local RAM_marioFrameCount = 0x7e1496
local RAM_RNG = 0x7e148d
local RAM_blockedStatus = 0x7e0077

local RAM_bluePOW = 0x7e14ad
local RAM_grayPOW = 0x7e14ae
local RAM_multipleCoinBlockTimer = 0x7e186b
local RAM_directionalCoinTimer = 0x7e190c
local RAM_pBalloonTimer = 0x7e1891
local RAM_pBalloonTimerAlt = 0x7e13f3

local RAM_ropeClimbingFlag = 0x7e18be

local RAM_frozen = 0x7e13fb
local RAM_paused = 0x7e13d4
local RAM_levelIndex = 0x7e13bf
local RAM_levelFlagTable = 0x7e1ea2
local RAM_typeOfExit = 0x7e0dd5
local RAM_midwayPoint = 0x7e13ce
local RAM_activateNextLevel = 0x7e13ce

local pMeter_max = 112
local takeOffMeter_max = 80

local gameMode_ow  = 14
local gameMode_level = 20

local smwSpriteMaxCount = 12

local smwPlayerPrev, smwPlayer, smwPlayerChanged
local smwGameModePrev, smwGameMode, smwGameModeChanged
local smwPausePrev, smwPause, smwPauseChanged
local smwMovementPrev, smwMovement, smwMovementChanged
-- scan some parameters that control behavior of the script
function smwScanStatus()
    smwPlayerPrev = smwPlayer
    smwPlayer = memory.readbyte(RAM_player) + 1
    smwPlayerChanged = (smwPlayer ~= smwPlayerPrev)
    smwGameModePrev = smwGameMode
    smwGameMode = memory.readbyte(RAM_gameMode)
    smwGameModeChanged = (smwGameMode ~= smwGameModePrev)
    smwPausePrev = smwPause
    smwPause = (memory.readbyte(RAM_paused) ~= 0)
    smwPauseChanged = (smwPause ~= smwPausePrev)
    smwMovementPrev = smwMovement
    smwMovement = memory.readbyte(RAM_movement)
    smwMovementChanged = (smwMovement ~= smwMovementPrev)
end

-- increment powerup
function smwDoPowerUp()
    local powerup = memory.readbyte(RAM_powerup)
    memory.writebyte(RAM_powerup, powerup + 1)
end

-- decrement powerup
function smwDoPowerDown()
	local powerup = memory.readbyte(RAM_powerup)
	memory.writebyte(RAM_powerup, powerup - 1)
end

-- set move method
function smwSetMoveMethod(mode)
    -- cleanups
    if smwMoveMethod == moveMethod_free then
        memory.writebyte(RAM_frozen, 0) -- unfreeze Mario
    end
    -- apply new method
    smwMoveMethod = mode % moveMethod_max
end

-- normal move
function smwMoveNormalProc()
    -- do nothing
end

-- P-meter mode
function smwMovePMeterProc()
    memory.writebyte(RAM_pMeter, pMeter_max)
    memory.writebyte(RAM_takeOffMeter, takeOffMeter_max+1)
end

-- count own pmeter for 
function smwFreeMovePMeterCount()
    local move = pad_press[smwPlayer].left or pad_press[smwPlayer].right
        or pad_press[smwPlayer].up or pad_press[smwPlayer].down

    -- count up own P-meter
    if pad_press[smwPlayer].Y and move then
        if smwFreeMovePMeter < smwFreeMovePMeterLength then
            smwFreeMovePMeter = smwFreeMovePMeter + 1
        end
    else
        smwFreeMovePMeter = 0
    end
end

-- Free move mode
function smwMoveFreeProc()
    local x = memory.readword(RAM_xPos) + (memory.readbyte(RAM_xSubPos)/256.0)
    local y = memory.readword(RAM_yPos) + (memory.readbyte(RAM_ySubPos)/256.0)
    local speed, xv, yv = 0.0, 0.0, 0.0

    -- calc Mario's new position
    smwFreeMovePMeterCount()
    speed = smwFreeMoveSpeed + (smwFreeMoveSpeedupMax * smwFreeMovePMeter / smwFreeMovePMeterLength)
    if pad_press[smwPlayer].left  then xv = xv - speed end
    if pad_press[smwPlayer].right then xv = xv + speed end
    if pad_press[smwPlayer].up    then yv = yv - speed end
    if pad_press[smwPlayer].down  then yv = yv + speed end

    -- freeze Mario
    if smwMovement == 0 then
        memory.writebyte(RAM_frozen, 1)
        memory.writebyte(RAM_xSpeed, 0)
        memory.writebyte(RAM_ySpeed, 0)
        x, y = x + xv, y + yv

        -- but animate sprites
        memory.writebyte(RAM_frameCountAlt, (memory.readbyte(RAM_frameCountAlt) + 1) % 256)
    else
        memory.writebyte(RAM_frozen, 0)
    end
    -- make him invulnerable
    memory.writebyte(RAM_hurtInvCount, 127)
    -- manipulate Mario's position
    memory.writeword(RAM_xPos, math.floor(x))
    memory.writeword(RAM_yPos, math.floor(y))
    memory.writeword(RAM_xSubPos, math.floor(x*16)%16*16)
    memory.writeword(RAM_ySubPos, math.floor(y*16)%16*16)
end

local smwMoveMethodProc = { smwMoveNormalProc, smwMovePMeterProc, smwMoveFreeProc }

-- force allow escape
local smwForceSecretExit = false
local smwModExitStatus = false
function smwAllowEscape()
    if smwPause and pad_down[smwPlayer].select then
        local levelIndex = memory.readbyte(RAM_levelIndex)
        local levelFlag = memory.readbyte(RAM_levelFlagTable + levelIndex)
        -- save midway point flag
        if memory.readbyte(RAM_midwayPoint) == 1 then
            memory.writebyte(RAM_levelFlagTable + levelIndex, bit.bor(levelFlag, 0x40))
        end
        -- exit the level force
        memory.writebyte(RAM_levelFlagTable + levelIndex, bit.bor(levelFlag, 0x80))
        smwForceSecretExit = pad_press[smwPlayer].A
        -- activate next stage (destination must be written by smwRewriteOnPauseExit())
        -- pressing B will cancel this effect (exit without activate the next level)
        if not pad_press[smwPlayer].B then
            memory.writebyte(RAM_activateNextLevel, 1)
        else
            memory.writebyte(RAM_activateNextLevel, 0)
        end
        smwModExitStatus = true
    end
end

-- allow start+select to beat the level
function smwRewriteOnPauseExit()
    if not smwModExitStatus then return end
    if memory.readbyte(RAM_typeOfExit) == 0x80 and memory.readbyte(RAM_activateNextLevel) == 1 then
        if smwForceSecretExit then
            memory.writebyte(RAM_typeOfExit, 2)
        else
            memory.writebyte(RAM_typeOfExit, 1)
        end
        smwModExitStatus = false
    end
end

-- cut powerup animation
function smwCutPowerupAnimation()
    if smwMovement == 2 then -- super
        memory.writebyte(RAM_lockSpritesTimer, 0)
        memory.writebyte(RAM_movement, 0)
        memory.writebyte(RAM_marioFrameCount, 0)
        smwDoPowerUp() -- don't know why script needs to process it, anyway
    elseif smwMovement == 3 then -- cape
        memory.writebyte(RAM_lockSpritesTimer, 0)
        memory.writebyte(RAM_movement, 0)
        memory.writebyte(RAM_marioFrameCount, 0)
    elseif smwMovement == 4 then -- fire
        memory.writebyte(RAM_lockSpritesTimer, 0)
        memory.writebyte(RAM_movement, 0)
        memory.writebyte(RAM_marioFrameCount, 0)
        memory.writebyte(0x7e149b, 0)
    end
end

-- cut powerdown animation
function smwCutPowerdownAnimation()
    if smwMovement == 1 then -- powerdown
        memory.writebyte(RAM_lockSpritesTimer, 0)
        memory.writebyte(RAM_marioFrameCount, 0) -- stops 1 frame, but who cares
        -- memory.writebyte(RAM_movement, 0)
        -- memory.writebyte(RAM_hurtInvCount, 127)
    end
end

local smwDragTargets = {}
function smwDragAndDrop()
    if dev_press["leftclick"] then
        local x, y = dev_press["xmouse"], dev_press["ymouse"]
        local cameraX = memory.readwordsigned(RAM_cameraX)
        local cameraY = memory.readwordsigned(RAM_cameraY)
        for id = 0, smwSpriteMaxCount - 1 do
            local stat = memory.readbyte(0x7e14c8+id)
            local spriteX = memory.readbytesigned(0x7e14e0+id) * 0x100 + memory.readbyte(0x7e00e4+id)
            local spriteY = memory.readbytesigned(0x7e14d4+id) * 0x100 + memory.readbyte(0x7e00d8+id)

            if stat ~= 0 then
                local width, height = 16, 16
                local spriteRect = {
                    left = spriteX - cameraX,
                    top = spriteY - cameraY,
                    right = spriteX - cameraX + width,
                    bottom = spriteY - cameraY + height
                }
                if smwDragTargets[id] or (x >= spriteRect.left and x <= spriteRect.right and
                    y >= spriteRect.top and y <= spriteRect.bottom) then
                        local spriteX = cameraX + x - 8
                        local spriteY = cameraY + y - 8
                        memory.writebyte(0x7e14e0+id, math.floor(spriteX / 0x100))
                        memory.writebyte(0x7e00e4+id, spriteX % 0x100)
                        memory.writebyte(0x7e14d4+id, math.floor(spriteY / 0x100))
                        memory.writebyte(0x7e00d8+id, spriteY % 0x100)
                        smwDragTargets[id] = true
                end
            end
        end
    end
    if dev_up["leftclick"] then
        -- for id = 0, smwSpriteMaxCount - 1 do
        --     if smwDragTargets[id] then
        --         memory.writebyte(0x7e00b6+id, 0)
        --         memory.writebyte(0x7e00aa+id, 0)
        --     end
        -- end
        smwDragTargets = {}
    end
end

function getSpriteByMousePos(x, y)
    local spriteId = nil
    local cameraX = memory.readwordsigned(RAM_cameraX)
    local cameraY = memory.readwordsigned(RAM_cameraY)
    for id = 0, smwSpriteMaxCount - 1 do
        local stat = memory.readbyte(0x7e14c8+id)
        local spriteX = memory.readbytesigned(0x7e14e0+id) * 0x100 + memory.readbyte(0x7e00e4+id)
        local spriteY = memory.readbytesigned(0x7e14d4+id) * 0x100 + memory.readbyte(0x7e00d8+id)

        if stat ~= 0 then
            local width, height = 16, 16
            local spriteRect = {
                left = spriteX - cameraX,
                top = spriteY - cameraY,
                right = spriteX - cameraX + width,
                bottom = spriteY - cameraY + height
            }
            if x >= spriteRect.left and x <= spriteRect.right and
                y >= spriteRect.top and y <= spriteRect.bottom then
                spriteId = id
                break
            end
        end
    end
    return spriteId
end

-- [ game-specific main ] ------------------------------------------------------



local preventItemPopup = false
-- apply various cheats that work in Level
function smwApplyLevelCheats()
    if smwRegularDebugFuncOn then
        -- power-ups
        if not smwPause and pad_press[smwPlayer].up and pad_down[smwPlayer].select then -- increment
            smwDoPowerUp()
            preventItemPopup = true
		elseif not smwPause and pad_press[smwPlayer].up and pad_press[smwPlayer].select and pad_presstime[smwPlayer].select >= 50 then -- increment quickly
			smwDoPowerUp()
        end
		if not smwPause and pad_press[smwPlayer].down and pad_down[smwPlayer].select then -- decrement
            smwDoPowerDown()
            preventItemPopup = true
		elseif not smwPause and pad_press[smwPlayer].down and pad_press[smwPlayer].select and pad_presstime[smwPlayer].select >= 50 then -- decrement quickly
			smwDoPowerDown()
        end		
        -- moving method
        if not smwPause and pad_press[smwPlayer].L and pad_down[smwPlayer].A then
            smwSetMoveMethod(smwMoveMethod + 1)
        end
        if not smwPause then
            smwMoveMethodProc[smwMoveMethod+1]()
        end
    end

    -- prevent item popup
    if preventItemPopup and not pad_press[smwPlayer].select then
        preventItemPopup = false
    end
    if preventItemPopup then
        pad_send[smwPlayer].select = not pad_send[smwPlayer].select
    end

    -- cut powerup/powerdown animation
    if smwCutPowerupAnimationOn then
        smwCutPowerupAnimation()
    end
    if smwCutPowerdownAnimationOn then
        smwCutPowerdownAnimation()
    end

    -- allow escape
    if smwRegularDebugFuncOn then
        smwAllowEscape()
    end

    -- sprite drag and drop
    if smwDragAndDropOn then
        smwDragAndDrop()
    end
end

-- apply various cheats
function smwApplyCheats()
    if smwGameMode == gameMode_level then
        smwApplyLevelCheats()
    elseif smwGameMode == gameMode_ow then
        smwMoveMethod = moveMethod_normal
    elseif smwGameMode == 11 then
        smwRewriteOnPauseExit()
    end
end

-- draw P-meter in the screen
local pMeterMaxCount = 0
function smwDrawPMeter()
    if not (smwGameMode == gameMode_level) then return end

    local pMeter = memory.readbyte(RAM_pMeter)
    local pMeterBarXPos = 8
    local pMeterBarYPos = 208
    local pMeterBarWidth = 112
    local pMeterBarHeight = 6
    local pMeterBarLen
    local pMeterBorderColor = "#000000ff"
    local pMeterMeterColorNormal = "#31bdc5cc"
    local pMeterMeterColorMax = { "#ff0000cc", "#ff0000cc", "#ffffffcc" }
    local pMeterMeterColor
    local pMeterBGColor = "#00000080"

    if pMeter >= pMeter_max or smwMoveMethod == moveMethod_pmeter then
        pMeterMaxCount = (pMeterMaxCount + 1) % 3
        pMeterMeterColor = pMeterMeterColorMax[1+pMeterMaxCount]
        pMeterBarLen = pMeterBarWidth
    else
        pMeterColorPulse = 0
        pMeterMeterColor = pMeterMeterColorNormal
        pMeterBarLen = math.floor((pMeter/1.0)*pMeterBarWidth/pMeter_max)
    end

    gui.edgelessbox(pMeterBarXPos, pMeterBarYPos, pMeterBarXPos + pMeterBarWidth, pMeterBarYPos + pMeterBarHeight, "#000000")
    gui.box(pMeterBarXPos + 1, pMeterBarYPos + 1, pMeterBarXPos + pMeterBarWidth - 1, pMeterBarYPos + pMeterBarHeight - 1, pMeterBGColor, pMeterBGColor)
    if pMeter > 0 then
        gui.box(pMeterBarXPos + 1, pMeterBarYPos + 1, pMeterBarXPos + pMeterBarLen - 1, pMeterBarYPos + pMeterBarHeight - 1, pMeterMeterColor, pMeterMeterColor)
    end
end

-- draw Mario's speed vector in a grid
function smwDrawSpeedVector()
	if not (smwGameMode == gameMode_level) then return end

    gui.opacity(guiOpacity)
	local spdVectorColor = "red"
	local gridColor = "#a9a9a9" -- grey
	local gridFillColor = "#b0a9a9a9" -- grey
	local xSpeed = memory.readbytesigned(RAM_xSpeed)
    local ySpeed = memory.readbytesigned(RAM_ySpeed)
	local cameraX = memory.readwordsigned(RAM_cameraX)
    local cameraY = memory.readwordsigned(RAM_cameraY)
	local xPos = memory.readwordsigned(RAM_xPos) --+ memory.readbyte(RAM_xSubPos)
    local yPos = memory.readwordsigned(RAM_yPos) --+ memory.readbyte(RAM_ySubPos)
	local deltaMarioCameraX = xPos - cameraX
	local deltaMarioCameraY = yPos - cameraY
	local marioCenterX = deltaMarioCameraX + 8
	local marioCenterY = deltaMarioCameraY + 24
	local gridBig = true
	local gridSizeFactor = 0
	
	-- clickable menu
	local notSelectedColor = "#ffffff55" -- transparent
	local selectedColor = "#ff6060aa" -- red
	gui.text(205, 196, "Speed vector")
	
	gui.box(204, 205, 222, 217, selectedColor, "black")
	local buttonX1 = 222
	for size = 1, 3 do
		gui.box(buttonX1, 205, buttonX1 + 10, 217, notSelectedColor, "black")
		buttonX1 = buttonX1 + 10
	end
	gui.text(208, 208, "OFF")
	gui.text(226, 208, "S")
	gui.text(236, 208, "M")
	gui.text(246, 208, "B")

	if input.get("leftclick") then
		local x, y = dev_press["xmouse"], dev_press["ymouse"]
		if x > 204 and x < 222 and y > 205 and y < 217 then
			gridSizeFactor = 0
		elseif x > 222 and x < 232 and y > 205 and y < 217 then
			gui.box(204, 205, 222, 217, notSelectedColor, "black")
			gui.text(208, 208, "OFF")
			gui.box(222, 205, 232, 217, selectedColor, "black")
			gui.text(226, 208, "S")
			gridSizeFactor = 2
		elseif x > 232 and x < 242 and y > 205 and y < 217 then
			gui.box(204, 205, 222, 217, notSelectedColor, "black")
			gui.text(208, 208, "OFF")
			gui.box(232, 205, 242, 217, selectedColor, "black")
			gui.text(236, 208, "M")
			gridSizeFactor = 1.4285714285714285714285714285714
		elseif x > 242 and x < 252 and y > 205 and y < 217 then
			gui.box(204, 205, 222, 217, notSelectedColor, "black")
			gui.text(208, 208, "OFF")
			gui.box(242, 205, 252, 217, selectedColor, "black")
			gui.text(246, 208, "B")
			gridSizeFactor = 1
		end
		
	end	
	
	if gridSizeFactor ~= 0 then
		-- draw grid
		local fillColor = "#ffffff55" -- transparent
		local outlineColor = "#090909aa" -- black
		local gridX1 = marioCenterX - 50 / gridSizeFactor
		local gridY1 = marioCenterY - 100 / gridSizeFactor
		local gridX2 = gridX1 + 10 / gridSizeFactor
		local gridY2 = gridY1 + 10 / gridSizeFactor
	
		for collumn = 1, 10  do
			for row = 1, 17 do
				gui.box(gridX1, gridY1, gridX2, gridY2, fillColor, outlineColor)
				gridY1 = gridY1 + 10 / gridSizeFactor
				gridY2 = gridY2 + 10 / gridSizeFactor
			end
			gridY1 = marioCenterY - 100 / gridSizeFactor
			gridY2 = gridY1 + 10 / gridSizeFactor
			gridX1 = gridX1 + 10 / gridSizeFactor
			gridX2 = gridX2 + 10 / gridSizeFactor
		end
		gui.line(marioCenterX - 50 / gridSizeFactor, marioCenterY, marioCenterX + 50 / gridSizeFactor, marioCenterY, "blue")
		gui.line(marioCenterX, marioCenterY - 100 / gridSizeFactor, marioCenterX, marioCenterY + 70 / gridSizeFactor, "blue")
			
		-- draw vector
		gui.line(marioCenterX, marioCenterY, marioCenterX + xSpeed/gridSizeFactor, marioCenterY + ySpeed/gridSizeFactor, spdVectorColor)
	end
end

-- draw sprite info on screen
function smwDrawSpriteInfo()
    if not (smwGameMode == gameMode_level) then return end

    gui.opacity(guiOpacity)
    local cameraX = memory.readwordsigned(RAM_cameraX)
    local cameraY = memory.readwordsigned(RAM_cameraY)
    local spriteCount = 0
	local yoshiColor = "#40ff40" -- green
    local colorTable = {
        "#80ffff", -- cyan
        "#a0a0ff", -- blue
        "#ff6060", -- red
        "#ff80ff", -- magenta
        "#ffa100", -- orange
        "#ffff80", -- yellow
		"#ffffff"  -- white
    }
    for id = 0, smwSpriteMaxCount - 1 do
        local stat = memory.readbyte(0x7e14c8+id)
        local hOffscreen = (memory.readbyte(0x7e15a0+id) ~= 0)
        local vOffscreen = (memory.readbyte(0x7e186c+id) ~= 0)
        local number = memory.readbyte(0x7e009e+id)
        local x = memory.readbytesigned(0x7e14e0+id) * 0x100 + memory.readbyte(0x7e00e4+id)
        local y = memory.readbytesigned(0x7e14d4+id) * 0x100 + memory.readbyte(0x7e00d8+id)
        local xsub = memory.readbyte(0x7e14f8+id)
        local ysub = memory.readbyte(0x7e14ec+id)
        local xspeed = memory.readbyte(0x7e00b6+id)
        local yspeed = memory.readbyte(0x7e00aa+id)
        local hOffscreenAlt = (math.abs(cameraX - x + 112) > 176)
        local vOffscreenAlt = (math.abs(cameraY - y + 88) > 208)

        if stat ~= 0 then -- not hOffscreen and not vOffscreen then
            local dispString = string.format("<%02d> %02x (%d.%02x, %d.%02x)", id, number, x, xsub, y, ysub)
			local dispString = string.upper(dispString) -- to make sprite hex number easier to read
            if number == 53 then -- when Yoshi
				local colorString = yoshiColor
				if not vOffscreenAlt and not hOffscreenAlt then
					gui.text(math.min(242, math.max(2, 2 + x - cameraX)), math.min(216, math.max(2, -8 + y - cameraY)), string.format("<%02d>", id), colorString)
				end
				gui.text(160, 36 + spriteCount * 8, dispString, colorString)
				spriteCount = spriteCount + 1
			else
				local colorString = colorTable[1 + id % #colorTable]
				if not vOffscreenAlt and not hOffscreenAlt then
					gui.text(math.min(242, math.max(2, 2 + x - cameraX)), math.min(216, math.max(2, -8 + y - cameraY)), string.format("<%02d>", id), colorString)
				end
				gui.text(160, 36 + spriteCount * 8, dispString, colorString)
				spriteCount = spriteCount + 1
			end
        end
    end
    gui.text(238-24, 2, string.format("Sprites:%02d", spriteCount))
end

-- draw main info on screen
function smwDrawMainInfo()
    if not (smwGameMode == gameMode_level) then return end

    gui.opacity(guiOpacity)
    local frameCount = memory.readbyte(RAM_frameCount)
    local frameCountAlt = memory.readbyte(RAM_frameCountAlt)
    local powerup = memory.readbyte(RAM_powerup)
    local pMeter = memory.readbyte(RAM_pMeter)
    local takeOffMeter = memory.readbyte(RAM_takeOffMeter)
    local starInvCount = memory.readbyte(RAM_starInvCount)
    local hurtInvCount = memory.readbyte(RAM_hurtInvCount)
    local cameraX = memory.readword(RAM_cameraX)
    local cameraY = memory.readword(RAM_cameraY)
    local xSpeed = memory.readbytesigned(RAM_xSpeed)
    local ySpeed = memory.readbytesigned(RAM_ySpeed)
    local xSubSpeed = memory.readbyte(RAM_xSubSpeed)
    local xPos = memory.readwordsigned(RAM_xPos)
    local yPos = memory.readwordsigned(RAM_yPos)
    local xSubPos = memory.readbyte(RAM_xSubPos)
    local ySubPos = memory.readbyte(RAM_ySubPos)
    local facingDirection = memory.readbyte(RAM_facingDirection)
    local flightAnimation = memory.readbyte(RAM_flightAnimation)
    local capeSlowFallCount = memory.readbyte(RAM_capeSlowFallCount)
    local capeSpinTimer = memory.readbyte(RAM_capeSpinTimer)
    local bluePOW = memory.readbyte(RAM_bluePOW)
    local grayPOW = memory.readbyte(RAM_grayPOW)
    local multipleCoinBlockTimer = memory.readbyte(RAM_multipleCoinBlockTimer)
    local directionalCoinTimer = memory.readbyte(RAM_directionalCoinTimer)
    local pBalloonTimer = memory.readbyte(RAM_pBalloonTimer)
    local pBalloonTimerAlt = memory.readbyte(RAM_pBalloonTimerAlt)
    local ropeClimbingFlag = memory.readbyte(RAM_ropeClimbingFlag)
	local RNG = memory.readbyte(RAM_RNG)
	local blockedStatus = memory.readbyte(RAM_blockedStatus)

    local timerPosition = 148
    local timerCount = 1
    function timerCountPlus()
        timerCount = timerCount + 1
    end

    if ropeClimbingFlag == 8 then
        gui.text(1, 148, string.format("rope flag: ON"))
    end

    if multipleCoinBlockTimer ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("multiCoin: %d", multipleCoinBlockTimer))
        timerCountPlus()
    end

    if grayPOW ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("grayPOW: %d", grayPOW * 4 - frameCountAlt % 4))
        timerCountPlus()
    end

    if bluePOW ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("bluePOW: %d", bluePOW * 4 - frameCountAlt % 4))
        timerCountPlus()
    end

    if directionalCoinTimer ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("dirCoin: %d", directionalCoinTimer * 4 - frameCount % 4))
        timerCountPlus()
    end

    if starInvCount ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("star: %d", starInvCount * 4 - (frameCountAlt - 3) % 4))
        timerCountPlus()
    end

    if hurtInvCount ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("invinc: %d", hurtInvCount))
        timerCountPlus()
    end

    if pBalloonTimerAlt ~= 0 then
        gui.text(1, timerPosition - timerCount * 8, string.format("P-balloon: %d", pBalloonTimer * 4 - frameCount % 4))
        timerCountPlus()
    end

    if powerup == 2 then
        gui.text(1, 84, string.format("%d, %d", capeSpinTimer, capeSlowFallCount))
    end

    if pMeter ~= 0 or takeOffMeter ~= 0 then
        gui.text(1, 76, string.format("Meter (%03d, %02d)", pMeter, takeOffMeter))
    end
	
	if facingDirection == 0 then
		facingDirection = "<-"
	else
		facingDirection = "->"
	end
	
    if flightAnimation == 0 then
        gui.text(1, 52, string.format("%s", facingDirection))
    else
        gui.text(1, 52, string.format("%s, %d", facingDirection, flightAnimation))
    end
	
	-- Blocked Status
	local blockedStatusStr = {}
    if blockedStatus == 1 then
        blockedStatusStr = "R    "
    elseif blockedStatus == 2 then
        blockedStatusStr = " L   "
    elseif blockedStatus == 4 then
		blockedStatusStr = "  D  "
	elseif blockedStatus == 5 then
		blockedStatusStr = "R D  "
	elseif blockedStatus == 6 then
		blockedStatusStr = " LD  "
	elseif blockedStatus == 8 then
		blockedStatusStr = "   U "
	elseif blockedStatus == 9 then
		blockedStatusStr = "R  U "
	elseif blockedStatus == 10 then
        blockedStatusStr = "  LU "
    elseif blockedStatus == 25 then
		blockedStatusStr = "    M"
	elseif blockedStatus == 129 then
		blockedStatusStr = "R     border"
	elseif blockedStatus == 130 then
		blockedStatusStr = " L    border"
	elseif blockedStatus == 133 then
		blockedStatusStr = "R D   border"
	elseif blockedStatus == 134 then
		blockedStatusStr = " LD   border"
	else
		blockedStatusStr = "     "
	end	
	-- draw blocked status
	local weak_color = "#b0a9a9a9" -- gray
	local warning_color = "#ff2222" -- red
    gui.text(1, 60, "Blocked: ")
	gui.text(36, 60, "RLDUM", weak_color)
    gui.text(36, 60, string.format("%s", blockedStatusStr), warning_color)
		
    gui.text(1, 36, string.format("Pos (%d.%02x, %d.%02x)", xPos, xSubPos, yPos, ySubPos))
    local xSpeedComposite = xSpeed + (xSubSpeed / 0x100)
    local xSpeedInt, xSpeedFrac = math.modf(xSpeedComposite)
    gui.text(1, 44, string.format("Spd (%d(%.0f.%02x), %d)", xSpeed, xSpeedInt, math.abs(xSpeedFrac * 0x100), ySpeed))
	gui.text(1, 68, string.format("Power: %02d", powerup))
	
	gui.text(160, 2, string.format("RNG(%04x)", RNG))
end

-- draw yoshi info on screen
function smwDrawYoshiInfo()
    if not (smwGameMode == gameMode_level) then return end

    gui.opacity(guiOpacity)
    local yoshiId = 0
	local yoshiColor = "#40ff40" -- green

    -- search for yoshi's ID
    while memory.readbyte(0x7e009e + yoshiId) ~= 53 do
        yoshiId = yoshiId +1
        if yoshiId >= 12 then return end
    end

    local yoshiStat = memory.readbyte(0x7e14c8 + yoshiId)
    local spriteIdYoshiEat = memory.readbyte(0x7e160e + yoshiId)
    local spriteTypeYoshiEat = memory.readbyte(0x009e + spriteIdYoshiEat)
    local yoshiTongueLength = memory.readbyte(0x7e151c + yoshiId)
    local yoshiTongueStopTimer = memory.readbyte(0x7e1558 + yoshiId)
	local yoshiSwallowTimer = memory.readbyte(0x7e18ac)

    local factor1 = spriteIdYoshiEat == 255 and "OFF" or string.format("<%02d>", spriteIdYoshiEat)
    local factor2 = spriteIdYoshiEat == 255 and "OFF" or string.upper(string.format("%x",spriteTypeYoshiEat))

    if yoshiStat ~= 0 then
        gui.text(1, 156, string.format("Yoshi (%s, %s, %d, %d)", factor1, factor2, yoshiTongueLength, yoshiTongueStopTimer, ppp), yoshiColor)
		if yoshiSwallowTimer ~= 0 then
		gui.text(1, 164, string.format("Swallow: %d", yoshiSwallowTimer), yoshiColor)
		end
	end
end

-- display some useful information
function smwDisplayInfo()
    if showPMeter then
        smwDrawPMeter()
    end
	if showSpeedVector then
		smwDrawSpeedVector()
	end
    if showSpriteInfo then
        smwDrawSpriteInfo()
    end
    if showMainInfo then
        smwDrawMainInfo()
    end
    if showYoshiInfo then
        smwDrawYoshiInfo()
    end
end

-- [ core ] --------------------------------------------------------------------

emu.registerbefore(function()
    scanJoypad()
    scanInputDevs()
    smwScanStatus()
    if not movie.active() then
       if smwPlayer <= pad_max then
           smwApplyCheats()
       end
       sendJoypad()
    end
end)

emu.registerafter(function()
end)

emu.registerexit(function()
    if not movie.active() and smwMoveMethod == moveMethod_free then
        memory.writebyte(RAM_frozen, 0) -- unfreeze Mario
    end
end)

gui.register(function()
    smwDisplayInfo()
end)
