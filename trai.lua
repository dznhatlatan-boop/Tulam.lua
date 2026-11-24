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
local _KeyDivisor = 7

local function _IsValidKey(inputKey)
    local cleanKey = tostring(inputKey or ""):gsub("%s+", "")
    local num = tonumber(cleanKey)
    if not num or num < 10000000 or num > 99999999 then
        return false
    end
    return (num % _KeyDivisor) == 0
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
            local _PCount = _srvInfo.playing or 0
            local _MCount = _srvInfo.maxPlayers or 0

            if _PCount >= 1 and _PCount <= 5 and _srvInfo.id ~= _SvcX.JobId then
                _FoundCount = _FoundCount + 1

                local _Card = Instance.new("Frame")
                _Card.Size = UDim2.new(1, -6, 0, 35)
                _Card.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
                _Card.BorderSizePixel = 0
                _Card.Parent = _ScrollArea

                local _CCor = Instance.new("UICorner")
                _CCor.CornerRadius = UDim.new(0, 6)
                _CCor.Parent = _Card

                local _InfoLab = Instance.new("TextLabel")
                _InfoLab.Size = UDim2.new(0.68, -8, 1, 0)
                _InfoLab.Position = UDim2.new(0, 8, 0, 0)
                _InfoLab.BackgroundTransparency = 1
                _InfoLab.Text = "👥 " .. _PCount .. "/" .. _MCount .. " | " .. tostring(_srvInfo.id):sub(1, 8)
                _InfoLab.TextColor3 = Color3.fromRGB(220, 235, 255)
                _InfoLab.TextSize = 10
                _InfoLab.Font = Enum.Font.GothamSemibold
                _InfoLab.TextXAlignment = Enum.TextXAlignment.Left
                _InfoLab.Parent = _Card

                local _JoinBtn = Instance.new("TextButton")
                _JoinBtn.Size = UDim2.new(0.28, 0, 0.72, 0)
                _JoinBtn.Position = UDim2.new(0.70, 0, 0.14, 0)
                _JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 110)
                _JoinBtn.Text = "Join"
                _JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                _JoinBtn.TextSize = 10
                _JoinBtn.Font = Enum.Font.GothamBold
                _JoinBtn.Parent = _Card

                local _JCor = Instance.new("UICorner")
                _JCor.CornerRadius = UDim.new(0, 5)
                _JCor.Parent = _JoinBtn

                _JoinBtn.MouseButton1Click:Connect(function()
                    _ShowPop("Đang vào server", "Đang dịch chuyển...", 3)
                    pcall(function()
                        _TpRt:TeleportToPlaceInstance(_CurrPlace, _srvInfo.id, _MePlr)
                    end)
                end)
            end
        end

        _ScrollArea.CanvasSize = UDim2.new(0, 0, 0, _UIList.AbsoluteContentSize.Y + 10)
        if _FoundCount == 0 then
            _ShowPop("Không có server", "Thử quét lại sau vài giây.", 3)
        else
            _ShowPop("Hoàn tất", "Tìm thấy " .. _FoundCount .. " server.", 3)
        end
    else
        _ShowPop("Lỗi quét", "Không lấy được danh sách server.", 3)
    end

    _ScanBtn.Text = "Find a server for one person."
end

_ScanBtn.MouseButton1Click:Connect(_ExecuteScan)

-- ==================== KHUNG NHẬP KEY ====================
local _KeyWin = Instance.new("Frame")
_KeyWin.Size = UDim2.new(0, 280, 0, 185)
_KeyWin.Position = UDim2.new(0.5, -140, 0.5, -92)
_KeyWin.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
_KeyWin.BorderSizePixel = 0
_KeyWin.Active = true
_KeyWin.Draggable = true
_KeyWin.Parent = _RootGui

local _KWCor = Instance.new("UICorner")
_KWCor.CornerRadius = UDim.new(0, 12)
_KWCor.Parent = _KeyWin

