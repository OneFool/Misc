local lp = game:GetService("Players").LocalPlayer
local MissionLabelUPD = true
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()
local Window = OrionLib:MakeWindow({
    Name = "Fool Hub | FFO",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "FoolFFO"
})

local Missions = Window:MakeTab({
    Name = "Missions",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

local MissionLabel = Missions:AddLabel("Current Mission: None")

spawn(function()
    while MissionLabelUPD do
        task.wait(0.1)
        local foundMission = false
        for _, MissionLBL in next, game:GetService("Workspace").MidGameMissions:GetDescendants() do
            if MissionLBL:IsA("StringValue") and MissionLBL.Value == lp.Name then
                MissionLabel:Set("Current Mission: " .. tostring(MissionLBL.Parent.Name))
                foundMission = true
                break
            end
        end
        if not foundMission then
            MissionLabel:Set("Current Mission: None")
        end
    end
end)

Missions:AddButton({
    Name = "Find Red Book",
    Callback = function()
        local book = game:GetService("Workspace").MidGameMissions.FindBook:FindFirstChild("Book")
        if book then
            fireclickdetector(book.ClickDetector)
        else
            OrionLib:MakeNotification({
                Name = "No Book Found!",
                Content = "Did you click the wrong button?",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})

Missions:AddButton({
    Name = "Plant All Fire Bugs",
    Callback = function()
        local FireBugMission = game:GetService("Workspace").MidGameMissions.PlantFireBugs.Area1:FindFirstChild(
            "MissionOnGoing")
        if FireBugMission and FireBugMission.Value == lp.Name then
            for _, v in pairs(game:GetService("Workspace").MidGameMissions.PlantFireBugs.Area1.Spots:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    fireclickdetector(v)
                end
            end
        else
            OrionLib:MakeNotification({
                Name = "You are not in fire bug mission!",
                Content = "Did you click the wrong button?",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})

Missions:AddButton({
    Name = "Escort Pillar",
    Callback = function()
        local Pillar = game:GetService("Workspace").Alive:FindFirstChild("Inca")
        if Pillar and Pillar:FindFirstChild("Carried") and Pillar:FindFirstChild("Carried").Value == lp.Name then
            local CFrameEnd = game:GetService("Workspace").MidGameMissions.EscortPillar.WalkPoints["_12"].CFrame
            local Time = 5
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        else
            OrionLib:MakeNotification({
                Name = "Not Carrying Pillar!",
                Content = "Please kill the Pillar and carry her!",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})