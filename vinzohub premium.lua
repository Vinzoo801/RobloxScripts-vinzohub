-- =====================================================
-- VINZOHUB KEY SYSTEM - Discord Webhook Version
-- =====================================================

local WEBHOOK_URL = "https://discord.com/api/webhooks/1487782597009477663/Ml2kijtlJR_JTlhRIy9ReXEx5vZBdVfKbKK4p0pbJe6fI_vlS61_ZYBzSu8tMWc6kjHG"

-- =====================================================
-- SERVICES
-- =====================================================
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =====================================================
-- DESTROY EXISTING
-- =====================================================
for _, v in pairs(playerGui:GetChildren()) do
	if v.Name:find("VINZO") then v:Destroy() end
end

-- =====================================================
-- KEY DATABASE
-- Bot Discord (!vnz gen) otomatis tambah key di sini
-- Format: ["KEY"] = { expired = "DD/MM/YYYY" atau nil, lockedUser = nil }
-- =====================================================
local KEY_DATABASE = {
	-- key akan otomatis ditambah oleh bot Discord
},
},
}

-- =====================================================
-- VALIDATE KEY FUNCTION
-- =====================================================
local function validateKey(key)
	local record = KEY_DATABASE[key]

	if not record then
		return false, "❌ Key tidak ditemukan!"
	end

	if record.expired then
		local day   = tonumber(record.expired:sub(1,2))
		local month = tonumber(record.expired:sub(4,5))
		local year  = tonumber(record.expired:sub(7,10))
		local expDate = os.time({year=year, month=month, day=day, hour=23, min=59, sec=59})
		if os.time() > expDate then
			return false, "❌ Key sudah expired! (" .. record.expired .. ")"
		end
	end

	if record.lockedUser and record.lockedUser ~= player.Name then
		return false, "❌ Key ini sudah dipakai oleh " .. record.lockedUser .. "!"
	end

	if not record.lockedUser then
		KEY_DATABASE[key].lockedUser = player.Name
	end

	local expStr = record.expired or "Permanent"
	pcall(function()
		HttpService:RequestAsync({
			Url    = WEBHOOK_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body   = HttpService:JSONEncode({
				embeds = {{
					title       = "🔑 Key Digunakan",
					description = "**Key:** `" .. key .. "`\n**User:** " .. player.Name .. " (" .. tostring(player.UserId) .. ")\n**Expired:** " .. expStr,
					color       = 9109504,
					footer      = { text = "VINZOHUB Key System" },
					timestamp   = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}}
			})
		})
	end)

	return true, "✅ Welcome " .. player.Name .. "! Exp: " .. expStr
end

-- =====================================================
-- KEY GUI
-- =====================================================
local keyGui = Instance.new("ScreenGui")
keyGui.Name           = "VINZOHUB_KEY"
keyGui.ResetOnSpawn   = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
keyGui.Parent         = playerGui

local overlay = Instance.new("Frame", keyGui)
overlay.Size                   = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.45
overlay.ZIndex                 = 5

local card = Instance.new("Frame", keyGui)
card.Size             = UDim2.new(0, 420, 0, 290)
card.Position         = UDim2.new(0.5, -210, 1.5, 0)
card.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
card.ZIndex           = 10
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", card)
stroke.Color     = Color3.fromRGB(140, 0, 255)
stroke.Thickness = 2.5

local headerBar = Instance.new("Frame", card)
headerBar.Size             = UDim2.new(1, 0, 0, 50)
headerBar.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
headerBar.ZIndex           = 11
Instance.new("UICorner", headerBar).CornerRadius = UDim.new(0, 14)

local headerFix = Instance.new("Frame", headerBar)
headerFix.Size             = UDim2.new(1, 0, 0.5, 0)
headerFix.Position         = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
headerFix.BorderSizePixel  = 0
headerFix.ZIndex           = 10

local logoLabel = Instance.new("TextLabel", headerBar)
logoLabel.Size                   = UDim2.new(1, 0, 1, 0)
logoLabel.BackgroundTransparency = 1
logoLabel.Text                   = "🔑 VINZOHUB"
logoLabel.TextColor3             = Color3.new(1, 1, 1)
logoLabel.Font                   = Enum.Font.GothamBlack
logoLabel.TextSize               = 22
logoLabel.ZIndex                 = 12

local subLabel = Instance.new("TextLabel", card)
subLabel.Size                   = UDim2.new(1, 0, 0, 20)
subLabel.Position               = UDim2.new(0, 0, 0, 58)
subLabel.BackgroundTransparency = 1
subLabel.Text                   = "Masukkan key untuk melanjutkan"
subLabel.TextColor3             = Color3.fromRGB(180, 130, 255)
subLabel.Font                   = Enum.Font.Gotham
subLabel.TextSize               = 13
subLabel.ZIndex                 = 11

local inputBox = Instance.new("TextBox", card)
inputBox.Size              = UDim2.new(1, -40, 0, 42)
inputBox.Position          = UDim2.new(0, 20, 0, 90)
inputBox.BackgroundColor3  = Color3.fromRGB(22, 18, 35)
inputBox.TextColor3        = Color3.new(1, 1, 1)
inputBox.Font              = Enum.Font.GothamBold
inputBox.TextSize          = 15
inputBox.PlaceholderText   = "VNZ-XXXX-XXXX-XXXX"
inputBox.PlaceholderColor3 = Color3.fromRGB(100, 80, 130)
inputBox.ClearTextOnFocus  = true
inputBox.Text              = ""
inputBox.ZIndex            = 12
inputBox.BorderSizePixel   = 0
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 8)
local inputStroke = Instance.new("UIStroke", inputBox)
inputStroke.Color     = Color3.fromRGB(100, 0, 200)
inputStroke.Thickness = 1.5
local inputPad = Instance.new("UIPadding", inputBox)
inputPad.PaddingLeft  = UDim.new(0, 12)
inputPad.PaddingRight = UDim.new(0, 12)

local statusLabel = Instance.new("TextLabel", card)
statusLabel.Size                   = UDim2.new(1, -40, 0, 22)
statusLabel.Position               = UDim2.new(0, 20, 0, 140)
statusLabel.BackgroundTransparency = 1
statusLabel.Text                   = ""
statusLabel.TextColor3             = Color3.fromRGB(0, 220, 120)
statusLabel.Font                   = Enum.Font.GothamBold
statusLabel.TextSize               = 13
statusLabel.ZIndex                 = 12
statusLabel.TextXAlignment         = Enum.TextXAlignment.Left

local submitBtn = Instance.new("TextButton", card)
submitBtn.Size             = UDim2.new(0.65, -25, 0, 44)
submitBtn.Position         = UDim2.new(0, 20, 0, 172)
submitBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
submitBtn.TextColor3       = Color3.new(1, 1, 1)
submitBtn.Font             = Enum.Font.GothamBold
submitBtn.TextSize         = 15
submitBtn.Text             = "✅ SUBMIT KEY"
submitBtn.ZIndex           = 12
submitBtn.BorderSizePixel  = 0
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 9)

submitBtn.MouseEnter:Connect(function()
	TweenService:Create(submitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(160, 30, 255)}):Play()
end)
submitBtn.MouseLeave:Connect(function()
	TweenService:Create(submitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(120, 0, 255)}):Play()
end)

local closeKeyBtn = Instance.new("TextButton", card)
closeKeyBtn.Size             = UDim2.new(0.35, -15, 0, 44)
closeKeyBtn.Position         = UDim2.new(0.65, 5, 0, 172)
closeKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeKeyBtn.TextColor3       = Color3.new(1, 1, 1)
closeKeyBtn.Font             = Enum.Font.GothamBold
closeKeyBtn.TextSize         = 15
closeKeyBtn.Text             = "✖ CLOSE"
closeKeyBtn.ZIndex           = 12
closeKeyBtn.BorderSizePixel  = 0
Instance.new("UICorner", closeKeyBtn).CornerRadius = UDim.new(0, 9)

closeKeyBtn.MouseEnter:Connect(function()
	TweenService:Create(closeKeyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
end)
closeKeyBtn.MouseLeave:Connect(function()
	TweenService:Create(closeKeyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}):Play()
end)
closeKeyBtn.MouseButton1Click:Connect(function()
	TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Position = UDim2.new(0.5, -210, 1.5, 0)
	}):Play()
	task.wait(0.35)
	keyGui:Destroy()
end)

local discordLabel = Instance.new("TextLabel", card)
discordLabel.Size                   = UDim2.new(1, -40, 0, 20)
discordLabel.Position               = UDim2.new(0, 20, 0, 228)
discordLabel.BackgroundTransparency = 1
discordLabel.Text                   = "🔗 Beli key: discord.gg/c7JtbZpyDQ"
discordLabel.TextColor3             = Color3.fromRGB(100, 100, 160)
discordLabel.Font                   = Enum.Font.Gotham
discordLabel.TextSize               = 12
discordLabel.ZIndex                 = 12
discordLabel.TextXAlignment         = Enum.TextXAlignment.Left

-- =====================================================
-- SUBMIT HANDLER
-- =====================================================
local checking = false

local function doSubmit()
	if checking then return end
	local key = inputBox.Text:match("^%s*(.-)%s*$")

	if key == "" then
		statusLabel.Text       = "⚠️ Key tidak boleh kosong!"
		statusLabel.TextColor3 = Color3.fromRGB(255, 180, 0)
		return
	end

	checking = true
	submitBtn.Text             = "⏳ Memeriksa..."
	submitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	statusLabel.Text           = "🔍 Validasi key..."
	statusLabel.TextColor3     = Color3.fromRGB(0, 200, 255)

	task.spawn(function()
		local valid, msg = validateKey(key)
		if valid then
			statusLabel.Text           = msg
			statusLabel.TextColor3     = Color3.fromRGB(0, 220, 100)
			submitBtn.Text             = "✅ BERHASIL!"
			submitBtn.BackgroundColor3 = Color3.fromRGB(30, 160, 70)
			task.wait(1.2)
			keyGui:Destroy()
			task.spawn(loadMainScript)
		else
			statusLabel.Text           = msg
			statusLabel.TextColor3     = Color3.fromRGB(255, 70, 70)
			submitBtn.Text             = "✅ SUBMIT KEY"
			submitBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
		end
		checking = false
	end)
end

submitBtn.MouseButton1Click:Connect(doSubmit)
inputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then doSubmit() end
end)

-- =====================================================
-- ANIMASI MASUK
-- =====================================================
TweenService:Create(card, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -210, 0.5, -145)
}):Play()

