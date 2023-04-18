-- This will automatically update with every new Vehicle that is added assuming there isn't a change to the names of GUI's.
-- Made by OneFool#7876

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "✈️ Plane crash physics 2",
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

for _, v in next, game:GetService("Players").LocalPlayer.PlayerGui.PlaneSpawner.Frame:GetChildren() do
    if v.Name ~= "TXT" and not v.Name:match("Rank") and v.Name ~= "GAMEPASS" then
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
