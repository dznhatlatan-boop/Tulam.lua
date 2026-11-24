-- [[ Server Hub - Key + Force Render - Credit: tan ]] --
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local KEY_LINK = "https://dznhatlatan-boop.github.io/Wed-key-/"
local SECRET_SALT = 7919
local CYCLE_SECONDS = 86400 -- 24 giờ

local OWNER_NAMES = {
    ["hupbera23"] = true,
}

local OWNER_USER_IDS = {
    -- Điền thêm số UserId thật của đại ca nếu muốn, VD: [123456789] = true,
}

local function waitPlayer()
    local lp = Players.LocalPlayer
    for _ = 1, 100 do
        if lp then break end
        task.wait(0.1)
        lp = Players.LocalPlayer
    end
    return lp
end

local LocalPlayer = waitPlayer()

local function isOwnerAccount(player)
    if not player then
        return false
    end
    local uid = tonumber(player.UserId)
    if uid and OWNER_USER_IDS[uid] == true then
        return true
    end
    local uname = string.lower(tostring(player.Name or ""))
    local dname = string.lower(tostring(player.DisplayName or ""))
    if OWNER_NAMES[uname] or OWNER_NAMES[dname] then
        return true
    end
    return false
end

local function getCurrentCycle()
    return math.floor(os.time() / CYCLE_SECONDS)
end

local function buildUserKey(userId, cycleIdx)
    local raw = tostring(userId or "") .. "_" .. tostring(cycleIdx or 0)
    local hash = SECRET_SALT
    for i = 1, #raw do
        hash = (hash * 131 + string.byte(raw, i)) % 89999999
    end
    return tostring(10000000 + hash)
end

local function isValidKey(inputText)
    if not LocalPlayer then
        return false
    end
    local cleaned = tostring(inputText or ""):gsub("%D", "")
    if cleaned == "" then
        return false
    end
    local uid = LocalPlayer.UserId
    local nowCycle = getCurrentCycle()
    for offset = -1, 30 do
        if cleaned == buildUserKey(uid, nowCycle + offset) then
            return true
        end
    end
    return false
end

local function getTargets()
    local list = {}
    if LocalPlayer then
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
        if pg then
            table.insert(list, pg)
        end
    end
    pcall(function()
        local cg = game:GetService("CoreGui")
        if cg then
            table.insert(list, cg)
        end
    end)
    if StarterGui then
        table.insert(list, StarterGui)
    end
    return list
end

local targets = getTargets()
local isOwner = isOwnerAccount(LocalPlayer)

local templateGui = Instance.new("ScreenGui")
templateGui.Name = "ServerHubTemplate"
templateGui.ResetOnSpawn = false
templateGui.IgnoreGuiInset = true
templateGui.DisplayOrder = 999999

-- ==================== MENU CHÍNH ====================
local mainWin = Instance.new("Frame")
mainWin.Name = "MainHubWindow"
mainWin.Size = UDim2.new(0, 300, 0, 350)
mainWin.Position = UDim2.new(0.05, 0, 0.16, 0)
mainWin.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
mainWin.BorderSizePixel = 0
mainWin.Active = true
mainWin.Draggable = true
mainWin.Visible = isOwner
mainWin.Parent = templateGui

local mwCorner = Instance.new("UICorner")
mwCorner.CornerRadius = UDim.new(0, 12)
mwCorner.Parent = mainWin

local mwStroke = Instance.new("UIStroke")
mwStroke.Color = Color3.fromRGB(0, 150, 255)
mwStroke.Thickness = 2
mwStroke.Parent = mainWin

local titleLab = Instance.new("TextLabel")
titleLab.Name = "TitleLabel"
titleLab.Size = UDim2.new(1, -45, 0, 38)
titleLab.Position = UDim2.new(0, 12, 0, 0)
titleLab.BackgroundTransparency = 1
titleLab.Text = isOwner and "✨ SERVER HUB (OWNER) - by tân ✨" or "✨ SERVER HUB - by tân ✨"
titleLab.TextColor3 = Color3.fromRGB(0, 190, 255)
titleLab.TextSize = 12
titleLab.Font = Enum.Font.GothamBold
titleLab.TextXAlignment = Enum.TextXAlignment.Left
titleLab.Parent = mainWin

local minBtn = Instance.new("TextButton")
minBtn.Name = "MinButton"
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -34, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainWin

local bodyF = Instance.new("Frame")
bodyF.Name = "BodyFrame"
bodyF.Size = UDim2.new(1, 0, 1, -38)
bodyF.Position = UDim2.new(0, 0, 0, 38)
bodyF.BackgroundTransparency = 1
bodyF.Parent = mainWin

local accName = LocalPlayer and (LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")") or "Unknown"
local usrBox = Instance.new("TextLabel")
usrBox.Name = "UserBox"
usrBox.Size = UDim2.new(0.92, 0, 0, 26)
usrBox.Position = UDim2.new(0.04, 0, 0.02, 0)
usrBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
usrBox.BorderSizePixel = 0
usrBox.Text = "  👤 Acc: " .. accName .. (isOwner and " [VÔ HẠN]" or "")
usrBox.TextColor3 = Color3.fromRGB(255, 215, 0)
usrBox.TextSize = 11
usrBox.Font = Enum.Font.GothamSemibold
usrBox.TextXAlignment = Enum.TextXAlignment.Left
usrBox.Parent = bodyF

