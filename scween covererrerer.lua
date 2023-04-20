local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(0)

local screen = Instance.new("ScreenGui")
screen.Parent = PlayerGui
local soulOd = Instance.new('ImageLabel', screen)
soulOd.Image = "rbxassetid://12614663538"
soulOd.ZIndex = 1
soulOd.BackgroundTransparency = 1
soulOd.BackgroundColor3 = Color3.new(.4,.4,.4)
soulOd.Size = UDim2.new(1,0,1,0)
local frame = Instance.new('Frame', screen)
frame.Size = UDim2.new(.715,0,0.1,0)
frame.Position = UDim2.new(.15, 0, .65, 0)
frame.BackgroundColor3 = Color3.new(.2,.2,.2)
frame.BackgroundTransparency = 1
local loadingBar = Instance.new('Frame', frame)
loadingBar.Size = UDim2.new(0,0,1,0)
loadingBar.ZIndex = 2
loadingBar.BackgroundTransparency = 0.8
loadingBar.BackgroundColor3 = Color3.new(.4,.4,.4)
local soulText = Instance.new('ImageLabel', screen)
soulText.Size = UDim2.new(1,0,1,0)
soulText.Position = UDim2.new(0,0,-0.08,0)
soulText.BackgroundTransparency = 1
soulText.ZIndex = 3
soulText.Image = "rbxassetid://12614663538"