-- =====================================================
-- MAIN SCRIPT
-- =====================================================
function loadMainScript()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("VINZOHUB") then
	playerGui.VINZOHUB:Destroy()
end

-- ================= NOTIF =================
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "VINZOHUB_NOTIF"
notifGui.Parent = playerGui

local notifFrame = Instance.new("Frame", notifGui)
notifFrame.Size = UDim2.new(0,350,0,80)
notifFrame.Position = UDim2.new(1,-360,0,100)
notifFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
notifFrame.BorderSizePixel = 0
Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0,8)

local notifText = Instance.new("TextLabel", notifFrame)
notifText.Size = UDim2.new(1,-10,1,-10)
notifText.Position = UDim2.new(0,5,0,5)
notifText.BackgroundTransparency = 1
notifText.TextColor3 = Color3.new(1,1,1)
notifText.Font = Enum.Font.SourceSansBold
notifText.TextSize = 18
notifText.TextWrapped = true
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.TextYAlignment = Enum.TextYAlignment.Top

task.spawn(function()
	local notifSound = Instance.new("Sound", notifGui)
	notifSound.SoundId = "rbxassetid://4590662766"
	notifSound.Volume = 0.8
	notifSound:Play()
	local msg = "PESAN DARI OWNER VINZOOX : Makasih udah order\nKalau ada bug report di Discord."
	for i = 1, #msg do
		notifText.Text = string.sub(msg,1,i)
		task.wait(0.03)
	end
	task.wait(5)
	notifGui:Destroy()
end)

-- ================= INTRO =================
local introGui = Instance.new("ScreenGui")
introGui.Name = "VINZOHUB_INTRO"
introGui.Parent = playerGui

local introFrame = Instance.new("Frame", introGui)
introFrame.Size = UDim2.new(1,0,1,0)
introFrame.BackgroundTransparency = 1

local logo = Instance.new("TextLabel", introFrame)
logo.Size = UDim2.new(0,400,0,100)
logo.Position = UDim2.new(0.5,-200,-0.3,0)
logo.BackgroundTransparency = 1
logo.Text = "VINZOHUB"
logo.TextColor3 = Color3.fromRGB(0,255,255)
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 60

TweenService:Create(logo, TweenInfo.new(1), {Position = UDim2.new(0.5,-200,0.5,-50)}):Play()
task.wait(1.5)
TweenService:Create(logo, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
task.wait(0.6)
introGui:Destroy()

-- ================= MAIN GUI =================
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "VINZOHUB"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,750,0,430)
main.Position = UDim2.new(0.5,-375,0.5,-215)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
main.Active = true
main.Draggable = true
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(140,0,255)
stroke.Thickness = 2

local floatBtn = Instance.new("TextButton", gui)
floatBtn.Size = UDim2.new(0,60,0,60)
floatBtn.Position = UDim2.new(1,-80,0.5,-30)
floatBtn.Text = "V"
floatBtn.BackgroundColor3 = Color3.fromRGB(140,0,255)
floatBtn.TextColor3 = Color3.new(1,1,1)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 22
floatBtn.Visible = false
floatBtn.ZIndex = 10
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1,0)

task.spawn(function()
	while true do
		TweenService:Create(floatBtn,TweenInfo.new(0.8),{Size=UDim2.new(0,65,0,65)}):Play()
		task.wait(0.8)
		TweenService:Create(floatBtn,TweenInfo.new(0.8),{Size=UDim2.new(0,60,0,60)}):Play()
		task.wait(0.8)
	end
end)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,40)
header.BackgroundColor3 = Color3.fromRGB(120,0,255)
header.ZIndex = 11
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,0.5,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "VINZOHUB GOD MODE PREMIUM"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.ZIndex = 12

local function playSound() end

local function hbtn(txt, pos)
	local b = Instance.new("TextButton", header)
	b.Size = UDim2.new(0,32,0,26)
	b.Position = pos
	b.Text = txt
	b.BackgroundColor3 = Color3.fromRGB(30,30,40)
	b.TextColor3 = Color3.new(1,1,1)
	b.ZIndex = 13
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local minBtn   = hbtn("-", UDim2.new(1,-80,0,7))
local closeBtn = hbtn("X", UDim2.new(1,-40,0,7))
closeBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)

local oldSize = main.Size
minBtn.MouseButton1Click:Connect(function()
	main:TweenSize(UDim2.new(0,0,0,0),"In","Quad",0.25,true)
	task.wait(0.25)
	main.Visible = false
	floatBtn.Visible = true
end)
floatBtn.MouseButton1Click:Connect(function()
	main.Visible = true
	main:TweenSize(oldSize,"Out","Back",0.3,true)
	floatBtn.Visible = false
end)

local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.P then
		guiVisible = not guiVisible
		main.Visible = guiVisible
	end
end)

-- ================= TAB BAR =================
local tabBar = Instance.new("ScrollingFrame", main)
tabBar.Size = UDim2.new(1,0,0,25)
tabBar.Position = UDim2.new(0,0,0,40)
tabBar.BackgroundColor3 = Color3.fromRGB(10,10,15)
tabBar.ScrollBarThickness = 3
tabBar.CanvasSize = UDim2.new(0,800,0,0)
tabBar.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
tabBar.ZIndex = 11
tabBar.BorderSizePixel = 0

local contentFrame = Instance.new("Frame", main)
contentFrame.Size = UDim2.new(1,0,1,-65)
contentFrame.Position = UDim2.new(0,0,0,65)
contentFrame.BackgroundColor3 = Color3.fromRGB(12,12,18)
contentFrame.ZIndex = 11
contentFrame.BorderSizePixel = 0

local tabs = {}
local activeTab

local function newTab(name, x)
	local tabBtn = Instance.new("TextButton", tabBar)
	tabBtn.Size = UDim2.new(0,155,1,0)
	tabBtn.Position = UDim2.new(0,x,0,0)
	tabBtn.Text = name
	tabBtn.BackgroundColor3 = Color3.fromRGB(20,20,28)
	tabBtn.TextColor3 = Color3.new(1,1,1)
	tabBtn.Font = Enum.Font.GothamBold
	tabBtn.TextSize = 13
	tabBtn.BorderSizePixel = 0
	tabBtn.ZIndex = 12

	local frame = Instance.new("ScrollingFrame", contentFrame)
	frame.Size = UDim2.new(1,0,1,0)
	frame.CanvasSize = UDim2.new(0,0,0,0)
	frame.ScrollBarThickness = 5
	frame.BackgroundColor3 = Color3.fromRGB(12,12,18)
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.ZIndex = 12

	local layout = Instance.new("UIListLayout", frame)
	layout.Padding = UDim.new(0,6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		frame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)
	end)

	local pad = Instance.new("UIPadding", frame)
	pad.PaddingTop    = UDim.new(0,10)
	pad.PaddingLeft   = UDim.new(0,8)
	pad.PaddingRight  = UDim.new(0,8)
	pad.PaddingBottom = UDim.new(0,10)

	tabBtn.MouseButton1Click:Connect(function()
		for _,v in pairs(tabs) do
			v.frame.Visible = false
			v.btn.BackgroundColor3 = Color3.fromRGB(20,20,28)
		end
		frame.Visible = true
		tabBtn.BackgroundColor3 = Color3.fromRGB(140,0,255)
		activeTab = frame
	end)
	tabBtn.MouseEnter:Connect(function()
		if activeTab ~= frame then
			TweenService:Create(tabBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(50,0,100)}):Play()
		end
	end)
	tabBtn.MouseLeave:Connect(function()
		if activeTab ~= frame then
			TweenService:Create(tabBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(20,20,28)}):Play()
		end
	end)

	tabs[name] = {btn=tabBtn, frame=frame}
	return frame
end

local shopTab    = newTab("SHOP",    0)
local featureTab = newTab("FEATURES",155)
local potatoTab  = newTab("POTATO",  310)
local respawnTab = newTab("RESPAWN", 465)
local tpTab      = newTab("TELEPORT",620)
local visualTab  = newTab("VISUAL",  775)
local creditTab  = newTab("CREDIT",  930)
local lastTabPos = 775 + 155
tabBar.CanvasSize = UDim2.new(0, lastTabPos + 50, 0, 0)

shopTab.Visible = true
tabs["SHOP"].btn.BackgroundColor3 = Color3.fromRGB(140,0,255)
activeTab = shopTab

-- ================= BUTTON HELPER =================
local function btn(parent, text)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(1,0,0,36)
	b.BackgroundColor3 = Color3.fromRGB(80,0,180)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Text = text
	b.BorderSizePixel = 0
	b.ZIndex = 20
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,7)
	local s = Instance.new("UIStroke", b)
	s.Color = Color3.fromRGB(160,60,255)
	s.Thickness = 1
	b.MouseButton1Click:Connect(playSound)
	b.MouseEnter:Connect(function()
		TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(130,0,255)}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(80,0,180)}):Play()
	end)
	return b
end

local function makeLabel(parent, text, h)
	local l = Instance.new("TextLabel", parent)
	l.Size = UDim2.new(1,0,0,h or 30)
	l.BackgroundColor3 = Color3.fromRGB(20,20,35)
	l.TextColor3 = Color3.fromRGB(0,255,180)
	l.Font = Enum.Font.GothamBold
	l.TextSize = 13
	l.Text = text
	l.ZIndex = 20
	l.BorderSizePixel = 0
	Instance.new("UICorner", l).CornerRadius = UDim.new(0,7)
	return l
end

-- ===================================================
-- COUNT ITEM
-- ===================================================
local function countItem(keyword)
	keyword = string.lower(keyword)
	local total = 0
	for _, v in pairs(player.Backpack:GetChildren()) do
		if string.lower(v.Name) == keyword then total += 1 end
	end
	if player.Character then
		for _, v in pairs(player.Character:GetChildren()) do
			if string.lower(v.Name) == keyword then total += 1 end
		end
	end
	return total
end

local function equipItem(name)
	local char = player.Character
	if not char then return false end
	local nameLower = string.lower(name)
	for _, tool in pairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") and string.lower(tool.Name):find(nameLower, 1, true) then
			tool.Parent = char
			task.wait(0.3)
			return true
		end
	end
	return false
end

-- ===================================================
-- SHOP TAB
-- ===================================================
local buyRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase")
local buyAmount = 5

local buyAmountLabel = makeLabel(shopTab, "🛍️ Jumlah Beli: 5")

