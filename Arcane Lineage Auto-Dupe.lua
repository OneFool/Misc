--[[
-- Executable
-- AUTO DUPE SETTINGS

-- IMPORTANT: YOU MUST HAVE THE PLAYER YOU'RE DUPING ITEMS TO LOADED IN SO JUST BE IN THE SAME AREA OF THE MAP AS THEM BEFORE USING SCRIPT.
-- IMPORTANT: YOU MUST HAVE THIS SCRIPT IN YOUR AUTO-EXECUTE FOLDER FOR THIS TO BE AUTOMATIC. | maybe will use queue_on_teleport soon but seemed to have some crashes
getgenv().Enabled = true            -- Change to false to disable
getgenv().target = ""          -- Exact CaSe SeNsItIvE username of the player you want to drop items to between the ""
getgenv().distancefrmplr = 3        -- The distance you are from the player after tping, don't change this unless you're experiencing problems
getgenv().itemtodrop = "" -- Exact name of the item you want to drop between the ""
getgenv().amountToDrop = 25         -- Amount of the item to drop, Dropping more than 30 of an item may result in the dupe not working
getgenv().delay = 10 -- Delay before execution on rejoin | Setting this to low may result in you getting kicked!

loadstring(game:HttpGet("https://raw.githubusercontent.com/OneFool/Misc/main/Arcane%20Lineage%20Auto-Dupe.lua"))()
--]]

repeat
    wait()
until game:IsLoaded()


-- getgenv().delay = 10 -- Delay before execution on rejoin | Setting this to low may result in you getting kicked!

task.wait(tonumber(delay))
print("first wait")

-- Not my adonis bypasses - Everything else made by me (OneFool)
for _, v in pairs(getgc(true)) do
    if pcall(function() return rawget(v, "indexInstance") end) and type(rawget(v, "indexInstance")) == "table" and (rawget(v, "indexInstance"))[1] == "kick" then
        v.tvk = { "kick", function() return game.Workspace:WaitForChild("") end }
    end
end

for _, v in next, getgc() do
    if typeof(v) == "function" and islclosure(v) and not isexecutorclosure(v) then
        local Constants = debug.getconstants(v)
        if table.find(Constants, "Detected") and table.find(Constants, "crash") then
            setthreadidentity(2)
            hookfunction(v, function()
                return task.wait(9e9)
            end)
            setthreadidentity(7)
        end
    end
end
-- End Adonis Bypasses

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

--[[
-- AUTO DUPE SETTINGS

-- IMPORTANT: YOU MUST HAVE THE PLAYER YOU'RE DUPING ITEMS TO LOADED IN SO JUST BE IN THE SAME AREA OF THE MAP AS THEM BEFORE USING SCRIPT.
-- IMPORTANT: YOU MUST HAVE THIS SCRIPT IN YOUR AUTO-EXECUTE FOLDER FOR THIS TO BE AUTOMATIC. | maybe will use queue_on_teleport soon but seemed to have some crashes
getgenv().Enabled = true            -- Change to false to disable
getgenv().target = ""          -- Exact username of the player you want to drop items to between the ""
getgenv().distancefrmplr = 3        -- The distance you are from the player after tping, don't change this unless you're experiencing problems
getgenv().itemtodrop = "" -- Exact name of the item you want to drop between the ""
getgenv().amountToDrop = 28       -- Amount of the item to drop, Dropping more than 50 of an item may result in the dupe not working
--]]

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
