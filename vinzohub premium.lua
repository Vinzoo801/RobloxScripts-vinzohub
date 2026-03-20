--// VINZOHUB GOD MODE PREMIUM 🔥

-- ================= TRIAL CONFIG =================
local TRIAL_DURATION_MINUTES = 4320 -- atur durasi trial di sini (menit)
-- ================================================

local _trialStart = tick()
local _trialExpired = false

task.spawn(function()
	task.wait(TRIAL_DURATION_MINUTES * 4320)
	_trialExpired = true
	-- matiin semua fitur
	getgenv().AUTO_BUY = false
	getgenv().AUTO_SELL = false
	getgenv().ESP_NAME = false
	getgenv().ANTI_HIT = false
	getgenv().KILL_AURA = false

	-- hapus GUI
	local pg = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	if pg:FindFirstChild("VINZOHUB") then pg.VINZOHUB:Destroy() end
	if pg:FindFirstChild("VINZOHUB_NOTIF") then pg.VINZOHUB_NOTIF:Destroy() end

	-- notif expired
	local expGui = Instance.new("ScreenGui", pg)
	expGui.Name = "VINZOHUB_EXPIRED"
	local expFrame = Instance.new("Frame", expGui)
	expFrame.Size = UDim2.new(0,400,0,100)
	expFrame.Position = UDim2.new(0.5,-200,0.5,-50)
	expFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
	expFrame.BorderSizePixel = 0
	Instance.new("UICorner", expFrame).CornerRadius = UDim.new(0,10)
	local expStroke = Instance.new("UIStroke", expFrame)
	expStroke.Color = Color3.fromRGB(255,50,50)
	expStroke.Thickness = 2
	local expText = Instance.new("TextLabel", expFrame)
	expText.Size = UDim2.new(1,0,1,0)
	expText.BackgroundTransparency = 1
	expText.Text = "⏰ Trial VINZOHUB telah berakhir!\nHubungi owner untuk versi full."
	expText.TextColor3 = Color3.new(1,1,1)
	expText.Font = Enum.Font.GothamBold
	expText.TextSize = 16
	expText.TextWrapped = true
	task.wait(5)
	expGui:Destroy()
end)

-- countdown timer di GUI (opsional, akan dibuat setelah GUI siap)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

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

-- FLOAT BUTTON
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

-- HEADER
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

-- countdown timer
local timerLabel = Instance.new("TextLabel", header)
timerLabel.Size = UDim2.new(1,-120,0.5,0)
timerLabel.Position = UDim2.new(0,15,0.5,0)
timerLabel.BackgroundTransparency = 1
timerLabel.TextColor3 = Color3.fromRGB(255,200,0)
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextSize = 13
timerLabel.ZIndex = 12

task.spawn(function()
	while not _trialExpired do
		local remaining = math.max(0, (TRIAL_DURATION_MINUTES * 60) - (tick() - _trialStart))
		local mins = math.floor(remaining / 60)
		local secs = math.floor(remaining % 60)
		timerLabel.Text = string.format("⏰ Trial: %02d:%02d", mins, secs)
		task.wait(1)
	end
	timerLabel.Text = "⏰ Trial Habis!"
	timerLabel.TextColor3 = Color3.fromRGB(255,50,50)
end)

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

-- TOGGLE KEY P
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
local tpTab      = newTab("TELEPORT",310)
local visualTab  = newTab("VISUAL",  465)
local creditTab  = newTab("CREDIT",  620)
local ownerTab   = isOwner and newTab("👑 OWNER", 775) or nil

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

-- ================= LABEL HELPER =================
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
-- ================= SHOP TAB ========================
-- ===================================================

-- ---- AUTO BUY ----
local buyTitleLabel = makeLabel(shopTab, "🛍️ Jumlah Beli: 1", 25)
buyTitleLabel.BackgroundTransparency = 1
buyTitleLabel.TextColor3 = Color3.new(1,1,1)

-- Slider container
local sliderContainer = Instance.new("Frame", shopTab)
sliderContainer.Size = UDim2.new(1,0,0,30)
sliderContainer.BackgroundColor3 = Color3.fromRGB(20,20,35)
sliderContainer.BorderSizePixel = 0
sliderContainer.ZIndex = 20
Instance.new("UICorner", sliderContainer).CornerRadius = UDim.new(0,7)

local sliderTrack = Instance.new("Frame", sliderContainer)
sliderTrack.Size = UDim2.new(1,-20,0,6)
sliderTrack.Position = UDim2.new(0,10,0.5,-3)
sliderTrack.BackgroundColor3 = Color3.fromRGB(60,60,80)
sliderTrack.BorderSizePixel = 0
sliderTrack.ZIndex = 21
Instance.new("UICorner", sliderTrack).CornerRadius = UDim.new(0,3)

