local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
game:GetService("RunService").RenderStepped:Connect(function()
    if mouse.Target.Parent:FindFirstChild("Humanoid") and mouse.Target.Parent.Name ~= player.Name and Workspace.Camera:WorldToScreenPoint(mouse.Target.Parent.Head.Position) then
        mouse1press()
        wait()
        mouse1release()
    end
end)
