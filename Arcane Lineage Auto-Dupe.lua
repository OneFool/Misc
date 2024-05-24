--[[
-- Executable
-- AUTO DUPE SETTINGS

-- IMPORTANT: YOU MUST HAVE THE PLAYER YOU'RE DUPING ITEMS TO LOADED IN SO JUST BE IN THE SAME AREA OF THE MAP AS THEM BEFORE USING SCRIPT.
-- IMPORTANT: YOU MUST HAVE THIS SCRIPT IN YOUR AUTO-EXECUTE FOLDER FOR THIS TO BE AUTOMATIC. | maybe will use queue_on_teleport soon but seemed to have some crashes
getgenv().Enabled = true            -- Change to false to disable
getgenv().target = ""          -- Exact CaSe SeNsItIvE username of the player you want to drop items to between the ""
getgenv().distancefrmplr = 3        -- The distance you are from the player after tping, don't change this unless you're experiencing problems
getgenv().itemtodrop = "" -- Exact name of the item you want to drop between the ""
getgenv().delay = 10 -- Delay before execution on rejoin | Setting this to low may result in you getting kicked!

loadstring(game:HttpGet("https://raw.githubusercontent.com/OneFool/Misc/main/Arcane%20Lineage%20Auto-Dupe.lua"))()
--]]

repeat
    wait()
until game:IsLoaded()

task.wait(tonumber(delay))
print("first wait")

-- Not my adonis bypass - Everything else made by me (OneFool)
local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}

local Detected, Kill

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")

        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc

            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if DEBUG then
                        warn("Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}")
                    end
                end

                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if DEBUG then
                    warn("Adonis AntiCheat tried to kill (fallback): {Info}")
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn("Adonis AntiCheat sanity check detected and broken")
        end

        return coroutine.yield(coroutine.running())
    end

    return Old(...)
end))
-- setthreadidentity(9)
setthreadidentity(7)
-- End Adonis Bypass

task.wait(2)
print("2nd wait")

-- Client AntiKick
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if not checkcaller() and string.lower(getnamecallmethod()) == "kick" then
        return nil
    end

    return OldNamecall(...)
end))

task.wait(0.5)
print("3rd wait")

-- Main Code
print("main code executed")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local lp = Players.LocalPlayer
local lpc = lp.Character

local function DropItemToPlayer(itemName)
    local ohString1 = "Drop"
    local ohInstance3 = lp.Backpack.Tools:FindFirstChild(itemName)
    if ohInstance3 then
        ReplicatedStorage.Remotes.Information.InventoryManage:FireServer(ohString1, itemName, ohInstance3)
    end
end

while Enabled do
    task.wait()
    if Players:FindFirstChild(target) then
        local targetPosition = workspace.Living[target].HumanoidRootPart.Position
        local direction = (targetPosition - lpc.HumanoidRootPart.Position).unit
        local teleportPosition = targetPosition - (direction * distancefrmplr)

        lpc:SetPrimaryPartCFrame(CFrame.new(teleportPosition, targetPosition))
        task.wait(0.2)

        local t = os.clock()

        repeat
            task.wait()
            local ohNumber1 = 1
            local ohTable2 = {
                ["1"] = "\237\190\140"
            }
            ReplicatedStorage.Remotes.Data.UpdateHotbar:FireServer(ohNumber1, ohTable2)
            DropItemToPlayer(itemtodrop)
        until os.clock() - t >= 20 or not lp.Backpack.Tools:FindFirstChild(itemtodrop)


        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    else
        print("else triggered")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    end
end
