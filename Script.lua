local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-------------------------------------------------
-- SETTINGS
-------------------------------------------------

local ESPEnabled = true
local Mode = "Highlight"
local ESPColor = Color3.fromRGB(255,0,0)

local WalkSpeed = 16
local SpeedEnabled = true
local Noclip = false

local ESPObjects = {}

-------------------------------------------------
-- GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,200,0,250)
Main.Position = UDim2.new(0.04,0,0.34,0)
Main.BackgroundColor3 = Color3.fromRGB(35,0,0)
Main.Visible = false

Instance.new("UICorner",Main)

-------------------------------------------------
-- LOADING
-------------------------------------------------

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = gui
LoadingFrame.Size = UDim2.new(0,260,0,120)
LoadingFrame.Position = UDim2.new(0.5,-130,0.5,-60)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(35,0,0)

Instance.new("UICorner",LoadingFrame)

local loadingText = Instance.new("TextLabel",LoadingFrame)
loadingText.Size = UDim2.new(1,0,0,40)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading Script..."
loadingText.TextScaled = true
loadingText.TextColor3 = Color3.fromRGB(255,120,120)

local barBG = Instance.new("Frame",LoadingFrame)
barBG.Size = UDim2.new(0.8,0,0,18)
barBG.Position = UDim2.new(0.1,0,0.6,0)
barBG.BackgroundColor3 = Color3.fromRGB(60,60,60)

Instance.new("UICorner",barBG)

local bar = Instance.new("Frame",barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,80,80)

Instance.new("UICorner",bar)

for i = 1,100 do

	bar.Size = UDim2.new(i/100,0,1,0)

	if i == 30 then
		loadingText.Text = "Loading UI..."
	elseif i == 60 then
		loadingText.Text = "Loading Systems..."
	elseif i == 90 then
		loadingText.Text = "Almost Done..."
	end

	task.wait(0.015)

end

task.wait(0.3)

LoadingFrame:Destroy()
Main.Visible = true

-------------------------------------------------
-- DRAG MENU
-------------------------------------------------

local DragBar = Instance.new("Frame",Main)
DragBar.Size = UDim2.new(1,0,0,30)
DragBar.BackgroundTransparency = 1

local dragging = false
local dragStart
local startPos

DragBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end

end)

UIS.InputChanged:Connect(function(input)

	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
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

-------------------------------------------------
-- PAGES
-------------------------------------------------

local ESPPage = Instance.new("Frame",Main)
ESPPage.Size = UDim2.new(1,0,1,0)
ESPPage.BackgroundTransparency = 1

local PlayerPage = Instance.new("Frame",Main)
PlayerPage.Size = UDim2.new(1,0,1,0)
PlayerPage.BackgroundTransparency = 1
PlayerPage.Visible = false

-------------------------------------------------
-- PAGE 1
-------------------------------------------------

local title = Instance.new("TextLabel",ESPPage)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "ESP MENU"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,120,120)

local toggle = Instance.new("TextButton",ESPPage)
toggle.Size = UDim2.new(0.8,0,0,30)
toggle.Position = UDim2.new(0.1,0,0.25,0)
toggle.Text = "ESP: ON"

local modebtn = Instance.new("TextButton",ESPPage)
modebtn.Size = UDim2.new(0.8,0,0,30)
modebtn.Position = UDim2.new(0.1,0,0.45,0)
modebtn.Text = "MODE: Highlight"

local colorbtn = Instance.new("TextButton",ESPPage)
colorbtn.Size = UDim2.new(0.8,0,0,30)
colorbtn.Position = UDim2.new(0.1,0,0.65,0)
colorbtn.Text = "RANDOM COLOR"

local nextbtn = Instance.new("TextButton",ESPPage)
nextbtn.Size = UDim2.new(0.4,0,0,25)
nextbtn.Position = UDim2.new(0.55,0,0.85,0)
nextbtn.Text = "NEXT ▶"

-------------------------------------------------
-- PAGE 2
-------------------------------------------------

local title2 = Instance.new("TextLabel",PlayerPage)
title2.Size = UDim2.new(1,0,0,40)
title2.BackgroundTransparency = 1
title2.Text = "PLAYER"
title2.TextScaled = true
title2.TextColor3 = Color3.fromRGB(255,120,120)

local speedLabel = Instance.new("TextLabel",PlayerPage)
speedLabel.Size = UDim2.new(0.8,0,0,25)
speedLabel.Position = UDim2.new(0.1,0,0.2,0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextScaled = true

local sliderBG = Instance.new("Frame",PlayerPage)
sliderBG.Size = UDim2.new(0.8,0,0,10)
sliderBG.Position = UDim2.new(0.1,0,0.32,0)
sliderBG.BackgroundColor3 = Color3.fromRGB(70,70,70)

local slider = Instance.new("Frame",sliderBG)
slider.Size = UDim2.new(0,10,1,0)
slider.BackgroundColor3 = Color3.fromRGB(255,120,120)

local draggingSlider = false

slider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = false
	end
end)