local devType = (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) and "Máy tính (PC)" or "Điện thoại (Mobile)"
local devBox = Instance.new("TextLabel")
devBox.Name = "DeviceBox"
devBox.Size = UDim2.new(0.92, 0, 0, 26)
devBox.Position = UDim2.new(0.04, 0, 0.11, 0)
devBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
devBox.BorderSizePixel = 0
devBox.Text = "  🎮 Thiết bị: " .. devType
devBox.TextColor3 = Color3.fromRGB(0, 255, 150)
devBox.TextSize = 11
devBox.Font = Enum.Font.GothamSemibold
devBox.TextXAlignment = Enum.TextXAlignment.Left
devBox.Parent = bodyF

local scanBtn = Instance.new("TextButton")
scanBtn.Name = "ScanButton"
scanBtn.Size = UDim2.new(0.92, 0, 0, 38)
scanBtn.Position = UDim2.new(0.04, 0, 0.24, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
scanBtn.Text = "Find a server for one person."
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.TextSize = 12
scanBtn.Font = Enum.Font.GothamBold
scanBtn.Parent = bodyF

local scrollArea = Instance.new("ScrollingFrame")
scrollArea.Name = "ServerList"
scrollArea.Size = UDim2.new(0.92, 0, 0, 185)
scrollArea.Position = UDim2.new(0.04, 0, 0.40, 0)
scrollArea.BackgroundColor3 = Color3.fromRGB(6, 9, 15)
scrollArea.BorderSizePixel = 0
scrollArea.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollArea.ScrollBarThickness = 4
scrollArea.Parent = bodyF

local uiList = Instance.new("UIListLayout")
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 6)
uiList.Parent = scrollArea

-- ==================== KHUNG NHẬP KEY ====================
local keyWin = Instance.new("Frame")
keyWin.Name = "KeyWindow"
keyWin.Size = UDim2.new(0, 286, 0, 195)
keyWin.Position = UDim2.new(0.5, -143, 0.5, -97)
keyWin.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
keyWin.BorderSizePixel = 0
keyWin.Active = true
keyWin.Draggable = true
keyWin.Visible = not isOwner
keyWin.Parent = templateGui

local kwCorner = Instance.new("UICorner")
kwCorner.CornerRadius = UDim.new(0, 12)
kwCorner.Parent = keyWin

local kwStroke = Instance.new("UIStroke")
kwStroke.Color = Color3.fromRGB(0, 160, 255)
kwStroke.Thickness = 2
kwStroke.Parent = keyWin

local kTitle = Instance.new("TextLabel")
kTitle.Name = "KeyTitle"
kTitle.Size = UDim2.new(1, -20, 0, 28)
kTitle.Position = UDim2.new(0, 10, 0, 8)
kTitle.BackgroundTransparency = 1
kTitle.Text = "🔐 NHẬP KEY ĐỂ MỞ HUB"
kTitle.TextColor3 = Color3.fromRGB(0, 190, 255)
kTitle.TextSize = 13
kTitle.Font = Enum.Font.GothamBold
kTitle.Parent = keyWin

local kUidHint = Instance.new("TextLabel")
kUidHint.Name = "UidHint"
kUidHint.Size = UDim2.new(1, -20, 0, 18)
kUidHint.Position = UDim2.new(0, 10, 0, 34)
kUidHint.BackgroundTransparency = 1
kUidHint.Text = "UserId: " .. tostring(LocalPlayer and LocalPlayer.UserId or "Unknown")
kUidHint.TextColor3 = Color3.fromRGB(250, 204, 21)
kUidHint.TextSize = 11
kUidHint.Font = Enum.Font.GothamSemibold
kUidHint.Parent = keyWin

