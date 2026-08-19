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

-- [HỆ THỐNG KEY]
local KeyGui = Instance.new("Frame", ScreenGui)
KeyGui.Size = UDim2.new(0, 300, 0, 160)
KeyGui.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", KeyGui)

local TitleKey = Instance.new("TextLabel", KeyGui)
TitleKey.Size = UDim2.new(1, 0, 0, 40)
TitleKey.Text = "NHẬP KEY: tan Make"
TitleKey.TextColor3 = Color3.fromRGB(46, 204, 113)
TitleKey.Font = Enum.Font.GothamBold
TitleKey.TextSize = 16

local KeyBox = Instance.new("TextBox", KeyGui)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.PlaceholderText = "Nhập key..."
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
KeyBox.TextColor3 = Color3.new(1, 1, 1)

local SubmitBtn = Instance.new("TextButton", KeyGui)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
Instance.new("UICorner", SubmitBtn)

-- [MAIN MENU]
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Ô nhập Speed
local SpeedInput = Instance.new("TextBox", MainFrame)
SpeedInput.Size = UDim2.new(0.9, 0, 0, 35)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 15)
SpeedInput.PlaceholderText = "Số Speed (vd: 50)..."
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)

-- Ô nhập tên TP
local TargetBox = Instance.new("TextBox", MainFrame)
TargetBox.Size = UDim2.new(0.9, 0, 0, 35)
TargetBox.Position = UDim2.new(0.05, 0, 0, 55)
TargetBox.PlaceholderText = "Tên người cần TP..."
TargetBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TargetBox.TextColor3 = Color3.new(1, 1, 1)

-- [LOGIC KHÓA MỤC TIÊU (AIM BOT)]
local Aiming = false
local AimBtnText = "🎯 KHÓA MỤC TIÊU: TẮT"

local function GetClosestTarget()
    local closestTarget = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                -- Ưu tiên khóa vào Đầu (Head), nếu không có thì khóa vào Thân (HumanoidRootPart)
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
            -- Khóa tâm camera thẳng vào đối thủ cực mượt
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        end
    end
end)

-- Tạo các nút bấm chức năng
local function CreateBtn(name, posY, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", btn)
    return btn
end

-- [XỬ LÝ SỰ KIỆN]
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "tan Make" then
        KeyGui.Visible = false
        MainFrame.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Sai Key! Nhập lại..."
    end
end)

CreateBtn("⚡ ÁP DỤNG SPEED", 100, function()
    local val = tonumber(SpeedInput.Text)
    if val and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = val
    end
end)

local AimToggleButton = CreateBtn("🎯 KHÓA MỤC TIÊU: TẮT", 143, function()
    Aiming = not Aiming
    if Aiming then
        AimToggleButton.Text = "🎯 KHÓA MỤC TIÊU: BẬT"
        AimToggleButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60) -- Đổi sang màu đỏ khi bật
    else
        AimToggleButton.Text = "🎯 KHÓA MỤC TIÊU: TẮT"
        AimToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- Đổi về xanh khi tắt
    end
end)

CreateBtn("📍 TP ĐẾN NGƯỜI CHỌN", 186, function()
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

CreateBtn("✈️ MỞ FLY GUI V3", 229, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
end)

CreateBtn("💀 RESET NHÂN VẬT", 272, function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.Health = 0
    end
end)
