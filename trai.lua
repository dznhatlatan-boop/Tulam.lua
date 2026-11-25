local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local KEY_LINK = "https://dznhatlatan-boop.github.io/Wed-key-/"
local FLY_SCRIPT_URL = "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
local _SecretSalt = 7919
local CYCLE_SECONDS = 18000

local OWNER_NAMES = {
    ["hupbera23"] = true,
    ["qwp1545"] = true,
}

local OWNER_USER_IDS = {}
local lp = Players.LocalPlayer or Players.PlayerAdded:Wait()

local function isOwnerAccount(player)
    if not player then return false end
    local uid = tonumber(player.UserId)
    if uid and OWNER_USER_IDS[uid] == true then return true end
    local uname = string.lower(tostring(player.Name or ""))
    local dname = string.lower(tostring(player.DisplayName or ""))
    return OWNER_NAMES[uname] or OWNER_NAMES[dname] or false
end

local function getCurrentCycle()
    return math.floor(os.time() / CYCLE_SECONDS)
end

local function buildUserKey(userId, cycleIdx)
    local raw = tostring(userId or "") .. "_" .. tostring(cycleIdx or 0)
    local hash = _SecretSalt
    for i = 1, #raw do
        hash = (hash * 131 + string.byte(raw, i)) % 89999999
    end
    return tostring(10000000 + hash)
end

local function isValidKey(inputText)
    if not lp then return false end
    local cleaned = tostring(inputText or ""):gsub("%D", "")
    if cleaned == "" then return false end
    local nowCycle = getCurrentCycle()
    for offset = -1, 30 do
        if cleaned == buildUserKey(lp.UserId, nowCycle + offset) then
            return true
        end
    end
    return false
end

local function clearAllOldGuis()
    local targets = {}
    local pg = lp:FindFirstChildOfClass("PlayerGui")
    if pg then table.insert(targets, pg) end
    pcall(function()
        local cg = game:GetService("CoreGui")
        if cg then table.insert(targets, cg) end
    end)

    for _, container in ipairs(targets) do
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("ScreenGui") then
                local n = child.Name
                if n == "AKHubColorGui" or n == "AKHubSingleGui" or n == "AKHubCleanGui" or n == "ServerHubTemplate"
                    or string.find(n, "TraiHubGui_", 1, true)
                    or string.find(n, "ServerPickerHub_", 1, true)
                    or string.find(n, "AKHub", 1, true)
                then
                    child:Destroy()
                end
            end
        end
    end
end

local function getGuiParent()
    local pg = lp:FindFirstChildOfClass("PlayerGui") or lp:WaitForChild("PlayerGui", 10)
    if pg then return pg end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    return ok and cg or nil
end

_G.AKHubSessionId = (_G.AKHubSessionId or 0) + 1
local mySession = _G.AKHubSessionId
clearAllOldGuis()
task.wait(0.05)
if _G.AKHubSessionId ~= mySession then return end

local parentGui = getGuiParent()
if not parentGui then return end

local isOwner = isOwnerAccount(lp)
local THEME = isOwner and {
    windowBg = Color3.fromRGB(34, 22, 6),
    stroke = Color3.fromRGB(255, 205, 0),
    titleText = Color3.fromRGB(255, 225, 50),
    btnBg = Color3.fromRGB(255, 165, 0),
    btnText = Color3.fromRGB(25, 14, 2),
    cardBg = Color3.fromRGB(54, 36, 10),
    minBtnBg = Color3.fromRGB(70, 46, 12),
    badgeText = Color3.fromRGB(255, 235, 110),
} or {
    windowBg = Color3.fromRGB(10, 18, 34),
    stroke = Color3.fromRGB(0, 200, 255),
    titleText = Color3.fromRGB(56, 225, 255),
    btnBg = Color3.fromRGB(0, 150, 255),
    btnText = Color3.fromRGB(255, 255, 255),
    cardBg = Color3.fromRGB(18, 32, 56),
    minBtnBg = Color3.fromRGB(24, 42, 72),
    badgeText = Color3.fromRGB(125, 225, 255),
}

local gui = Instance.new("ScreenGui")
gui.Name = "AKHubColorGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = parentGui

