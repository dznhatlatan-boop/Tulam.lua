-- [[ Server Hub - Key System - Credit: tan ]] --
local _SvcX = game
local _Usrs = _SvcX:GetService("Players")
local _TpRt = _SvcX:GetService("TeleportService")
local _NetF = _SvcX:GetService("HttpService")
local _InpS = _SvcX:GetService("UserInputService")
local _MePlr = _Usrs.LocalPlayer
local _CoreG = _SvcX:GetService("CoreGui")

-- CẤU HÌNH KEY CỦA ĐẠI CA Ở ĐÂY
local _KeyLink = "https://dznhatlatan-boop.github.io/Wed-key-/"
local _SecretSalt = 7919

local function _GetBaseCycleIndex()
    -- Giờ Việt Nam (+7), mỗi chu kỳ 86400 giây (24h)
    local vnTime = os.time() + (7 * 3600)
    return math.floor(vnTime / 86400)
end

local function _TinhKey(userId, cycleIdx)
    local str = tostring(userId or "") .. "_" .. tostring(cycleIdx or 0)
    local hash = _SecretSalt
    for i = 1, #str do
        local b = string.byte(str, i)
        hash = (hash * 131 + b) % 89999999
    end
    return tostring(10000000 + hash)
end

local function _IsValidKey(inputKey)
    local cleanKey = tostring(inputKey or ""):gsub("%D", "")
    if cleanKey == "" then
        return false
    end

    local baseCycle = _GetBaseCycleIndex()
    -- Cho phép khớp với chu kỳ hiện tại hoặc các chu kỳ gia hạn (tối đa 30 lần gia hạn)
    for offset = 0, 30 do
        local candidateKey = _TinhKey(_MePlr.UserId, baseCycle + offset)
        if cleanKey == candidateKey then
            return true
        end
    end
    return false
end

if _CoreG:FindFirstChild("ServerPickerHub") then
    _CoreG.ServerPickerHub:Destroy()
end

local _RootGui = Instance.new("ScreenGui")
_RootGui.Name = "ServerPickerHub"
_RootGui.Parent = _CoreG
_RootGui.ResetOnSpawn = false

