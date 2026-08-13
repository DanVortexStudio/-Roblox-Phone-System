--// 📱 iPhone Style Mobile GUI
--// Put this LocalScript inside:
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local OPEN_TIME = 0.55
local CLOSE_TIME = 0.45

local EASE_STYLE = Enum.EasingStyle.Quint
local EASE_DIRECTION = Enum.EasingDirection.Out

--==================================================
-- SCREEN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "iPhoneGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--==================================================
-- PHONE BUTTON
--==================================================

local phoneButton = Instance.new("TextButton")
phoneButton.Name = "PhoneButton"
phoneButton.Size = UDim2.new(0, 58, 0, 58)
phoneButton.Position = UDim2.new(1, -78, 1, -78)
phoneButton.AnchorPoint = Vector2.new(0, 0)
phoneButton.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
phoneButton.BackgroundTransparency = 0.08
phoneButton.Text = ""
phoneButton.AutoButtonColor = false
phoneButton.ZIndex = 20
phoneButton.Parent = gui

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.32, 0)
buttonCorner.Parent = phoneButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(255, 255, 255)
buttonStroke.Transparency = 0.78
buttonStroke.Thickness = 1.5
buttonStroke.Parent = phoneButton

local buttonGradient = Instance.new("UIGradient")
buttonGradient.Rotation = 135
buttonGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 55, 60)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 18))
})
buttonGradient.Parent = phoneButton

local phoneIcon = Instance.new("TextLabel")
phoneIcon.Size = UDim2.fromScale(1, 1)
phoneIcon.BackgroundTransparency = 1
phoneIcon.Text = "📱"
phoneIcon.TextScaled = true
phoneIcon.Font = Enum.Font.GothamBold
phoneIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
phoneIcon.ZIndex = 21
phoneIcon.Parent = phoneButton

--==================================================
-- PHONE FRAME
--==================================================

local phone = Instance.new("Frame")
phone.Name = "iPhone"
phone.Size = UDim2.new(0, 350, 0, 620)

-- يبدأ تحت الشاشة
phone.Position = UDim2.new(1, -25, 1, 680)

phone.AnchorPoint = Vector2.new(1, 1)
phone.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
phone.BackgroundTransparency = 0
phone.Visible = false
phone.ZIndex = 10
phone.Parent = gui

--==================================================
-- PHONE CORNERS
--==================================================

local phoneCorner = Instance.new("UICorner")
phoneCorner.CornerRadius = UDim.new(0, 42)
phoneCorner.Parent = phone

local phoneStroke = Instance.new("UIStroke")
phoneStroke.Color = Color3.fromRGB(90, 90, 98)
phoneStroke.Transparency = 0.35
phoneStroke.Thickness = 2
phoneStroke.Parent = phone

--==================================================
-- PHONE GRADIENT
--==================================================

local phoneGradient = Instance.new("UIGradient")
phoneGradient.Rotation = 135
phoneGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 35)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 12, 15)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30))
})
phoneGradient.Parent = phone

--==================================================
-- INNER SCREEN
--==================================================

local screen = Instance.new("Frame")
screen.Name = "Screen"
screen.Size = UDim2.new(1, -12, 1, -12)
screen.Position = UDim2.new(0, 6, 0, 6)
screen.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
screen.ClipsDescendants = true
screen.ZIndex = 11
screen.Parent = phone

local screenCorner = Instance.new("UICorner")
screenCorner.CornerRadius = UDim.new(0, 37)
screenCorner.Parent = screen

--==================================================
-- TOP DYNAMIC ISLAND
--==================================================

local island = Instance.new("Frame")
island.Name = "DynamicIsland"
island.Size = UDim2.new(0, 125, 0, 30)
island.Position = UDim2.new(0.5, 0, 0, 12)
island.AnchorPoint = Vector2.new(0.5, 0)
island.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
island.ZIndex = 30
island.Parent = screen

local islandCorner = Instance.new("UICorner")
islandCorner.CornerRadius = UDim.new(1, 0)
islandCorner.Parent = island