local flyLoadedOnce = false
local function runFlyGuiV3()
    if flyLoadedOnce then
        pcall(function()
            for _, container in ipairs({lp:FindFirstChildOfClass("PlayerGui"), game:GetService("CoreGui")}) do
                if container then
                    for _, g in ipairs(container:GetChildren()) do
                        if g:IsA("ScreenGui") and string.find(string.lower(g.Name), "fly") then
                            for _, obj in ipairs(g:GetChildren()) do
                                if obj:IsA("Frame") then
                                    obj.Visible = not obj.Visible
                                end
                            end
                        end
                    end
                end
            end
        end)
        return
    end
    flyLoadedOnce = true
    pcall(function()
        loadstring(game:HttpGet(FLY_SCRIPT_URL))()
    end)
end

local mainWin = Instance.new("Frame")
mainWin.Size = UDim2.new(0, 305, 0, 355)
mainWin.Position = UDim2.new(0.05, 0, 0.16, 0)
mainWin.BackgroundColor3 = THEME.windowBg
mainWin.BorderSizePixel = 0
mainWin.Active = true
mainWin.Draggable = true
mainWin.Visible = isOwner
mainWin.Parent = gui
Instance.new("UICorner", mainWin).CornerRadius = UDim.new(0, 14)

local mwStroke = Instance.new("UIStroke")
mwStroke.Color = THEME.stroke
mwStroke.Thickness = 2.5
mwStroke.Parent = mainWin

local titleLab = Instance.new("TextLabel")
titleLab.Size = UDim2.new(1, -76, 0, 40)
titleLab.Position = UDim2.new(0, 12, 0, 0)
titleLab.BackgroundTransparency = 1
titleLab.Text = isOwner and "👑 AK HUB [OWNER VN] 🔥" or "⚡ AK HUB VIP ✨"
titleLab.TextColor3 = THEME.titleText
titleLab.TextSize = 13
titleLab.Font = Enum.Font.GothamBlack
titleLab.TextXAlignment = Enum.TextXAlignment.Left
titleLab.Parent = mainWin

local gearBtn = Instance.new("TextButton")
gearBtn.Size = UDim2.new(0, 28, 0, 28)
gearBtn.Position = UDim2.new(1, -66, 0, 6)
gearBtn.BackgroundColor3 = THEME.minBtnBg
gearBtn.Text = "⚙️"
gearBtn.TextColor3 = THEME.titleText
gearBtn.TextSize = 14
gearBtn.Font = Enum.Font.GothamBold
gearBtn.Parent = mainWin
Instance.new("UICorner", gearBtn).CornerRadius = UDim.new(0, 8)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -34, 0, 6)
minBtn.BackgroundColor3 = THEME.minBtnBg
minBtn.Text = "-"
minBtn.TextColor3 = THEME.titleText
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainWin
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

local bodyF = Instance.new("Frame")
bodyF.Size = UDim2.new(1, 0, 1, -40)
bodyF.Position = UDim2.new(0, 0, 0, 40)
bodyF.BackgroundTransparency = 1
bodyF.Parent = mainWin

local accName = lp.DisplayName .. " (@" .. lp.Name .. ")"
local usrBox = Instance.new("TextLabel")
usrBox.Size = UDim2.new(0.92, 0, 0, 28)
usrBox.Position = UDim2.new(0.04, 0, 0.02, 0)
usrBox.BackgroundColor3 = THEME.cardBg
usrBox.BorderSizePixel = 0
usrBox.Text = isOwner and ("  👑 OWNER VN: " .. accName) or ("  👤 Acc: " .. accName)
usrBox.TextColor3 = THEME.badgeText
usrBox.TextSize = 11
usrBox.Font = Enum.Font.GothamBold
usrBox.TextXAlignment = Enum.TextXAlignment.Left
usrBox.Parent = bodyF
Instance.new("UICorner", usrBox).CornerRadius = UDim.new(0, 8)

