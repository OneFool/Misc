local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()
local Window = OrionLib:MakeWindow({ Name = "Fool Hub Ni2 Copies ", HidePremium = false, SaveConfig = true,
    ConfigFolder = "FoolNi2" })

local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Main:AddButton({
    Name = "No Fall-Damage",
    Callback = function()
        local OldNameCall
        OldNameCall = hookmetamethod(game, "__namecall", function(...)
            local Self, Args = ...
            local Args = { Args }
            if getnamecallmethod() == "FireServer" and tostring(Self) == "Fall" then
                Args[1] = 0
                return OldNameCall(Self, unpack(Args))
            end
            return OldNameCall(...)
        end)
    end
})

Main:AddSlider({
    Name = "Change Sprinting Speed",
    Min = 0,
    Max = 250,
    Default = 35,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        local mt = getrawmetatable(game)
        local newindex = mt.__newindex

        setreadonly(mt, false)
        mt.__newindex = newcclosure(function(self, property, new_value)
            if rawequal(self, game.Players.LocalPlayer.Character:WaitForChild("Humanoid")) and property == "WalkSpeed" and new_value >= 30 and new_value <= 36 then
                return newindex(self, property, (Value))
            end

            return newindex(self, property, new_value)
        end)
        setreadonly(mt, true)
    end
})

Main:AddButton({
    Name = "Reset and Respawn at Village",
    Callback = function()
        game.Players.LocalPlayer.Character.Head:Destroy()
    end
})
OrionLib:Init()
