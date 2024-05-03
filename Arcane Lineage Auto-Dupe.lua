repeat
    wait()
until game:IsLoaded()

task.wait(5)

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

task.wait(3)

-- Client AntiKick
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if not checkcaller() and string.lower(getnamecallmethod()) == "kick" then
        return nil
    end

    return OldNamecall(...)
end))

-- Main Code
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
getgenv().amountToDrop = 20         -- Amount of the item to drop, Dropping more than 50 of an item may result in the dupe not working
--]]

while Enabled do
    task.wait()
    if Players:FindFirstChild(target) then
        local targetPosition = workspace.Living[target].HumanoidRootPart.Position
        local direction = (targetPosition - lpc.HumanoidRootPart.Position).unit
        local teleportPosition = targetPosition - (direction * distancefrmplr)

        lpc:SetPrimaryPartCFrame(CFrame.new(teleportPosition, targetPosition))
        task.wait(0.2)

        local ohNumber1 = 1
        local ohTable2 = {
            ["1"] = "\237\190\140"
        }
        ReplicatedStorage.Remotes.Data.UpdateHotbar:FireServer(ohNumber1, ohTable2)

        task.wait()

        local droppedCount = 0
        repeat
            task.wait()
            DropItemToPlayer(itemtodrop)
            droppedCount = droppedCount + 1
            task.wait(1)
        until droppedCount >= amountToDrop

        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    else
        task.wait(5)
    end
end