local sliderFill = Instance.new("Frame", sliderTrack)
sliderFill.Size = UDim2.new(0,0,1,0)
sliderFill.BackgroundColor3 = Color3.fromRGB(140,0,255)
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 22
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0,3)

local sliderKnob = Instance.new("TextButton", sliderTrack)
sliderKnob.Size = UDim2.new(0,16,0,16)
sliderKnob.Position = UDim2.new(0,-8,0.5,-8)
sliderKnob.BackgroundColor3 = Color3.fromRGB(180,60,255)
sliderKnob.Text = ""
sliderKnob.BorderSizePixel = 0
sliderKnob.ZIndex = 23
Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1,0)

local buyAmount = 1
local dragging = false

local function updateSlider(val)
	val = math.clamp(val, 1, 200)
	buyAmount = math.floor(val)
	local pct = (buyAmount - 1) / 199
	sliderFill.Size = UDim2.new(pct, 0, 1, 0)
	sliderKnob.Position = UDim2.new(pct, -8, 0.5, -8)
	buyTitleLabel.Text = "🛍️ Jumlah Beli: "..buyAmount
end

sliderKnob.MouseButton1Down:Connect(function()
	dragging = true
end)
UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
RunService.Heartbeat:Connect(function()
	if dragging then
		local trackPos = sliderTrack.AbsolutePosition.X
		local trackWidth = sliderTrack.AbsoluteSize.X
		local mouseX = UserInputService:GetMouseLocation().X
		local pct = math.clamp((mouseX - trackPos) / trackWidth, 0, 1)
		updateSlider(1 + pct * 199)
	end
end)

local autoBuyBtn = btn(shopTab, "🛍️ AUTO BUY : OFF")
local buyStatusLabel = makeLabel(shopTab, "Auto Buy: idle")

getgenv().AUTO_BUY = false

local function doInteract(holdTime)
	VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
	task.wait(holdTime or 0.2)
	VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ✅ FIXED: findItemButton sekarang cari TextButton "PurchaseableItem" langsung
local function findItemButton(keyword)
	local shop = playerGui:FindFirstChild("Shop")
	if not shop then return nil end
	local scrolling = shop:FindFirstChild("Main") and shop.Main:FindFirstChild("ScrollingFrame")
	if not scrolling then return nil end
	for _, item in pairs(scrolling:GetChildren()) do
		if item.Name == "PurchaseableItem" and item:IsA("TextButton") then
			local itemLabel = item:FindFirstChild("Item")
			if itemLabel and itemLabel.Text:lower():find(keyword:lower()) then
				return item -- ✅ ini langsung TextButton-nya
			end
		end
	end
	return nil
end

