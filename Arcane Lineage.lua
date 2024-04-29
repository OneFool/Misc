-- THIS SCRIPT WAS MADE FOR PERSONAL USE MEANING IT HAS VERY LITTLE OPTIMIZATION.

repeat
    wait()
until game:IsLoaded()
wait()

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

-- Client AntiKick
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if not checkcaller() and string.lower(getnamecallmethod()) == "kick" then
        return nil
    end

    return OldNamecall(...)
end))

------------------------Anti_AFK----------------------------------
if getconnections then
    for _, v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
        v:Disable()
    end
end

if not getconnections then
    game:GetService("Players").LocalPlayer.Idled:connect(
        function()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end
    )
end
------------------------End_Anti_AFK------------------------------

local NPCList = {}
local QuestNPCList = {}
local Moves = {}
local Items = {}
local AntiDupeItems = { "Carnastool", "Everthistle", "Hightail", "Driproot", "Slime Chunk", "Mushroom Cap", "Crylight",
    "Cryastem", "Sneak", "Bestiary", "Pickaxe" }
local lp = game:GetService("Players").LocalPlayer
local BlacklistedNPC = { "Quest", "Filler", "Aretim", "PurgNPC", "ExampleNPC", "Pup 1", "Pup 2", "Pup 3", "SlimeStatue3" }
Boolerean = nil
local orgwalk = lp.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed
local orgjump = lp.Character:FindFirstChildWhichIsA("Humanoid").JumpPower
local Walkspeeder = false
local JumpPowerr = false
local CurrentWalkspeed = 16
local CurrentJumpPower = 50

function checkforfight()
    if game:GetService("Workspace").Living[lp.Name]:FindFirstChild("FightInProgress") then
        Boolerean = true
    else
        Boolerean = false
    end
end

function getproximity()
    for _, Cauldrons in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
        if Cauldrons:IsA("ProximityPrompt") then
            fireproximityprompt(Cauldrons)
        end
    end
end

function getclicker()
    for _, CauldronsClick in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
        if CauldronsClick:IsA("ClickDetector") then
            fireclickdetector(CauldronsClick)
        end
    end
end

for _, Movess in next, lp.PlayerGui.StatMenu.SkillMenu.Actives:GetChildren() do
    if Movess:IsA("TextButton") then
        table.insert(Moves, Movess.Name)
    end
end

for _, Itemss in next, lp.Backpack.Tools:GetChildren() do
    if Itemss:IsA("StringValue") and not table.find(AntiDupeItems, Itemss.Name) then
        local itemName = Itemss.Name
        table.insert(Items, itemName)
    end
end

for _, NPC in next, game:GetService("Workspace").NPCs:GetChildren() do
    if NPC:IsA("Model") and not table.find(BlacklistedNPC, NPC.Name) then
        table.insert(NPCList, NPC.Name)
    end
end

for _, QuestNPC in next, game:GetService("Workspace").NPCs.Quest:GetChildren() do
    if QuestNPC:IsA("Model") then
        table.insert(QuestNPCList, QuestNPC.Name)
    end
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()
local Window = OrionLib:MakeWindow({
    Name = "Fool Hub | Arcane Lineage",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "FoolArcLin"
})

-- Character

local PlayerSec = Window:MakeTab({
    Name = "Character",
    Icon = "rbxassetid://5009915795",
    PremiumOnly = false
})

PlayerSec:AddToggle({
    Name = "No Fall-DMG",
    Default = false,
    Save = true,
    Flag = "NoFall",
    Callback = function(Value)
        getgenv().NoFall = (Value)

        local OldNameCall = nil
        OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
            local Arg = { ... }
            if self.Name == "EnviroEffects" and NoFall then
                return
            end
            return OldNameCall(self, ...)
        end)
    end
})

