-- Kiểm tra game đã load xong chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChild("PlayerGui") or CoreGui

-- Xóa menu cũ nếu chạy lại nhiều lần
if PlayerGui:FindFirstChild("ByTanCustomHub") then
    PlayerGui.ByTanCustomHub:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ByTanCustomHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ================= 1. KEY SYSTEM UI ("BY TAN") =================
local KeyGui = Instance.new("Frame")
KeyGui.Size = UDim2.new(0, 300, 0, 190)
KeyGui.Position = UDim2.new(0.5, -150, 0.5, -95)
KeyGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyGui.BorderSizePixel = 0
KeyGui.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyGui

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "BY TAN - NHẬP KEY"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyGui

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 40)
KeyBox.Position = UDim2.new(0.075, 0, 0, 50)
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Nhập key (speed)..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyGui

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.075, 0, 0, 110)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = SubmitBtn

-- ================= 2. MAIN MENU UI =================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Thanh Tiêu đề (Header) màu xanh lục
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.05, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ MENU"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Nút Thu Nhỏ (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 85)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Nút Tắt (X)
local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 30, 0, 30)
ExitBtn.Position = UDim2.new(1, -35, 0.5, -15)
ExitBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
ExitBtn.BorderSizePixel = 0
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.TextSize = 14
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.Parent = TopBar

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(0, 6)
ExitCorner.Parent = ExitBtn

-- ================= CÁC NÚT CHỨC NĂNG =================
local function CreateFeatureButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

local SpeedToggleBtn = CreateFeatureButton("⚡ SPEED: 16 (OFF)", 60)
local JumpToggleBtn = CreateFeatureButton("🦘 JUMP: 50 (OFF)", 115)
local FlyGuiBtn = CreateFeatureButton("✈️ MỞ FLY GUI V3", 170)
local ResetFuncBtn = CreateFeatureButton("💀 RESET NHÂN VẬT", 225)

-- ================= NÚT TRÒN NỔI BẬT ĐỂ MỞ LẠI MENU =================
local FloatButton = Instance.new("TextButton")
FloatButton.Size = UDim2.new(0, 50, 0, 50)
FloatButton.Position = UDim2.new(0.85, 0, 0.75, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
FloatButton.BorderSizePixel = 0
FloatButton.Text = "⚡"
FloatButton.TextSize = 22
FloatButton.Visible = false
FloatButton.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatButton

-- ================= LOGIC XỬ LÝ CHỨC NĂNG =================

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "speed" then
        KeyGui.Visible = false
        MainFrame.Visible = true
        FloatButton.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Sai Key! Nhập (speed)"
    end
end)

-- 1. Speed
local isSpeedOn = false
SpeedToggleBtn.MouseButton1Click:Connect(function()
    isSpeedOn = not isSpeedOn
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if isSpeedOn then
            char.Humanoid.WalkSpeed = 60
            SpeedToggleBtn.Text = "⚡ SPEED: 60 (ON)"
            SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        else
            char.Humanoid.WalkSpeed = 16
            SpeedToggleBtn.Text = "⚡ SPEED: 16 (OFF)"
            SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        end
    end
end)

-- 2. Jump
local isJumpOn = false
JumpToggleBtn.MouseButton1Click:Connect(function()
    isJumpOn = not isJumpOn
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.UseJumpPower = true
        if isJumpOn then
            char.Humanoid.JumpPower = 150
            JumpToggleBtn.Text = "🦘 JUMP: 150 (ON)"
            JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        else
            char.Humanoid.JumpPower = 50
            JumpToggleBtn.Text = "🦘 JUMP: 50 (OFF)"
            JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        end
    end
end)

-- 3. Gọi trực tiếp FlyGuiV3 chuẩn từ link GitHub khi bấm nút
FlyGuiBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
    if success then
        FlyGuiBtn.Text = "✈️ ĐÃ MỞ FLY V3"
        FlyGuiBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    else
        FlyGuiBtn.Text = "✈️ LỖI TẢI FLY"
    end
end)

-- 4. Reset
ResetFuncBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 0
    end
end)

-- Điều khiển hiển thị menu
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatButton.Visible = true
end)

ExitBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