local function autoBuyLoop()
	local amount = buyAmount
	local itemKeywords = {"water", "sugar", "gelatin"}
	local itemLabels   = {"💧 Water", "🍬 Sugar Block Bag", "🟡 Gelatin"}

	local function ensureShopOpen()
		local shop = playerGui:FindFirstChild("Shop")
		if shop and shop.Enabled then return true end

		local ok, pp = pcall(function()
			return workspace.Folders.NPCs["Lamont Bell"].UpperTorso.ProximityPrompt
		end)
		if not ok or not pp then return false end

		-- lock kamera biar tidak snap ke NPC
		local cam = workspace.CurrentCamera
		local savedCFrame = cam.CFrame
		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = savedCFrame

		-- hide ProximityPrompts & DialogueUI
		local ppGui = playerGui:FindFirstChild("ProximityPrompts")
		if ppGui then ppGui.Enabled = false end

		fireproximityprompt(pp)

		-- tunggu dialog muncul lalu klik FirstChoice
		for i = 1, 12 do
			task.wait(0.25)
			local dialog = playerGui:FindFirstChild("DialogueUI")
			if dialog and dialog.Enabled then
				dialog.Enabled = false
				local fc = dialog.MainFrame and dialog.MainFrame:FindFirstChild("FirstChoice")
				if fc then
					fc:MouseButton1Click()
				end
				break
			end
		end

		-- tunggu shop muncul
		for i = 1, 12 do
			task.wait(0.25)
			shop = playerGui:FindFirstChild("Shop")
			if shop and shop.Enabled then break end
		end

		-- restore kamera & GUI
		cam.CameraType = Enum.CameraType.Custom
		if ppGui then ppGui.Enabled = true end

		shop = playerGui:FindFirstChild("Shop")
		return shop ~= nil and shop.Enabled
	end

	for i, keyword in pairs(itemKeywords) do
		if not getgenv().AUTO_BUY then break end
		local bought = 0
		while bought < amount and getgenv().AUTO_BUY do
			buyStatusLabel.Text = itemLabels[i].." ("..bought.."/"..amount..")"

			if not ensureShopOpen() then
				buyStatusLabel.Text = "⚠️ Dekati Lamont Bell dulu!"
				task.wait(1)
				continue
			end

			-- sembunyikan shop & dialog dari layar
			local shopGui = playerGui:FindFirstChild("Shop")
			local dialogGui = playerGui:FindFirstChild("DialogueUI")
			if shopGui then shopGui.Enabled = false end
			if dialogGui then dialogGui.Enabled = false end

			local itemBtn = findItemButton(keyword)
			if itemBtn then
				-- enable sebentar untuk klik, lalu sembunyikan lagi
				if shopGui then shopGui.Enabled = true end
				itemBtn:MouseButton1Click()
				task.wait(0.1)
				if shopGui then shopGui.Enabled = false end
				task.wait(0.4)
				bought += 1
			else
				buyStatusLabel.Text = "❌ Item tidak ditemukan!"
				task.wait(1)
				break
			end
		end
	end

	-- enable & tutup shop setelah selesai
	local shop = playerGui:FindFirstChild("Shop")
	if shop then shop.Enabled = true end
	local dialogGui = playerGui:FindFirstChild("DialogueUI")
	if dialogGui then dialogGui.Enabled = true end
	local exitBtn = shop and shop:FindFirstChild("Main") and shop.Main:FindFirstChild("Exit")
	if exitBtn and exitBtn.Visible then
		exitBtn:MouseButton1Click()
	end

	getgenv().AUTO_BUY = false
	autoBuyBtn.Text = "🛍️ AUTO BUY : OFF"
	autoBuyBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
	buyStatusLabel.Text = "✅ Selesai beli "..buyAmount.."x semua bahan!"
end

autoBuyBtn.MouseButton1Click:Connect(function()
	getgenv().AUTO_BUY = not getgenv().AUTO_BUY
	if getgenv().AUTO_BUY then
		autoBuyBtn.Text = "🛍️ AUTO BUY : ON"
		autoBuyBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		buyStatusLabel.Text = "▶ Auto Buy: Running"
		task.spawn(autoBuyLoop)
	else
		autoBuyBtn.Text = "🛍️ AUTO BUY : OFF"
		autoBuyBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		buyStatusLabel.Text = "Auto Buy: idle"
	end
end)

-- ---- AUTO SELL ----
local autoSellBtn = btn(shopTab, "🛒 AUTO SELL : OFF")
local sellStatusLabel = makeLabel(shopTab, "Auto Sell: idle")

getgenv().AUTO_SELL = false

local function autoSellLoop()
	while getgenv().AUTO_SELL do
		local char = player.Character
		if not char then task.wait(1) continue end

		local hasItem = false
		local tools = player.Backpack:GetChildren()
		for _,tool in pairs(tools) do
			if not getgenv().AUTO_SELL then break end
			local n = tool.Name:lower()
			if n:find("small marshmallow") or n:find("medium marshmallow") or n:find("large marshmallow") then
				sellStatusLabel.Text = "🛒 Menjual: "..tool.Name

				-- equip
				tool.Parent = char

				-- disable inventory GUI biar tidak muncul kotak
				for _, sg in pairs(playerGui:GetChildren()) do
					if sg:IsA("ScreenGui") and sg.Name ~= "VINZOHUB" and sg.Name ~= "VINZOHUB_NOTIF" then
						sg.Enabled = false
					end
				end

				task.wait(0.4)
				doInteract(1.5)
				task.wait(0.8)

				-- enable kembali
				for _, sg in pairs(playerGui:GetChildren()) do
					if sg:IsA("ScreenGui") and sg.Name ~= "VINZOHUB" and sg.Name ~= "VINZOHUB_NOTIF" then
						sg.Enabled = true
					end
				end

				task.wait(0.3)
				hasItem = true
			end
		end

		if not hasItem then
			sellStatusLabel.Text = "⏳ Menunggu marshmallow..."
			task.wait(2)
		end
	end

	sellStatusLabel.Text = "Auto Sell: idle"
end

autoSellBtn.MouseButton1Click:Connect(function()
	getgenv().AUTO_SELL = not getgenv().AUTO_SELL
	if getgenv().AUTO_SELL then
		autoSellBtn.Text = "🛒 AUTO SELL : ON"
		autoSellBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		sellStatusLabel.Text = "▶ Auto Sell: Running"
		task.spawn(autoSellLoop)
	else
		autoSellBtn.Text = "🛒 AUTO SELL : OFF"
		autoSellBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		sellStatusLabel.Text = "Auto Sell: idle"
	end
end)