PlayerSec:AddToggle({
    Name = "Mastery Point Notifier",
    Default = false,
    Save = true,
    Flag = "MasteryNotifier",
    Callback = function(Value)
        getgenv().MasteryNoti = Value

        lp.PlayerGui.ClassMastery.Main.Points:GetPropertyChangedSignal("Text"):Connect(function()
            if MasteryNoti then
                OrionLib:MakeNotification({
                    Name = "Mastery Point(s) Gained!",
                    Content = "If you just put a point into your mastery tree ignore this!",
                    Image = "rbxassetid://12614663538",
                    Time = 10
                })
            end
        end)
    end
})

PlayerSec:AddButton({
    Name = "Heal At Doctor",
    Callback = function()
        local oldcframe = lp.Character.HumanoidRootPart.CFrame

        lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCs.Doctor.Head
            .CFrame
        task.wait(0.6)
        fireproximityprompt(game:GetService("Workspace").NPCs.Doctor.Head.ProximityPrompt)
        lp.PlayerGui:WaitForChild("NPCDialogue")
        lp.PlayerGui.NPCDialogue.RemoteEvent:FireServer(lp.PlayerGui.NPCDialogue.BG.Options.Option)
        task.wait(0.4)
        lp.Character.HumanoidRootPart.CFrame = oldcframe
    end
})

PlayerSec:AddToggle({
    Name = "Enable Walkspeed",
    Default = false,
    Callback = function(Value)
        Walkspeeder = Value
        while Walkspeeder do
            task.wait()
            if Walkspeeder then
                lp.Character.Humanoid.WalkSpeed = CurrentWalkspeed
            elseif not Walkspeeder then
                lp.Character.Humanoid.WalkSpeed = orgwalk
                task.wait()
            end
        end
    end
})

PlayerSec:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "Walkspeed",
    Callback = function(Value)
        CurrentWalkspeed = Value
        if Walkspeeder then
            lp.Character.Humanoid.WalkSpeed = Value
        end
    end
})

PlayerSec:AddToggle({
    Name = "Enable JumpPower",
    Default = false,
    Callback = function(Value)
        JumpPowerr = Value
        if Value then
            lp.Character.Humanoid.JumpPower = CurrentJumpPower
        elseif not Value then
            lp.Character.Humanoid.JumpPower = orgjump
        end
    end
})

PlayerSec:AddSlider({
    Name = "JumpPower",
    Min = tonumber(lp.Character.Humanoid.JumpPower),
    Max = 250,
    Default = tonumber(lp.Character.Humanoid.JumpPower),
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "JumpPower",
    Callback = function(Value)
        CurrentJumpPower = Value
        if JumpPowerr then
            lp.Character.Humanoid.JumpPower = Value
        end
    end
})

-- Combat

local Combat = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://5009915795",
    PremiumOnly = false
})

