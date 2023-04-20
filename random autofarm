local chara = game.Players.LocalPlayer.Character.HumanoidRootPart

getgenv().PickupAura = true
while PickupAura do
    task.wait(1)
    for i, Trinket in pairs(game:GetService("Workspace")["Trinket Spawners"]:GetChildren()) do
        if Trinket:IsA("Part") then
            chara.CFrame = Trinket.CFrame
        end
        task.wait(1)
        for i, v in pairs(game:GetService("Workspace")["Trinket Spawners"]:GetDescendants()) do
            if v:IsA("ClickDetector") and game.Players.LocalPlayer:DistanceFromCharacter(v.Parent.Position) <= 10 then
                fireclickdetector(v)
            end
        end
    end
end