-- ===================================================
-- ================= FEATURES TAB ====================
-- ===================================================

local startBtn = btn(featureTab, "▶ START AutoFarm")
local stopBtn  = btn(featureTab, "⏹ STOP")
local cekBtn   = btn(featureTab, "🔍 Cek Inventory")
local marshBtn = btn(featureTab, "🍡 Cek Marshmallow")

local invText = Instance.new("TextLabel", featureTab)
invText.Size = UDim2.new(1,0,0,80)
invText.BackgroundColor3 = Color3.fromRGB(20,20,35)
invText.TextColor3 = Color3.new(1,1,1)
invText.Font = Enum.Font.GothamBold
invText.TextSize = 13
invText.Text = "💧 Water            : -\n🍬 Sugar Block Bag : -\n🟡 Gelatin         : -\n📦 Can Make        : -"
invText.TextXAlignment = Enum.TextXAlignment.Left
invText.TextWrapped = true
invText.ZIndex = 20
invText.BorderSizePixel = 0
Instance.new("UICorner", invText).CornerRadius = UDim.new(0,7)
local invPad = Instance.new("UIPadding", invText)
invPad.PaddingLeft = UDim.new(0,8)
invPad.PaddingTop  = UDim.new(0,6)

local marshText = Instance.new("TextLabel", featureTab)
marshText.Size = UDim2.new(1,0,0,75)
marshText.BackgroundColor3 = Color3.fromRGB(20,20,35)
marshText.TextColor3 = Color3.new(1,1,1)
marshText.Font = Enum.Font.GothamBold
marshText.TextSize = 13
marshText.Text = "🍡 Marshmallow:\nSmall  : -\nMedium : -\nLarge  : -"
marshText.TextXAlignment = Enum.TextXAlignment.Left
marshText.TextWrapped = true
marshText.ZIndex = 20
marshText.BorderSizePixel = 0
Instance.new("UICorner", marshText).CornerRadius = UDim.new(0,7)
local marshPad = Instance.new("UIPadding", marshText)
marshPad.PaddingLeft = UDim.new(0,8)
marshPad.PaddingTop  = UDim.new(0,6)

local statusLabel = makeLabel(featureTab, "Macro: idle")

-- ================= COUNT & INVENTORY =================
local backpack = player:WaitForChild("Backpack")

local function countItem(name)
	local count = 0
	for _,v in pairs(backpack:GetChildren()) do
		if v.Name:lower():find(name:lower()) then count += 1 end
	end
	if player.Character then
		for _,v in pairs(player.Character:GetChildren()) do
			if v.Name:lower():find(name:lower()) then count += 1 end
		end
	end
	return count
end

local function updateInventory()
	local water   = countItem("water")
	local sugar   = countItem("sugar")
	local gelatin = countItem("gelatin")
	local canMake = math.min(water, sugar, gelatin)
	invText.Text =
		"💧 Water            : "..water.."\n"..
		"🍬 Sugar Block Bag : "..sugar.."\n"..
		"🟡 Gelatin         : "..gelatin.."\n"..
		"📦 Can Make        : "..canMake.."x"
	return water, sugar, gelatin
end

cekBtn.MouseButton1Click:Connect(updateInventory)

marshBtn.MouseButton1Click:Connect(function()
	local small  = countItem("small marshmallow")
	local medium = countItem("medium marshmallow")
	local large  = countItem("large marshmallow")
	marshText.Text =
		"🍡 Marshmallow:\n"..
		"Small  : "..small.."\n"..
		"Medium : "..medium.."\n"..
		"Large  : "..large
end)

-- ================= AUTOFARM =================
local farming = false

local function equipItem(name)
	local char = player.Character
	if not char then return false end
	for _,tool in pairs(backpack:GetChildren()) do
		if tool.Name:lower():find(name:lower()) then
			tool.Parent = char
			task.wait(0.3)
			return true
		end
	end
	return false
end

local function farmWait(seconds)
	local elapsed = 0
	while elapsed < seconds do
		if not farming then return false end
		task.wait(0.5)
		elapsed += 0.5
	end
	return true
end

