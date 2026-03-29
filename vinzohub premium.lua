-- =====================================================
-- VINZOHUB KEY SYSTEM - FIXED VERSION
-- Fix: lock 1 player, logs sync, support semua executor
-- =====================================================

local WEBHOOK_LOG = "https://discord.com/api/webhooks/1487782597009477663/Ml2kijtlJR_JTlhRIy9ReXEx5vZBdVfKbKK4p0pbJe6fI_vlS61_ZYBzSu8tMWc6kjHG"

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
-- SUPPORT SEMUA EXECUTOR (Delta, Synapse, dll)
-- =====================================================
if not getgenv then
	getgenv = function() return _G end
end
if not _G then _G = {} end

-- =====================================================
-- DESTROY EXISTING
-- =====================================================
for _, v in pairs(playerGui:GetChildren()) do
	if v.Name:find("VINZO") then v:Destroy() end
end

-- =====================================================
-- KEY DATABASE
-- Format: ["KEY"] = { expired = "DD/MM/YYYY" atau nil, lockedUser = nil }
-- Bot Discord otomatis tambah key di sini via GitHub
-- =====================================================
local KEY_DATABASE = {
	-- key akan otomatis ditambah oleh bot Discord
	["VNZ-D30A2F0CC8F34D72"] = { expired = "31/03/2026", lockedUser = nil },
}

-- =====================================================
-- VALIDATE KEY + LOCK + LOG KE DISCORD
-- =====================================================
local function validateKey(key)
	local record = KEY_DATABASE[key]

	-- Key tidak ada
	if not record then
		-- Log percobaan key salah
		pcall(function()
			HttpService:RequestAsync({
				Url    = WEBHOOK_LOG,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body   = HttpService:JSONEncode({
					embeds = {{
						title       = "❌ Key Salah",
						description = "**Key:** `" .. key .. "`\n**User:** " .. player.Name .. " (" .. tostring(player.UserId) .. ")\n**Status:** Key tidak ditemukan",
						color       = 16711680,
						footer      = { text = "VINZOHUB Key System" },
						timestamp   = os.date("!%Y-%m-%dT%H:%M:%SZ")
					}}
				})
			})
		end)
		return false, "❌ Key tidak ditemukan!"
	end

	-- Cek expired
	if record.expired then
		local day   = tonumber(record.expired:sub(1,2))
		local month = tonumber(record.expired:sub(4,5))
		local year  = tonumber(record.expired:sub(7,10))
		local expDate = os.time({year=year, month=month, day=day, hour=23, min=59, sec=59})
		if os.time() > expDate then
			pcall(function()
				HttpService:RequestAsync({
					Url    = WEBHOOK_LOG,
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body   = HttpService:JSONEncode({
						embeds = {{
							title       = "⏰ Key Expired",
							description = "**Key:** `" .. key .. "`\n**User:** " .. player.Name .. "\n**Expired:** " .. record.expired,
							color       = 16744272,
							footer      = { text = "VINZOHUB Key System" },
							timestamp   = os.date("!%Y-%m-%dT%H:%M:%SZ")
						}}
					})
				})
			end)
			return false, "❌ Key sudah expired! (" .. record.expired .. ")"
		end
	end

	-- Cek locked user (key sudah dipakai orang lain)
	if record.lockedUser and record.lockedUser ~= player.Name then
		pcall(function()
			HttpService:RequestAsync({
				Url    = WEBHOOK_LOG,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body   = HttpService:JSONEncode({
					embeds = {{
						title       = "🔒 Key Dicoba User Lain",
						description = "**Key:** `" .. key .. "`\n**Dicoba oleh:** " .. player.Name .. " (" .. tostring(player.UserId) .. ")\n**Key milik:** " .. record.lockedUser,
						color       = 16711680,
						footer      = { text = "VINZOHUB Key System" },
						timestamp   = os.date("!%Y-%m-%dT%H:%M:%SZ")
					}}
				})
			})
		end)
		return false, "❌ Key ini sudah dipakai oleh " .. record.lockedUser .. "!"
	end

	-- Lock key ke user ini (pertama kali pakai)
	local isFirstUse = not record.lockedUser
	KEY_DATABASE[key].lockedUser = player.Name

	local expStr = record.expired or "Permanent"

	-- Kirim log sukses ke Discord
	pcall(function()
		HttpService:RequestAsync({
			Url    = WEBHOOK_LOG,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body   = HttpService:JSONEncode({
				embeds = {{
					title       = isFirstUse and "🔑 Key Pertama Kali Digunakan!" or "✅ Key Valid - Login",
					description = "**Key:** `" .. key .. "`\n**User:** " .. player.Name .. " (" .. tostring(player.UserId) .. ")\n**Expired:** " .. expStr .. "\n**Status:** " .. (isFirstUse and "🆕 Baru di-lock ke user ini" or "🔄 Re-login"),
					color       = isFirstUse and 16753920 or 65280,
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

local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color     = Color3.fromRGB(140, 0, 255)
cardStroke.Thickness = 2.5

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
-- MAIN SCRIPT LOADER
-- =====================================================
function loadMainScript()

-- PASTE SCRIPT UTAMA KAMU DI SINI --

end
