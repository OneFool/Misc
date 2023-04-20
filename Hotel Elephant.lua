local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()

local Window = OrionLib:MakeWindow({Name = "Hotel Elephant", HidePremium = false, SaveConfig = false, ConfigFolder = "nil"})

local Main = Window:MakeTab({
	Name = "Server",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Local = Window:MakeTab({
	Name = "Local",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Main:AddButton({
	Name = "Noclip entire map (Click Again to disable kinda slow)",
	Callback = function()
        for _,v in pairs(game:GetDescendants()) do
            game.ReplicatedStorage.DoorOpener:FireServer(v)
        end
  	end    
})

Main:AddTextbox({
	Name = "Give Everyone Money",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
    
    local a = false
    local b = (Value)
    local c = "Cash"
        for i,r in pairs(game.Players:GetPlayers()) do
		game:GetService("ReplicatedStorage").MoneyRequest:FireServer(a, b, c, r)
    end
	end
})

Main:AddTextbox({
	Name = "Spawn Any Boat",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
    game:GetService("ReplicatedStorage").BoatSpawner:InvokeServer((Value))
    end
})
local Section = Main:AddSection({
	Name = "Boat will not spawn if dock slot is full."
})
local Section = Main:AddSection({
	Name = "Exact Boat Names: Jetski, Transport Boat, Dinghy"
})

Local:AddTextbox({
	Name = "Give Yourself Money",
	Default = "",
	TextDisappear = true,
	Callback = function(Value2)
    local ohBoolean1 = false
    local ohString2 = (Value2)
    local ohString3 = "Cash"
    local ohInstance4 = game:GetService("Players").LocalPlayer
    game:GetService("ReplicatedStorage").MoneyRequest:FireServer(ohBoolean1, ohString2, ohString3, ohInstance4)
	end	  
})

Local:AddButton({
	Name = "Change to Neutral Team",
	Callback = function()
        game:GetService("ReplicatedStorage").ChangeTeam:InvokeServer('')
  	end    
})

Local:AddColorpicker({
	Name = "Change Ocean Color [Client-Sided]",
	Default = Color3.fromRGB(128, 187, 219),
	Callback = function(Value3)
		game:GetService("Workspace").OceanMover.WaterCave.Color = (Value3)
        game:GetService("Workspace").OceanMover.WaterDock.Color = (Value3)
        game:GetService("Workspace").OceanMover.WaterHeli.Color = (Value3)
	end	  
})
OrionLib:Init()