local buySliderContainer = Instance.new("Frame", shopTab)
buySliderContainer.Size = UDim2.new(1,0,0,30)
buySliderContainer.BackgroundColor3 = Color3.fromRGB(20,20,35)
buySliderContainer.BorderSizePixel = 0
buySliderContainer.ZIndex = 20
Instance.new("UICorner", buySliderContainer).CornerRadius = UDim.new(0,7)

local buyTrack = Instance.new("Frame", buySliderContainer)
buyTrack.Size = UDim2.new(1,-20,0,6)
buyTrack.Position = UDim2.new(0,10,0.5,-3)
buyTrack.BackgroundColor3 = Color3.fromRGB(60,60,80)
buyTrack.BorderSizePixel = 0
buyTrack.ZIndex = 21
Instance.new("UICorner", buyTrack).CornerRadius = UDim.new(0,3)

local buyFill = Instance.new("Frame", buyTrack)
buyFill.Size = UDim2.new((buyAmount-1)/199, 0, 1, 0)
buyFill.BackgroundColor3 = Color3.fromRGB(140,0,255)
buyFill.BorderSizePixel = 0
buyFill.ZIndex = 22
Instance.new("UICorner", buyFill).CornerRadius = UDim.new(0,3)

local buyKnob = Instance.new("TextButton", buyTrack)
buyKnob.Size = UDim2.new(0,16,0,16)
buyKnob.Position = UDim2.new((buyAmount-1)/199, -8, 0.5, -8)
buyKnob.BackgroundColor3 = Color3.fromRGB(180,60,255)
buyKnob.Text = ""
buyKnob.BorderSizePixel = 0
buyKnob.ZIndex = 23
Instance.new("UICorner", buyKnob).CornerRadius = UDim.new(1,0)

local draggingBuy = false

local function updateBuySlider(val)
	val = math.clamp(math.floor(val), 1, 200)
	buyAmount = val
	local pct = (buyAmount - 1) / 199
	buyFill.Size = UDim2.new(pct, 0, 1, 0)
	buyKnob.Position = UDim2.new(pct, -8, 0.5, -8)
	buyAmountLabel.Text = "🛍️ Jumlah Beli: " .. buyAmount
end

buyKnob.MouseButton1Down:Connect(function() draggingBuy = true end)
UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingBuy = false end
end)
RunService.Heartbeat:Connect(function()
	if draggingBuy then
		local trackPos = buyTrack.AbsolutePosition.X
		local trackWidth = buyTrack.AbsoluteSize.X
		local mouseX = UserInputService:GetMouseLocation().X
		local pct = math.clamp((mouseX - trackPos) / trackWidth, 0, 1)
		updateBuySlider(1 + pct * 199)
	end
end)

local autoBuyBtn = btn(shopTab, "🛍️ AUTO BUY : OFF")
local buyStatusLabel = makeLabel(shopTab, "Auto Buy: idle")

autoBuyBtn.MouseButton1Click:Connect(function()
	if getgenv().AUTO_BUY then
		getgenv().AUTO_BUY = false
		autoBuyBtn.Text = "🛍️ AUTO BUY : OFF"
		autoBuyBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		buyStatusLabel.Text = "Auto Buy: idle"
	else
		getgenv().AUTO_BUY = true
		autoBuyBtn.Text = "🛍️ AUTO BUY : ON"
		autoBuyBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		local total = buyAmount
		buyStatusLabel.Text = "▶ Membeli " .. total .. "x..."
		task.spawn(function()
			for i = 1, total do
				if not getgenv().AUTO_BUY then break end
				buyStatusLabel.Text = "🛍️ Beli " .. i .. "/" .. total
				buyRemote:FireServer("Water")
				task.wait(0.35)
				buyRemote:FireServer("Sugar Block Bag")
				task.wait(0.35)
				buyRemote:FireServer("Gelatin")
				task.wait(0.35)
				buyRemote:FireServer("Empty Bag")
				task.wait(0.35)
			end
			if getgenv().AUTO_BUY then
				getgenv().AUTO_BUY = false
				autoBuyBtn.Text = "🛍️ AUTO BUY : OFF"
				autoBuyBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
				buyStatusLabel.Text = "✅ Selesai beli " .. total .. "x"
			end
		end)
	end
end)

local function doInteract(dur)
	VIM:SendKeyEvent(true,"E",false,game)
	task.wait(dur or 0.6)
	VIM:SendKeyEvent(false,"E",false,game)
end

local autoSellBtn = btn(shopTab, "🛒 AUTO SELL : OFF")
local sellStatusLabel = makeLabel(shopTab, "Auto Sell: idle")

local function autoSellLoop()
	while getgenv().AUTO_SELL do
		local char = player.Character
		if not char then task.wait(1) continue end
		local hasItem = false
		local tools = {}
		for _, t in ipairs(player.Backpack:GetChildren()) do table.insert(tools, t) end
		for _, t in ipairs(char:GetChildren()) do
			if t:IsA("Tool") then table.insert(tools, t) end
		end
		for _, tool in ipairs(tools) do
			if not getgenv().AUTO_SELL then break end
			if not tool or not tool.Parent then continue end
			if not tool:IsA("Tool") then continue end
			local nameLower = string.lower(tool.Name)
			local isMarshmallow = nameLower:find("marshmallow") or nameLower:find("marsh")
			if isMarshmallow then
				local sm = countItem("small marshmallow")
				local md = countItem("medium marshmallow")
				local lg = countItem("large marshmallow")
				sellStatusLabel.Text = string.format("🛒 Jual: %s | S:%d M:%d L:%d", tool.Name, sm, md, lg)
				if tool.Parent == player.Backpack then
					tool.Parent = char
					task.wait(0.5)
				end
				doInteract(1.5)
				task.wait(1.0)
				hasItem = true
			end
		end
		if not hasItem then
			local sm = countItem("small marshmallow")
			local md = countItem("medium marshmallow")
			local lg = countItem("large marshmallow")
			sellStatusLabel.Text = string.format("⏳ Nunggu marshmallow... | S:%d M:%d L:%d", sm, md, lg)
			task.wait(2)
		end
	end
	sellStatusLabel.Text = "Auto Sell: idle"
end

autoSellBtn.MouseButton1Click:Connect(function()
	if getgenv().AUTO_SELL then
		getgenv().AUTO_SELL = false
		autoSellBtn.Text = "🛒 AUTO SELL : OFF"
		autoSellBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		sellStatusLabel.Text = "Auto Sell: idle"
	else
		getgenv().AUTO_SELL = false
		task.wait(0.1)
		getgenv().AUTO_SELL = true
		autoSellBtn.Text = "🛒 AUTO SELL : ON"
		autoSellBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		sellStatusLabel.Text = "▶ Auto Sell: Running"
		task.spawn(autoSellLoop)
	end
end)

-- ===================================================
-- FEATURES TAB
-- ===================================================
local backpack = player:WaitForChild("Backpack")

local startBtn    = btn(featureTab, "▶ START AutoFarm")
local stopBtn     = btn(featureTab, "⏹ STOP")
local statusLabel = makeLabel(featureTab, "Macro: idle")

local SCAN_RADIUS = 25
local scannedPrompts = {}

local function stopPromptScan()
	getgenv().PROMPT_SCANNING = false
	for prompt, original in pairs(scannedPrompts) do
		if prompt and prompt.Parent then
			pcall(function()
				prompt.Enabled = original.enabled or false
				prompt.MaxActivationDistance = original.maxDist or 8
				prompt.RequiresLineOfSight = original.lineOfSight or true
				prompt.HoldDuration = original.holdDuration or 0
			end)
		end
	end
	scannedPrompts = {}
end

-- FIX: fungsi getPromptPosition yang bisa detect CookingPot dll
local function getPromptPosition(prompt)
	local p = prompt.Parent
	if not p then return nil end
	if p:IsA("BasePart") then return p.Position end
	if p:IsA("Attachment") then return p.WorldPosition end
	if p:IsA("Model") then
		if p.PrimaryPart then return p.PrimaryPart.Position end
		for _, child in ipairs(p:GetDescendants()) do
			if child:IsA("BasePart") then return child.Position end
		end
	end
	local grandParent = p.Parent
	if grandParent then
		if grandParent:IsA("BasePart") then return grandParent.Position end
		if grandParent:IsA("Model") then
			if grandParent.PrimaryPart then return grandParent.PrimaryPart.Position end
			for _, child in ipairs(grandParent:GetDescendants()) do
				if child:IsA("BasePart") then return child.Position end
			end
		end
	end
	return nil
end

-- FIX: doPromptScan pakai getPromptPosition
local function doPromptScan(statusLbl, countLbl)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	scannedPrompts = {}
	local found = 0
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			local pos = getPromptPosition(v)
			if pos then
				local dist = (hrp.Position - pos).Magnitude
				if dist <= SCAN_RADIUS then
					scannedPrompts[v] = {
						maxDist      = v.MaxActivationDistance,
						lineOfSight  = v.RequiresLineOfSight,
						enabled      = v.Enabled,
						holdDuration = v.HoldDuration
					}
					v.Enabled               = true
					v.MaxActivationDistance = 20
					v.RequiresLineOfSight   = false
					v.HoldDuration          = 0
					found += 1
				end
			end
		end
	end
	countLbl.Text  = "📊 " .. found .. " prompt"
	statusLbl.Text = "✅ Scan: " .. found
end

local promptScanBtn     = btn(featureTab, "👁️ PROMPT SCANNER : OFF")
local promptCountLabel  = makeLabel(featureTab, "📊 0 prompt")
local promptStatusLabel = makeLabel(featureTab, "Scanner: idle")

promptScanBtn.MouseButton1Click:Connect(function()
	if getgenv().PROMPT_SCANNING then
		stopPromptScan()
		promptScanBtn.Text = "👁️ PROMPT SCANNER : OFF"
	else
		getgenv().PROMPT_SCANNING = true
		promptScanBtn.Text = "👁️ PROMPT SCANNER : ON"
		task.spawn(function()
			while getgenv().PROMPT_SCANNING do
				doPromptScan(promptStatusLabel, promptCountLabel)
				task.wait(1)
			end
		end)
	end
end)

-- ===================================================
-- TURUN JALAN
-- ===================================================
local lowerRoadBtn    = btn(featureTab, "🛣️ TURUNKAN JALAN : OFF")
local lowerRoadStatus = makeLabel(featureTab, "Status: idle")

local ROAD_KEYWORDS = {"road","street","sidewalk","pavement","asphalt","ground","floor","path","lane","crossing","jalan","trotoar","jalanan"}
local originalPositions = {}
local currentRoadOffset = 0