local _KWStr = Instance.new("UIStroke")
_KWStr.Color = Color3.fromRGB(0, 160, 255)
_KWStr.Thickness = 2
_KWStr.Parent = _KeyWin

local _KTitle = Instance.new("TextLabel")
_KTitle.Size = UDim2.new(1, -20, 0, 32)
_KTitle.Position = UDim2.new(0, 10, 0, 6)
_KTitle.BackgroundTransparency = 1
_KTitle.Text = "🔐 NHẬP KEY ĐỂ MỞ HUB"
_KTitle.TextColor3 = Color3.fromRGB(0, 190, 255)
_KTitle.TextSize = 13
_KTitle.Font = Enum.Font.GothamBold
_KTitle.Parent = _KeyWin

local _KeyBox = Instance.new("TextBox")
_KeyBox.Size = UDim2.new(0.88, 0, 0, 36)
_KeyBox.Position = UDim2.new(0.06, 0, 0.24, 0)
_KeyBox.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
_KeyBox.BorderSizePixel = 0
_KeyBox.Text = ""
_KeyBox.PlaceholderText = "Dán dãy số key lấy từ web..."
_KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
_KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 150, 180)
_KeyBox.TextSize = 12
_KeyBox.Font = Enum.Font.GothamSemibold
_KeyBox.ClearTextOnFocus = false
_KeyBox.Parent = _KeyWin

local _KBCor = Instance.new("UICorner")
_KBCor.CornerRadius = UDim.new(0, 8)
_KBCor.Parent = _KeyBox

local _CheckBtn = Instance.new("TextButton")
_CheckBtn.Size = UDim2.new(0.42, 0, 0, 36)
_CheckBtn.Position = UDim2.new(0.06, 0, 0.52, 0)
_CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
_CheckBtn.Text = "Xác nhận"
_CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
_CheckBtn.TextSize = 12
_CheckBtn.Font = Enum.Font.GothamBold
_CheckBtn.Parent = _KeyWin

local _CBCor = Instance.new("UICorner")
_CBCor.CornerRadius = UDim.new(0, 8)
_CBCor.Parent = _CheckBtn

local _GetKeyBtn = Instance.new("TextButton")
_GetKeyBtn.Size = UDim2.new(0.42, 0, 0, 36)
_GetKeyBtn.Position = UDim2.new(0.52, 0, 0.52, 0)
_GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
_GetKeyBtn.Text = "Lấy Key"
_GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
_GetKeyBtn.TextSize = 12
_GetKeyBtn.Font = Enum.Font.GothamBold
_GetKeyBtn.Parent = _KeyWin

local _GBCor = Instance.new("UICorner")
_GBCor.CornerRadius = UDim.new(0, 8)
_GBCor.Parent = _GetKeyBtn

local _KHint = Instance.new("TextLabel")
_KHint.Size = UDim2.new(0.9, 0, 0, 24)
_KHint.Position = UDim2.new(0.05, 0, 0.78, 0)
_KHint.BackgroundTransparency = 1
_KHint.Text = "Bấm Lấy Key để copy link web"
_KHint.TextColor3 = Color3.fromRGB(160, 180, 210)
_KHint.TextSize = 10
_KHint.Font = Enum.Font.Gotham
_KHint.Parent = _KeyWin

_GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        pcall(setclipboard, _KeyLink)
        _ShowPop("Đã copy link web", _KeyLink, 3)
        _KHint.Text = "Đã copy link! Dán vào trình duyệt để lấy số."
    else
        _ShowPop("Link lấy key", _KeyLink, 5)
        _KHint.Text = _KeyLink
    end
end)

_CheckBtn.MouseButton1Click:Connect(function()
    if _IsValidKey(_KeyBox.Text) then
        _KeyWin:Destroy()
        _MainWin.Visible = true
        _ShowPop("Key hợp lệ", "Đã mở SERVER HUB!", 3)
    else
        _ShowPop("Key sai", "Số key chưa đúng, hãy lấy số mới trên web!", 3)
        _KHint.Text = "Key không hợp lệ! Thử bấm Lấy Key Mới trên web."
    end
end)