Combat:AddToggle({
    Name = "Auto-Dodge",
    Default = false,
    Save = true,
    Flag = "AutoDodge",
    Callback = function(Value)
        if not AutoBlock then
            getgenv().AutoDodge = (Value)

            while AutoDodge and game:GetService("Workspace").Living[lp.Name]:WaitForChild("FightInProgress") do
                task.wait()
                local ohTable1 = {
                    [1] = true,
                    [2] = true
                }
                local ohString2 = "DodgeMinigame"

                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohTable1, ohString2)
                task.wait()
            end
        else
            OrionLib:MakeNotification({
                Name = "Warning:",
                Content = "Disable Auto-Block and Re-Enable this to use it",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})

Combat:AddToggle({
    Name = "Auto-Block",
    Default = false,
    Save = true,
    Flag = "AutoBlock",
    Callback = function(Value)
        if not AutoDodge then
            getgenv().AutoBlock = (Value)

            while AutoBlock and game:GetService("Workspace").Living[lp.Name]:WaitForChild("FightInProgress") do
                task.wait()
                local ohTable1 = {
                    [1] = true,
                    [2] = false
                }
                local ohString2 = "DodgeMinigame"

                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohTable1, ohString2)
                task.wait()
            end
        else
            OrionLib:MakeNotification({
                Name = "Warning:",
                Content = "Disable Auto-Dodge and Re-Enable this to use it",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})

Combat:AddToggle({
    Name = "Auto-QTE",
    Default = false,
    Save = true,
    Flag = "AutoQTE",
    Callback = function(Value)
        getgenv().AutoQTE = (Value)
        local BaseClass = lp.PlayerGui.StatMenu.Holder.ContentFrame.Stats.Body.RightColumn.Content.BaseClass.Type.Text

        while AutoQTE and game:GetService("Workspace").Living[lp.Name]:WaitForChild("FightInProgress") do
            task.wait()

            -- Wizard
            if BaseClass == "Wizard" then
                local ohBoolean1 = true
                local ohString2 = "MagicQTE"
                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohBoolean1, ohString2)
                lp.PlayerGui.Combat.MagicQTE.Visible = false

                -- Thief
            elseif BaseClass == "Thief" then
                local ohBoolean1 = true
                local ohString2 = "DaggerQTE"
                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohBoolean1, ohString2)
                lp.PlayerGui.Combat.DaggerQTE.Visible = false

                -- Slayer
            elseif BaseClass == "Slayer" then
                local ohBoolean1 = true
                local ohString2 = "SpearQTE"
                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohBoolean1, ohString2)
                lp.PlayerGui.Combat.SpearQTE.Visible = false
                -- Fist
            elseif BaseClass == "Martial Artist" then
                local ohBoolean1 = true
                local ohString2 = "FistQTE"
                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohBoolean1, ohString2)
                lp.PlayerGui.Combat.FistQTE.Visible = false
                -- Sword
            elseif BaseClass == "Warrior" then
                local ohBoolean1 = true
                local ohString2 = "SwordQTE"
                game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohBoolean1, ohString2)
                lp.PlayerGui.Combat.SwordQTE.Visible = false
                task.wait()
            end
        end
    end
})

Combat:AddToggle({
    Name = "Auto-Attack",
    Default = false,
    Callback = function(Value)
        getgenv().AutoAttack = (Value)

        pcall(function()
            local function performAttack(target)
                local ohString1 = "Attack"
                local ohString2 = tostring(MoveToUse)
                local ohTable3 = {
                    ["Attacking"] = target
                }

                local energyText = lp.PlayerGui.HUD.Holder.EnergyOutline.Count.Text
                local slashPos = string.find(energyText, "/")
                local energy = tonumber(string.sub(energyText, 1, slashPos - 1))

                if energy >= tonumber(lp.PlayerGui.StatMenu.SkillMenu.Actives[MoveToUse].Cost.Text) then
                    lp.PlayerGui.Combat.CombatHandle.RemoteFunction:InvokeServer(ohString1, ohString2, ohTable3)

                    task.wait(2)
                    local ohString11 = "Attack"
                    local ohString22 = "Strike"
                    local ohTable33 = {
                        ["Attacking"] = target
                    }
                    lp.PlayerGui.Combat.CombatHandle.RemoteFunction:InvokeServer(ohString11, ohString22, ohTable33)
                else
                    local ohString1 = "Attack"
                    local ohString2 = "Strike"
                    local ohTable3 = {
                        ["Attacking"] = target
                    }
                    lp.PlayerGui.Combat.CombatHandle.RemoteFunction:InvokeServer(ohString1, ohString2, ohTable3)
                    task.wait(2)
                end
            end

            while AutoAttack do
                task.wait(1)
                checkforfight()
                task.wait(1.1)
                if Boolerean == true then
                    local enemiesToAttack = {}
                    for _, Enemies in next, game:GetService("Workspace").Living:GetDescendants() do
                        if Enemies:IsA("IntValue") and Enemies.Value == game:GetService("Workspace").Living[lp.Name]:WaitForChild("FightInProgress").Value and Enemies.Parent.Name ~= lp.Name then
                            table.insert(enemiesToAttack, Enemies.Parent.Name)

                            for _, enemyName in ipairs(enemiesToAttack) do
                                local enemy = game:GetService("Workspace").Living[enemyName]
                                if enemy then
                                    performAttack(enemy)
                                end
                                task.wait(1)
                            end
                        end
                    end
                end
            end
        end)
    end
})