UIS.InputChanged:Connect(function()

	if draggingSlider then

		local mouse = UIS:GetMouseLocation().X

		local percent = math.clamp(
			(mouse - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X,
			0,1
		)

		slider.Size = UDim2.new(percent,0,1,0)

		WalkSpeed = math.floor(16 + (100-16)*percent)

		speedLabel.Text = "Speed: "..WalkSpeed

	end

end)

local speedToggle = Instance.new("TextButton",PlayerPage)
speedToggle.Size = UDim2.new(0.8,0,0,30)
speedToggle.Position = UDim2.new(0.1,0,0.45,0)
speedToggle.Text = "Speed: ON"

speedToggle.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	speedToggle.Text = SpeedEnabled and "Speed: ON" or "Speed: OFF"
end)

local noclipBtn = Instance.new("TextButton",PlayerPage)
noclipBtn.Size = UDim2.new(0.8,0,0,30)
noclipBtn.Position = UDim2.new(0.1,0,0.60,0)
noclipBtn.Text = "Noclip: OFF"

noclipBtn.MouseButton1Click:Connect(function()
	Noclip = not Noclip
	noclipBtn.Text = Noclip and "Noclip: ON" or "Noclip: OFF"
end)

local backbtn = Instance.new("TextButton",PlayerPage)
backbtn.Size = UDim2.new(0.4,0,0,25)
backbtn.Position = UDim2.new(0.05,0,0.85,0)
backbtn.Text = "◀ BACK"

-------------------------------------------------
-- PAGE SWITCH
-------------------------------------------------

nextbtn.MouseButton1Click:Connect(function()
	ESPPage.Visible = false
	PlayerPage.Visible = true
end)

backbtn.MouseButton1Click:Connect(function()
	PlayerPage.Visible = false
	ESPPage.Visible = true
end)

-------------------------------------------------
-- RIGHT SHIFT
-------------------------------------------------

local open = true

UIS.InputBegan:Connect(function(input,gpe)

	if gpe then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		open = not open
		Main.Visible = open
	end

end)

-------------------------------------------------
-- SPEED
-------------------------------------------------

RunService.RenderStepped:Connect(function()

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")

	if hum then
		hum.WalkSpeed = SpeedEnabled and WalkSpeed or 16
	end

end)

-------------------------------------------------
-- NOCLIP
-------------------------------------------------

RunService.Stepped:Connect(function()

	if not Noclip then return end

	local char = player.Character
	if not char then return end

	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end

end)

-------------------------------------------------
-- ESP SYSTEM
-------------------------------------------------

local function clearESP()

	for _,v in pairs(ESPObjects) do
		if v then
			v:Destroy()
		end
	end

	table.clear(ESPObjects)

end

local function createESP(plr)

	if not ESPEnabled then return end
	if plr == player then return end

	local char = plr.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if Mode == "Highlight" then

		local h = Instance.new("Highlight")
		h.FillColor = ESPColor
		h.OutlineColor = ESPColor
		h.FillTransparency = 0.5
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Parent = char

		ESPObjects[plr] = h

	else

		local box = Instance.new("BoxHandleAdornment")
		box.Size = Vector3.new(4,6,2)
		box.Adornee = root
		box.AlwaysOnTop = true
		box.ZIndex = 10
		box.Color3 = ESPColor
		box.Parent = root

		ESPObjects[plr] = box

	end

end

local function applyESP()

	clearESP()

	for _,plr in pairs(Players:GetPlayers()) do
		createESP(plr)
	end

end

toggle.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled
	toggle.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"

	applyESP()

end)

modebtn.MouseButton1Click:Connect(function()

	if Mode == "Highlight" then
		Mode = "Box"
	else
		Mode = "Highlight"
	end

	modebtn.Text = "MODE: "..Mode

	applyESP()

end)

colorbtn.MouseButton1Click:Connect(function()

	ESPColor = Color3.fromRGB(
		math.random(255),
		math.random(255),
		math.random(255)
	)

	applyESP()

end)

Players.PlayerAdded:Connect(function(plr)

	plr.CharacterAdded:Connect(function()
		task.wait(1)
		createESP(plr)
	end)

end)

for _,plr in pairs(Players:GetPlayers()) do

	if plr ~= player then

		plr.CharacterAdded:Connect(function()
			task.wait(1)
			createESP(plr)
		end)

	end

end

task.wait(1)
applyESP()