local function autoFarm()
	while farming do
		local water, sugar, gelatin = updateInventory()

		if water <= 0 or sugar <= 0 or gelatin <= 0 then
			statusLabel.Text = "❌ Bahan kurang!"
			if not farmWait(3) then break end
			continue
		end

		-- STEP 1: Water
		statusLabel.Text = "💧 Masukkan Water..."
		equipItem("water")
		task.wait(0.5)
		doInteract(0.2)
		if not farming then break end

		-- STEP 2: Tunggu 20 detik
		statusLabel.Text = "⏳ Tunggu 20 detik..."
		if not farmWait(20) then break end
		if not farming then break end

		-- STEP 3: Sugar Block Bag
		statusLabel.Text = "🍬 Masukkan Sugar Block Bag..."
		equipItem("sugar")
		task.wait(0.5)
		doInteract(0.2)
		if not farming then break end
		task.wait(1)

		-- STEP 4: Gelatin
		statusLabel.Text = "🟡 Masukkan Gelatin..."
		equipItem("gelatin")
		task.wait(0.5)
		doInteract(0.2)
		if not farming then break end

		-- STEP 5: Tunggu 45 detik
		statusLabel.Text = "⏳ Memasak 45 detik..."
		if not farmWait(45) then break end
		if not farming then break end

		-- STEP 6: Ambil marshmallow
		statusLabel.Text = "🍡 Ambil Marshmallow..."
		equipItem("empty")
		task.wait(0.5)
		doInteract(0.2)
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
-- ================= TELEPORT TAB ====================
-- ===================================================

local TARGET_DEALER = Vector3.new(511,3,601)
local TP_RS1        = Vector3.new(1140.8,10.1,451.8)
local TP_RS2        = Vector3.new(1141.2,10.1,423.2)
local TP_TIER1      = Vector3.new(985.9,10.1,247)
local TP_TIER2      = Vector3.new(989.3,11.0,228.3)
local TP_TRASH1     = Vector3.new(890.9,10.1,44.3)
local TP_TRASH2     = Vector3.new(920.4,10.1,46.3)
local TP_Ujung      = Vector3.new(-467.1,4.8,353.5)
local TP_MID        = Vector3.new(218.7,3.7,-176.2)
local TP_DEALERSHIP = Vector3.new(733.5,4.6,431.9)

local teleporting = false

local function lockPosition(part, targetPos)
	local conn
	conn = RunService.Heartbeat:Connect(function()
		if not part or not part.Parent then conn:Disconnect() return end
		part.CFrame = CFrame.new(targetPos)
		part.AssemblyLinearVelocity = Vector3.zero
		part.AssemblyAngularVelocity = Vector3.zero
	end)
	task.delay(1.5, function()
		if conn then conn:Disconnect() end
	end)
end

local function teleportVehiclePro(targetPos)
	if teleporting then return end
	teleporting = true
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp  = char:WaitForChild("HumanoidRootPart")
	local hum  = char:FindFirstChildOfClass("Humanoid")
	if not hum then teleporting = false return end
	local seat = hum.SeatPart
	if seat then
		local vehicle = seat:FindFirstAncestorOfClass("Model")
		if vehicle then
			if not vehicle.PrimaryPart then
				for _,v in pairs(vehicle:GetDescendants()) do
					if v:IsA("BasePart") then vehicle.PrimaryPart = v break end
				end
			end
			if vehicle.PrimaryPart then
				for _,v in pairs(vehicle:GetDescendants()) do
					if v:IsA("BasePart") then
						v.AssemblyLinearVelocity = Vector3.zero
						v.AssemblyAngularVelocity = Vector3.zero
					end
				end
				vehicle:SetPrimaryPartCFrame(CFrame.new(targetPos + Vector3.new(0,2,0)))
				lockPosition(vehicle.PrimaryPart, targetPos)
			end
		end
	else
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
		hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,2,0))
		lockPosition(hrp, targetPos)
	end
	teleporting = false
end

btn(tpTab,"🚀 Dealer").MouseButton1Click:Connect(function()      teleportVehiclePro(TARGET_DEALER)  end)
btn(tpTab,"🏥 RS 1").MouseButton1Click:Connect(function()         teleportVehiclePro(TP_RS1)         end)
btn(tpTab,"🏥 RS 2").MouseButton1Click:Connect(function()         teleportVehiclePro(TP_RS2)         end)
btn(tpTab,"🏠 Tier 1").MouseButton1Click:Connect(function()       teleportVehiclePro(TP_TIER1)       end)
btn(tpTab,"🏠 Tier 2").MouseButton1Click:Connect(function()       teleportVehiclePro(TP_TIER2)       end)
btn(tpTab,"🗑️ Trash 1").MouseButton1Click:Connect(function()      teleportVehiclePro(TP_TRASH1)      end)
btn(tpTab,"🗑️ Trash 2").MouseButton1Click:Connect(function()      teleportVehiclePro(TP_TRASH2)      end)
btn(tpTab,"🚗 Dealership").MouseButton1Click:Connect(function()   teleportVehiclePro(TP_DEALERSHIP)  end)
btn(tpTab,"🔫 GS Ujung").MouseButton1Click:Connect(function()     teleportVehiclePro(TP_Ujung)       end)
btn(tpTab,"🔫 GS Mid").MouseButton1Click:Connect(function()       teleportVehiclePro(TP_MID)         end)

