local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
-- GUI (không mất khi chết)
local gui = Instance.new("ScreenGui")
gui.Name = "HomeGui"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game.CoreGui end)
if not gui.Parent then
gui.Parent = player:WaitForChild("PlayerGui")
end
-- NÚT TRÒN
local button = Instance.new("TextButton")
button.Size = UDim2.new(0,70,0,70)
button.Position = UDim2.new(0.5,-35,0.5,-35)
button.Text = "🏠"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(255,0,0)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = gui
-- BO GÓC THÀNH HÌNH TRÒN
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = button
-- VIỀN ĐẸP
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Parent = button
-- =====================
-- 🟢 DRAG (PC + MOBILE)
-- =====================
local dragging = false
local dragStart, startPos
button.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = button.Position
end
end)
button.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
UIS.InputChanged:Connect(function(input)
if dragging and (
input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch
) then
local delta = input.Position - dragStart
button.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
-- =====================
-- 🔻 TELEPORT XUỐNG 80 STUDS
-- =====================
button.MouseButton1Click:Connect(function()
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
-- dịch xuống 80 studs
hrp.CFrame = hrp.CFrame - Vector3.new(0,200,0)
end)