Combat:AddDropdown({
    Name = "Auto-Attack Move",
    Default = "",
    Options = Moves,
    Callback = function(Value)
        MoveToUse = Value
    end
})

-- Automation

local Automation = Window:MakeTab({
    Name = "Automation",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

local Plants = Automation:AddSection({
    Name = "Use an Abhorrent Elixir Before Using The Plant Farm To Avoid Fights"
})

Plants:AddButton({
    Name = "Pickup All Plants",
    Callback = function()
        local avoidCFrame = CFrame.new(1465.6145, 48.1683693, -3372.54272, -0.406715393, 0, -0.913554907, 0, 1, 0,
            0.913554907, 0, -0.406715393)
        local trinkets = {}
        local originalLocation = lp.Character.HumanoidRootPart.CFrame

        for _, Trinket in pairs(game:GetService("Workspace").SpawnedItems:GetDescendants()) do
            if Trinket:IsA("Part") and Trinket.Name == "ClickPart" and Trinket.CFrame ~= avoidCFrame then
                table.insert(trinkets, Trinket)
            end
        end

        for _, Trinket in ipairs(trinkets) do
            lp.Character.HumanoidRootPart.CFrame = Trinket.CFrame
            task.wait(0.35)
            for _, v in pairs(game:GetService("Workspace").SpawnedItems:GetDescendants()) do
                if v:IsA("ClickDetector") and lp:DistanceFromCharacter(v.Parent.Position) <= 10 then
                    fireclickdetector(v)
                end
            end
        end
        lp.Character.HumanoidRootPart.CFrame = originalLocation
    end
})

local Brew = Automation:AddSection({
    Name = "Auto Brew"
})

Brew:AddDropdown({
    Name = "Potion To Auto Brew",
    Default = "",
    Options = { "Small Healing Potion", "Medium Healing Potion", "Minor Energy Elixir", "Average Energy Elixer", "Minor Empowering Elixir", "Minor Absorbing Potion", "Ferrus Skin Potion", "Invisibility Potion", "Light of Grace", "Heartbreaking Elixir", "Heartsoothing Remedy", "Abhorrent Elixir", "Alluring Elixir" },
    Callback = function(Value)
        Potion = Value
    end
})

Brew:AddToggle({
    Name = "Auto Brew Potion",
    Default = false,
    Callback = function(Value)
        local originalCameraSubject = game.Workspace.CurrentCamera.CameraSubject
        local originalCameraCF = game.Workspace.CurrentCamera.CFrame
        local originalCameraType = game.Workspace.CurrentCamera.CameraType

        getgenv().AutoBrew = (Value)

        while AutoBrew do
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(2659.95288, 389.135986, -3946.76294, 0.993850768,
                4.01330915e-08, 0.110727936, -4.54039046e-08, 1, 4.50799895e-08, -0.110727936, -4.98302626e-08,
                0.993850768)
            for _, CauldronPos in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
                if CauldronPos:IsA("BasePart") and CauldronPos.CFrame == CFrame.new(2660.21313, 385.237915, -3945.37964, -0.990265131, 0.139194876, 6.78002834e-07, -6.78002834e-07, -9.77516174e-06, 1.00000012, 0.139194876, 0.990265071, 9.7155571e-06) then
                    CauldronPos.Name = "AutoCaul"
                    CauldronPos.Parent.Name = "AutoCauldron"
                end
            end

            local Workspace = game.Workspace
            local Part = game:GetService("Workspace").Cauldrons.AutoCauldron["AutoCaul"]

            Workspace.CurrentCamera.CameraSubject = Part
            Workspace.CurrentCamera.CoordinateFrame = Part.CFrame
            Workspace.CurrentCamera.CameraType = "Scriptable"
            task.wait(0.1)

            if Potion == "Heartbreaking Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Carnastool") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Heartsoothing Remedy" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Cryastem") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Cryastem"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Heartsoothing Remedy" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Cryastem") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Cryastem"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Abhorrent Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Cryastem") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Cryastem"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Alluring Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Carnastool") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Small Healing Potion" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Slime Chunk") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Slime Chunk"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Medium Healing Potion" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Slime Chunk") and lp.Backpack.Tools:FindFirstChild("Carnastool") and lp.Backpack.Tools:FindFirstChild("Hightail") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Slime Chunk"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Hightail"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Minor Energy Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Carnastool") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Average Energy Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Everthistle") and lp.Backpack.Tools:FindFirstChild("Cryastem") and lp.Backpack.Tools:FindFirstChild("Restless Fragment") then
                local ohString1 = "Equip"
                local ohString2 = "Everthistle"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Cryastem"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Restless Fragment"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Minor Empowering Elixir" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Cryastem") and lp.Backpack.Tools:FindFirstChild("Carnastool") and lp.Backpack.Tools:FindFirstChild("Sand Core") then
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Cryastem"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Sand Core"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Minor Absorbing Potion" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Hightail") and lp.Backpack.Tools:FindFirstChild("Mushroom Cap") then
                local ohString1 = "Equip"
                local ohString2 = "Hightail"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Mushroom Cap"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Ferrus Skin Potion" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Carnastool") and lp.Backpack.Tools:FindFirstChild("Mushroom Cap") and lp.Backpack.Tools:FindFirstChild("Sand Core") then
                local ohString1 = "Equip"
                local ohString2 = "Carnastool"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Mushroom Cap"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Sand Core"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Invisibility Potion" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Driproot") and lp.Backpack.Tools:FindFirstChild("Hightail") and lp.Backpack.Tools:FindFirstChild("Haze Chunk") then
                local ohString1 = "Equip"
                local ohString2 = "Driproot"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Hightail"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Haze Chunk"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            elseif Potion == "Light of Grace" and AutoBrew and lp.Backpack.Tools:FindFirstChild("Phoenix Tear") and lp.Backpack.Tools:FindFirstChild("Crylight") and lp.Backpack.Tools:FindFirstChild("Haze Chunk") and lp.Backpack.Tools:FindFirstChild("Sand Core") and lp.Backpack.Tools:FindFirstChild("Driproot") then
                local ohString1 = "Equip"
                local ohString2 = "Phoenix Tear"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Crylight"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Haze Chunk"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Sand Core"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                local ohString1 = "Equip"
                local ohString2 = "Driproot"
                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, ohString2)
                task.wait(0.23)
                getproximity()
                task.wait(0.1)
                getclicker()
            else
                OrionLib:MakeNotification({
                    Name = "Missing Required Ingredient For:",
                    Content = tostring(Potion),
                    Image = "rbxassetid://12614663538",
                    Time = 5
                })
            end

            if not AutoBrew then
                Workspace.CurrentCamera.CameraSubject = originalCameraSubject
                Workspace.CurrentCamera.CFrame = originalCameraCF
                Workspace.CurrentCamera.CameraType = originalCameraType
                break
            end
        end
    end
})