local devType = (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) and "PC 💻" or "Mobile 📱"
local devBox = Instance.new("TextLabel")
devBox.Size = UDim2.new(0.92, 0, 0, 28)
devBox.Position = UDim2.new(0.04, 0, 0.12, 0)
devBox.BackgroundColor3 = THEME.cardBg
devBox.BorderSizePixel = 0
devBox.Text = "  🎮 Device: " .. devType
devBox.TextColor3 = isOwner and Color3.fromRGB(255, 215, 70) or Color3.fromRGB(45, 255, 165)
devBox.TextSize = 11
devBox.Font = Enum.Font.GothamBold
devBox.TextXAlignment = Enum.TextXAlignment.Left
devBox.Parent = bodyF
Instance.new("UICorner", devBox).CornerRadius = UDim.new(0, 8)

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0.92, 0, 0, 40)
scanBtn.Position = UDim2.new(0.04, 0, 0.25, 0)
scanBtn.BackgroundColor3 = THEME.btnBg
scanBtn.Text = "🔎 Find a server for one person."
scanBtn.TextColor3 = THEME.btnText
scanBtn.TextSize = 12
scanBtn.Font = Enum.Font.GothamBlack
scanBtn.Parent = bodyF
Instance.new("UICorner", scanBtn).CornerRadius = UDim.new(0, 10)

local scrollArea = Instance.new("ScrollingFrame")
scrollArea.Size = UDim2.new(0.92, 0, 0, 180)
scrollArea.Position = UDim2.new(0.04, 0, 0.41, 0)
scrollArea.BackgroundColor3 = Color3.fromRGB(7, 12, 22)
scrollArea.BorderSizePixel = 0
scrollArea.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollArea.ScrollBarThickness = 4
scrollArea.Parent = bodyF
Instance.new("UICorner", scrollArea).CornerRadius = UDim.new(0, 10)

local uiList = Instance.new("UIListLayout")
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 6)
uiList.Parent = scrollArea

local keyWin = Instance.new("Frame")
keyWin.Size = UDim2.new(0, 292, 0, 205)
keyWin.Position = UDim2.new(0.5, -146, 0.5, -102)
keyWin.BackgroundColor3 = Color3.fromRGB(10, 18, 36)
keyWin.BorderSizePixel = 0
keyWin.Active = true
keyWin.Draggable = true
keyWin.Visible = not isOwner
keyWin.Parent = gui
Instance.new("UICorner", keyWin).CornerRadius = UDim.new(0, 14)

local kwStroke = Instance.new("UIStroke")
kwStroke.Color = Color3.fromRGB(0, 200, 255)
kwStroke.Thickness = 2.5
kwStroke.Parent = keyWin

local kTitle = Instance.new("TextLabel")
kTitle.Size = UDim2.new(1, -20, 0, 28)
kTitle.Position = UDim2.new(0, 10, 0, 8)
kTitle.BackgroundTransparency = 1
kTitle.Text = "🔐 AK HUB // KEY SYSTEM ✨"
kTitle.TextColor3 = Color3.fromRGB(56, 225, 255)
kTitle.TextSize = 13
kTitle.Font = Enum.Font.GothamBlack
kTitle.Parent = keyWin

local kUidHint = Instance.new("TextLabel")
kUidHint.Size = UDim2.new(1, -20, 0, 18)
kUidHint.Position = UDim2.new(0, 10, 0, 35)
kUidHint.BackgroundTransparency = 1
kUidHint.Text = "🆔 UserId: " .. tostring(lp.UserId)
kUidHint.TextColor3 = Color3.fromRGB(255, 210, 75)
kUidHint.TextSize = 11
kUidHint.Font = Enum.Font.GothamBold
kUidHint.Parent = keyWin

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.88, 0, 0, 36)
keyBox.Position = UDim2.new(0.06, 0, 0.31, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(18, 32, 58)
keyBox.BorderSizePixel = 0
keyBox.Text = ""
keyBox.PlaceholderText = "🔑 Paste key from website..."
keyBox.TextColor3 = Color3.fromRGB(120, 255, 180)
keyBox.PlaceholderColor3 = Color3.fromRGB(145, 175, 215)
keyBox.TextSize = 12
keyBox.Font = Enum.Font.GothamBold
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyWin
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local checkBtn = Instance.new("TextButton")
checkBtn.Size = UDim2.new(0.42, 0, 0, 38)
checkBtn.Position = UDim2.new(0.06, 0, 0.55, 0)
checkBtn.BackgroundColor3 = Color3.fromRGB(24, 195, 110)
checkBtn.Text = "✅ Verify"
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.TextSize = 12
checkBtn.Font = Enum.Font.GothamBold
checkBtn.Parent = keyWin
Instance.new("UICorner", checkBtn).CornerRadius = UDim.new(0, 8)

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.42, 0, 0, 38)
getKeyBtn.Position = UDim2.new(0.52, 0, 0.55, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 145, 0)
getKeyBtn.Text = "🌐 Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(25, 15, 0)
getKeyBtn.TextSize = 12
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Parent = keyWin
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