local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyInput"
keyBox.Size = UDim2.new(0.88, 0, 0, 36)
keyBox.Position = UDim2.new(0.06, 0, 0.31, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
keyBox.BorderSizePixel = 0
keyBox.Text = ""
keyBox.PlaceholderText = "Dán key lấy từ web..."
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(130, 150, 180)
keyBox.TextSize = 12
keyBox.Font = Enum.Font.GothamSemibold
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyWin

local checkBtn = Instance.new("TextButton")
checkBtn.Name = "ConfirmKeyBtn"
checkBtn.Size = UDim2.new(0.42, 0, 0, 36)
checkBtn.Position = UDim2.new(0.06, 0, 0.56, 0)
checkBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
checkBtn.Text = "Xác nhận"
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.TextSize = 12
checkBtn.Font = Enum.Font.GothamBold
checkBtn.Parent = keyWin

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Name = "GetKeyBtn"
getKeyBtn.Size = UDim2.new(0.42, 0, 0, 36)
getKeyBtn.Position = UDim2.new(0.52, 0, 0.56, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
getKeyBtn.Text = "Lấy Key"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 12
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Parent = keyWin

local kStatus = Instance.new("TextLabel")
kStatus.Name = "KeyStatus"
kStatus.Size = UDim2.new(0.92, 0, 0, 26)
kStatus.Position = UDim2.new(0.04, 0, 0.79, 0)
kStatus.BackgroundTransparency = 1
kStatus.Text = "Bấm Lấy Key để copy link web"
kStatus.TextColor3 = Color3.fromRGB(160, 180, 210)
kStatus.TextSize = 10
kStatus.Font = Enum.Font.Gotham
kStatus.TextWrapped = true
kStatus.Parent = keyWin

local function bindGui(rootGui)
    local mw = rootGui:FindFirstChild("MainHubWindow")
    local kw = rootGui:FindFirstChild("KeyWindow")
    if not mw then return end

    local bf = mw:FindFirstChild("BodyFrame")
    local mb = mw:FindFirstChild("MinButton")
    if mb and bf then
        local minimized = false
        mb.MouseButton1Click:Connect(function()
            minimized = not minimized
            bf.Visible = not minimized
            mw.Size = minimized and UDim2.new(0, 300, 0, 38) or UDim2.new(0, 300, 0, 350)
            mb.Text = minimized and "+" or "-"
        end)
    end

    if bf then
        local sBtn = bf:FindFirstChild("ScanButton")
        local scArea = bf:FindFirstChild("ServerList")
        if sBtn and scArea then
            sBtn.MouseButton1Click:Connect(function()
                for _, c in ipairs(scArea:GetChildren()) do
                    if c:IsA("Frame") then c:Destroy() end
                end
                sBtn.Text = "Đang quét..."
                local okReq, raw = pcall(function()
                    return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
                end)
                if okReq and type(raw) == "string" then
                    local okDec, data = pcall(function()
                        return HttpService:JSONDecode(raw)
                    end)
                    if okDec and type(data) == "table" and type(data.data) == "table" then
                        for _, srv in ipairs(data.data) do
                            local playing = srv.playing or 0
                            local maxP = srv.maxPlayers or 0
                            if playing >= 1 and playing <= 5 and srv.id ~= game.JobId then
                                local card = Instance.new("Frame")
                                card.Size = UDim2.new(1, -6, 0, 35)
                                card.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
                                card.BorderSizePixel = 0
                                card.Parent = scArea

                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(0.68, -8, 1, 0)
                                lbl.Position = UDim2.new(0, 8, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = "👥 " .. playing .. "/" .. maxP .. " | " .. tostring(srv.id):sub(1, 8)
                                lbl.TextColor3 = Color3.fromRGB(220, 235, 255)
                                lbl.TextSize = 10
                                lbl.Font = Enum.Font.GothamSemibold
                                lbl.TextXAlignment = Enum.TextXAlignment.Left
                                lbl.Parent = card

                                local jBtn = Instance.new("TextButton")
                                jBtn.Size = UDim2.new(0.28, 0, 0.72, 0)
                                jBtn.Position = UDim2.new(0.70, 0, 0.14, 0)
                                jBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 110)
                                jBtn.Text = "Join"
                                jBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                                jBtn.TextSize = 10
                                jBtn.Font = Enum.Font.GothamBold
                                jBtn.Parent = card

                                jBtn.MouseButton1Click:Connect(function()
                                    pcall(function()
                                        TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, LocalPlayer)
                                    end)
                                end)
                            end
                        end
                        local listLay = scArea:FindFirstChildOfClass("UIListLayout")
                        if listLay then
                            scArea.CanvasSize = UDim2.new(0, 0, 0, listLay.AbsoluteContentSize.Y + 10)
                        end
                    end
                end
                sBtn.Text = "Find a server for one person."
            end)
        end
    end

    if kw then
        local kInp = kw:FindFirstChild("KeyInput")
        local cBtn = kw:FindFirstChild("ConfirmKeyBtn")
        local gBtn = kw:FindFirstChild("GetKeyBtn")
        local stLbl = kw:FindFirstChild("KeyStatus")

        if gBtn and stLbl then
            gBtn.MouseButton1Click:Connect(function()
                if type(setclipboard) == "function" then
                    pcall(setclipboard, KEY_LINK)
                    stLbl.Text = "Đã copy link! Dán vào trình duyệt."
                else
                    stLbl.Text = KEY_LINK
                end
            end)
        end

        if cBtn and kInp and stLbl then
            cBtn.MouseButton1Click:Connect(function()
                if isValidKey(kInp.Text) then
                    kw.Visible = false
                    mw.Visible = true
                else
                    stLbl.Text = "Key sai hoặc không khớp UserId!"
                end
            end)
        end
    end
end

for _, parentTarget in ipairs(targets) do
    pcall(function()
        local cloneGui = templateGui:Clone()
        cloneGui.Name = "ServerPickerHub_" .. tostring(parentTarget.Name)
        cloneGui.Enabled = true
        cloneGui.ResetOnSpawn = false
        cloneGui.IgnoreGuiInset = true
        cloneGui.DisplayOrder = 999999
        cloneGui.Parent = parentTarget
        bindGui(cloneGui)
    end)
end

templateGui:Destroy()