local cameraDot = Instance.new("Frame")
cameraDot.Size = UDim2.new(0, 8, 0, 8)
cameraDot.Position = UDim2.new(1, -22, 0.5, 0)
cameraDot.AnchorPoint = Vector2.new(0.5, 0.5)
cameraDot.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
cameraDot.ZIndex = 31
cameraDot.Parent = island

local cameraCorner = Instance.new("UICorner")
cameraCorner.CornerRadius = UDim.new(1, 0)
cameraCorner.Parent = cameraDot

--==================================================
-- TIME
--==================================================

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0, 60, 0, 20)
timeLabel.Position = UDim2.new(0, 20, 0, 18)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "9:41"
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 14
timeLabel.TextColor3 = Color3.fromRGB(255,255,255)
timeLabel.ZIndex = 25
timeLabel.Parent = screen

--==================================================
-- HEADER
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 45)
title.Position = UDim2.new(0, 20, 0, 70)
title.BackgroundTransparency = 1
title.Text = "Welcome"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255,255,255)
title.ZIndex = 20
title.Parent = screen

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -40, 0, 25)
subtitle.Position = UDim2.new(0, 20, 0, 108)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Your mobile control center"
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.TextColor3 = Color3.fromRGB(155,155,165)
subtitle.ZIndex = 20
subtitle.Parent = screen

--==================================================
-- CONTENT CONTAINER
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -30, 1, -210)
content.Position = UDim2.new(0, 15, 0, 145)
content.BackgroundTransparency = 1
content.ZIndex = 15
content.Parent = screen

--==================================================
-- CARD FUNCTION
--==================================================

local function createCard(name, text, emoji, y)
	local card = Instance.new("TextButton")
	card.Name = name
	card.Size = UDim2.new(1, 0, 0, 82)
	card.Position = UDim2.new(0, 0, 0, y)
	card.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	card.BackgroundTransparency = 0.05
	card.Text = ""
	card.AutoButtonColor = false
	card.ZIndex = 18
	card.Parent = content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 22)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255,255,255)
	stroke.Transparency = 0.9
	stroke.Thickness = 1
	stroke.Parent = card

	local icon = Instance.new("TextLabel")
	icon.Size = UDim2.new(0, 50, 0, 50)
	icon.Position = UDim2.new(0, 14, 0.5, 0)
	icon.AnchorPoint = Vector2.new(0, 0.5)
	icon.BackgroundColor3 = Color3.fromRGB(45,45,52)
	icon.Text = emoji
	icon.TextScaled = true
	icon.Font = Enum.Font.GothamBold
	icon.TextColor3 = Color3.fromRGB(255,255,255)
	icon.ZIndex = 19
	icon.Parent = card

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 16)
	iconCorner.Parent = icon

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -90, 0, 30)
	label.Position = UDim2.new(0, 78, 0.5, 0)
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 17
	label.TextColor3 = Color3.fromRGB(245,245,248)
	label.ZIndex = 19
	label.Parent = card

	-- Hover / press animation
	card.MouseEnter:Connect(function()
		TweenService:Create(
			card,
			TweenInfo.new(0.18),
			{BackgroundColor3 = Color3.fromRGB(42,42,50)}
		):Play()
	end)

	card.MouseLeave:Connect(function()
		TweenService:Create(
			card,
			TweenInfo.new(0.18),
			{BackgroundColor3 = Color3.fromRGB(28,28,34)}
		):Play()
	end)

	return card
end

--==================================================
-- INTERNAL BUTTONS
--==================================================

local homeButton = createCard(
	"HomeButton",
	"Home",
	"⌂",
	0
)

local profileButton = createCard(
	"ProfileButton",
	"Profile",
	"●",
	94
)

local settingsButton = createCard(
	"SettingsButton",
	"Settings",
	"⚙",
	188
)

--==================================================
-- BOTTOM BAR
--==================================================

local bottomBar = Instance.new("Frame")
bottomBar.Size = UDim2.new(1, -35, 0, 58)
bottomBar.Position = UDim2.new(0, 17.5, 1, -72)
bottomBar.BackgroundColor3 = Color3.fromRGB(28,28,33)
bottomBar.BackgroundTransparency = 0.1
bottomBar.ZIndex = 20
bottomBar.Parent = screen

local bottomCorner = Instance.new("UICorner")
bottomCorner.CornerRadius = UDim.new(0, 22)
bottomCorner.Parent = bottomBar

