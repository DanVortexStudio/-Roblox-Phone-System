  local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة النسخة القديمة إذا كانت موجودة
local oldGui = playerGui:FindFirstChild("PhoneSystem")
if oldGui then
	oldGui:Destroy()
end

--==================================================
-- إعدادات
--==================================================

local PHONE_WIDTH = 320
local PHONE_HEIGHT = 560

local phoneOpen = false
local soundEnabled = true

--==================================================
-- إنشاء الـ GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "PhoneSystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- زر الجوال
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.fromOffset(58,58)
openButton.Position = UDim2.new(1,-75,1,-75)
openButton.BackgroundColor3 = Color3.fromRGB(25,25,30)
openButton.Text = "📱"
openButton.TextSize = 27
openButton.TextColor3 = Color3.new(1,1,1)
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1,0)
openCorner.Parent = openButton

--==================================================
-- جسم الجوال
--==================================================

local phone = Instance.new("Frame")
phone.Size = UDim2.fromOffset(PHONE_WIDTH,PHONE_HEIGHT)
phone.Position = UDim2.new(0.5,-PHONE_WIDTH/2,0.5,-PHONE_HEIGHT/2)
phone.BackgroundColor3 = Color3.fromRGB(12,12,15)
phone.Visible = false
phone.Parent = gui

local phoneCorner = Instance.new("UICorner")
phoneCorner.CornerRadius = UDim.new(0,32)
phoneCorner.Parent = phone

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(60,60,70)
stroke.Parent = phone

--==================================================
-- شريط علوي
--==================================================

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,-20,0,55)
topBar.Position = UDim2.fromOffset(10,10)
topBar.BackgroundTransparency = 1
topBar.Parent = phone

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.fromOffset(100,35)
timeLabel.Position = UDim2.fromOffset(10,10)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.new(1,1,1)
timeLabel.TextSize = 18
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = topBar

local signalLabel = Instance.new("TextLabel")
signalLabel.Size = UDim2.fromOffset(100,35)
signalLabel.Position = UDim2.new(1,-110,0,10)
signalLabel.BackgroundTransparency = 1
signalLabel.Text = "📶 🔋"
signalLabel.TextColor3 = Color3.new(1,1,1)
signalLabel.TextSize = 16
signalLabel.Parent = topBar

--==================================================
-- الصفحات
--==================================================

local pages = {}

local function createPage(name)
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1,-20,1,-75)
	page.Position = UDim2.fromOffset(10,65)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = phone
	
	pages[name] = page
	
	return page
end

local home = createPage("Home")
home.Visible = true

local messages = createPage("Messages")
local calls = createPage("Calls")
local contacts = createPage("Contacts")
local gps = createPage("GPS")
local notifications = createPage("Notifications")
local notes = createPage("Notes")
local settings = createPage("Settings")

--==================================================
-- أدوات
--==================================================

local function rounded(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,radius)
	c.Parent = obj
end

local function createButton(parent,text,pos,size)
	local b = Instance.new("TextButton")
	b.Size = size or UDim2.fromOffset(130,70)
	b.Position = pos
	b.BackgroundColor3 = Color3.fromRGB(35,35,42)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 17
	b.Font = Enum.Font.GothamBold
	b.Parent = parent
	
	rounded(b,15)
	
	return b
end

local function createTitle(parent,text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,0,45)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1,1,1)
	label.TextSize = 24
	label.Font = Enum.Font.GothamBold
	label.Parent = parent
	
	return label
end

local function createBack(parent)
	local b = createButton(
		parent,
		"← Back",
		UDim2.new(0,0,1,-55),
		UDim2.fromOffset(80,45)
	)
	
	b.MouseButton1Click:Connect(function()
		for _,page in pairs(pages) do
			page.Visible = false
		end
		
		home.Visible = true
	end)
end

local function openPage(page)
	for _,p in pairs(pages) do
		p.Visible = false
	end
	
	page.Visible = true
end

