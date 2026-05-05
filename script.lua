local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- FIX RESPAWN
player.CharacterAdded:Connect(function(char)
    character = char
    hrp = char:WaitForChild("HumanoidRootPart")
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ChatGPTv2"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- NÚT MỞ MENU (HÌNH TRÒN)
local toggle = Instance.new("TextButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0,200)
toggle.Text = "☰"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,255)
toggle.TextScaled = true
toggle.AutoButtonColor = true
toggle.BorderSizePixel = 0

local corner = Instance.new("UICorner", toggle)
corner.CornerRadius = UDim.new(1,0)

-- MENU
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,220,0,300)
frame.Position = UDim2.new(0,100,0,200)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false

local frameCorner = Instance.new("UICorner", frame)

-- KÉO MENU
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- MỞ / ĐÓNG MENU
toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- TEXT
local powerBox = Instance.new("TextBox")
powerBox.Parent = frame
powerBox.Size = UDim2.new(0,180,0,40)
powerBox.Position = UDim2.new(0,20,0,20)
powerBox.PlaceholderText = "Nhập số (vd: 50)"
powerBox.Text = ""
powerBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
powerBox.TextColor3 = Color3.new(1,1,1)

-- GIÁ TRỊ
local height = 0

-- NÚT LÊN +15
local upBtn = Instance.new("TextButton")
upBtn.Parent = frame
upBtn.Size = UDim2.new(0,180,0,40)
upBtn.Position = UDim2.new(0,20,0,80)
upBtn.Text = "⬆ +15"
upBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)

upBtn.MouseButton1Click:Connect(function()
	height += 15
end)

-- NÚT XUỐNG -15
local downBtn = Instance.new("TextButton")
downBtn.Parent = frame
downBtn.Size = UDim2.new(0,180,0,40)
downBtn.Position = UDim2.new(0,20,0,130)
downBtn.Text = "⬇ -15"
downBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)

downBtn.MouseButton1Click:Connect(function()
	height -= 15
end)

-- NÚT ÁP DỤNG
local applyBtn = Instance.new("TextButton")
applyBtn.Parent = frame
applyBtn.Size = UDim2.new(0,180,0,40)
applyBtn.Position = UDim2.new(0,20,0,180)
applyBtn.Text = "Áp dụng"
applyBtn.BackgroundColor3 = Color3.fromRGB(0,85,255)

applyBtn.MouseButton1Click:Connect(function()
	local val = tonumber(powerBox.Text)
	if val then
		height = val
	end
end)

-- GIỮ ĐỘ CAO
RunService.RenderStepped:Connect(function()
	if hrp then
		hrp.Velocity = Vector3.new(0,0,0)
		hrp.CFrame = CFrame.new(hrp.Position.X, height, hrp.Position.Z)
	end
end)