--==================================================
-- HOME INDICATOR
--==================================================

local homeIndicator = Instance.new("Frame")
homeIndicator.Size = UDim2.new(0, 105, 0, 5)
homeIndicator.Position = UDim2.new(0.5, 0, 1, -10)
homeIndicator.AnchorPoint = Vector2.new(0.5, 1)
homeIndicator.BackgroundColor3 = Color3.fromRGB(255,255,255)
homeIndicator.BackgroundTransparency = 0.15
homeIndicator.ZIndex = 40
homeIndicator.Parent = screen

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(1, 0)
indicatorCorner.Parent = homeIndicator

--==================================================
-- CLOSE BUTTON
--==================================================

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 38, 0, 38)
closeButton.Position = UDim2.new(1, -20, 0, 20)
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40,40,45)
closeButton.Text = "×"
closeButton.TextSize = 25
closeButton.Font = Enum.Font.Gotham
closeButton.TextColor3 = Color3.fromRGB(255,255,255)
closeButton.AutoButtonColor = false
closeButton.ZIndex = 35
closeButton.Parent = screen

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

--==================================================
-- OPEN / CLOSE
--==================================================

local isOpen = false
local busy = false

local closedPosition = UDim2.new(1, -25, 1, 680)
local openPosition = UDim2.new(1, -25, 1, -25)

local function openPhone()
	if busy or isOpen then
		return
	end

	busy = true
	isOpen = true

	phone.Visible = true
	phone.Position = closedPosition

	-- button shrinks slightly
	TweenService:Create(
		phoneButton,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = UDim2.new(0, 52, 0, 52)}
	):Play()

	-- phone comes from bottom
	local tween = TweenService:Create(
		phone,
		TweenInfo.new(
			OPEN_TIME,
			EASE_STYLE,
			EASE_DIRECTION
		),
		{
			Position = openPosition
		}
	)

	tween:Play()
	tween.Completed:Wait()

	busy = false
end

local function closePhone()
	if busy or not isOpen then
		return
	end

	busy = true
	isOpen = false

	local tween = TweenService:Create(
		phone,
		TweenInfo.new(
			CLOSE_TIME,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.In
		),
		{
			Position = closedPosition
		}
	)

	tween:Play()

	TweenService:Create(
		phoneButton,
		TweenInfo.new(0.2),
		{Size = UDim2.new(0, 58, 0, 58)}
	):Play()

	tween.Completed:Wait()

	phone.Visible = false
	busy = false
end

--==================================================
-- PHONE BUTTON
--==================================================

phoneButton.MouseButton1Click:Connect(function()
	if isOpen then
		closePhone()
	else
		openPhone()
	end
end)

--==================================================
-- CLOSE BUTTON
--==================================================

closeButton.MouseButton1Click:Connect(function()
	closePhone()
end)

--==================================================
-- INTERNAL BUTTON ACTIONS
--==================================================

homeButton.MouseButton1Click:Connect(function()
	title.Text = "Welcome"
	subtitle.Text = "Your mobile control center"
end)

profileButton.MouseButton1Click:Connect(function()
	title.Text = player.DisplayName
	subtitle.Text = "@" .. player.Name
end)

settingsButton.MouseButton1Click:Connect(function()
	title.Text = "Settings"
	subtitle.Text = "Customize your experience"
end)

--==================================================
-- BUTTON PRESS ANIMATION
--==================================================

local function addPressAnimation(button)
	button.MouseButton1Down:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.08),
			{Size = UDim2.new(
				button.Size.X.Scale,
				button.Size.X.Offset - 4,
				button.Size.Y.Scale,
				button.Size.Y.Offset - 4
			)}
		):Play()
	end)

	button.MouseButton1Up:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.12),
			{Size = UDim2.new(
				button.Size.X.Scale,
				button.Size.X.Offset + 4,
				button.Size.Y.Scale,
				button.Size.Y.Offset + 4
			)}
		):Play()
	end)
end

addPressAnimation(phoneButton)
addPressAnimation(closeButton)

--==================================================
-- DONE
--==================================================

print("📱 iPhone GUI Loaded Successfully!")