--==================================================
-- الصفحة الرئيسية
--==================================================

local welcome = Instance.new("TextLabel")
welcome.Size = UDim2.new(1,0,0,45)
welcome.Position = UDim2.fromOffset(0,5)
welcome.BackgroundTransparency = 1
welcome.Text = "MY PHONE"
welcome.TextColor3 = Color3.new(1,1,1)
welcome.TextSize = 26
welcome.Font = Enum.Font.GothamBold
welcome.Parent = home

local appsFrame = Instance.new("Frame")
appsFrame.Size = UDim2.new(1,0,0,350)
appsFrame.Position = UDim2.fromOffset(0,55)
appsFrame.BackgroundTransparency = 1
appsFrame.Parent = home

local messagesBtn = createButton(appsFrame,"💬\nMessages",UDim2.fromOffset(5,5))
local callsBtn = createButton(appsFrame,"📞\nCalls",UDim2.fromOffset(165,5))
local contactsBtn = createButton(appsFrame,"👥\nContacts",UDim2.fromOffset(5,90))
local gpsBtn = createButton(appsFrame,"🗺️\nGPS",UDim2.fromOffset(165,90))
local notifyBtn = createButton(appsFrame,"🔔\nAlerts",UDim2.fromOffset(5,175))
local notesBtn = createButton(appsFrame,"📝\nNotes",UDim2.fromOffset(165,175))
local settingsBtn = createButton(appsFrame,"⚙️\nSettings",UDim2.fromOffset(5,260))

--==================================================
-- الرسائل
--==================================================

createTitle(messages,"💬 Messages")

local messageBox = Instance.new("TextBox")
messageBox.Size = UDim2.new(1,-20,0,100)
messageBox.Position = UDim2.fromOffset(10,65)
messageBox.BackgroundColor3 = Color3.fromRGB(30,30,36)
messageBox.TextColor3 = Color3.new(1,1,1)
messageBox.PlaceholderText = "اكتب رسالتك..."
messageBox.Text = ""
messageBox.TextSize = 17
messageBox.MultiLine = true
messageBox.ClearTextOnFocus = false
messageBox.Parent = messages
rounded(messageBox,12)

local sendMessage = createButton(
	messages,
	"إرسال 💬",
	UDim2.fromOffset(10,180),
	UDim2.new(1,-20,0,55)
)

local messageStatus = Instance.new("TextLabel")
messageStatus.Size = UDim2.new(1,-20,0,100)
messageStatus.Position = UDim2.fromOffset(10,250)
messageStatus.BackgroundTransparency = 1
messageStatus.Text = "لا توجد رسائل."
messageStatus.TextColor3 = Color3.fromRGB(180,180,180)
messageStatus.TextSize = 16
messageStatus.TextWrapped = true
messageStatus.Parent = messages

sendMessage.MouseButton1Click:Connect(function()
	if messageBox.Text ~= "" then
		messageStatus.Text = "أنت:\n"..messageBox.Text
		messageBox.Text = ""
	end
end)

createBack(messages)

--==================================================
-- الاتصال
--==================================================

createTitle(calls,"📞 Calls")

local numberBox = Instance.new("TextBox")
numberBox.Size = UDim2.new(1,-20,0,55)
numberBox.Position = UDim2.fromOffset(10,70)
numberBox.BackgroundColor3 = Color3.fromRGB(30,30,36)
numberBox.TextColor3 = Color3.new(1,1,1)
numberBox.PlaceholderText = "اكتب الرقم..."
numberBox.Text = ""
numberBox.TextSize = 18
numberBox.Parent = calls
rounded(numberBox,12)

local callButton = createButton(
	calls,
	"📞 اتصال",
	UDim2.fromOffset(10,140),
	UDim2.new(1,-20,0,60)
)