local kStatus = Instance.new("TextLabel")
kStatus.Size = UDim2.new(0.92, 0, 0, 28)
kStatus.Position = UDim2.new(0.04, 0, 0.79, 0)
kStatus.BackgroundTransparency = 1
kStatus.Text = "💡 Click Get Key to copy link"
kStatus.TextColor3 = Color3.fromRGB(165, 215, 255)
kStatus.TextSize = 10
kStatus.Font = Enum.Font.GothamSemibold
kStatus.TextWrapped = true
kStatus.Parent = keyWin

gearBtn.MouseButton1Click:Connect(runFlyGuiV3)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    bodyF.Visible = not minimized
    mainWin.Size = minimized and UDim2.new(0, 305, 0, 40) or UDim2.new(0, 305, 0, 355)
    minBtn.Text = minimized and "+" or "-"
end)

scanBtn.MouseButton1Click:Connect(function()
    for _, c in ipairs(scrollArea:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    scanBtn.Text = "⏳ Scanning..."
    local okReq, raw = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    end)
    if okReq and type(raw) == "string" then
        local okDec, data = pcall(function() return HttpService:JSONDecode(raw) end)
        if okDec and type(data) == "table" and type(data.data) == "table" then
            for _, srv in ipairs(data.data) do
                local playing = srv.playing or 0
                local maxP = srv.maxPlayers or 0
                if playing >= 1 and playing <= 5 and srv.id ~= game.JobId then
                    local card = Instance.new("Frame")
                    card.Size = UDim2.new(1, -6, 0, 36)
                    card.BackgroundColor3 = THEME.cardBg
                    card.BorderSizePixel = 0
                    card.Parent = scrollArea
                    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(0.68, -8, 1, 0)
                    lbl.Position = UDim2.new(0, 8, 0, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "👥 " .. playing .. "/" .. maxP .. " | " .. tostring(srv.id):sub(1, 8)
                    lbl.TextColor3 = Color3.fromRGB(245, 250, 255)
                    lbl.TextSize = 10
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextXAlignment = Enum.TextXAlignment.Left
                    lbl.Parent = card

                    local jBtn = Instance.new("TextButton")
                    jBtn.Size = UDim2.new(0.28, 0, 0.72, 0)
                    jBtn.Position = UDim2.new(0.70, 0, 0.14, 0)
                    jBtn.BackgroundColor3 = THEME.btnBg
                    jBtn.Text = "🚀 Join"
                    jBtn.TextColor3 = THEME.btnText
                    jBtn.TextSize = 10
                    jBtn.Font = Enum.Font.GothamBlack
                    jBtn.Parent = card
                    Instance.new("UICorner", jBtn).CornerRadius = UDim.new(0, 6)

                    jBtn.MouseButton1Click:Connect(function()
                        jBtn.Text = "⏳..."
                        local okTele, errTele = pcall(function()
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, lp)
                        end)
                        if not okTele then
                            jBtn.Text = "❌ Err"
                            warn("[AK HUB Teleport Error]:", tostring(errTele))
                            task.delay(2, function()
                                if jBtn and jBtn.Parent then jBtn.Text = "🚀 Join" end
                            end)
                        else
                            task.delay(3, function()
                                if jBtn and jBtn.Parent and jBtn.Text == "⏳..." then
                                    jBtn.Text = "🚀 Join"
                                end
                            end)
                        end
                    end)
                end
            end
            scrollArea.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize.Y + 10)
        end
    end
    scanBtn.Text = "🔎 Find a server for one person."
end)

getKeyBtn.MouseButton1Click:Connect(function()
    if type(setclipboard) == "function" then
        pcall(setclipboard, KEY_LINK)
        kStatus.Text = "📋 Link copied! Paste in browser."
        kStatus.TextColor3 = Color3.fromRGB(110, 255, 175)
    else
        kStatus.Text = KEY_LINK
        kStatus.TextColor3 = Color3.fromRGB(255, 215, 90)
    end
end)

checkBtn.MouseButton1Click:Connect(function()
    if isValidKey(keyBox.Text) then
        keyWin.Visible = false
        mainWin.Visible = true
    else
        kStatus.Text = "❌ Invalid key or wrong UserId!"
        kStatus.TextColor3 = Color3.fromRGB(255, 110, 125)
    end
end)