local function isRoadPart(part)
	if not part:IsA("BasePart") and not part:IsA("UnionOperation") then return false end
	local nameLower = part.Name:lower()
	for _, kw in pairs(ROAD_KEYWORDS) do
		if nameLower:find(kw) then return true end
	end
	if part.Parent then
		local parentName = part.Parent.Name:lower()
		for _, kw in pairs(ROAD_KEYWORDS) do
			if parentName:find(kw) then return true end
		end
	end
	return false
end

local function lowerAllRoads(offset)
	local count = 0
	originalPositions = {}
	currentRoadOffset = offset
	lowerRoadStatus.Text = "🔍 Mencari jalanan..."
	task.wait(0.1)
	for _, obj in pairs(workspace:GetDescendants()) do
		if isRoadPart(obj) then
			originalPositions[obj] = obj.CFrame
			obj.CFrame = obj.CFrame * CFrame.new(0, -offset, 0)
			count += 1
		end
	end
	local char = player.Character
	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, -offset, 0) end
	end
	lowerRoadStatus.Text = "✅ "..count.." part jalan diturunkan -"..offset.."Y"
end

local function restoreAllRoads()
	local count = 0
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	for part, originalCF in pairs(originalPositions) do
		if part and part.Parent then
			part.CFrame = originalCF
			count += 1
		end
	end
	if hrp and currentRoadOffset ~= 0 then
		hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + currentRoadOffset, hrp.Position.Z)
		hrp.AssemblyLinearVelocity = Vector3.zero
	end
	originalPositions = {}
	currentRoadOffset = 0
	lowerRoadStatus.Text = "↩️ "..count.." part jalan dikembalikan"
end

local depthLabel = makeLabel(featureTab, "⬇️ Kedalaman: 10", 25)
depthLabel.BackgroundTransparency = 1
depthLabel.TextColor3 = Color3.new(1,1,1)

local depthSliderContainer = Instance.new("Frame", featureTab)
depthSliderContainer.Size = UDim2.new(1,0,0,30)
depthSliderContainer.BackgroundColor3 = Color3.fromRGB(20,20,35)
depthSliderContainer.BorderSizePixel = 0
depthSliderContainer.ZIndex = 20
Instance.new("UICorner", depthSliderContainer).CornerRadius = UDim.new(0,7)

local depthTrack = Instance.new("Frame", depthSliderContainer)
depthTrack.Size = UDim2.new(1,-20,0,6)
depthTrack.Position = UDim2.new(0,10,0.5,-3)
depthTrack.BackgroundColor3 = Color3.fromRGB(60,60,80)
depthTrack.BorderSizePixel = 0
depthTrack.ZIndex = 21
Instance.new("UICorner", depthTrack).CornerRadius = UDim.new(0,3)

local depthFill = Instance.new("Frame", depthTrack)
depthFill.Size = UDim2.new(0.18,0,1,0)
depthFill.BackgroundColor3 = Color3.fromRGB(140,0,255)
depthFill.BorderSizePixel = 0
depthFill.ZIndex = 22
Instance.new("UICorner", depthFill).CornerRadius = UDim.new(0,3)

local depthKnob = Instance.new("TextButton", depthTrack)
depthKnob.Size = UDim2.new(0,16,0,16)
depthKnob.Position = UDim2.new(0.18,-8,0.5,-8)
depthKnob.BackgroundColor3 = Color3.fromRGB(180,60,255)
depthKnob.Text = ""
depthKnob.BorderSizePixel = 0
depthKnob.ZIndex = 23
Instance.new("UICorner", depthKnob).CornerRadius = UDim.new(1,0)

local roadDepth = 10
local draggingDepth = false

local function updateDepthSlider(val)
	val = math.clamp(math.floor(val), 5, 60)
	roadDepth = val
	local pct = (roadDepth - 5) / 55
	depthFill.Size = UDim2.new(pct, 0, 1, 0)
	depthKnob.Position = UDim2.new(pct, -8, 0.5, -8)
	depthLabel.Text = "⬇️ Kedalaman: "..roadDepth
end

depthKnob.MouseButton1Down:Connect(function() draggingDepth = true end)
UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingDepth = false end
end)
RunService.Heartbeat:Connect(function()
	if draggingDepth then
		local trackPos = depthTrack.AbsolutePosition.X
		local trackWidth = depthTrack.AbsoluteSize.X
		local mouseX = UserInputService:GetMouseLocation().X
		local pct = math.clamp((mouseX - trackPos) / trackWidth, 0, 1)
		updateDepthSlider(5 + pct * 55)
	end
end)

lowerRoadBtn.MouseButton1Click:Connect(function()
	getgenv().LOWER_ROAD = not getgenv().LOWER_ROAD
	if getgenv().LOWER_ROAD then
		lowerRoadBtn.Text = "🛣️ TURUNKAN JALAN : ON"
		lowerRoadBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		task.spawn(function() lowerAllRoads(roadDepth) end)
	else
		lowerRoadBtn.Text = "🛣️ TURUNKAN JALAN : OFF"
		lowerRoadBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		restoreAllRoads()
	end
end)

-- ===================================================
-- INVENTORY DISPLAY
-- ===================================================
local invWaterLabel   = makeLabel(featureTab, "💧 Water            : -")
local invSugarLabel   = makeLabel(featureTab, "🍬 Sugar Block Bag : -")
local invGelatinLabel = makeLabel(featureTab, "🟡 Gelatin         : -")
local invCanMakeLabel = makeLabel(featureTab, "📦 Dapat buat      : -")
local invSmallLabel   = makeLabel(featureTab, "🍡 Small Marsh     : -")
local invMediumLabel  = makeLabel(featureTab, "🍡 Medium Marsh    : -")
local invLargeLabel   = makeLabel(featureTab, "🍡 Large Marsh     : -")

task.spawn(function()
	while task.wait(0.5) do
		if not playerGui:FindFirstChild("VINZOHUB") then break end
		local water, sugar, gelatin, small, medium, large = 0,0,0,0,0,0
		for _, v in pairs(player.Backpack:GetChildren()) do
			local n = string.lower(v.Name)
			if n:find("water")        then water   += 1 end
			if n:find("sugar block")  then sugar   += 1 end
			if n:find("gelatin")      then gelatin += 1 end
			if n:find("small marsh")  then small   += 1 end
			if n:find("medium marsh") then medium  += 1 end
			if n:find("large marsh")  then large   += 1 end
		end
		if player.Character then
			for _, v in pairs(player.Character:GetChildren()) do
				local n = string.lower(v.Name)
				if n:find("water")        then water   += 1 end
				if n:find("sugar block")  then sugar   += 1 end
				if n:find("gelatin")      then gelatin += 1 end
				if n:find("small marsh")  then small   += 1 end
				if n:find("medium marsh") then medium  += 1 end
				if n:find("large marsh")  then large   += 1 end
			end
		end
		local totalMarsh = small + medium + large
		local canMake    = math.min(water, sugar, gelatin)
		invWaterLabel.Text   = "💧 Water            : " .. water
		invSugarLabel.Text   = "🍬 Sugar Block Bag : " .. sugar
		invGelatinLabel.Text = "🟡 Gelatin         : " .. gelatin
		invCanMakeLabel.Text = "📦 Dapat buat      : " .. canMake .. "x | Total Marsh: " .. totalMarsh
		invSmallLabel.Text   = "🍡 Small Marsh     : " .. small
		invMediumLabel.Text  = "🍡 Medium Marsh    : " .. medium
		invLargeLabel.Text   = "🍡 Large Marsh     : " .. large
	end
end)

-- ===================================================
-- AUTOFARM
-- ===================================================
local farming = false

local function farmWait(seconds)
	local elapsed = 0
	while elapsed < seconds do
		if not farming then return false end
		task.wait(0.5)
		elapsed += 0.5
	end
	return true
end

local function waitForItems(timeout)
	timeout = timeout or 15
	local elapsed = 0
	while elapsed < timeout do
		local w = countItem("water")
		local s = countItem("sugar block bag")
		local g = countItem("gelatin")
		if w > 0 and s > 0 and g > 0 then return true end
		statusLabel.Text = "⏳ Menunggu item sync... (" .. math.floor(elapsed) .. "s)"
		task.wait(0.5)
		elapsed += 0.5
	end
	return false
end

local function autoFarm()
	while farming do
		local ready = waitForItems(15)
		if not ready then
			statusLabel.Text = "❌ Bahan tidak ditemukan setelah 15 detik!"
			if not farmWait(3) then break end
			continue
		end
		statusLabel.Text = "💧 Masukkan Water..."
		equipItem("water") task.wait(0.5) doInteract(0.2)
		if not farming then break end
		statusLabel.Text = "⏳ Tunggu 20 detik..."
		if not farmWait(20) then break end
		statusLabel.Text = "🍬 Masukkan Sugar Block Bag..."
		equipItem("sugar block bag") task.wait(0.5) doInteract(0.2)
		if not farming then break end
		task.wait(1)
		statusLabel.Text = "🟡 Masukkan Gelatin..."
		equipItem("gelatin") task.wait(0.5) doInteract(0.2)
		if not farming then break end
		statusLabel.Text = "⏳ Memasak 45 detik..."
		if not farmWait(45) then break end
		statusLabel.Text = "🍡 Ambil Marshmallow..."
		equipItem("empty bag") task.wait(0.5) doInteract(0.2)
		task.wait(2)
		statusLabel.Text = "✅ Siklus selesai! Lanjut..."
		if not farmWait(1) then break end
	end
	farming = false
	statusLabel.Text = "Macro: idle"
end

startBtn.MouseButton1Click:Connect(function()
	if farming then return end
	farming = true
	statusLabel.Text = "▶ Macro: Running"
	task.spawn(autoFarm)
end)
stopBtn.MouseButton1Click:Connect(function()
	farming = false
	statusLabel.Text = "⏹ Macro: Stopped"
end)

-- ===================================================
-- POTATO TAB
-- ===================================================
local potatoFarming = false

local POTATO_STEPS = {
	{ pos = Vector3.new(-479.4, 3.9, -437.9), label = "Step 1 - Interact awal",           equip = nil,      interact = true, waitAfter = 0  },
	{ pos = Vector3.new(-462.5, 3.9, -466.0), label = "Step 2 - Equip Potato & Interact", equip = "Potato", interact = true, waitAfter = 0  },
	{ pos = Vector3.new(-462.1, 3.9, -472.9), label = "Step 3 - Interact",                equip = nil,      interact = true, waitAfter = 0  },
	{ pos = Vector3.new(-463.2, 3.9, -521.2), label = "Step 4 - Equip Flour & Interact",  equip = "Flour",  interact = true, waitAfter = 0  },
	{ pos = Vector3.new(-497.0, 3.9, -492.3), label = "Step 5 - Interact & Tunggu Masak", equip = nil,      interact = true, waitAfter = 62 },
}