-- ===================================================
-- ================= VISUAL TAB ======================
-- ESP
local espBtn = btn(visualTab,"👁️ ESP NAME : OFF")
getgenv().ESP_NAME = false

espBtn.ZIndex = 20
espBtn.Active = true

local ESP_FOLDER = Instance.new("Folder")
ESP_FOLDER.Name = "ESP_STORAGE"
ESP_FOLDER.Parent = game.CoreGui

local connections = {}

local function clearESP()
	ESP_FOLDER:ClearAllChildren()
	for _,conn in pairs(connections) do
		if conn then conn:Disconnect() end
	end
	connections = {}
end

local function createESP(plr)
	if plr == player then return end

	local function add(char)
		if not getgenv().ESP_NAME then return end

		local head = char:FindFirstChild("Head")
		if not head then return end

		if ESP_FOLDER:FindFirstChild(plr.Name) then
			ESP_FOLDER[plr.Name]:Destroy()
		end

		local bill = Instance.new("BillboardGui")
		bill.Name = plr.Name
		bill.Adornee = head
		bill.Size = UDim2.new(0,90,0,20)
		bill.StudsOffset = Vector3.new(0,2.5,0)
		bill.AlwaysOnTop = true
		bill.Parent = ESP_FOLDER

		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1,0,1,0)
		lbl.BackgroundTransparency = 1
		lbl.Text = plr.Name
		lbl.TextColor3 = Color3.fromRGB(255,255,255)
		lbl.TextStrokeTransparency = 0.3
		lbl.TextScaled = false
		lbl.TextSize = 12
		lbl.Font = Enum.Font.GothamBold
		lbl.Parent = bill
	end

	if plr.Character then
		add(plr.Character)
	end

	connections[plr] = plr.CharacterAdded:Connect(function(char)
		task.wait(0.5)
		add(char)
	end)
end

local function enableESP()
	clearESP()
	for _,plr in pairs(Players:GetPlayers()) do
		createESP(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	if getgenv().ESP_NAME then
		createESP(plr)
	end
end)

espBtn.MouseButton1Click:Connect(function()
	getgenv().ESP_NAME = not getgenv().ESP_NAME
	if getgenv().ESP_NAME then
		espBtn.Text = "👁️ ESP NAME : ON"
		espBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
		enableESP()
	else
		espBtn.Text = "👁️ ESP NAME : OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
		clearESP()
	end
end)

-- ANTI HIT TP
local antiHitBtn = btn(visualTab,"🛡️ ANTI HIT TP : OFF")
getgenv().ANTI_HIT = false
local antiHitConn = nil
local SAFE_POS = Vector3.new(579.0,3.5,-539.7)

local function startAntiHit()
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	antiHitConn = hum.HealthChanged:Connect(function(newHealth)
		if not getgenv().ANTI_HIT then return end
		if newHealth < hum.MaxHealth and newHealth > 0 then
			teleportVehiclePro(SAFE_POS)
		end
	end)
end

local function stopAntiHit()
	if antiHitConn then
		antiHitConn:Disconnect()
		antiHitConn = nil
	end
end

player.CharacterAdded:Connect(function()
	if getgenv().ANTI_HIT then
		task.wait(1)
		startAntiHit()
	end
end)

antiHitBtn.MouseButton1Click:Connect(function()
	getgenv().ANTI_HIT = not getgenv().ANTI_HIT
	if getgenv().ANTI_HIT then
		startAntiHit()
		antiHitBtn.Text = "🛡️ ANTI HIT TP : ON"
		antiHitBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
	else
		stopAntiHit()
		antiHitBtn.Text = "🛡️ ANTI HIT TP : OFF"
		antiHitBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
	end
end)

-- KILL AURA (SILENT INSTANT KILL)
local killAuraBtn = btn(visualTab, "💀 KILL AURA : OFF")
getgenv().KILL_AURA = false
local killAuraConn = nil
local KILL_RADIUS = 150

local function getNearest()
	local char = player.Character
	if not char then return nil end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local nearest, nearDist = nil, KILL_RADIUS
	for _, target in pairs(Players:GetPlayers()) do
		if target ~= player and target.Character then
			local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
			local tHum = target.Character:FindFirstChildOfClass("Humanoid")
			if tHRP and tHum and tHum.Health > 0 then
				local dist = (hrp.Position - tHRP.Position).Magnitude
				if dist < nearDist then
					nearest = target
					nearDist = dist
				end
			end
		end
	end
	return nearest
