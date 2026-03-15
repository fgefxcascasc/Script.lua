local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ESPEnabled = true
local ESPColor = Color3.fromRGB(255,0,0)
local Mode = "Highlight"

local ESPObjects = {}

-- GUI

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(58,58,58)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.04,0,0.34,0)
Frame.Size = UDim2.new(0,179,0,213)
Frame.Active = true
Frame.Draggable = true

UIGradient.Parent = Frame

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.12,0,0,0)
TextLabel.Size = UDim2.new(0,135,0,48)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "ESP MENU"
TextLabel.TextColor3 = Color3.fromRGB(255,120,2)
TextLabel.TextScaled = true

TextButton.Parent = Frame
TextButton.Position = UDim2.new(0.08,0,0.27,0)
TextButton.Size = UDim2.new(0,148,0,35)
TextButton.Text = "ESP: ON"
TextButton.TextScaled = true

TextButton_2.Parent = Frame
TextButton_2.Position = UDim2.new(0.08,0,0.49,0)
TextButton_2.Size = UDim2.new(0,148,0,35)
TextButton_2.Text = "MODE: Highlight"
TextButton_2.TextScaled = true

TextButton_3.Parent = Frame
TextButton_3.Position = UDim2.new(0.08,0,0.72,0)
TextButton_3.Size = UDim2.new(0,148,0,35)
TextButton_3.Text = "RM COLOR"
TextButton_3.TextScaled = true

TextButton_4.Parent = Frame
TextButton_4.Size = UDim2.new(0,32,0,32)
TextButton_4.Position = UDim2.new(1,-35,0,0)
TextButton_4.Text = "X"
TextButton_4.TextScaled = true

-- BUTTON VARIABLES
local toggle = TextButton
local modeBtn = TextButton_2
local colorBtn = TextButton_3
local closeBtn = TextButton_4

-- ENEMY CHECK
local function isEnemy(plr)

	if plr == player then return false end

	if player.Team and plr.Team then
		if player.Team == plr.Team then
			return false
		end
	end

	return true
end

-- CREATE ESP
local function createESP(plr)

	if not ESPEnabled then return end
	if not isEnemy(plr) then return end

	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:FindFirstChild("HumanoidRootPart")

	if not root then return end

	if ESPObjects[plr] then
		ESPObjects[plr]:Destroy()
	end

	if Mode == "Highlight" then

		local h = Instance.new("Highlight")
		h.FillColor = ESPColor
		h.FillTransparency = 0.5
		h.OutlineColor = Color3.new(1,1,1)
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Parent = char

		ESPObjects[plr] = h

	else

		local box = Instance.new("BoxHandleAdornment")
		box.Adornee = root
		box.Size = Vector3.new(4,6,2)
		box.Color3 = ESPColor
		box.AlwaysOnTop = true
		box.ZIndex = 10
		box.Parent = root

		ESPObjects[plr] = box

	end

end

-- APPLY ESP
local function applyESP()

	for _,plr in pairs(Players:GetPlayers()) do
		createESP(plr)
	end

end

-- CLEAR ESP
local function clearESP()

	for _,v in pairs(ESPObjects) do
		if v then v:Destroy() end
	end

	table.clear(ESPObjects)

end

-- PLAYER SETUP
local function setup(plr)

	plr.CharacterAdded:Connect(function()

		task.wait(0.5)

		if ESPEnabled then
			createESP(plr)
		end

	end)

end

for _,p in pairs(Players:GetPlayers()) do
	setup(p)
end

Players.PlayerAdded:Connect(setup)

-- BUTTONS

toggle.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled
	toggle.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"

	clearESP()
	if ESPEnabled then applyESP() end

end)

modeBtn.MouseButton1Click:Connect(function()

	Mode = (Mode == "Highlight") and "Box" or "Highlight"
	modeBtn.Text = "MODE: "..Mode

	clearESP()
	if ESPEnabled then applyESP() end

end)

colorBtn.MouseButton1Click:Connect(function()

	ESPColor = Color3.fromRGB(
		math.random(255),
		math.random(255),
		math.random(255)
	)

	clearESP()
	if ESPEnabled then applyESP() end

end)

closeBtn.MouseButton1Click:Connect(function()

	clearESP()
	ScreenGui:Destroy()

end)

task.wait(1)
applyESP()