local Merchant = Window:MakeTab({
    Name = "Merchant",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

Merchant:AddToggle({
    Name = "Merchant Notifier",
    Default = false,
    Save = true,
    Flag = "MerchantNoti",
    Callback = function(Value)
        getgenv().MerchNoti = (Value)
        getgenv().merchnotifier = false

        while MerchNoti do
            task.wait()
            if game:GetService("Workspace").NPCs:FindFirstChild("Mysterious Merchant") then
                OrionLib:MakeNotification({
                    Name = "Merchant Detected!",
                    Content = "The Mysterious Merchant Is Spawned!",
                    Image = "rbxassetid://12614663538",
                    Time = 10
                })
                merchnotifier = true
                task.wait(60)
                merchnotifier = false
            end
        end
    end
})

Merchant:AddButton({
    Name = "Teleport To Merchant",
    Callback = function()
        if game:GetService("Workspace").NPCs:FindFirstChild("Mysterious Merchant") then
            lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCs:FindFirstChild(
                "Mysterious Merchant").HumanoidRootPart.CFrame
        else
            OrionLib:MakeNotification({
                Name = "No Merchant Detected!",
                Content = "Cannot Teleport To Merchant, Not Spawned!",
                Image = "rbxassetid://12614663538",
                Time = 5
            })
        end
    end
})

-- Teleports

local Teleports = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

Teleports:AddDropdown({
    Name = "NPC's",
    Default = "",
    Options = NPCList,
    Callback = function(Value)
        local CFrameEnd = CFrame.new(game:GetService("Workspace").NPCs[Value]:FindFirstChild("HumanoidRootPart")
            .Position)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrameEnd })
        tween:Play()
    end
})