end

local GUN_BLACKLIST = {"fist", "phone", "medkit", "bandage", "food", "drink", "bag", "empty"}

local function isGun(tool)
	local name = tool.Name:lower()
	for _, v in pairs(GUN_BLACKLIST) do
		if name:find(v) then return false end
	end
	-- cek ada Handle/BasePart
	if tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart") then
		return true
	end
	return false
end

local function findGun()
	local char = player.Character
	-- cek equipped dulu
	if char then
		for _, t in pairs(char:GetChildren()) do
			if t:IsA("Tool") and isGun(t) then return t end
		end
	end
	-- cek backpack
	for _, t in pairs(player.Backpack:GetChildren()) do
		if t:IsA("Tool") and isGun(t) then return t end
	end
	return nil
end

local function startKillAura()
	local lastFire = 0
	killAuraConn = RunService.Heartbeat:Connect(function()
		if not getgenv().KILL_AURA then return end
		local now = tick()
		if now - lastFire < 0.1 then return end -- cooldown 0.1 detik
		lastFire = now

		local char = player.Character
		if not char then return end

		local target = getNearest()
		if not target or not target.Character then return end
		local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
		if not tHRP then return end

		local gun = findGun()
		if not gun then return end

		-- infinite ammo + rapid fire
		for _, v in pairs(gun:GetDescendants()) do
			if v:IsA("IntValue") or v:IsA("NumberValue") then
				local n = v.Name:lower()
				if n:find("ammo") or n:find("mag") or n:find("bullet") then
					v.Value = 999
				end
				if n:find("cooldown") or n:find("firerate") or n:find("delay") then
					v.Value = 0
				end
			end
		end

		-- equip sementara kalau di backpack
		local wasInBackpack = gun.Parent == player.Backpack
		if wasInBackpack then
			gun.Parent = char
		end

		-- aim ke target sebelum tembak
		local cam = workspace.CurrentCamera
		local savedCF = cam.CFrame
		cam.CFrame = CFrame.new(cam.CFrame.Position, tHRP.Position)

		firetool(gun)

		-- restore kamera
		cam.CFrame = savedCF

		-- kembalikan ke backpack
		if wasInBackpack then
			gun.Parent = player.Backpack
		end
	end)
end

local function stopKillAura()
	if killAuraConn then
		killAuraConn:Disconnect()
		killAuraConn = nil
	end
end

killAuraBtn.MouseButton1Click:Connect(function()
	getgenv().KILL_AURA = not getgenv().KILL_AURA
	if getgenv().KILL_AURA then
		startKillAura()
		killAuraBtn.Text = "💀 KILL AURA : ON"
		killAuraBtn.BackgroundColor3 = Color3.fromRGB(40,170,90)
	else
		stopKillAura()
		killAuraBtn.Text = "💀 KILL AURA : OFF"
		killAuraBtn.BackgroundColor3 = Color3.fromRGB(80,0,180)
	end
end)

-- ===================================================
-- ================= CREDIT TAB ======================
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
-- ================= OWNER TAB =======================
-- ===================================================

