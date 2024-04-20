-- This will automatically update with every new Vehicle that is added assuming there isn't a change to the names of GUI's.
-- Made by @onefool
-- Was bored and they released a new game so why not

-- Game added adonis so I'm just adding this bypass in there just incase (bypass not made by me)
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
-- end of adonis bypass

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()

local Window = OrionLib:MakeWindow({
    Name = "✈️ Plane crash physics X",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = ""
})

local Main = Window:MakeTab({
    Name = "Vehicles",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Planes = {}

for _, v in next, game:GetService("Players").LocalPlayer.PlayerGui.PlaneSpawner.Frame.Frame.Planes:GetChildren() do
    if v.Name ~= "TXT" and not v.Name:match("Rank") and not v.Name:match("[GAMEPASS]") and v.Name ~= "UIGridLayout" then
        table.insert(Planes, v.Name)
    end
end

Main:AddDropdown({
    Name = "Spawn Any Vehicle",
    Default = "",
    Options = Planes,
    Callback = function(Value)
        game:GetService("ReplicatedStorage").SpawnCar:FireServer(Value)
    end
})
