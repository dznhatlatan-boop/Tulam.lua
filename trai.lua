local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local KEY_LINK = "https://dznhatlatan-boop.github.io/Wed-key-/"
local _SecretSalt = 7919
local CYCLE_SECONDS = 18000

local OWNER_NAMES = {
    ["hupbera23"] = true,
    ["qwp1545"] = true,
}

local OWNER_USER_IDS = {
    -- Them UserId that neu can, VD: [123456789] = true,
}

local lp = Players.LocalPlayer or Players.PlayerAdded:Wait()

local function isOwnerAccount(player)
    if not player then return false end
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
    local uid = lp.UserId
    local nowCycle = getCurrentCycle()
    for offset = -1, 30 do
        if cleaned == buildUserKey(uid, nowCycle + offset) then
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
                if n == "AKHubColorGui"
                    or n == "AKHubSingleGui"
                    or n == "AKHubCleanGui"
                    or n == "ServerHubTemplate"
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
    local ok, cg = pcall(function()
        return game:GetService("CoreGui")
    end)
    if ok and cg then return cg end
    return nil
end

_G.AKHubSessionId = (_G.AKHubSessionId or 0) + 1
local mySession = _G.AKHubSessionId

clearAllOldGuis()
task.wait(0.05)
if _G.AKHubSessionId ~= mySession then
    return
end

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

local flyCreated = false
local flyFrameRef = nil

