-- [[ Server Hub - Key System - Credit: tan ]] --
local _SvcX = game
local _Usrs = _SvcX:GetService("Players")
local _TpRt = _SvcX:GetService("TeleportService")
local _NetF = _SvcX:GetService("HttpService")
local _InpS = _SvcX:GetService("UserInputService")
local _MePlr = _Usrs.LocalPlayer
local _CoreG = _SvcX:GetService("CoreGui")

-- CẤU HÌNH KEY CỦA ĐẠI CA Ở ĐÂY
local _ValidKey = "123" 
local _KeyLink = "https://dznhatlatan-boop.github.io/Wed-key-/"
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
_MainWin.Visible = false -- Ẩn cho đến khi nhập đúng key
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
_UsrBox.TextColor3 = Color3.fromRGB(255, 215, 0)
_UsrBox.TextSize = 11
_UsrBox.Font = Enum.Font.GothamSemibold
_UsrBox.TextXAlignment = Enum.TextXAlignment.Left
_UsrBox.Parent = _BodyF

local _UBCor = Instance.new("UICorner")
_UBCor.CornerRadius = UDim.new(0, 6)
_UBCor.Parent = _UsrBox

local _DevName = "Điện thoại (Mobile)"
if _InpS.KeyboardEnabled and _InpS.MouseEnabled then
    _DevName = "Máy tính (PC)"
end

local _DevBox = Instance.new("TextLabel")
_DevBox.Size = UDim2.new(0.92, 0, 0, 26)
_DevBox.Position = UDim2.new(0.04, 0, 0.11, 0)
_DevBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_DevBox.BorderSizePixel = 0
_DevBox.Text = "  🎮 Thiết bị: " .. _DevName
_DevBox.TextColor3 = Color3.fromRGB(0, 255, 150)
_DevBox.TextSize = 11
_DevBox.Font = Enum.Font.GothamSemibold
_DevBox.TextXAlignment = Enum.TextXAlignment.Left
_DevBox.Parent = _BodyF

local _DBCor = Instance.new("UICorner")
_DBCor.CornerRadius = UDim.new(0, 6)
_DBCor.Parent = _DevBox

local _ExecName = "Unknown"
if identifyexecutor then
    local _s, _r = pcall(identifyexecutor)
    if _s and _r then _ExecName = tostring(_r) end
elseif getexecutorname then
    local _s, _r = pcall(getexecutorname)
    if _s and _r then _ExecName = tostring(_r) end
elseif syn then
    _ExecName = "Synapse X"
elseif Delta then
    _ExecName = "Delta"
end

local _ExecBox = Instance.new("TextLabel")
_ExecBox.Size = UDim2.new(0.92, 0, 0, 26)
_ExecBox.Position = UDim2.new(0.04, 0, 0.20, 0)
_ExecBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
_ExecBox.BorderSizePixel = 0
_ExecBox.Text = "  ⚙️ hack: " .. _ExecName
_ExecBox.TextColor3 = Color3.fromRGB(255, 120, 120)
_ExecBox.TextSize = 11
_ExecBox.Font = Enum.Font.GothamSemibold
_ExecBox.TextXAlignment = Enum.TextXAlignment.Left
_ExecBox.Parent = _BodyF

local _EBCor = Instance.new("UICorner")
_EBCor.CornerRadius = UDim.new(0, 6)
_EBCor.Parent = _ExecBox

local _ScanBtn = Instance.new("TextButton")
_ScanBtn.Size = UDim2.new(0.92, 0, 0, 38)
_ScanBtn.Position = UDim2.new(0.04, 0, 0.31, 0)
_ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
_ScanBtn.Text = "Find a server for one person."
_ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
_ScanBtn.TextSize = 12
_ScanBtn.Font = Enum.Font.GothamBold
_ScanBtn.Parent = _BodyF

local _SBCor = Instance.new("UICorner")
_SBCor.CornerRadius = UDim.new(0, 8)
_SBCor.Parent = _ScanBtn

local _ScrollArea = Instance.new("ScrollingFrame")
_ScrollArea.Size = UDim2.new(0.92, 0, 0, 175)
_ScrollArea.Position = UDim2.new(0.04, 0, 0.45, 0)
_ScrollArea.BackgroundColor3 = Color3.fromRGB(6, 9, 15)
_ScrollArea.BorderSizePixel = 0
_ScrollArea.CanvasSize = UDim2.new(0, 0, 0, 0)
_ScrollArea.ScrollBarThickness = 4
_ScrollArea.Parent = _BodyF

local _SACor = Instance.new("UICorner")
_SACor.CornerRadius = UDim.new(0, 8)
_SACor.Parent = _ScrollArea

local _UIList = Instance.new("UIListLayout")
_UIList.SortOrder = Enum.SortOrder.LayoutOrder
_UIList.Padding = UDim.new(0, 6)
_UIList.Parent = _ScrollArea

local function _WipeList()
    for _, _v in ipairs(_ScrollArea:GetChildren()) do
        if _v:IsA("Frame") then
            _v:Destroy()
        end
    end
end

local function _ExecuteScan()
    _WipeList()
    _ShowPop("searching ", "time2...", 2)
    _ScanBtn.Text = "Đang quét..."
    
    local _CurrPlace = _SvcX.PlaceId
    local _RawList = {}
    local _OkFlag = pcall(function()
        local _Endpoint = "https://games.roblox.com/v1/games/" .. _CurrPlace .. "/servers/Public?sortOrder=Asc&limit=100"
        local _RawData = _SvcX:HttpGet(_Endpoint)
        local _Decoded = _NetF:JSONDecode(_RawData)
        _RawList = _Decoded.data
    end)

    if _OkFlag and _RawList then
        local _FoundCount = 0
        for _, _srvInfo in ipairs(_RawList) do
            local _PCount = _srvInfo.playing
            local _MCount = _srvInfo.maxPlayers
            
            if _PCount >= 1 and _PCount <= 5 and _srvInfo.id ~= _SvcX.JobId then
                _FoundCount = _FoundCount + 1
                
                local _Card = Instance.new("Frame")
                _Card.Size = UDim2.new(1, -6, 0, 35)
                _Card.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
                _Card.BorderSizePixel = 0
                _Card.Parent = _ScrollArea

                local _CCor = Instance.new("U
                    
