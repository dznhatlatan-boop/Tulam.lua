-- [[ Server Hub - Key System - Credit: tan ]] --
local okRun, errRun = pcall(function()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local UserInputService = game:GetService("UserInputService")

    local LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 15)

    -- ==================== CẤU HÌNH CHỦ HUB & KEY ====================
    local KEY_LINK = "https://dznhatlatan-boop.github.io/Wed-key-/"
    local SECRET_SALT = 7919
    local CYCLE_SECONDS = 86400 -- 24 giờ

    -- Khóa quyền tự mở vô hạn theo acc thật của đại ca
    local OWNER_NAMES = {
        ["hupbera23"] = true,
    }

    local OWNER_USER_IDS = {
        -- Có thể điền thêm số UserId thật của đại ca vào đây, VD: [123456789] = true,
    }

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

    -- Key luôn gắn chặt với UserId thật của người chơi hiện tại
    local function buildUserKey(userId, cycleIdx)
        local raw = tostring(userId or "") .. "_" .. tostring(cycleIdx or 0)
        local hash = SECRET_SALT
        for i = 1, #raw do
            hash = (hash * 131 + string.byte(raw, i)) % 89999999
        end
        return tostring(10000000 + hash)
    end

    local function isValidKey(inputText)
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

    -- ==================== CHỌN NƠI GẮN GUI AN TOÀN ====================
    local function resolveGuiParent()
        if type(gethui) == "function" then
            local okH, hui = pcall(gethui)
            if okH and typeof(hui) == "Instance" then
                return hui
            end
        end

        local okC, coreGui = pcall(function()
            return game:GetService("CoreGui")
        end)
        if okC and coreGui then
            local okTest = pcall(function()
                local probe = Instance.new("Frame")
                probe.Name = "_ProbeCheck"
                probe.Parent = coreGui
                probe:Destroy()
            end)
            if okTest then
                return coreGui
            end
        end

        return PlayerGui
    end

    local guiParent = resolveGuiParent()
    if not guiParent then
        warn("[SERVER HUB] Không tìm thấy nơi gắn GUI.")
        return
    end

    local oldGui = guiParent:FindFirstChild("ServerPickerHub")
    if oldGui then
        oldGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ServerPickerHub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 2147483647
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = guiParent

    -- ==================== THÔNG BÁO GÓC PHẢI ====================
    local function notify(title, message, duration)
        pcall(function()
            local oldPop = screenGui:FindFirstChild("ActiveNotify")
            if oldPop then
                oldPop:Destroy()
            end

            local pop = Instance.new("Frame")
            pop.Name = "ActiveNotify"
            pop.Size = UDim2.new(0, 270, 0, 64)
            pop.Position = UDim2.new(1, -285, 0.08, 0)
            pop.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
            pop.BorderSizePixel = 0
            pop.Parent = screenGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = pop

            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(56, 189, 248)
            stroke.Thickness = 1.5
            stroke.Parent = pop

            local lblTitle = Instance.new("TextLabel")
            lblTitle.Size = UDim2.new(1, -16, 0, 22)
            lblTitle.Position = UDim2.new(0, 10, 0, 6)
            lblTitle.BackgroundTransparency = 1
            lblTitle.Text = tostring(title)
            lblTitle.TextColor3 = Color3.fromRGB(56, 189, 248)
            lblTitle.TextSize = 12
            lblTitle.Font = Enum.Font.GothamBold
            lblTitle.TextXAlignment = Enum.TextXAlignment.Left
            lblTitle.Parent = pop

            local lblDesc = Instance.new("TextLabel")
            lblDesc.Size = UDim2.new(1, -16, 0, 30)
            lblDesc.Position = UDim2.new(0, 10, 0, 28)
            lblDesc.BackgroundTransparency = 1
            lblDesc.Text = tostring(message)
            lblDesc.TextColor3 = Color3.fromRGB(226, 232, 240)
            lblDesc.TextSize = 11
            lblDesc.Font = Enum.Font.Gotham
            lblDesc.TextXAlignment = Enum.TextXAlignment.Left
            lblDesc.TextWrapped = true
            lblDesc.Parent = pop

            task.delay(duration or 3.5, function()
                if pop and pop.Parent then
                    pop:Destroy()
                end
            end)
        end)
    end

    -- ==================== MENU CHÍNH ====================
    local mainWin = Instance.new("Frame")
    mainWin.Name = "MainHubWindow"
    mainWin.Size = UDim2.new(0, 300, 0, 360)
    mainWin.Position = UDim2.new(0.03, 0, 0.16, 0)
    mainWin.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
    mainWin.BorderSizePixel = 0
    mainWin.Active = true
    mainWin.Draggable = true
    mainWin.Visible = false
    mainWin.Parent = screenGui

    local mwCorner = Instance.new("UICorner")
    mwCorner.CornerRadius = UDim.new(0, 12)
    mwCorner.Parent = mainWin

    local mwStroke = Instance.new("UIStroke")
    mwStroke.Color = Color3.fromRGB(0, 150, 255)
    mwStroke.Thickness = 2
    mwStroke.Parent = mainWin

    local titleLab = Instance.new("TextLabel")
    titleLab.Size = UDim2.new(1, -45, 0, 38)
    titleLab.Position = UDim2.new(0, 12, 0, 0)
    titleLab.BackgroundTransparency = 1
    titleLab.Text = "✨ SERVER HUB - by tân ✨"
    titleLab.TextColor3 = Color3.fromRGB(0, 190, 255)
    titleLab.TextSize = 12
    titleLab.Font = Enum.Font.GothamBold
    titleLab.TextXAlignment = Enum.TextXAlignment.Left
    titleLab.Parent = mainWin

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 28, 0, 28)
    minBtn.Position = UDim2.new(1, -34, 0, 5)
    minBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
    minBtn.TextSize = 16
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = mainWin

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn

    local bodyF = Instance.new("Frame")
    bodyF.Size = UDim2.new(1, 0, 1, -38)
    bodyF.Position = UDim2.new(0, 0, 0, 38)
    bodyF.BackgroundTransparency = 1
    bodyF.Parent = mainWin

    local isMin = false
    minBtn.MouseButton1Click:Connect(function()
        isMin = not isMin
        if isMin then
            bodyF.Visible = false
            mainWin.Size = UDim2.new(0, 300, 0, 38)
            minBtn.Text = "+"
        else
            mainWin.Size = UDim2.new(0, 300, 0, 360)
            bodyF.Visible = true
            minBtn.Text = "-"
        end
    end)

    local usrBox = Instance.new("TextLabel")
    usrBox.Size = UDim2.new(0.92, 0, 0, 26)
    usrBox.Position = UDim2.new(0.04, 0, 0.02, 0)
    usrBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
    usrBox.BorderSizePixel = 0
    usrBox.Text = "  👤 Acc: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"
    usrBox.TextColor3 = Color3.fromRGB(255, 215, 0)
    usrBox.TextSize = 11
    usrBox.Font = Enum.Font.GothamSemibold
    usrBox.TextXAlignment = Enum.TextXAlignment.Left
    usrBox.Parent = bodyF

    local devType = (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) and "Máy tính (PC)" or "Điện thoại (Mobile)"
    local devBox = Instance.new("TextLabel")
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

    local execName = "Unknown"
    if type(identifyexecutor) == "function" then
        local okE, resE = pcall(identifyexecutor)
        if okE and resE then execName = tostring(resE) end
    elseif type(getexecutorname) == "function" then
        local okE, resE = pcall(getexecutorname)
        if okE and resE then execName = tostring(resE) end
    end

    local execBox = Instance.new("TextLabel")
    execBox.Size = UDim2.new(0.92, 0, 0, 26)
    execBox.Position = UDim2.new(0.04, 0, 0.20, 0)
    execBox.BackgroundColor3 = Color3.fromRGB(16, 22, 35)
    execBox.BorderSizePixel = 0
    execBox.Text = "  ⚙️ Executor: " .. execName
    execBox.TextColor3 = Color3.fromRGB(255, 120, 120)
    execBox.TextSize = 11
    execBox.Font = Enum.Font.GothamSemibold
    execBox.TextXAlignment = Enum.TextXAlignment.Left
    execBox.Parent = bodyF

    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.92, 0, 0, 38)
    scanBtn.Position = UDim2.new(0.04, 0, 0.31, 0)
    scanBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 240)
    scanBtn.Text = "Find a server for one person."
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.TextSize = 12
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.Parent = bodyF

    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn

        
