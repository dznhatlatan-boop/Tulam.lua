-- [[ Server Hub - No Key / Free - Credit: tan ]] --
local _G_Svc = game
local _Plrs = _G_Svc:GetService("Players")
local _TpSvc = _G_Svc:GetService("TeleportService")
local _Http = _G_Svc:GetService("HttpService")
local _UIS = _G_Svc:GetService("UserInputService")
local _LPlayer = _Plrs.LocalPlayer
local _CGui = _G_Svc:GetService("CoreGui")

if _CGui:FindFirstChild("ServerPickerHub") then
    _CGui.ServerPickerHub:Destroy()
end

local _GuiMain = Instance.new("ScreenGui")
_GuiMain.Name = "ServerPickerHub"
_GuiMain.Parent = _CGui
_GuiMain.ResetOnSpawn = false

local function _Notify(_t, _m, _d)
    if _GuiMain:FindFirstChild("ActiveNotify") then
        _GuiMain.ActiveNotify:Destroy()
    end

    local _NF = Instance.new("Frame")
    _NF.Name = "ActiveNotify"
    _NF.Size = UDim2.new(0, 280, 0, 65)
    _NF.Position = UDim2.new(1, 300, 0.1, 0)
    _NF.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
    _NF.BorderSizePixel = 0
    _NF.Parent = _GuiMain

    local _NC = Instance.new("UICorner")
    _NC.CornerRadius = UDim.new(0, 8)
    _NC.Parent = _NF

    local _NS = Instance.new("UIStroke")
    _NS.Color = Color3.fromRGB(0, 160, 255)
    _NS.Transparency = 0.3
    _NS.Thickness = 1.5
    _NS.Parent = _NF

    local _NT = Instance.new("TextLabel")
    _NT.Size = UDim2.new(1, -20, 0, 22)
    _NT.Position = UDim2.new(0, 15, 0, 6)
    _NT.BackgroundTransparency = 1
    _NT.Text = _t
    _NT.TextColor3 = Color3.fromRGB(0, 190, 255)
    _NT.TextSize = 12
    _NT.Font = Enum.Font.GothamBold
    _NT.TextXAlignment = Enum.TextXAlignment.Left
    _NT.Parent = _NF

    local _NSub = Instance.new("TextLabel")
    _NSub.Size = UDim2.new(1, -20, 0, 30)
    _NSub.Position = UDim2.new(0, 15, 0, 28)
    _NSub.BackgroundTransparency = 1
    _NSub.Text = _m
    _NSub.TextColor3 = Color3.fromRGB(200, 220, 240)
    _NSub.TextSize = 11
    _NSub.Font = Enum.Font.Gotham
    _NSub.TextXAlignment = Enum.TextXAlignment.Left
    _NSub.TextWrapped = true
    _NSub.Parent = _NF

    _NF:TweenPosition(UDim2.new(1, -295, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    task.spawn(function()
        task.wait(_d or 4)
        if _NF and _NF.Parent then
            _NF:TweenPosition(UDim2.new(1, 300, 0.1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
            task.wait(0.3)
            _NF:Destroy()
        end
    end)
end

-- ==================== GIAO DIỆN CHÍNH ====================
local _MainF = Instance.new("Frame")
_MainF.Size = UDim2.new(0, 300, 0, 360)
_MainF.Position = UDim2.new(0.02, 0, 0.18, 0)
_MainF.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
_MainF.BorderSizePixel = 0
_MainF.Active = true
_MainF.Draggable = true
_MainF.Parent = _GuiMain

local _MFC = Instance.new("UICorner")
_MFC.CornerRadius = UDim.new(0, 12)
_MFC.Parent = _MainF

local _MFS = Instance.new("UIStroke")
_MFS.Color = Color3.fromRGB(0, 150, 255)
_MFS.Transparency = 0.2
_MFS.Thickness = 2
_MFS.Parent = _MainF

local _TitleL = Instance.new("TextLabel")
_TitleL.Size = UDim2.new(1, -45, 0, 38)
_TitleL.Position = UDim2.new(0, 12, 0, 0)
_TitleL.BackgroundTransparency = 1
_TitleL.Text = "✨ SERVER HUB - by tan ✨"
_TitleL.TextColor3 = Color3.fromRGB(0, 190, 255)
_TitleL.TextSize = 12
_TitleL.Font = Enum.Font.GothamBold
_TitleL.TextXAlignment = Enum.TextXAlignment.Left
_TitleL.Parent = _MainF

local _TglBtn = Instance.new("TextButton")
_TglBtn.Size = UDim2.new(0, 28, 0, 28)
_TglBtn.Position = UDim2.new(1, -34, 0, 5)
_TglBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
_TglBtn.Text = "-"
_TglBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
_TglBtn.TextSize = 16
_TglBtn.Font = Enum.Font.GothamBold
_TglBtn.Parent = _MainF

local _TglC = Instance.new("UICorner")
_TglC.CornerRadius = UDim.new(0, 6)
_TglC.Parent = _TglBtn

local _Container = Instance.new("Frame")
_Container.Size = UDim2.new(1, 0, 1, -38)
_Container.Position = UDim2.new(0, 0, 0, 38)
_Container.BackgroundTransparency = 1
_Container.Parent = _MainF

local _MinState = false
_TglBtn.MouseButton1Click:Connect(function()
    _MinState = not _MinState
    if _MinState then
        _Container.Visible = false
        _MainF:TweenSize(UDim2.new(0, 300, 0, 38), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        _TglBtn.Text = "+"
    else
        _MainF:TweenSize(UDim2.new(0, 300, 0, 360), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        task.wait(0.2)
        _Container.Visible = true
        _TglBtn.Text = "-"
    end
end)

local _UInfo = Instance.new("TextLabel")
_UInfo.Size = UDim2.new(0.92, 0, 0, 26)
_UInfo.Position = UDim2.new(0.04, 0, 0.02, 0)
_UInfo.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_UInfo.BorderSizePixel = 0
_UInfo.Text = "  👤 Acc: " .. _LPlayer.DisplayName .. " (@" .. _LPlayer.Name .. ")"
_UInfo.TextColor3 = Color3.fromRGB(255, 215, 0)
_UInfo.TextSize = 11
_UInfo.Font = Enum.Font.GothamSemibold
_UInfo.TextXAlignment = Enum.TextXAlignment.Left
_UInfo.Parent = _Container

local _UC = Instance.new("UICorner")
_UC.CornerRadius = UDim.new(0, 6)
_UC.Parent = _UInfo

local _DevStr = "Điện thoại (Mobile)"
if _UIS.KeyboardEnabled and _UIS.MouseEnabled then
    _DevStr = "Máy tính (PC)"
end

local _DInfo = Instance.new("TextLabel")
_DInfo.Size = UDim2.new(0.92, 0, 0, 26)
_DInfo.Position = UDim2.new(0.04, 0, 0.11, 0)
_DInfo.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_DInfo.BorderSizePixel = 0
_DInfo.Text = "  🎮 Thiết bị: " .. _DevStr
_DInfo.TextColor3 = Color3.fromRGB(0, 255, 150)
_DInfo.TextSize = 11
_DInfo.Font = Enum.Font.GothamSemibold
_DInfo.TextXAlignment = Enum.TextXAlignment.Left
_DInfo.Parent = _Container

local _DC = Instance.new("UICorner")
_DC.CornerRadius = UDim.new(0, 6)
_DC.Parent = _DInfo

local _CName = "Unknown"
if identifyexecutor then
    local _s, _r = pcall(identifyexecutor)
    if _s and _r then _CName = tostring(_r) end
elseif getexecutorname then
    local _s, _r = pcall(getexecutorname)
    if _s and _r then _CName = tostring(_r) end
elseif syn then
    _CName = "Synapse X"
elseif Delta then
    _CName = "Delta"
end

local _CInfo = Instance.new("TextLabel")
_CInfo.Size = UDim2.new(0.92, 0, 0, 26)
_CInfo.Position = UDim2.new(0.04, 0, 0.20, 0)
_CInfo.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_CInfo.BorderSizePixel = 0
_CInfo.Text = "  ⚙️ Client: " .. _CName
_CInfo.TextColor3 = Color3.fromRGB(255, 120, 120)
_CInfo.TextSize = 11
_CInfo.Font = Enum.Font.GothamSemibold
_CInfo.TextXAlignment = Enum.TextXAlignment.Left
_CInfo.Parent = _Container

local _CC = Instance.new("UICorner")
_CC.CornerRadius = UDim.new(0, 6)
_CC.Parent = _CInfo

local _ScanBtn = Instance.new("TextButton")
_ScanBtn.Size = UDim2.new(0.92, 0, 0, 38)
_ScanBtn.Position = UDim2.new(0.04, 0, 0.31, 0)
_ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
_ScanBtn.Text = "QUÉT DANH SÁCH SERVER"
_ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
_ScanBtn.TextSize = 12
_ScanBtn.Font = Enum.Font.GothamBold
_ScanBtn.Parent = _Container

local _SBtnC = Instance.new("UICorner")
_SBtnC.CornerRadius = UDim.new(0, 8)
_SBtnC.Parent = _ScanBtn

local _ScrollF = Instance.new("ScrollingFrame")
_ScrollF.Size = UDim2.new(0.92, 0, 0, 175)
_ScrollF.Position = UDim2.new(0.04, 0, 0.45Dạ, nghe bạn than là thấy mệt ngang luôn rồi đó! Không biết là bạn đang bị rắc rối với việc khóa màn hình điện thoại, khóa tài khoản, hay là lỡ quên mật khẩu gì mà bực mình dữ vậy? 

Bạn cần mình hỗ trợ gỡ rối hoặc tìm cách mở khóa cái gì thì cứ nói cụ thể nha, để mình hướng dẫn cho lẹ chứ khỏi phải mò mẫm mệt lắm!
    