local function _ShowPop(_head, _desc, _dur)
    if _RootGui:FindFirstChild("ActiveNotify") then
        _RootGui.ActiveNotify:Destroy()
    end

    local _BoxF = Instance.new("Frame")
    _BoxF.Name = "ActiveNotify"
    _BoxF.Size = UDim2.new(0, 280, 0, 65)
    _BoxF.Position = UDim2.new(1, 300, 0.1, 0)
    _BoxF.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
    _BoxF.BorderSizePixel = 0
    _BoxF.Parent = _RootGui

    local _BCor = Instance.new("UICorner")
    _BCor.CornerRadius = UDim.new(0, 8)
    _BCor.Parent = _BoxF

    local _BStr = Instance.new("UIStroke")
    _BStr.Color = Color3.fromRGB(0, 160, 255)
    _BStr.Transparency = 0.3
    _BStr.Thickness = 1.5
    _BStr.Parent = _BoxF

    local _TxtH = Instance.new("TextLabel")
    _TxtH.Size = UDim2.new(1, -20, 0, 22)
    _TxtH.Position = UDim2.new(0, 15, 0, 6)
    _TxtH.BackgroundTransparency = 1
    _TxtH.Text = _head
    _TxtH.TextColor3 = Color3.fromRGB(0, 190, 255)
    _TxtH.TextSize = 12
    _TxtH.Font = Enum.Font.GothamBold
    _TxtH.TextXAlignment = Enum.TextXAlignment.Left
    _TxtH.Parent = _BoxF

    local _TxtD = Instance.new("TextLabel")
    _TxtD.Size = UDim2.new(1, -20, 0, 30)
    _TxtD.Position = UDim2.new(0, 15, 0, 28)
    _TxtD.BackgroundTransparency = 1
    _TxtD.Text = _desc
    _TxtD.TextColor3 = Color3.fromRGB(200, 220, 240)
    _TxtD.TextSize = 11
    _TxtD.Font = Enum.Font.Gotham
    _TxtD.TextXAlignment = Enum.TextXAlignment.Left
    _TxtD.TextWrapped = true
    _TxtD.Parent = _BoxF

    _BoxF:TweenPosition(UDim2.new(1, -295, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    task.spawn(function()
        task.wait(_dur or 4)
        if _BoxF and _BoxF.Parent then
            _BoxF:TweenPosition(UDim2.new(1, 300, 0.1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
            task.wait(0.3)
            _BoxF:Destroy()
        end
    end)
end

-- ==================== GIAO DIỆN CHÍNH (ẨN LÚC CHƯA NHẬP KEY) ====================
local _MainWin = Instance.new("Frame")
_MainWin.Size = UDim2.new(0, 300, 0, 360)
_MainWin.Position = UDim2.new(0.02, 0, 0.18, 0)
_MainWin.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
_MainWin.BorderSizePixel = 0
_MainWin.Active = true
_MainWin.Draggable = true
_MainWin.Visible = false
_MainWin.Parent = _RootGui

local _MWCor = Instance.new("UICorner")
_MWCor.CornerRadius = UDim.new(0, 12)
_MWCor.Parent = _MainWin

local _MWStr = Instance.new("UIStroke")
_MWStr.Color = Color3.fromRGB(0, 150, 255)
_MWStr.Transparency = 0.2
_MWStr.Thickness = 2
_MWStr.Parent = _MainWin

local _TitleLab = Instance.new("TextLabel")
_TitleLab.Size = UDim2.new(1, -45, 0, 38)
_TitleLab.Position = UDim2.new(0, 12, 0, 0)
_TitleLab.BackgroundTransparency = 1
_TitleLab.Text = "✨ SERVER HUB - by tân ✨"
_TitleLab.TextColor3 = Color3.fromRGB(0, 190, 255)
_TitleLab.TextSize = 12
_TitleLab.Font = Enum.Font.GothamBold
_TitleLab.TextXAlignment = Enum.TextXAlignment.Left
_TitleLab.Parent = _MainWin

local _MinBtn = Instance.new("TextButton")
_MinBtn.Size = UDim2.new(0, 28, 0, 28)
_MinBtn.Position = UDim2.new(1, -34, 0, 5)
_MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
_MinBtn.Text = "-"
_MinBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
_MinBtn.TextSize = 16
_MinBtn.Font = Enum.Font.GothamBold
_MinBtn.Parent = _MainWin

local _MBCor = Instance.new("UICorner")
_MBCor.CornerRadius = UDim.new(0, 6)
_MBCor.Parent = _MinBtn

local _BodyF = Instance.new("Frame")
_BodyF.Size = UDim2.new(1, 0, 1, -38)
_BodyF.Position = UDim2.new(0, 0, 0, 38)
_BodyF.BackgroundTransparency = 1
_BodyF.Parent = _MainWin

local _IsMin = false
_MinBtn.MouseButton1Click:Connect(function()
    _IsMin = not _IsMin
    if _IsMin then
        _BodyF.Visible = false
        _MainWin:TweenSize(UDim2.new(0, 300, 0, 38), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        _MinBtn.Text = "+"
    else
        _MainWin:TweenSize(UDim2.new(0, 300, 0, 360), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        task.wait(0.2)
        _BodyF.Visible = true
        _MinBtn.Text = "-"
    end
end)

local _UsrBox = Instance.new("TextLabel")
_UsrBox.Size = UDim2.new(0.92, 0, 0, 26)
_UsrBox.Position = UDim2.new(0.04, 0, 0.02, 0)
_UsrBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_UsrBox.BorderSizePixel = 0
_UsrBox.Text = "  👤 Acc: " .. _MePlr.DisplayName .. " (@" .. _MePlr.Name .. ")"
_UsrBox.TextColor3 = Color3
