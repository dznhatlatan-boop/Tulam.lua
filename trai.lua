-- Kiểm tra game đã load xong chưa
if not game:IsLoaded() then game.Loaded:Wait() end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChild("PlayerGui") or CoreGui
local Camera = workspace.CurrentCamera

-- Xóa menu cũ nếu chạy lại
if PlayerGui:FindFirstChild("ByTanCustomHub") then PlayerGui.ByTanCustomHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ByTanCustomHub"

-- [1. NÚT TRÒN NỔI BẬT ĐỂ BẬT/TẮT MENU]
local FloatButton = Instance.new("TextButton", ScreenGui)
FloatButton.Size = UDim2.new(0, 50, 0, 50)
FloatButton.Position = UDim2.new(0.85, 0, 0.75, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
FloatButton.BorderSizePixel = 0
FloatButton.Text = "⚡"
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatButton.TextSize = 22
FloatButton.Font = Enum.Font.GothamBold
FloatButton.Visible = false -- Ẩn đi chờ nhập key xong mới hiện
Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(1, 0)

-- [2. HỆ THỐNG KEY]
local KeyGui = Instance.new("Frame", ScreenGui)
KeyGui.Size = UDim2.new(0, 300, 0, 160)
KeyGui.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", KeyGui)

local TitleKey = Instance.new("TextLabel", KeyGui)
TitleKey.Size = UDim2.new(1, 0, 0, 40)
TitleKey.Text = "NHẬP KEY: tan"
TitleKey.TextColor3 = Color3.fromRGB(46, 204, 113)
TitleKey.Font = Enum.Font.GothamBold
TitleKey.TextSize = 16
TitleKey.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", KeyGui)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.PlaceholderText = "Nhập key..."
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
KeyBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KeyBox)

local SubmitBtn = Instance.new("TextButton", KeyGui)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn)

-- [3. MAIN MENU]
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 350)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

local MainTitle = Instance.new("TextLabel", MainFrame)
MainTitle.Size = UDim2.new(1, 0, 0, 35)
MainTitle.Text = "⚡ MENU BY TAN"
MainTitle.TextColor3 = Color3.fromRGB(46, 204, 113)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 15
MainTitle.BackgroundTransparency = 1

-- Ô nhập Speed
local SpeedInput = Instance.new("TextBox", MainFrame)
SpeedInput.Size = UDim2.new(0.9, 0, 0, 35)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 40)
SpeedInput.PlaceholderText = "Nhập số Speed (vd: 50)..."
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedInput)

-- Ô nhập tên TP
local TargetBox = Instance.new("TextBox", MainFrame)
TargetBox.Size = UDim2.new(0.9, 0, 0, 35)
TargetBox.Position = UDim2.new(0.05, 0, 0, 80)
TargetBox.PlaceholderText = "Tên người cần TP..."
TargetBox.Text = ""
TargetBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TargetBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetBox)

-- [LOGIC KHÓA MỤC TIÊU]
local Aiming = false

local function GetClosestTarget()
    local closestTarget = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                local targetPart = p.Character:FindFirstChild("Head") or p.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                
                if onScreen then
                    local screenPos = Vector2.new(vector.X, vector.Y)
                    local distance = (screenPos - screenCenter).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestTarget = targetPart
                    end
                end
            end
        end
    end
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    if Aiming then
        local targetPart = GetClosestTarget()
        if targetPart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        end
    end
end)

-- Hàm tạo nút bấm
local function CreateBtn(name, posY, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", btn)
    return btn
end

-- [SỰ KIỆN NÚT BẤM]
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "tan" then
        KeyGui.Visible = false
        MainFrame.Visible = true
        FloatButton.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Sai Key! Nhập (tan)..."
    end
end)

-- Bấm vào nút tròn nổi để Bật/Tắt (Ẩn/Hiện) Menu chính
FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CreateBtn("⚡ ÁP DỤNG SPEED", 125, function()
    local val = tonumber(SpeedInput.Text)
    if val and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = val
    end
end)

local AimToggleButton = CreateBtn("🎯 KHÓA MỤC TIÊU: TẮT", 165, function()
    Aiming = not Aiming
    if Aiming then
        AimToggleButton.Text = "🎯 KHÓA MỤC TIÊU: BẬT"
        AimToggleButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    else
        AimToggleButton.Text = "🎯 KHÓA MỤC TIÊU: TẮT"
        AimToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    end
end)

CreateBtn("📍 TP ĐẾN NGƯỜI CHỌN", 205, function()
    local targetName = TargetBox.Text
    for _, p in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #targetName) == string.lower(targetName) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                break
            end
        end
    end
end)

CreateBtn("✈️ MỞ FLY GUI V3", 245, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
end)

CreateBtn("💀 RESET NHÂN VẬT", 285, function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.Health = 0
    end
end)