if isOwner and ownerTab then
	local ownerTitle = Instance.new("TextLabel", ownerTab)
	ownerTitle.Size = UDim2.new(1,0,0,35)
	ownerTitle.BackgroundColor3 = Color3.fromRGB(120,0,255)
	ownerTitle.TextColor3 = Color3.new(1,1,1)
	ownerTitle.Font = Enum.Font.GothamBlack
	ownerTitle.TextSize = 16
	ownerTitle.Text = "👑 OWNER PANEL - Manajemen Trial"
	ownerTitle.ZIndex = 20
	ownerTitle.BorderSizePixel = 0
	Instance.new("UICorner", ownerTitle).CornerRadius = UDim.new(0,7)

	-- input username
	local usernameLabel = makeLabel(ownerTab, "Username:", 25)
	usernameLabel.TextColor3 = Color3.new(1,1,1)
	usernameLabel.BackgroundTransparency = 1

	local usernameBox = Instance.new("TextBox", ownerTab)
	usernameBox.Size = UDim2.new(1,0,0,34)
	usernameBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
	usernameBox.TextColor3 = Color3.new(1,1,1)
	usernameBox.Font = Enum.Font.GothamBold
	usernameBox.TextSize = 14
	usernameBox.PlaceholderText = "Masukkan username..."
	usernameBox.PlaceholderColor3 = Color3.fromRGB(120,120,120)
	usernameBox.Text = ""
	usernameBox.ZIndex = 20
	usernameBox.BorderSizePixel = 0
	Instance.new("UICorner", usernameBox).CornerRadius = UDim.new(0,7)
	Instance.new("UIStroke", usernameBox).Color = Color3.fromRGB(140,0,255)

	-- input durasi
	local durasiLabel = makeLabel(ownerTab, "Durasi Trial (menit):", 25)
	durasiLabel.TextColor3 = Color3.new(1,1,1)
	durasiLabel.BackgroundTransparency = 1

	local durasiBox = Instance.new("TextBox", ownerTab)
	durasiBox.Size = UDim2.new(1,0,0,34)
	durasiBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
	durasiBox.TextColor3 = Color3.new(1,1,1)
	durasiBox.Font = Enum.Font.GothamBold
	durasiBox.TextSize = 14
	durasiBox.PlaceholderText = "Contoh: 60"
	durasiBox.PlaceholderColor3 = Color3.fromRGB(120,120,120)
	durasiBox.Text = ""
	durasiBox.ZIndex = 20
	durasiBox.BorderSizePixel = 0
	Instance.new("UICorner", durasiBox).CornerRadius = UDim.new(0,7)
	Instance.new("UIStroke", durasiBox).Color = Color3.fromRGB(140,0,255)

	local ownerStatus = makeLabel(ownerTab, "Status: idle", 28)

	-- tombol tambah trial
	local addTrialBtn = btn(ownerTab, "✅ Tambah Trial User")
	addTrialBtn.BackgroundColor3 = Color3.fromRGB(30,140,60)
	addTrialBtn.MouseButton1Click:Connect(function()
		local uname = usernameBox.Text
		local durasi = tonumber(durasiBox.Text)
		if uname == "" then
			ownerStatus.Text = "❌ Username kosong!"
			return
		end
		if not durasi or durasi <= 0 then
			ownerStatus.Text = "❌ Durasi tidak valid!"
			return
		end
		TRIAL_USERS[uname] = durasi
		ownerStatus.Text = "✅ "..uname.." ditambah ("..durasi.." menit)"
		usernameBox.Text = ""
		durasiBox.Text = ""
	end)

	-- tombol hapus trial
	local removeTrialBtn = btn(ownerTab, "❌ Hapus Trial User")
	removeTrialBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)
	removeTrialBtn.MouseButton1Click:Connect(function()
		local uname = usernameBox.Text
		if uname == "" then
			ownerStatus.Text = "❌ Username kosong!"
			return
		end
		if TRIAL_USERS[uname] then
			TRIAL_USERS[uname] = nil
			ownerStatus.Text = "🗑️ "..uname.." dihapus dari trial"
		else
			ownerStatus.Text = "⚠️ "..uname.." tidak ada di list"
		end
		usernameBox.Text = ""
	end)

	-- tombol lihat list
	local listLabel = makeLabel(ownerTab, "📋 Trial Users:", 25)
	listLabel.TextColor3 = Color3.new(1,1,1)
	listLabel.BackgroundTransparency = 1

	local listText = Instance.new("TextLabel", ownerTab)
	listText.Size = UDim2.new(1,0,0,100)
	listText.BackgroundColor3 = Color3.fromRGB(20,20,35)
	listText.TextColor3 = Color3.fromRGB(0,255,180)
	listText.Font = Enum.Font.GothamBold
	listText.TextSize = 12
	listText.Text = "(kosong)"
	listText.TextXAlignment = Enum.TextXAlignment.Left
	listText.TextWrapped = true
	listText.ZIndex = 20
	listText.BorderSizePixel = 0
	Instance.new("UICorner", listText).CornerRadius = UDim.new(0,7)
	local lPad = Instance.new("UIPadding", listText)
	lPad.PaddingLeft = UDim.new(0,8)
	lPad.PaddingTop = UDim.new(0,6)

	local refreshBtn = btn(ownerTab, "🔄 Refresh List")
	refreshBtn.MouseButton1Click:Connect(function()
		local txt = ""
		local count = 0
		for uname, menit in pairs(TRIAL_USERS) do
			txt = txt..uname.." → "..menit.." menit\n"
			count += 1
		end
		listText.Text = count > 0 and txt or "(kosong)"
	end)
end
-- ===================================================

local function cleanupAll()
	farming = false
	getgenv().ESP_NAME = false
	clearESP()
	getgenv().ANTI_HIT = false
	stopAntiHit()
	getgenv().AUTO_SELL = false
	getgenv().AUTO_BUY = false
	getgenv().KILL_AURA = false
	stopKillAura()
	if playerGui:FindFirstChild("VINZOHUB") then
		playerGui.VINZOHUB:Destroy()
	end
end

closeBtn.MouseButton1Click:Connect(cleanupAll) 