local callStatus = Instance.new("TextLabel")
callStatus.Size = UDim2.new(1,-20,0,70)
callStatus.Position = UDim2.fromOffset(10,220)
callStatus.BackgroundTransparency = 1
callStatus.Text = "جاهز للاتصال"
callStatus.TextColor3 = Color3.fromRGB(180,180,180)
callStatus.TextSize = 17
callStatus.Parent = calls

callButton.MouseButton1Click:Connect(function()
	if numberBox.Text == "" then
		callStatus.Text = "⚠️ اكتب رقم أولاً"
		return
	end
	
	callStatus.Text = "📞 جاري الاتصال بـ "..numberBox.Text
	
	task.wait(2)
	
	callStatus.Text = "📞 الاتصال جارٍ..."
end)

createBack(calls)

--==================================================
-- جهات الاتصال
--==================================================

createTitle(contacts,"👥 Contacts")

local contact1 = createButton(
	contacts,
	"👤 Dan\n555-100",
	UDim2.fromOffset(10,65),
	UDim2.new(1,-20,0,70)
)

local contact2 = createButton(
	contacts,
	"👤 Police\n911",
	UDim2.fromOffset(10,145),
	UDim2.new(1,-20,0,70)
)

local contact3 = createButton(
	contacts,
	"👤 Friend\n555-200",
	UDim2.fromOffset(10,225),
	UDim2.new(1,-20,0,70)
)

local contactStatus = Instance.new("TextLabel")
contactStatus.Size = UDim2.new(1,-20,0,60)
contactStatus.Position = UDim2.fromOffset(10,310)
contactStatus.BackgroundTransparency = 1
contactStatus.Text = "اختر جهة اتصال"
contactStatus.TextColor3 = Color3.fromRGB(180,180,180)
contactStatus.TextSize = 16
contactStatus.Parent = contacts

local function selectContact(name)
	contactStatus.Text = "تم اختيار: "..name
end

contact1.MouseButton1Click:Connect(function()
	selectContact("Dan")
end)

contact2.MouseButton1Click:Connect(function()
	selectContact("Police")
end)

contact3.MouseButton1Click:Connect(function()
	selectContact("Friend")
end)

createBack(contacts)

--==================================================
-- GPS
--==================================================

createTitle(gps,"🗺️ GPS")

local locationLabel = Instance.new("TextLabel")
locationLabel.Size = UDim2.new(1,-20,0,120)
locationLabel.Position = UDim2.fromOffset(10,70)
locationLabel.BackgroundColor3 = Color3.fromRGB(30,30,36)
locationLabel.TextColor3 = Color3.new(1,1,1)
locationLabel.TextSize = 17
locationLabel.TextWrapped = true
locationLabel.Parent = gps
rounded(locationLabel,15)

local refreshGPS = createButton(
	gps,
	"📍 تحديث الموقع",
	UDim2.fromOffset(10,210),
	UDim2.new(1,-20,0,60)
)

local function updateGPS()
	local character = player.Character
	
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position
		
		locationLabel.Text =
			"📍 موقعك الحالي\n\n"..
			"X: "..math.floor(pos.X).."\n"..
			"Y: "..math.floor(pos.Y).."\n"..
			"Z: "..math.floor(pos.Z)
	else
		locationLabel.Text = "❌ لم يتم العثور على الشخصية"
	end
end

refreshGPS.MouseButton1Click:Connect(updateGPS)

createBack(gps)

--==================================================
-- الإشعارات
--==================================================

createTitle(notifications,"🔔 Notifications")

local notificationLabel = Instance.new("TextLabel")
notificationLabel.Size = UDim2.new(1,-20,0,170)
notificationLabel.Position = UDim2.fromOffset(10,70)
notificationLabel.BackgroundColor3 = Color3.fromRGB(30,30,36)
notificationLabel.TextColor3 = Color3.new(1,1,1)
notificationLabel.TextSize = 17
notificationLabel.TextWrapped = true
notificationLabel.Text = "🔔 لا توجد إشعارات جديدة."
notificationLabel.Parent = notifications
rounded(notificationLabel,15)