local function findItemPotato(name)
	for _, v in pairs(player.Backpack:GetChildren()) do
		local n = v.Name:lower()
		if name == "Potato" and n == "potato" and not n:find("chip") then return v end
		if name == "Flour"  and n:find("flour") then return v end
	end
	if player.Character then
		for _, v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") then
				local n = v.Name:lower()
				if name == "Potato" and n == "potato" and not n:find("chip") then return v end
				if name == "Flour"  and n:find("flour") then return v end
			end
		end
	end
	return nil
end

local function countPotatoRaw()
	local count = 0
	for _, v in pairs(player.Backpack:GetChildren()) do
		local n = v.Name:lower()
		if n == "potato" and not n:find("chip") then count += 1 end
	end
	if player.Character then
		for _, v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") then
				local n = v.Name:lower()
				if n == "potato" and not n:find("chip") then count += 1 end
			end
		end
	end
	return count
end

local function countPotatoChips()
	local count = 0
	for _, v in pairs(player.Backpack:GetChildren()) do
		local n = v.Name:lower()
		if n:find("potato") and n:find("chip") then count += 1 end
	end
	if player.Character then
		for _, v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") then
				local n = v.Name:lower()
				if n:find("potato") and n:find("chip") then count += 1 end
			end
		end
	end
	return count
end

local function countFlour()
	local count = 0
	for _, v in pairs(player.Backpack:GetChildren()) do
		if v.Name:lower():find("flour") then count += 1 end
	end
	if player.Character then
		for _, v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") and v.Name:lower():find("flour") then count += 1 end
		end
	end
	return count
end

local function equipItemPotato(name)
	local char = player.Character
	if not char then return false end
	local item = findItemPotato(name)
	if item then item.Parent = char task.wait(0.4) return true end
	return false
end

local function pressInteract(duration)
	duration = duration or 2
	VIM:SendKeyEvent(true, "E", false, game)
	task.wait(duration)
	VIM:SendKeyEvent(false, "E", false, game)
	task.wait(0.3)
end

local potatoStartBtn  = btn(potatoTab, "🥔 START Auto Potato")
local potatoStopBtn   = btn(potatoTab, "⏹ STOP")
local potatoStatus    = makeLabel(potatoTab, "Auto Potato: idle")
local potatoLoopLabel = makeLabel(potatoTab, "🔄 Loop: 0")
local potatoInvRaw    = makeLabel(potatoTab, "🥔 Potato Mentah  : -")
local potatoInvChips  = makeLabel(potatoTab, "🍟 Potato Chips   : -")
local potatoInvFlour  = makeLabel(potatoTab, "🌾 Flour          : -")

local function refreshPotatoDisplay()
	potatoInvRaw.Text   = "🥔 Potato Mentah  : " .. countPotatoRaw()
	potatoInvChips.Text = "🍟 Potato Chips   : " .. countPotatoChips()
	potatoInvFlour.Text = "🌾 Flour          : " .. countFlour()
end

task.spawn(function()
	while task.wait(1) do
		if not playerGui:FindFirstChild("VINZOHUB") then break end
		refreshPotatoDisplay()
	end
end)

backpack.ChildAdded:Connect(function()   task.wait(0.3) refreshPotatoDisplay() end)
backpack.ChildRemoved:Connect(function() task.wait(0.1) refreshPotatoDisplay() end)

local potatoTPSeparator = makeLabel(potatoTab, "──── 📍 TELEPORT CEPAT ────")
potatoTPSeparator.TextColor3 = Color3.fromRGB(255, 200, 0)
potatoTPSeparator.BackgroundColor3 = Color3.fromRGB(40, 10, 60)

local TP_POTATO_BAHAN  = Vector3.new(-770.3, 4.6,  -179.2)
local TP_POTATO_PABRIK = Vector3.new(-481.9, 3.9,  -466.5)
local TP_POTATO_NPC    = Vector3.new(-30.5,  4.7,  -22.2)

local tpPotatoBahanBtn  = btn(potatoTab, "🛒 TP Beli Bahan")
local tpPotatoPabrikBtn = btn(potatoTab, "🏭 TP Pabrik Kentang")
local tpPotatoNPCBtn    = btn(potatoTab, "🤝 TP NPC Tuker")

tpPotatoBahanBtn.BackgroundColor3  = Color3.fromRGB(0, 100, 180)
tpPotatoPabrikBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 60)
tpPotatoNPCBtn.BackgroundColor3    = Color3.fromRGB(160, 80, 0)

tpPotatoBahanBtn.MouseEnter:Connect(function() TweenService:Create(tpPotatoBahanBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,150,255)}):Play() end)
tpPotatoBahanBtn.MouseLeave:Connect(function() TweenService:Create(tpPotatoBahanBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,100,180)}):Play() end)
tpPotatoPabrikBtn.MouseEnter:Connect(function() TweenService:Create(tpPotatoPabrikBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,200,90)}):Play() end)
tpPotatoPabrikBtn.MouseLeave:Connect(function() TweenService:Create(tpPotatoPabrikBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,130,60)}):Play() end)
tpPotatoNPCBtn.MouseEnter:Connect(function() TweenService:Create(tpPotatoNPCBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(220,120,0)}):Play() end)
tpPotatoNPCBtn.MouseLeave:Connect(function() TweenService:Create(tpPotatoNPCBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(160,80,0)}):Play() end)

-- ===================================================
-- TELEPORT FUNCTION
-- ===================================================
local teleporting = false
local tpCooldown  = {}

local function stopAllVelocity(obj)
	if not obj then return end
	pcall(function()
		obj.AssemblyLinearVelocity  = Vector3.new(0,0,0)
		obj.AssemblyAngularVelocity = Vector3.new(0,0,0)
		obj.Velocity                = Vector3.new(0,0,0)
		obj.RotVelocity             = Vector3.new(0,0,0)
	end)
end

local function teleportVehiclePro(targetPos)
	if teleporting then return end
	teleporting = true
	local btnKey = tostring(targetPos)
	if tpCooldown[btnKey] and tick() - tpCooldown[btnKey] < 0.3 then teleporting = false return end
	tpCooldown[btnKey] = tick()
	task.spawn(function()
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp  = char:WaitForChild("HumanoidRootPart", 3)
		local hum  = char:FindFirstChildOfClass("Humanoid")
		if not hrp or not hum then teleporting = false return end
		stopAllVelocity(hrp)
		local seat = hum.SeatPart
		if seat then
			local vehicle = seat:FindFirstAncestorOfClass("Model")
			if vehicle then
				for _, v in pairs(vehicle:GetDescendants()) do
					if v:IsA("BasePart") then stopAllVelocity(v) end
				end
				if not vehicle.PrimaryPart then
					for _, v in pairs(vehicle:GetDescendants()) do
						if v:IsA("BasePart") then vehicle.PrimaryPart = v break end
					end
				end
				if vehicle.PrimaryPart then vehicle:SetPrimaryPartCFrame(CFrame.new(targetPos)) end
			end
		else
			hrp.CFrame = CFrame.new(targetPos)
			local conn
			local t = 0
			conn = RunService.Heartbeat:Connect(function(dt)
				t += dt
				if t > 0.3 then conn:Disconnect() return end
				if hrp and hrp.Parent then
					hrp.AssemblyLinearVelocity  = Vector3.zero
					hrp.AssemblyAngularVelocity = Vector3.zero
				end
			end)
		end
		task.wait(0.5)
		teleporting = false
	end)
end

tpPotatoBahanBtn.MouseButton1Click:Connect(function()  teleportVehiclePro(TP_POTATO_BAHAN)  end)
tpPotatoPabrikBtn.MouseButton1Click:Connect(function() teleportVehiclePro(TP_POTATO_PABRIK) end)
tpPotatoNPCBtn.MouseButton1Click:Connect(function()    teleportVehiclePro(TP_POTATO_NPC)    end)

-- ===================================================
-- NPC TELEPORT
-- ===================================================
local npcSeparator = makeLabel(potatoTab, "──── 🧍 NPC LOCATIONS ────")
npcSeparator.TextColor3 = Color3.fromRGB(255, 140, 0)
npcSeparator.BackgroundColor3 = Color3.fromRGB(30, 15, 0)

local NPC_COORDS = {
	{ name = "NPC 1",  pos = Vector3.new(61.9,   4.7,   69.5)  },
	{ name = "NPC 2",  pos = Vector3.new(25.2,   4.7,  215.0)  },
	{ name = "NPC 3",  pos = Vector3.new(-273.9,  4.8, -208.9) },
	{ name = "NPC 4",  pos = Vector3.new(54.6,   4.7,  -423.0) },
	{ name = "NPC 5",  pos = Vector3.new(-313.2,  4.7, -365.5) },
	{ name = "NPC 6",  pos = Vector3.new(1103.2,  3.4,  521.9) },
	{ name = "NPC 7",  pos = Vector3.new(163.5,  4.7,  -224.6) },
	{ name = "NPC 8",  pos = Vector3.new(529.0,   4.3, -289.3) },
	{ name = "NPC 9",  pos = Vector3.new(699.7,  4.7,  -423.0) },
	{ name = "NPC 10", pos = Vector3.new(896.3,   4.3, -272.8) },
	{ name = "NPC 11", pos = Vector3.new(868.7,  4.7,   -63.2) },
	{ name = "NPC 12", pos = Vector3.new(-520.5, -6.9, -168.5) },
}

local npcColors = {
	Color3.fromRGB(0,100,180), Color3.fromRGB(0,130,60),
	Color3.fromRGB(160,80,0),  Color3.fromRGB(120,0,160),
	Color3.fromRGB(0,120,120), Color3.fromRGB(160,30,30),
	Color3.fromRGB(0,100,180), Color3.fromRGB(0,130,60),
	Color3.fromRGB(160,80,0),  Color3.fromRGB(120,0,160),
	Color3.fromRGB(0,120,120), Color3.fromRGB(160,30,30),
}

