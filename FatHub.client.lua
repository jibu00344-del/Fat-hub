local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local previousGui = playerGui:FindFirstChild("FatHub")
if previousGui then
	previousGui:Destroy()
end

local colors = {
	background = Color3.fromRGB(20, 22, 29),
	surface = Color3.fromRGB(34, 37, 47),
	surfaceHover = Color3.fromRGB(44, 48, 60),
	accent = Color3.fromRGB(110, 75, 190),
	text = Color3.fromRGB(245, 245, 250),
	muted = Color3.fromRGB(175, 179, 193),
}

local gui = Instance.new("ScreenGui")
gui.Name = "FatHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Name = "Panel"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.BackgroundColor3 = colors.background
frame.BorderSizePixel = 0
frame.Parent = gui

local minimized = false
local updatePanelSize

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(66, 69, 84)
frameStroke.Transparency = 0.2
frameStroke.Thickness = 1
frameStroke.Parent = frame

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 78)
header.BackgroundColor3 = colors.surface
header.BorderSizePixel = 0
header.Active = true
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local headerFill = Instance.new("Frame")
headerFill.Position = UDim2.new(0, 0, 1, -12)
headerFill.Size = UDim2.new(1, 0, 0, 12)
headerFill.BackgroundColor3 = colors.surface
headerFill.BorderSizePixel = 0
headerFill.Parent = header

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(18, 12)
title.Size = UDim2.new(1, -100, 0, 30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "FAT HUB  V1.0"
title.TextColor3 = colors.text
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local function makeHeaderButton(name, text, xOffset)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Position = UDim2.new(1, xOffset, 0, 14)
	button.Size = UDim2.fromOffset(24, 24)
	button.BackgroundColor3 = colors.background
	button.BorderSizePixel = 0
	button.AutoButtonColor = true
	button.Font = Enum.Font.GothamBold
	button.Text = text
	button.TextColor3 = colors.text
	button.TextSize = 14
	button.Parent = header

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button
	return button
end

local minimizeButton = makeHeaderButton("Minimize", "-", -62)
local closeButton = makeHeaderButton("Close", "X", -32)

closeButton.Activated:Connect(function()
	gui:Destroy()
end)

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(19, 44)
subtitle.Size = UDim2.new(1, -38, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.GothamMedium
subtitle.Text = "V1.0 DEMO  /  SWITCHES DO NOT RUN GAME FEATURES"
subtitle.TextColor3 = colors.muted
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "Settings"
scroll.Position = UDim2.fromOffset(12, 130)
scroll.Size = UDim2.new(1, -24, 1, -142)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarImageColor3 = colors.accent
scroll.ScrollBarThickness = 4
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new()
scroll.Parent = frame

local search = Instance.new("TextBox")
search.Name = "Search"
search.Position = UDim2.fromOffset(12, 88)
search.Size = UDim2.new(1, -24, 0, 34)
search.BackgroundColor3 = colors.surface
search.BorderSizePixel = 0
search.ClearTextOnFocus = false
search.Font = Enum.Font.Gotham
search.PlaceholderText = "Filter demo switches..."
search.PlaceholderColor3 = colors.muted
search.Text = ""
search.TextColor3 = colors.text
search.TextSize = 12
search.TextXAlignment = Enum.TextXAlignment.Left
search.Parent = frame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 7)
searchCorner.Parent = search

local searchPadding = Instance.new("UIPadding")
searchPadding.PaddingLeft = UDim.new(0, 11)
searchPadding.PaddingRight = UDim.new(0, 8)
searchPadding.Parent = search

local padding = Instance.new("UIPadding")
padding.PaddingBottom = UDim.new(0, 4)
padding.PaddingLeft = UDim.new(0, 1)
padding.PaddingRight = UDim.new(0, 5)
padding.PaddingTop = UDim.new(0, 1)
padding.Parent = scroll

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local features = {
	"Auto Dough King",
	"Dough King Server Finder",
	"Auto Cake Prince",
	"Cake Prince Server Finder",
	"Auto Rip Indra",
	"Rip Indra Server Finder",
	"Auto Darkbeard",
	"Darkbeard Server Finder",
	"Auto Soul Reaper",
	"Soul Reaper Server Finder",
	"Auto Elite Hunter",
	"Elite Boss Finder",
	"Auto Boss Respawn Detection",
	"Auto Boss Server Hop",
	"Avoid Previously Visited Servers",
	"Notify When Boss Is Found",
	"Stop Hopping When Boss Is Found",
}

local enabled = {}
local settingButtons = {}

for index, name in ipairs(features) do
	enabled[name] = false

	local button = Instance.new("TextButton")
	button.Name = "Setting" .. index
	button.LayoutOrder = index
	button.Size = UDim2.new(1, 0, 0, 38)
	button.BackgroundColor3 = colors.surface
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Font = Enum.Font.GothamMedium
	button.Text = name .. "     OFF"
	button.TextColor3 = colors.muted
	button.TextSize = 12
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.Parent = scroll
	settingButtons[name] = button

	local buttonPadding = Instance.new("UIPadding")
	buttonPadding.PaddingLeft = UDim.new(0, 12)
	buttonPadding.PaddingRight = UDim.new(0, 10)
	buttonPadding.Parent = button

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 7)
	buttonCorner.Parent = button

	button.Activated:Connect(function()
		enabled[name] = not enabled[name]
		button.Text = name .. (enabled[name] and "     ON" or "     OFF")
		button.TextColor3 = enabled[name] and colors.text or colors.muted
		button.BackgroundColor3 = enabled[name] and colors.accent or colors.surface
	end)

	button.MouseEnter:Connect(function()
		if not enabled[name] then
			button.BackgroundColor3 = colors.surfaceHover
		end
	end)

	button.MouseLeave:Connect(function()
		if not enabled[name] then
			button.BackgroundColor3 = colors.surface
		end
	end)
end

search:GetPropertyChangedSignal("Text"):Connect(function()
	local query = string.lower(search.Text)
	for name, button in pairs(settingButtons) do
		button.Visible = string.find(string.lower(name), query, 1, true) ~= nil
	end
end)

minimizeButton.Activated:Connect(function()
	minimized = not minimized
	search.Visible = not minimized
	scroll.Visible = not minimized
	minimizeButton.Text = minimized and "+" or "-"
	updatePanelSize()
end)

local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

local dragConnection = UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

gui.Destroying:Connect(function()
	dragConnection:Disconnect()
end)

updatePanelSize = function()
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	local viewport = camera.ViewportSize
	local width = math.min(390, math.max(280, viewport.X - 32))
	local height = math.min(560, math.max(360, viewport.Y - 48))
	frame.Size = UDim2.fromOffset(width, minimized and 78 or height)
end

updatePanelSize()
if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updatePanelSize)
end

gui.Parent = playerGui