local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local ESPEnabled = true
local Mode = "Highlight"
local ESPColor = Color3.fromRGB(255,0,0)

local WalkSpeed = 16

local ESPObjects = {}

-------------------------------------------------
-- GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui",player.PlayerGui)

local Main = Instance.new("Frame",gui)
Main.Size = UDim2.new(0,180,0,230)
Main.Position = UDim2.new(0.04,0,0.34,0)
Main.BackgroundColor3 = Color3.fromRGB(60,60,60)
Main.Active = true
Main.Draggable = true

local stroke = Instance.new("UIStroke",Main)
stroke.Color = Color3.fromRGB(255,121,3)
stroke.Thickness = 4

-------------------------------------------------
-- LOADING
-------------------------------------------------

local loading = Instance.new("TextLabel",Main)
loading.Size = UDim2.new(1,0,0,40)
loading.Position = UDim2.new(0,0,0.35,0)
loading.BackgroundTransparency = 1
loading.Text = "Loading..."
loading.TextScaled = true
loading.TextColor3 = Color3.fromRGB(255,121,3)

local barbg = Instance.new("Frame",Main)
barbg.Size = UDim2.new(0.8,0,0,18)
barbg.Position = UDim2.new(0.1,0,0.6,0)
barbg.BackgroundColor3 = Color3.fromRGB(70,70,70)

local bar = Instance.new("Frame",barbg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,121,3)

for i=1,100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.02)
end

loading:Destroy()
barbg:Destroy()

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
title.TextColor3 = Color3.fromRGB(255,121,3)

local toggle = Instance.new("TextButton",ESPPage)
toggle.Size = UDim2.new(0.8,0,0,30)
toggle.Position = UDim2.new(0.1,0,0.25,0)
toggle.Text = "ESP: ON"
toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
toggle.TextColor3 = Color3.fromRGB(255,121,3)

local modebtn = Instance.new("TextButton",ESPPage)
modebtn.Size = UDim2.new(0.8,0,0,30)
modebtn.Position = UDim2.new(0.1,0,0.45,0)
modebtn.Text = "MODE: Highlight"
modebtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
modebtn.TextColor3 = Color3.fromRGB(255,121,3)

local colorbtn = Instance.new("TextButton",ESPPage)
colorbtn.Size = UDim2.new(0.8,0,0,30)
colorbtn.Position = UDim2.new(0.1,0,0.65,0)
colorbtn.Text = "RM COLOR"
colorbtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
colorbtn.TextColor3 = Color3.fromRGB(255,121,3)

local nextbtn = Instance.new("TextButton",ESPPage)
nextbtn.Size = UDim2.new(0.4,0,0,25)
nextbtn.Position = UDim2.new(0.55,0,0.85,0)
nextbtn.Text = "NEXT ▶"
nextbtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
nextbtn.TextColor3 = Color3.fromRGB(255,121,3)

-------------------------------------------------
-- PAGE 2
-------------------------------------------------

local title2 = Instance.new("TextLabel",PlayerPage)
title2.Size = UDim2.new(1,0,0,40)
title2.BackgroundTransparency = 1
title2.Text = "PLAYER"
title2.TextScaled = true
title2.TextColor3 = Color3.fromRGB(255,121,3)

local speedbtn = Instance.new("TextButton",PlayerPage)
speedbtn.Size = UDim2.new(0.8,0,0,30)
speedbtn.Position = UDim2.new(0.1,0,0.25,0)
speedbtn.Text = "SPEED: 16"
speedbtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
speedbtn.TextColor3 = Color3.fromRGB(255,121,3)

local userLabel = Instance.new("TextLabel",PlayerPage)
userLabel.Size = UDim2.new(1,0,0,20)
userLabel.Position = UDim2.new(0,0,0.6,0)
userLabel.BackgroundTransparency = 1
userLabel.TextScaled = true
userLabel.TextColor3 = Color3.fromRGB(255,121,3)
userLabel.Text = "User: "..player.Name

local shiftMsg = Instance.new("TextLabel",PlayerPage)
shiftMsg.Size = UDim2.new(1,0,0,20)
shiftMsg.Position = UDim2.new(0,0,0.7,0)
shiftMsg.BackgroundTransparency = 1
shiftMsg.TextScaled = true
shiftMsg.TextColor3 = Color3.fromRGB(180,180,180)
shiftMsg.Text = "Press RightShift to close"

local backbtn = Instance.new("TextButton",PlayerPage)
backbtn.Size = UDim2.new(0.4,0,0,25)
backbtn.Position = UDim2.new(0.05,0,0.88,0)
backbtn.Text = "◀ BACK"
backbtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
backbtn.TextColor3 = Color3.fromRGB(255,121,3)

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
-- RIGHTSHIFT
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
-- SPEED (UNCHANGED)
-------------------------------------------------

speedbtn.MouseButton1Click:Connect(function()

	WalkSpeed += 10
	if WalkSpeed > 100 then
		WalkSpeed = 16
	end

	speedbtn.Text = "SPEED: "..WalkSpeed

end)

RunService.RenderStepped:Connect(function()

	local char = player.Character
	if char then

		local hum = char:FindFirstChildOfClass("Humanoid")

		if hum and hum.WalkSpeed ~= WalkSpeed then
			hum.WalkSpeed = WalkSpeed
		end

	end

end)

player.CharacterAdded:Connect(function(char)

	local hum = char:WaitForChild("Humanoid")

	task.wait(0.5)

	hum.WalkSpeed = WalkSpeed

end)

-------------------------------------------------
-- ESP SYSTEM
-------------------------------------------------

local function clearESP()
	for _,v in pairs(ESPObjects) do
		if v then v:Destroy() end
	end
	table.clear(ESPObjects)
end

local function createESP(plr)

	if not ESPEnabled then return end
	if plr == player then return end

	local char = plr.Character
	if not char then return end

	local h = Instance.new("Highlight")
	h.FillColor = ESPColor
	h.FillTransparency = 0.5
	h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	h.Parent = char

	ESPObjects[plr] = h

end

local function applyESP()

	clearESP()

	for _,plr in pairs(Players:GetPlayers()) do
		createESP(plr)
	end

end

-------------------------------------------------
-- BUTTONS
-------------------------------------------------

toggle.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled
	toggle.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"

	applyESP()

end)

colorbtn.MouseButton1Click:Connect(function()

	ESPColor = Color3.fromRGB(math.random(255),math.random(255),math.random(255))
	applyESP()

end)

-------------------------------------------------
-- AUTO ESP
-------------------------------------------------

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