for i, npc in ipairs(NPC_COORDS) do
	local b = btn(potatoTab, "🧍 " .. npc.name)
	local baseCol = npcColors[i]
	b.BackgroundColor3 = baseCol
	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(math.min(baseCol.R*255+50,255),math.min(baseCol.G*255+50,255),math.min(baseCol.B*255+50,255))}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3=baseCol}):Play()
	end)
	local targetPos = npc.pos
	b.MouseButton1Click:Connect(function() teleportVehiclePro(targetPos) end)
end

-- ===================================================
-- MOVE TO POS
-- ===================================================
local function moveToPos(targetPos)
	local char = player.Character
	if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return false end
	local MAX_ATTEMPTS = 5
	local attempt = 0
	while attempt < MAX_ATTEMPTS do
		if not potatoFarming then return false end
		attempt += 1
		if (hrp.Position - targetPos).Magnitude < 5 then task.wait(0.3) return true end
		if attempt >= 3 then
			potatoStatus.Text = "⚡ Force TP attempt " .. attempt
			hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))
			hrp.AssemblyLinearVelocity  = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			task.wait(0.6)
			return true
		end
		hum:MoveTo(targetPos)
		local timeout = 10
		local elapsed = 0
		local lastPos = hrp.Position
		local stuckTimer = 0
		while elapsed < timeout do
			if not potatoFarming then return false end
			if (hrp.Position - targetPos).Magnitude < 5 then task.wait(0.3) return true end
			local moved = (hrp.Position - lastPos).Magnitude
			if moved < 0.3 then
				stuckTimer += 0.1
				if stuckTimer >= 1.5 then
					hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(math.random(-4,4),2,math.random(-4,4)))
					hrp.AssemblyLinearVelocity = Vector3.zero
					task.wait(0.3)
					hum:MoveTo(targetPos)
					stuckTimer = 0
					lastPos = hrp.Position
				end
			else
				stuckTimer = 0
				lastPos = hrp.Position
			end
			task.wait(0.1)
			elapsed += 0.1
		end
	end
	hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))
	hrp.AssemblyLinearVelocity = Vector3.zero
	task.wait(0.5)
	return true
end

-- ===================================================
-- POTATO LOOP
-- ===================================================
local potatoLoopCount = 0

local function autoPotatoLoop()
	potatoLoopCount = 0
	while potatoFarming do
		if countPotatoRaw() <= 0 then
			potatoStatus.Text = "❌ Potato mentah habis! (" .. countPotatoChips() .. " chips)"
			potatoFarming = false
			potatoStartBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
			potatoStartBtn.Text = "🥔 START Auto Potato"
			break
		end
		if countFlour() <= 0 then
			potatoStatus.Text = "❌ Flour habis!"
			potatoFarming = false
			potatoStartBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
			potatoStartBtn.Text = "🥔 START Auto Potato"
			break
		end
		potatoLoopCount += 1
		potatoLoopLabel.Text = "🔄 Loop: " .. potatoLoopCount .. " | Potato: " .. countPotatoRaw()
		for _, step in ipairs(POTATO_STEPS) do
			if not potatoFarming then break end
			potatoStatus.Text = "🚶 " .. step.label
			if not moveToPos(step.pos) then break end
			if step.equip then
				if not equipItemPotato(step.equip) then
					potatoStatus.Text = "❌ " .. step.equip .. " tidak ditemukan!"
					potatoFarming = false
					potatoStartBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
					potatoStartBtn.Text = "🥔 START Auto Potato"
					break
				end
			end
			if step.interact then
				potatoStatus.Text = "🔘 Press E - " .. step.label
				pressInteract(2)
			end
			if step.waitAfter and step.waitAfter > 0 then
				local remaining = step.waitAfter
				while remaining > 0 do
					if not potatoFarming then break end
					potatoStatus.Text = "⏳ Masak... " .. remaining .. "s | Chips: " .. countPotatoChips()
					task.wait(1)
					remaining -= 1
				end
				if potatoFarming then
					potatoStatus.Text = "🔘 Ambil hasil masak..."
					pressInteract(2)
				end
			end
			task.wait(0.5)
		end
		potatoStatus.Text = "✅ Loop " .. potatoLoopCount .. " selesai!"
		task.wait(1)
	end
	potatoStatus.Text = "Auto Potato: idle"
	potatoLoopLabel.Text = "🔄 Loop selesai: " .. potatoLoopCount
end

potatoStartBtn.MouseButton1Click:Connect(function()
	if potatoFarming then return end
	potatoFarming = true
	potatoStartBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
	potatoStartBtn.Text = "🥔 Auto Potato: ON"
	potatoStatus.Text = "▶ Running..."
	task.spawn(autoPotatoLoop)
end)
potatoStopBtn.MouseButton1Click:Connect(function()
	potatoFarming = false
	potatoStartBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
	potatoStartBtn.Text = "🥔 START Auto Potato"
	potatoStatus.Text = "⏹ Dihentikan"
end)

-- ===================================================
-- RESPAWN TAB
-- ===================================================
local selectedSpawn = nil
local respawnStatus = makeLabel(respawnTab, "📍 Spawn: belum dipilih")

local function makeSpawnBtn(name, pos)
	local b = btn(respawnTab, "📍 "..name)
	b.MouseButton1Click:Connect(function()
		selectedSpawn = pos
		for _,v in pairs(respawnTab:GetChildren()) do
			if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(80,0,180) end
		end
		b.BackgroundColor3 = Color3.fromRGB(40,170,90)
		respawnStatus.Text = "📍 Spawn: "..name
	end)
end

makeSpawnBtn("🚀 Dealer",     Vector3.new(511,3,601))
makeSpawnBtn("🏥 RS 1",       Vector3.new(1140.8,10.1,451.8))
makeSpawnBtn("🏥 RS 2",       Vector3.new(1141.2,10.1,423.2))
makeSpawnBtn("🏠 Tier 1",     Vector3.new(985.9,10.1,247))
makeSpawnBtn("🏠 Tier 2",     Vector3.new(989.3,11.0,228.3))
makeSpawnBtn("🗑️ Trash 1",    Vector3.new(890.9,10.1,44.3))
makeSpawnBtn("🗑️ Trash 2",    Vector3.new(920.4,10.1,46.3))
makeSpawnBtn("🚗 Dealership", Vector3.new(733.5,4.6,431.9))
makeSpawnBtn("🔫 GS Ujung",   Vector3.new(-467.1,4.8,353.5))
makeSpawnBtn("🔫 GS Mid",     Vector3.new(218.7,3.7,-176.2))

local respawnNowBtn = btn(respawnTab, "🔄 RESPAWN SEKARANG")
respawnNowBtn.MouseButton1Click:Connect(function()
	if not selectedSpawn then respawnStatus.Text = "⚠️ Pilih spawn dulu!" return end
	local char = player.Character
	local hum  = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	respawnStatus.Text = "💀 Respawning..."
	hum.Health = 0
	task.wait(0.2)
	player.CharacterAdded:Wait()
	task.wait(1)
	local newChar = player.Character
	local hrp = newChar:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(selectedSpawn)
		respawnStatus.Text = "✅ Respawn berhasil!"
	end
end)

-- ===================================================
-- TELEPORT TAB
-- ===================================================
btn(tpTab,"🚀 Dealer").MouseButton1Click:Connect(function()     teleportVehiclePro(Vector3.new(511,3,601))          end)
btn(tpTab,"🏥 RS 1").MouseButton1Click:Connect(function()        teleportVehiclePro(Vector3.new(1140.8,10.1,451.8)) end)
btn(tpTab,"🏥 RS 2").MouseButton1Click:Connect(function()        teleportVehiclePro(Vector3.new(1141.2,10.1,423.2)) end)
btn(tpTab,"🏠 Tier 1").MouseButton1Click:Connect(function()      teleportVehiclePro(Vector3.new(985.9,10.1,247))    end)
btn(tpTab,"🏠 Tier 2").MouseButton1Click:Connect(function()      teleportVehiclePro(Vector3.new(989.3,11.0,228.3))  end)
btn(tpTab,"🗑️ Trash 1").MouseButton1Click:Connect(function()     teleportVehiclePro(Vector3.new(890.9,10.1,44.3))   end)
btn(tpTab,"🗑️ Trash 2").MouseButton1Click:Connect(function()     teleportVehiclePro(Vector3.new(920.4,10.1,46.3))   end)
btn(tpTab,"🚗 Dealership").MouseButton1Click:Connect(function()  teleportVehiclePro(Vector3.new(733.5,4.6,431.9))   end)
btn(tpTab,"🔫 GS Ujung").MouseButton1Click:Connect(function()    teleportVehiclePro(Vector3.new(-467.1,4.8,353.5))  end)
btn(tpTab,"🔫 GS Mid").MouseButton1Click:Connect(function()      teleportVehiclePro(Vector3.new(218.7,3.7,-176.2))  end)

-- ===================================================
-- VISUAL TAB
-- ===================================================
local ESP_FOLDER = Instance.new("Folder")
ESP_FOLDER.Name   = "ESP_STORAGE"
ESP_FOLDER.Parent = game.CoreGui

local espConnections = {}

local espNameBtn = btn(visualTab, "👁️ ESP NAME : OFF")
getgenv().ESP_NAME = false

local function clearESPName()
	for _, v in pairs(ESP_FOLDER:GetChildren()) do
		if v.Name:find("_NAME") then v:Destroy() end
	end
end

local function createESPName(plr)
	if plr == player then return end
	local function addName(char)
		if not getgenv().ESP_NAME then return end
		local head = char:FindFirstChild("Head")
		if not head then return end
		local ex = ESP_FOLDER:FindFirstChild(plr.Name.."_NAME")
		if ex then ex:Destroy() end
		local bill = Instance.new("BillboardGui")
		bill.Name = plr.Name.."_NAME"
		bill.Adornee = head
		bill.Size = UDim2.new(0,100,0,20)
		bill.StudsOffset = Vector3.new(0,3.5,0)
		bill.AlwaysOnTop = true
		bill.Parent = ESP_FOLDER
		local lbl = Instance.new("TextLabel", bill)
		lbl.Size = UDim2.new(1,0,1,0)
		lbl.BackgroundTransparency = 1
		lbl.Text = plr.Name
		lbl.TextColor3 = Color3.fromRGB(255,255,255)
		lbl.TextStrokeTransparency = 0.3
		lbl.TextSize = 12
		lbl.Font = Enum.Font.GothamBold
	end
	if plr.Character then addName(plr.Character) end
	if not espConnections[plr.Name.."_nameChar"] then
		espConnections[plr.Name.."_nameChar"] = plr.CharacterAdded:Connect(function(char)
			task.wait(0.5) addName(char)
		end)
	end
