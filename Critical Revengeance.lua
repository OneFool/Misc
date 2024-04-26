repeat
    wait()
until game:IsLoaded()
wait()

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

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/OneFool/intro/main/custom%20intro%20orion')))()
local Window = OrionLib:MakeWindow({
    Name = "Fool Hub | Critical Revengeance",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "FHCriticalRevengeance"
})

local lp = game:GetService("Players").LocalPlayer
function tweener(CFramee, time)
    local tween = game:GetService("TweenService"):Create(
        lp.Character.HumanoidRootPart,
        TweenInfo.new(time), { CFrame = CFramee })
    tween:Play()
end

-- Local

local PlayerSec = Window:MakeTab({
    Name = "Local",
    Icon = "rbxassetid://5009915795",
    PremiumOnly = false
})

PlayerSec:AddToggle({
    Name = "Anti-Aggro",
    Default = false,
    Save = true,
    Flag = "AntiAg",
    Callback = function(Value)
        getgenv().NoCombat = Value

        local OldNameCall = nil
        OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
            local Arg = { ... }
            if self.Name == "CombatTrigger" and NoCombat then
                return
            end
            return OldNameCall(self, ...)
        end)
    end
})

PlayerSec:AddToggle({
    Name = "Auto Hit Orbs",
    Default = false,
    Callback = function(Value)
        getgenv().AutoOrb = Value

        while AutoOrb do
            task.wait(0.5)
            for _, Orb in pairs(workspace:WaitForChild("CombatFolder"):GetDescendants()) do
                if Orb:IsA("Model") and Orb:FindFirstChild("OrbDestroy") then
                    local CFramee = Orb.WorldPivot
                    local time = 0.5
                    tweener(CFramee, time)
                end
            end
        end
    end
})