local notifyTest = createButton(
	notifications,
	"🔔 اختبار إشعار",
	UDim2.fromOffset(10,260),
	UDim2.new(1,-20,0,60)
)

notifyTest.MouseButton1Click:Connect(function()
	notificationLabel.Text =
		"🔔 إشعار جديد!\n\nلديك رسالة جديدة على هاتفك."
end)

createBack(notifications)

--==================================================
-- الملاحظات
--==================================================

createTitle(notes,"📝 Notes")

local noteBox = Instance.new("TextBox")
noteBox.Size = UDim2.new(1,-20,0,220)
noteBox.Position = UDim2.fromOffset(10,65)
noteBox.BackgroundColor3 = Color3.fromRGB(30,30,36)
noteBox.TextColor3 = Color3.new(1,1,1)
noteBox.PlaceholderText = "اكتب ملاحظتك هنا..."
noteBox.Text = ""
noteBox.TextSize = 17
noteBox.TextWrapped = true
noteBox.MultiLine = true
noteBox.ClearTextOnFocus = false
noteBox.Parent = notes
rounded(noteBox,15)

local saveNote = createButton(
	notes,
	"💾 حفظ الملاحظة",
	UDim2.fromOffset(10,300),
	UDim2.new(1,-20,0,55)
)

local noteStatus = Instance.new("TextLabel")
noteStatus.Size = UDim2.new(1,-20,0,50)
noteStatus.Position = UDim2.fromOffset(10,360)
noteStatus.BackgroundTransparency = 1
noteStatus.Text = ""
noteStatus.TextColor3 = Color3.fromRGB(100,220,130)
noteStatus.TextSize = 15
noteStatus.Parent = notes

saveNote.MouseButton1Click:Connect(function()
	noteStatus.Text = "✅ تم حفظ الملاحظة"
end)

createBack(notes)

--==================================================
-- الإعدادات
--==================================================

createTitle(settings,"⚙️ Settings")

local soundButton = createButton(
	settings,
	"🔊 Sound: ON",
	UDim2.fromOffset(10,70),
	UDim2.new(1,-20,0,60)
)

soundButton.MouseButton1Click:Connect(function()
	soundEnabled = not soundEnabled
	
	if soundEnabled then
		soundButton.Text = "🔊 Sound: ON"
	else
		soundButton.Text = "🔇 Sound: OFF"
	end
end)

local closeButton = createButton(
	settings,
	"📱 Close Phone",
	UDim2.fromOffset(10,145),
	UDim2.new(1,-20,0,60)
)

closeButton.MouseButton1Click:Connect(function()
	phoneOpen = false
	phone.Visible = false
end)

createBack(settings)

--==================================================
-- أزرار التطبيقات
--==================================================

messagesBtn.MouseButton1Click:Connect(function()
	openPage(messages)
end)

callsBtn.MouseButton1Click:Connect(function()
	openPage(calls)
end)

contactsBtn.MouseButton1Click:Connect(function()
	openPage(contacts)
end)

gpsBtn.MouseButton1Click:Connect(function()
	updateGPS()
	openPage(gps)
end)

notifyBtn.MouseButton1Click:Connect(function()
	openPage(notifications)
end)

notesBtn.MouseButton1Click:Connect(function()
	openPage(notes)
end)

settingsBtn.MouseButton1Click:Connect(function()
	openPage(settings)
end)

--==================================================
-- فتح وإغلاق الجوال
--==================================================

local function togglePhone()
	phoneOpen = not phoneOpen
	phone.Visible = phoneOpen
	
	if phoneOpen then
		openPage(home)
	end
end

openButton.MouseButton1Click:Connect(togglePhone)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if input.KeyCode == Enum.KeyCode.M then
		togglePhone()
	end
end)

--==================================================
-- الساعة
--==================================================

task.spawn(function()
	while gui.Parent do
		timeLabel.Text = os.date("%H:%M")
		task.wait(1)
	end
end)