end

local function enableESPName()
	clearESPName()
	for _, plr in pairs(Players:GetPlayers()) do createESPName(plr) end
end

espNameBtn.MouseButton1Click:Connect(function()
	getgenv().ESP_NAME = not getgenv().ESP_NAME
	if getgenv().ESP_NAME then
		espNameBtn.Text = "👁️ ESP NAME : ON"
		espNameBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		enableESPName()
	else
		espNameBtn.Text = "👁️ ESP NAME : OFF"
		espNameBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		clearESPName()
	end
end)

local espHealthBtn = btn(visualTab, "❤️ ESP HEALTH BAR : OFF")
getgenv().ESP_HEALTH = false

local function clearESPHealth()
	for _, v in pairs(ESP_FOLDER:GetChildren()) do
		if v.Name:find("_HEALTH") then v:Destroy() end
	end
end

local function createESPHealth(plr)
	if plr == player then return end
	local function addHealth(char)
		if not getgenv().ESP_HEALTH then return end
		local head = char:FindFirstChild("Head")
		local hum  = char:FindFirstChildOfClass("Humanoid")
		if not head or not hum then return end
		local ex = ESP_FOLDER:FindFirstChild(plr.Name.."_HEALTH")
		if ex then ex:Destroy() end
		local bill = Instance.new("BillboardGui")
		bill.Name = plr.Name.."_HEALTH"
		bill.Adornee = head
		bill.Size = UDim2.new(0,80,0,10)
		bill.StudsOffset = Vector3.new(0,2.0,0)
		bill.AlwaysOnTop = true
		bill.Parent = ESP_FOLDER
		local bg = Instance.new("Frame", bill)
		bg.Size = UDim2.new(1,0,1,0)
		bg.BackgroundColor3 = Color3.fromRGB(60,0,0)
		bg.BorderSizePixel = 0
		Instance.new("UICorner", bg).CornerRadius = UDim.new(0,3)
		local fill = Instance.new("Frame", bg)
		fill.Size = UDim2.new(hum.Health/hum.MaxHealth,0,1,0)
		fill.BackgroundColor3 = Color3.fromRGB(0,220,80)
		fill.BorderSizePixel = 0
		Instance.new("UICorner", fill).CornerRadius = UDim.new(0,3)
		local hpText = Instance.new("TextLabel", bg)
		hpText.Size = UDim2.new(1,0,1,0)
		hpText.BackgroundTransparency = 1
		hpText.TextColor3 = Color3.new(1,1,1)
		hpText.TextStrokeTransparency = 0.2
		hpText.Font = Enum.Font.GothamBold
		hpText.TextSize = 7
		hpText.Text = math.floor(hum.Health).."/"..math.floor(hum.MaxHealth)
		local conn
		conn = RunService.Heartbeat:Connect(function()
			if not getgenv().ESP_HEALTH or not hum or not hum.Parent then conn:Disconnect() return end
			local pct = math.clamp(hum.Health/hum.MaxHealth,0,1)
			fill.Size = UDim2.new(pct,0,1,0)
			if pct > 0.6 then fill.BackgroundColor3 = Color3.fromRGB(0,220,80)
			elseif pct > 0.3 then fill.BackgroundColor3 = Color3.fromRGB(230,200,0)
			else fill.BackgroundColor3 = Color3.fromRGB(220,50,50) end
			hpText.Text = math.floor(hum.Health).."/"..math.floor(hum.MaxHealth)
		end)
	end
	if plr.Character then addHealth(plr.Character) end
	if not espConnections[plr.Name.."_healthChar"] then
		espConnections[plr.Name.."_healthChar"] = plr.CharacterAdded:Connect(function(char)
			task.wait(0.5) addHealth(char)
		end)
	end
end

local function enableESPHealth()
	clearESPHealth()
	for _, plr in pairs(Players:GetPlayers()) do createESPHealth(plr) end
end

espHealthBtn.MouseButton1Click:Connect(function()
	getgenv().ESP_HEALTH = not getgenv().ESP_HEALTH
	if getgenv().ESP_HEALTH then
		espHealthBtn.Text = "❤️ ESP HEALTH BAR : ON"
		espHealthBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		enableESPHealth()
	else
		espHealthBtn.Text = "❤️ ESP HEALTH BAR : OFF"
		espHealthBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		clearESPHealth()
	end
end)

local espSkelBtn = btn(visualTab, "🦴 ESP SKELETON : OFF")
getgenv().ESP_SKELETON = false

