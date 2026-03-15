local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,210,0,220)
frame.Position = UDim2.new(0,20,0,200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

Instance.new("UICorner",frame)

-- Title
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "ESP MENU"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

Instance.new("UICorner",title)

-- X Button
local close = Instance.new("TextButton")
close.Parent = title
close.Size = UDim2.new(0,35,1,0)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16

Instance.new("UICorner",close)

-- Close GUI
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Button maker
local function makeButton(text,y)

	local b = Instance.new("TextButton")
	b.Parent = frame
	b.Size = UDim2.new(1,-20,0,35)
	b.Position = UDim2.new(0,10,0,y)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.Text = text
	
	Instance.new("UICorner",b)

	return b
end

-- Your buttons
local toggle = makeButton("ESP: ON",45)
local modeBtn = makeButton("Mode",85)
local colorBtn = makeButton("Random Color",125)
local refreshBtn = makeButton("Refresh",165)

-- Button test actions
toggle.MouseButton1Click:Connect(function()
	print("ESP button clicked")
end)

modeBtn.MouseButton1Click:Connect(function()
	print("Mode button clicked")
end)

colorBtn.MouseButton1Click:Connect(function()
	print("Color button clicked")
end)

refreshBtn.MouseButton1Click:Connect(function()
	print("Refresh button clicked")
end)