Teleports:AddDropdown({
    Name = "Quest NPC's",
    Default = "",
    Options = QuestNPCList,
    Callback = function(Value)
        local CFrameEnd = CFrame.new(game:GetService("Workspace").NPCs.Quest[Value]:FindFirstChild("HumanoidRootPart")
            .Position)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrameEnd })
        tween:Play()
    end
})

Teleports:AddDropdown({
    Name = "Specific Places",
    Default = "",
    Options = { "Caldera Spawn", "Ruins Spawn (Sand Town)", "Westwood Spawn", "Blades Spawn", "Yar'thul Gate",
        "Thorian Gate", "The Forgotten Sanctum", "Thanasius", "Westwood Apothecarian", "Deeproot Depths" },
    Callback = function(Value)
        if Value == "Caldera Spawn" then
            local CFrameEnd = CFrame.new(-221.396332, 46.5463257, -3328.51367, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Yar'thul Gate" then
            local CFrameEnd = CFrame.new(-4944.75781, 48.6970673, -3083.07324, -0.0124968914, -5.6133743e-08, 0.999921918,
                -6.00345373e-08, 1, 5.53878223e-08, -0.999921918, -5.93376726e-08, -0.0124968914)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Ruins Spawn (Sand Town)" then
            local CFrameEnd = CFrame.new(-2507.97217, 45.1969986, -2928.76367, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Westwood Spawn" then
            local CFrameEnd = CFrame.new(2531.55249, 388.945129, -3641.91064, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Thorian Gate" then
            local CFrameEnd = CFrame.new(2415.21777, 24.3336258, -429.789001, -0.720241308, -1.32400935e-08, 0.693723619,
                -3.0820011e-09, 1, 1.58857336e-08, -0.693723619, 9.30350552e-09, -0.720241308)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Blades Spawn" then
            local CFrameEnd = CFrame.new(-2930.36865, -36.1856079, -2022.60095, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "The Forgotten Sanctum" then
            local CFrameEnd = CFrame.new(5987.44678, 53.3530579, -3465.15186, 0.995714128, 3.02554888e-08, -0.0924842209,
                -3.60760062e-08, 1, -6.12634139e-08, 0.0924842209, 6.43373141e-08, 0.995714128)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Westwood Apothecarian" then
            local CFrameEnd = CFrame.new(2606.7832, 386.319122, -4042.98633, 0.999831498, -6.83423522e-08, 0.0183564071,
                6.99661413e-08, 1, -8.78168009e-08, -0.0183564071, 8.90863348e-08, 0.999831498)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Thanasius" then
            local CFrameEnd = CFrame.new(1675.40479, 5.31999874, -1663.76953, -0.404080033, 1.18365541e-07, 0.914723635,
                3.73702065e-08, 1, -1.1289201e-07, -0.914723635, -1.1433996e-08, -0.404080033)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        elseif Value == "Deeproot Depths" then
            local CFrameEnd = CFrame.new(5366.65625, 83.0383987, -2891.76953, 1, 5.01325315e-10, -5.26991848e-14,
                -5.01325315e-10, 1, -1.37222793e-08, 5.26923069e-14, 1.37222793e-08, 1)
            local Time = 0
            local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
                TweenInfo.new(Time), { CFrame = CFrameEnd })
            tween:Play()
        end
    end
})

Teleports:AddButton({
    Name = "Meditate",
    Callback = function()
        lp.Character.HumanoidRootPart.CFrame = workspace.Mats.MeditationMat.Root.CFrame
        task.wait(0.5)
        workspace.Living[lp.Name].MeditateHandler.Meditate:FireServer()
    end
})

local Misc = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

Misc:AddLabel("Do not use the data rollback on your main!")
Misc:AddToggle({
    Name = "Enable Data Rollback",
    Default = false,
    Save = false,
    Callback = function(Value)
        local rollbackChk = getgenv().Rollback or false
        getgenv().Rollback = Value

        if Rollback then
            OrionLib:MakeNotification({
                Name = "Rollback Enabled!",
                Content =
                "The data rollback is ready to use!",
                Image = "rbxassetid://12614663538",
                Time = 10
            })
            while Rollback do
                local ohNumber1 = 1
                local ohTable2 = {
                    ["1"] = "\237\190\140"
                }

                game:GetService("ReplicatedStorage").Remotes.Data.UpdateHotbar:FireServer(ohNumber1, ohTable2)
                task.wait()
                print("set")
            end
        else
            if rollbackChk then
                local ohNumber1 = 1
                local ohTable2 = {
                    ["1"] = ""
                }

                game:GetService("ReplicatedStorage").Remotes.Data.UpdateHotbar:FireServer(ohNumber1, ohTable2)
                OrionLib:MakeNotification({
                    Name = "Rollback Disabled!",
                    Content =
                    "Rollback has been canceled!",
                    Image = "rbxassetid://12614663538",
                    Time = 10
                })
                print("canceled")
            end
        end
    end
})

Misc:AddToggle({
    Name = "Auto-Drop Item",
    Default = false,
    Save = false,
    Callback = function(Value)
        getgenv().AutoDrop = Value

        if AutoDrop then
            while AutoDrop do
                local ohString1 = "Drop"
                local ohInstance3 = lp.Backpack.Tools:WaitForChild(Item)

                game:GetService("ReplicatedStorage").Remotes.Information.InventoryManage:FireServer(ohString1, Item,
                    ohInstance3)
                task.wait()
            end
        else
        end
    end
})

local id = Misc:AddDropdown({
    Name = "Item To Drop",
    Default = "",
    Options = Items,
    Callback = function(Value)
        Item = Value
    end
})

Misc:AddButton({
    Name = "Rejoin",
    Callback = function()
        local ts = game:GetService("TeleportService")
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    end
})

local AntiAFK = Misc:AddSection({
    Name = "Anti-AFK Built In"
})

local Info = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://12614663538",
    PremiumOnly = false
})

Info:AddLabel("My ONLY 2 Discords: fo.l | onefool")
Info:AddLabel("REPORT ERRORS TO MY DISCORD @fo.l")
Info:AddLabel("I recommend only using this script in a private server!")
Info:AddParagraph("Only Real Loadstring",
    "loadstring(game:HttpGet('https://raw.githubusercontent.com/OneFool/Misc/main/Arcane%20Lineage.lua'))()")
Info:AddButton({
    Name = "Copy Real Loadstring",
    Callback = function()
        setclipboard(
            "loadstring(game:HttpGet('https://raw.githubusercontent.com/OneFool/Misc/main/Arcane%20Lineage.lua'))()")
    end
})

OrionLib:MakeNotification({
    Name = "Warning:",
    Content =
    "If the auto attack doesn't work in the first fight after you enable it simply re-enable it and it should work from then on!",
    Image = "rbxassetid://12614663538",
    Time = 10
})

OrionLib:Init()