local function toggleClassicFlyGui()
    if flyCreated and flyFrameRef and flyFrameRef.Parent then
        flyFrameRef.Visible = not flyFrameRef.Visible
        return
    end

    flyCreated = true

    local Frame = Instance.new("Frame")
    local up = Instance.new("TextButton")
    local down = Instance.new("TextButton")
    local onof = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local plus = Instance.new("TextButton")
    local speed = Instance.new("TextLabel")
    local mine = Instance.new("TextButton")
    local closebutton = Instance.new("TextButton")
    local mini = Instance.new("TextButton")
    local mini2 = Instance.new("TextButton")

    flyFrameRef = Frame

    Frame.Name = "FlyV3ClassicFrame"
    Frame.Parent = gui
    Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
    Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
    Frame.Position = UDim2.new(0.100320168, 0, 0.55, 0)
    Frame.Size = UDim2.new(0, 190, 0, 57)
    Frame.Active = true
    Frame.Draggable = true

    up.Name = "up"
    up.Parent = Frame
    up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
    up.Size = UDim2.new(0, 44, 0, 28)
    up.Font = Enum.Font.SourceSans
    up.Text = "UP"
    up.TextColor3 = Color3.fromRGB(0, 0, 0)
    up.TextSize = 14.000

    down.Name = "down"
    down.Parent = Frame
    down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
    down.Position = UDim2.new(0, 0, 0.491228074, 0)
    down.Size = UDim2.new(0, 44, 0, 28)
    down.Font = Enum.Font.SourceSans
    down.Text = "DOWN"
    down.TextColor3 = Color3.fromRGB(0, 0, 0)
    down.TextSize = 14.000

    onof.Name = "onof"
    onof.Parent = Frame
    onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
    onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
    onof.Size = UDim2.new(0, 56, 0, 28)
    onof.Font = Enum.Font.SourceSans
    onof.Text = "fly"
    onof.TextColor3 = Color3.fromRGB(0, 0, 0)
    onof.TextSize = 14.000

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
    TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 100, 0, 28)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "FLY GUI V3"
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    plus.Name = "plus"
    plus.Parent = Frame
    plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
    plus.Position = UDim2.new(0.231578946, 0, 0, 0)
    plus.Size = UDim2.new(0, 45, 0, 28)
    plus.Font = Enum.Font.SourceSans
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(0, 0, 0)
    plus.TextScaled = true
    plus.TextSize = 14.000
    plus.TextWrapped = true

    speed.Name = "speed"
    speed.Parent = Frame
    speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
    speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
    speed.Size = UDim2.new(0, 44, 0, 28)
    speed.Font = Enum.Font.SourceSans
    speed.Text = "1"
    speed.TextColor3 = Color3.fromRGB(0, 0, 0)
    speed.TextScaled = true
    speed.TextSize = 14.000
    speed.TextWrapped = true

    mine.Name = "mine"
    mine.Parent = Frame
    mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
    mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
    mine.Size = UDim2.new(0, 45, 0, 29)
    mine.Font = Enum.Font.SourceSans
    mine.Text = "-"
    mine.TextColor3 = Color3.fromRGB(0, 0, 0)
    mine.TextScaled = true
    mine.TextSize = 14.000
    mine.TextWrapped = true

    closebutton.Name = "Close"
    closebutton.Parent = Frame
    closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
    closebutton.Font = Enum.Font.SourceSans
    closebutton.Size = UDim2.new(0, 45, 0, 28)
    closebutton.Text = "X"
    closebutton.TextSize = 30
    closebutton.Position = UDim2.new(0, 0, -1, 27)

    mini.Name = "minimize"
    mini.Parent = Frame
    mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini.Font = Enum.Font.SourceSans
    mini.Size = UDim2.new(0, 45, 0, 28)
    mini.Text = "-"
    mini.TextSize = 40
    mini.Position = UDim2.new(0, 44, -1, 27)

    mini2.Name = "minimize2"
    mini2.Parent = Frame
    mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini2.Font = Enum.Font.SourceSans
    mini2.Size = UDim2.new(0, 45, 0, 28)
    mini2.Text = "+"
    mini2.TextSize = 40
    mini2.Position = UDim2.new(0, 44, -1, 57)
    mini2.Visible = false

    local speeds = 1
    local speaker = Players.LocalPlayer
    local nowe = false
    local tpwalking = false

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "FLY GUI V3",
            Text = "BY XNEO",
            Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
            Duration = 5,
        })
    end)

    onof.MouseButton1Down:Connect(function()
        if nowe == true then
            nowe = false
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        else
            nowe = true

            for _ = 1, speeds do
                task.spawn(function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end

            Players.LocalPlayer.Character.Animate.Disabled = true
            local Char = Players.LocalPlayer.Character
            local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

            for _, v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end

            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        end

        if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            local plr = Players.LocalPlayer
            local torso = plr.Character.Torso
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local flySpd = 0

            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or Players.LocalPlayer.Character.Humanoid.Health == 0 do
                game:GetService("RunService").RenderStepped:Wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    flySpd = flySpd + 0.5 + (flySpd / maxspeed)
                    if flySpd > maxspeed then
                        flySpd = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and flySpd ~= 0 then
                    flySpd = flySpd - 1
                    if flySpd < 0 then
                        flySpd = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * flySpd
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and flySpd ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * flySpd
                else
                    bv.velocity = Vector3.new(0, 0, 0)
                end
                bg.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * flySpd / maxspeed), 0, 0)
            end
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        else
            local plr = Players.LocalPlayer
            local UpperTorso = plr.Character.UpperTorso
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local flySpd = 0

            local bg = Instance.new("BodyGyro", UpperTorso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = UpperTorso.CFrame
            local bv = Instance.new("BodyVelocity", UpperTorso)
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or Players.LocalPlayer.Character.Humanoid.Health == 0 do
                task.wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    flySpd = flySpd + 0.5 + (flySpd / maxspeed)
                    if flySpd > maxspeed then
                        flySpd = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and flySpd ~= 0 then
                    flySpd = flySpd - 1
                    if flySpd < 0 then
                        flySpd = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * flySpd
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and flySpd ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * flySpd
                else
                    bv.velocity = Vector3.new(0, 0, 0)
                end

                bg.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * flySpd / maxspeed), 0, 0)
            end
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        end
    end)

    local tis
    up.MouseButton1Down:Connect(function()
        tis = up.MouseEnter:Connect(function()
            while tis do
                task.wait()
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
            end
        end)
    end)

    up.MouseLeave:Connect(function()
        if tis then
            tis:Disconnect()
            tis = nil
        end
    end)

    local dis
    down.MouseButton1Down:Connect(function()
        dis = down.MouseEnter:Connect(function()
            while dis do
                task.wait()
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
            end
        end)
    end)

    down.MouseLeave:Connect(function()
        if dis then
            dis:Disconnect()
            dis = nil
        end
    end)

    Players.LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.7)
        Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        Players.LocalPlayer.Character.Animate.Disabled = false
    end)

    plus.MouseButton1Down:Connect(function()
        speeds = speeds + 1
                    speed.Text = tostring(speeds)
        if nowe == true then
            tpwalking = false
            for _ = 1, speeds do
                task.spawn(function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end)

    mine.MouseButton1Down:Connect(function()
        if speeds == 1 then
            speed.Text = "cannot be less than 1"
            task.wait(1)
            speed.Text = tostring(speeds)
        else
            speeds = speeds - 1
            speed.Text = tostring(speeds)
            if nowe == true then
                tpwalking = false
                for _ = 1, speeds do
                    task.spawn(function()
                        local hb = game:GetService("RunService").Heartbeat
                        tpwalking = true
                        local chr = Players.LocalPlayer.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        end
    end)

    closebutton.MouseButton1Click:Connect(function()
        Frame.Visible = false
    end)

    mini.MouseButton1Click:Connect(function()
        up.Visible = false
        down.Visible = false
        onof.Visible = false
        plus.Visible = false
        speed.Visible = false
        mine.Visible = false
        mini.Visible = false
        mini2.Visible = true
        Frame.BackgroundTransparency = 1
        closebutton.Position = UDim2.new(0, 0, -1, 57)
    end)

    mini2.MouseButton1Click:Connect(function()
        up.Visible = true
        down.Visible = true
        onof.Visible = true
        plus.Visible = true
        speed.Visible = true
        mine.Visible = true
        mini.Visible = true
        mini2.Visible = false
        Frame.BackgroundTransparency = 0
        closebutton.Position = UDim2.new(0, 0, -1, 27)
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

local mwCorner = Instance.new("UICorner")
mwCorner.CornerRadius = UDim.new(0, 14)
mwCorner.Parent = mainWin

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

local gearCorner = Instance.new("UICorner")
gearCorner.CornerRadius = UDim.new(0, 8)
gearCorner.Parent = gearBtn

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -34, 0, 6)
minBtn.BackgroundColor3 = THEME.minBtnBg
minBtn.Text = "-"
minBtn.TextColor3 = THEME.titleText
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainWin

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

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

local usrCorner = Instance.new("UICorner")
usrCorner.CornerRadius = UDim.new(0, 8)
usrCorner.Parent = usrBox

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

local devCorner = Instance.new("UICorner")
devCorner.CornerRadius = UDim.new(0, 8)
devCorner.Parent = devBox

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0.92, 0, 0, 40)
scanBtn.Position = UDim2.new(0.04, 0, 0.25, 0)
scanBtn.BackgroundColor3 = THEME.btnBg
scanBtn.Text = "🔎 Find a server for one person."
scanBtn.TextColor3 = THEME.btnText
scanBtn.TextSize = 12
scanBtn.Font = Enum.Font.GothamBlack
scanBtn.Parent = bodyF

local scanCorner = Instance.new("UICorner")
scanCorner.CornerRadius = UDim.new(0, 10)
scanCorner.Parent = scanBtn

local scrollArea = Instance.new("ScrollingFrame")
scrollArea.Size = UDim2.new(0.92, 0, 0, 180)
scrollArea.Position = UDim2.new(0.04, 0, 0.41, 0)
scrollArea.BackgroundColor3 = Color3.fromRGB(7, 12, 22)
scrollArea.BorderSizePixel = 0
scrollArea.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollArea.ScrollBarThickness = 4
scrollArea.Parent = bodyF

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = scrollArea

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

local kwCorner = Instance.new("UICorner")
kwCorner.CornerRadius = UDim.new(0, 14)
kwCorner.Parent = keyWin

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

local kbCorner = Instance.new("UICorner")
kbCorner.CornerRadius = UDim.new(0, 8)
kbCorner.Parent = keyBox

local checkBtn = Instance.new("TextButton")
checkBtn.Size = UDim2.new(0.42, 0, 0, 38)
checkBtn.Position = UDim2.new(0.06, 0, 0.55, 0)
checkBtn.BackgroundColor3 = Color3.fromRGB(24, 195, 110)
checkBtn.Text = "✅ Verify"
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.TextSize = 12
checkBtn.Font = Enum.Font.GothamBold
checkBtn.Parent = keyWin

local chkCorner = Instance.new("UICorner")
chkCorner.CornerRadius = UDim.new(0, 8)
chkCorner.Parent = checkBtn

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.42, 0, 0, 38)
getKeyBtn.Position = UDim2.new(0.52, 0, 0.55, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 145, 0)
getKeyBtn.Text = "🌐 Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(25, 15, 0)
getKeyBtn.TextSize = 12
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Parent = keyWin

local gkCorner = Instance.new("UICorner")
gkCorner.CornerRadius = UDim.new(0, 8)
gkCorner.Parent = getKeyBtn

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

gearBtn.MouseButton1Click:Connect(function()
    toggleClassicFlyGui()
end)

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
        local okDec, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
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

                    local cCorner = Instance.new("UICorner")
                    cCorner.CornerRadius = UDim.new(0, 8)
                    cCorner.Parent = card

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

                    local jbCorner = Instance.new("UICorner")
                    jbCorner.CornerRadius = UDim.new(0, 6)
                    jbCorner.Parent = jBtn

                    jBtn.MouseButton1Click:Connect(function()
                        pcall(function()
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, lp)
                        end)
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