local R6_BONES = {
	{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
	{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
	{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
	{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
	{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}
local R6_BONES_ALT = {
	{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
	{"Torso","Left Leg"},{"Torso","Right Leg"},
}

local skelConnections = {}
local skelGui = Instance.new("ScreenGui")
skelGui.Name = "VINZOHUB_SKEL"
skelGui.ResetOnSpawn = false
skelGui.IgnoreGuiInset = true
skelGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
skelGui.Parent = game.CoreGui

local skelLines = {}

local function makeLine(parent)
	local f = Instance.new("Frame", parent)
	f.AnchorPoint = Vector2.new(0.5,0)
	f.BackgroundColor3 = Color3.fromRGB(0,255,200)
	f.BorderSizePixel = 0
	f.ZIndex = 5
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,2)
	return f
end

local function updateLine(line, p1, p2, cam)
	local vp1, vis1 = cam:WorldToViewportPoint(p1)
	local vp2, vis2 = cam:WorldToViewportPoint(p2)
	if not vis1 or not vis2 or vp1.Z < 0 or vp2.Z < 0 then line.Visible = false return end
	line.Visible = true
	local dx = vp2.X - vp1.X
	local dy = vp2.Y - vp1.Y
	local len = math.sqrt(dx*dx + dy*dy)
	line.Size = UDim2.new(0,len,0,2)
	line.Position = UDim2.new(0,vp1.X,0,vp1.Y)
	line.Rotation = math.deg(math.atan2(dy,dx))
end

local function clearESPSkeleton()
	for _, v in pairs(ESP_FOLDER:GetChildren()) do
		if v.Name:find("_SKEL") then v:Destroy() end
	end
	for k, c in pairs(skelConnections) do
		if c then c:Disconnect() end
		skelConnections[k] = nil
	end
end

local function createESPSkeleton(plr)
	if plr == player then return end
	local function setupSkel(char)
		if not getgenv().ESP_SKELETON then return end
		if skelLines[plr.Name] then
			for _, ln in pairs(skelLines[plr.Name]) do
				if ln and ln.Parent then ln:Destroy() end
			end
		end
		skelLines[plr.Name] = {}
		local boneList = char:FindFirstChild("UpperTorso") and R6_BONES or R6_BONES_ALT
		for i, _ in ipairs(boneList) do
			skelLines[plr.Name][i] = makeLine(skelGui)
			skelLines[plr.Name][i].Visible = false
		end
		local connKey = plr.Name.."_skelHB"
		if skelConnections[connKey] then skelConnections[connKey]:Disconnect() end
		skelConnections[connKey] = RunService.Heartbeat:Connect(function()
			if not getgenv().ESP_SKELETON then
				for _, ln in pairs(skelLines[plr.Name] or {}) do
					if ln and ln.Parent then ln.Visible = false end
				end
				return
			end
			local cam = workspace.CurrentCamera
			if not char or not char.Parent then return end
			for i, pair in ipairs(boneList) do
				local ln = skelLines[plr.Name] and skelLines[plr.Name][i]
				if not ln then continue end
				local p1p = char:FindFirstChild(pair[1])
				local p2p = char:FindFirstChild(pair[2])
				if p1p and p2p and p1p:IsA("BasePart") and p2p:IsA("BasePart") then
					updateLine(ln, p1p.Position, p2p.Position, cam)
				else
					ln.Visible = false
				end
			end
		end)
	end
	if plr.Character then setupSkel(plr.Character) end
	local connKey = plr.Name.."_skelChar"
	if skelConnections[connKey] then skelConnections[connKey]:Disconnect() end
	skelConnections[connKey] = plr.CharacterAdded:Connect(function(char)
		task.wait(0.5) setupSkel(char)
	end)
end

local function enableESPSkeleton()
	clearESPSkeleton()
	for _, plr in pairs(Players:GetPlayers()) do createESPSkeleton(plr) end
end

espSkelBtn.MouseButton1Click:Connect(function()
	getgenv().ESP_SKELETON = not getgenv().ESP_SKELETON
	if getgenv().ESP_SKELETON then
		espSkelBtn.Text = "🦴 ESP SKELETON : ON"
		espSkelBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		enableESPSkeleton()
	else
		espSkelBtn.Text = "🦴 ESP SKELETON : OFF"
		espSkelBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		clearESPSkeleton()
		skelGui:ClearAllChildren()
		skelLines = {}
	end
end)

Players.PlayerAdded:Connect(function(plr)
	task.wait(1)
	if getgenv().ESP_NAME     then createESPName(plr)     end
	if getgenv().ESP_HEALTH   then createESPHealth(plr)   end
	if getgenv().ESP_SKELETON then createESPSkeleton(plr) end
end)

Players.PlayerRemoving:Connect(function(plr)
	if skelLines[plr.Name] then
		for _, ln in pairs(skelLines[plr.Name]) do
			if ln and ln.Parent then ln:Destroy() end
		end
		skelLines[plr.Name] = nil
	end
	local keys = {plr.Name.."_skelHB",plr.Name.."_skelChar",plr.Name.."_nameChar",plr.Name.."_healthChar"}
	for _, k in pairs(keys) do
		if espConnections[k] then espConnections[k]:Disconnect() espConnections[k] = nil end
		if skelConnections[k] then skelConnections[k]:Disconnect() skelConnections[k] = nil end
	end
	local nt = ESP_FOLDER:FindFirstChild(plr.Name.."_NAME")
	if nt then nt:Destroy() end
	local ht = ESP_FOLDER:FindFirstChild(plr.Name.."_HEALTH")
	if ht then ht:Destroy() end
end)

-- ===================================================
-- ANTI HIT + ANTI APPROACH
-- ===================================================
local antiHitBtn    = btn(visualTab, "🛡️ ANTI HIT + APPROACH : OFF")
local antiHitStatus = makeLabel(visualTab, "Status: idle")
local antiHitConn   = nil
local antiApprConn  = nil
local antiHitLastTP = 0

local SAFE_POS         = Vector3.new(579.0, 3.5, -539.7)
local MALL_POS         = Vector3.new(-725.4, 4.8, 587.4)
local APPROACH_RADIUS  = 25
local approachDetected = false

local function startAntiHit()
	local char = player.Character or player.CharacterAdded:Wait()
	local hum  = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	antiHitConn = RunService.Heartbeat:Connect(function()
		if not getgenv().ANTI_HIT then return end
		if not hum or not hum.Parent then return end
		if hum.Health < hum.MaxHealth and hum.Health > 0 then
			if tick() - antiHitLastTP < 2 then return end
			antiHitLastTP = tick()
			antiHitStatus.Text = "⚡ Kena hit! TP..."
			teleporting = false
			teleportVehiclePro(SAFE_POS)
		end
	end)
end

local function startAntiApproach()
	approachDetected = false
	antiApprConn = RunService.Heartbeat:Connect(function()
		if not getgenv().ANTI_HIT then return end
		local char = player.Character
		local hrp  = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		if tick() - antiHitLastTP < 1 then return end
		local closest     = nil
		local closestDist = math.huge
		for _, plr in pairs(Players:GetPlayers()) do
			if plr == player then continue end
			local c = plr.Character
			local h = c and c:FindFirstChild("HumanoidRootPart")
			if not h then continue end
			local dist = (hrp.Position - h.Position).Magnitude
			if dist > APPROACH_RADIUS then continue end
			if dist >= closestDist then continue end
			local origin = hrp.Position
			local target = h.Position
			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = {char, c}
			local checkPoints  = {origin, origin + Vector3.new(0,1.5,0), origin + Vector3.new(0,-1.5,0)}
			local targetPoints = {target, target + Vector3.new(0,1.5,0), target + Vector3.new(0,-1.5,0)}
			local clearCount = 0
			for i = 1, 3 do
				local dir     = targetPoints[i] - checkPoints[i]
				local rayDist = dir.Magnitude
				local result  = workspace:Raycast(checkPoints[i], dir, rayParams)
				if result then
					if (result.Position - checkPoints[i]).Magnitude >= rayDist - 1 then clearCount += 1 end
				else
					clearCount += 1
				end
			end
			if clearCount > 0 then closestDist = dist closest = plr end
		end
		if closest then
			if not approachDetected then
				approachDetected   = true
				antiHitLastTP      = tick()
				antiHitStatus.Text = "⚠️ " .. closest.Name .. " (jarak: " .. math.floor(closestDist) .. ") TP mall..."
				teleporting = false
				teleportVehiclePro(MALL_POS)
			end
		else
			approachDetected   = false
			antiHitStatus.Text = "🛡️ Aktif | Radius: " .. APPROACH_RADIUS .. " | Aman"
		end
	end)
end

local function stopAntiHit()
	if antiHitConn  then antiHitConn:Disconnect()  antiHitConn  = nil end
	if antiApprConn then antiApprConn:Disconnect() antiApprConn = nil end
	antiHitLastTP = 0
	antiHitStatus.Text = "Status: idle"
end

player.CharacterAdded:Connect(function()
	if getgenv().ANTI_HIT then
		task.wait(1)
		startAntiHit()
		startAntiApproach()
	end
end)

antiHitBtn.MouseButton1Click:Connect(function()
	getgenv().ANTI_HIT = not getgenv().ANTI_HIT
	if getgenv().ANTI_HIT then
		startAntiHit()
		startAntiApproach()
		antiHitBtn.Text = "🛡️ ANTI HIT + APPROACH : ON"
		antiHitBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		antiHitStatus.Text = "🛡️ Aktif | Radius: " .. APPROACH_RADIUS
	else
		stopAntiHit()
		antiHitBtn.Text = "🛡️ ANTI HIT + APPROACH : OFF"
		antiHitBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
	end
end)

-- ===================================================
-- DELETE OBJECT
-- ===================================================
local deleteObjectBtn  = btn(visualTab, "🗑️ DELETE OBJECT : OFF")
getgenv().DELETE_MODE  = false
local deleteHistory    = {}
local currentTarget    = nil
local currentHighlight = nil
local lastClickTime    = 0
local CLICK_COOLDOWN   = 0.5

deleteObjectBtn.MouseButton1Click:Connect(function()
	getgenv().DELETE_MODE = not getgenv().DELETE_MODE
	if getgenv().DELETE_MODE then
		deleteObjectBtn.Text = "🗑️ DELETE OBJECT : ON"
		deleteObjectBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
	else
		deleteObjectBtn.Text = "🗑️ DELETE OBJECT : OFF"
		deleteObjectBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
		currentTarget = nil
	end
end)

local altPressed = false

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftAlt then altPressed = true end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftAlt then
		altPressed = false
		if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
		currentTarget = nil
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp or not getgenv().DELETE_MODE then return end
	if input.KeyCode == Enum.KeyCode.Z and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		if #deleteHistory > 0 then
			local backup = table.remove(deleteHistory, 1)
			pcall(function()
				backup.clone.Parent = backup.originalParent
				if backup.clone:IsA("BasePart") then backup.clone.CFrame = backup.originalCFrame end
			end)
		end
	end
end)

local function createOutline(part)
	if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
	local box = Instance.new("SelectionBox")
	box.Color3 = Color3.new(1,0,0)
	box.LineThickness = 0.01
	box.SurfaceTransparency = 1
	box.SurfaceColor3 = Color3.new(1,0,0)
	box.Adornee = part
	box.Parent = game.CoreGui
	currentHighlight = box
end

RunService.Heartbeat:Connect(function()
	if not getgenv().DELETE_MODE or not altPressed then
		if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
		currentTarget = nil
		return
	end
	local cam = workspace.CurrentCamera
	local mousePos = UserInputService:GetMouseLocation()
	local ray = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local char = player.Character
	params.FilterDescendantsInstances = char and {char} or {}
	local result = workspace:Raycast(ray.Origin, ray.Direction * 500, params)
	if result and result.Instance and result.Instance:IsA("BasePart") then
		local hit = result.Instance
		if currentTarget ~= hit then currentTarget = hit createOutline(hit) end
	else
		if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
		currentTarget = nil
	end
end)

local deletedThisClick = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	if not altPressed or not getgenv().DELETE_MODE then return end
	if tick() - lastClickTime < CLICK_COOLDOWN then return end
	if deletedThisClick then return end
	if not currentTarget or not currentTarget.Parent then return end
	deletedThisClick = true
	lastClickTime = tick()
	local target = currentTarget
	local ok, clone = pcall(function() return target:Clone() end)
	if ok and clone then
		clone.Parent = game:GetService("ReplicatedStorage")
		table.insert(deleteHistory, 1, {
			name = target.Name,
			originalParent = target.Parent,
			originalCFrame = target.CFrame,
			clone = clone
		})
		if #deleteHistory > 15 then
			local old = table.remove(deleteHistory)
			if old.clone then pcall(function() old.clone:Destroy() end) end
		end
	end
	if currentHighlight then currentHighlight:Destroy() currentHighlight = nil end
	currentTarget = nil
	pcall(function() target:Destroy() end)
	task.wait(0.1)
	deletedThisClick = false
end)

local deleteStatus = makeLabel(visualTab, "🗑️ History: 0 | ALT+Click=Del | CTRL+Z=Undo")
task.spawn(function()
	while task.wait(1) do
		if not playerGui:FindFirstChild("VINZOHUB") then break end
		pcall(function()
			deleteStatus.Text = "🗑️ History: "..#deleteHistory.." | ALT+Click=Del | CTRL+Z=Undo"
		end)
	end
end)

-- ===================================================
-- CREDIT TAB
-- ===================================================
local creditTitle = Instance.new("TextLabel", creditTab)
creditTitle.Size = UDim2.new(1,0,0,50)
creditTitle.BackgroundColor3 = Color3.fromRGB(120,0,255)
creditTitle.TextColor3 = Color3.new(1,1,1)
creditTitle.Font = Enum.Font.GothamBlack
creditTitle.TextSize = 22
creditTitle.Text = "✨ VINZOHUB ✨"
creditTitle.ZIndex = 20
creditTitle.BorderSizePixel = 0
creditTitle.LayoutOrder = 1
Instance.new("UICorner", creditTitle).CornerRadius = UDim.new(0,7)

local creditInfo = Instance.new("TextLabel", creditTab)
creditInfo.Size = UDim2.new(1,0,0,70)
creditInfo.BackgroundColor3 = Color3.fromRGB(20,20,35)
creditInfo.TextColor3 = Color3.new(1,1,1)
creditInfo.Font = Enum.Font.GothamBold
creditInfo.TextSize = 14
creditInfo.Text = "👑 Owner  : Vinzo\n💬 Discord : VinzoHub"
creditInfo.TextXAlignment = Enum.TextXAlignment.Left
creditInfo.TextWrapped = true
creditInfo.ZIndex = 20
creditInfo.BorderSizePixel = 0
creditInfo.LayoutOrder = 2
Instance.new("UICorner", creditInfo).CornerRadius = UDim.new(0,7)
local cPad = Instance.new("UIPadding", creditInfo)
cPad.PaddingLeft = UDim.new(0,10)
cPad.PaddingTop  = UDim.new(0,8)

local discordBtn = btn(creditTab, "🔗 Join Discord VinzoHub")
discordBtn.LayoutOrder = 3
discordBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)
discordBtn.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/c7JtbZpyDQ")
	discordBtn.Text = "✅ Link Copied!"
	task.wait(2)
	discordBtn.Text = "🔗 Join Discord VinzoHub"
end)

-- ===================================================
-- CLEANUP
-- ===================================================
local function stopAutoRespawn() end

closeBtn.Activated:Connect(function()
	getgenv().VINZO_RUNNING   = false
	getgenv().PROMPT_SCANNING = false
	getgenv().AUTO_BUY        = false
	getgenv().AUTO_SELL       = false
	getgenv().LOWER_ROAD      = false
	getgenv().ESP_NAME        = false
	getgenv().ESP_HEALTH      = false
	getgenv().ESP_SKELETON    = false
	getgenv().ANTI_HIT        = false
	getgenv().DELETE_MODE     = false
	farming       = false
	potatoFarming = false
	pcall(stopPromptScan)
	pcall(stopAntiHit)
	pcall(stopAutoRespawn)
	pcall(restoreAllRoads)
	pcall(clearESPName)
	pcall(clearESPHealth)
	pcall(clearESPSkeleton)
	pcall(function() skelGui:Destroy() end)
	if gui then gui:Destroy() end
end)

end -- end loadMainScript
