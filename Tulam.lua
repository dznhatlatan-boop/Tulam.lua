-- ============================================
-- TYRANT OF JURASSIC HUB (MENU TO + TP FIX)
-- Key: tan
-- ============================================

local key = "tan"

local gui = Instance.new("ScreenGui")
gui.Name = "KeySystem"
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 220)
frame.Position = UDim2.new(0.5, -190, 0.5, -110)
frame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 0, 3)
border.BackgroundColor3 = Color3.new(1, 0.7, 0)
border.Parent = frame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
header.BorderSizePixel = 0
header.Parent = frame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Text = "🦖 TYRANT OF JURASSIC HUB"
title.TextColor3 = Color3.new(1, 0.7, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.BackgroundTransparency = 1
title.Parent = header

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.75, 0, 0, 45)
textBox.Position = UDim2.new(0.12, 0, 0.4, 0)
textBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.Text = ""
textBox.PlaceholderText = "ENTER KEY..."
textBox.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
textBox.Font = Enum.Font.GothamMedium
textBox.TextScaled = true
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.4, 0, 0, 40)
activateBtn.Position = UDim2.new(0.3, 0, 0.65, 0)
activateBtn.Text = "⚡ ACTIVATE"
activateBtn.TextColor3 = Color3.new(1, 1, 1)
activateBtn.BackgroundColor3 = Color3.new(1, 0.7, 0)
activateBtn.Font = Enum.Font.GothamBold
activateBtn.TextScaled = true
activateBtn.Parent = frame
Instance.new("UICorner", activateBtn).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextScaled = true
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = frame

activateBtn.MouseButton1Click:Connect(function()
    if textBox.Text == key then
        statusLabel.Text = "✅ KEY VALID! LOADING..."
        statusLabel.TextColor3 = Color3.new(0, 1, 0)
        task.wait(0.8)
        gui:Destroy()
        print("🦖 TYRANT ACTIVATED!")

        -- ============================================
        -- MAIN SCRIPT (MENU TO + TP FIX)
        -- ============================================
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")

        local espOn = false
        local rayOn = false
        local flyOn = false
        local selectedTarget = nil
        local espObjects = {}
        local rays = {}
        local flyBody = nil

        -- TOGGLE BUTTON
        local toggleGui = Instance.new("ScreenGui")
        toggleGui.Name = "ToggleButton"
        toggleGui.Parent = LocalPlayer.PlayerGui

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 55, 0, 55)
        toggleBtn.Position = UDim2.new(0.92, -27, 0.8, -27)
        toggleBtn.Text = "⚡"
        toggleBtn.TextScaled = true
        toggleBtn.TextColor3 = Color3.new(0, 1, 1)
        toggleBtn.BackgroundColor3 = Color3.new(0.05, 0.05, 0.1)
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = toggleGui
        Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
        local stroke = Instance.new("UIStroke", toggleBtn)
        stroke.Color = Color3.new(0, 1, 1)
        stroke.Thickness = 2

        -- MAIN MENU (TO HƠN)
        local mainGui = Instance.new("ScreenGui")
        mainGui.Name = "Menu"
        mainGui.Parent = LocalPlayer.PlayerGui

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 220, 0, 320)
        mainFrame.Position = UDim2.new(0.5, -110, 0.5, -160)
        mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        mainFrame.BackgroundTransparency = 0.2
        mainFrame.BorderSizePixel = 0
        mainFrame.Visible = false
        mainFrame.Parent = mainGui
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

        local title2 = Instance.new("TextLabel")
        title2.Size = UDim2.new(1, 0, 0, 40)
        title2.Text = "⚡ MENU"
        title2.TextColor3 = Color3.new(1, 1, 1)
        title2.TextScaled = true
        title2.Font = Enum.Font.GothamBold
        title2.BackgroundTransparency = 1
        title2.Parent = mainFrame

        local function makeBtn(name, y, color)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.85, 0, 0, 32)
            btn.Position = UDim2.new(0.075, 0, y, 0)
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundColor3 = color or Color3.new(0.2, 0.6, 0.2)
            btn.BorderSizePixel = 0
            btn.Parent = mainFrame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            return btn
        end

        local rayBtn = makeBtn("🔴 RAY: OFF", 0.11)
        local espBtn = makeBtn("🔵 ESP: OFF", 0.23)
        local flyBtn = makeBtn("✈️ FLY: OFF", 0.35)
        local tpBtn = makeBtn("🟢 TP: SELECT", 0.47)
        local closeBtn = makeBtn("✕ CLOSE", 0.68, Color3.new(0.5, 0.1, 0.1))

        toggleBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = not mainFrame.Visible
        end)

        -- PLAYER LIST (VỪA KHUNG MENU)
        local playerListFrame = Instance.new("ScrollingFrame")
        playerListFrame.Size = UDim2.new(0.85, 0, 0, 90)
        playerListFrame.Position = UDim2.new(0.075, 0, 0.60, 0)
        playerListFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
        playerListFrame.BorderSizePixel = 0
        playerListFrame.Parent = mainFrame
        Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 6)
        playerListFrame.Visible = false
        playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local playerListLabel = Instance.new("TextLabel")
        playerListLabel.Size = UDim2.new(1, 0, 0, 20)
        playerListLabel.Text = "🎯 SELECT TARGET:"
        playerListLabel.TextColor3 = Color3.new(1, 0.7, 0)
        playerListLabel.TextScaled = true
        playerListLabel.Font = Enum.Font.GothamBold
        playerListLabel.BackgroundTransparency = 1
        playerListLabel.Parent = playerListFrame

        local function updatePlayerList()
            for _, v in pairs(playerListFrame:GetChildren()) do
                if v:IsA("TextButton") then v:Destroy() end
            end
            local y = 25
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(1, -10, 0, 25)
                    btn.Position = UDim2.new(0.5, -5, 0, y)
                    btn.Text = pl.Name
                    btn.TextColor3 = Color3.new(1, 1, 1)
                    btn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
                    btn.BorderSizePixel = 0
                    btn.Parent = playerListFrame
                    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                    btn.MouseButton1Click:Connect(function()
                        selectedTarget = pl
                        tpBtn.Text = "🟢 TP: " .. pl.Name
                        playerListFrame.Visible = false
                        tpBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
                    end)
                    y = y + 28
                end
            end
            playerListFrame.CanvasSize = UDim2.new(0, 0, 0, y)
        end

        -- TP NOW
        local tpNowBtn = Instance.new("TextButton")
        tpNowBtn.Size = UDim2.new(0.4, 0, 0, 25)
        tpNowBtn.Position = UDim2.new(0.3, 0, 0.68, 0)
        tpNowBtn.Text = "🚀 TP NOW"
        tpNowBtn.TextColor3 = Color3.new(1, 1, 1)
        tpNowBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
        tpNowBtn.Parent = mainFrame
        Instance.new("UICorner", tpNowBtn).CornerRadius = UDim.new(0, 6)
        tpNowBtn.Visible = false

        local function teleportTo(pl)
            if not pl then return end
            local ch = pl.Character
            if not ch then return end
            local r = ch:FindFirstChild("HumanoidRootPart")
            if not r then return end
            local lc = LocalPlayer.Character
            if not lc then return end
            local lr = lc:FindFirstChild("HumanoidRootPart")
            if not lr then return end
            lr.CFrame = r.CFrame + Vector3.new(0, 2, 0)
        end

        tpNowBtn.MouseButton1Click:Connect(function()
            if selectedTarget then
                teleportTo(selectedTarget)
            end
        end)

        -- ESP
        local function addESP(pl)
            if pl == LocalPlayer or espObjects[pl] then return end
            local ch = pl.Character
            if not ch then return end
            local h = Instance.new("Highlight")
            h.FillColor = Color3.new(0, 0.6, 1)
            h.OutlineColor = Color3.new(0, 0.3, 0.8)
            h.Adornee = ch
            h.Parent = ch
            local lb = Instance.new("BillboardGui")
            lb.Size = UDim2.new(0, 150, 0, 30)
            lb.Adornee = ch
            lb.AlwaysOnTop = true
            lb.Parent = ch
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0.5
            label.Font = Enum.Font.GothamBold
            label.TextScaled = true
            label.Parent = lb
            espObjects[pl] = {highlight = h, label = label}
        end

        local function removeESP(pl)
            local data = espObjects[pl]
            if data then
                data.highlight:Destroy()
                data.label:Destroy()
                espObjects[pl] = nil
            end
        end

        -- RAY
        local function makeRay(pl)
            if pl == LocalPlayer or rays[pl] then return end
            local ch = pl.Character
            if not ch then return end
            local head = ch:FindFirstChild("Head")
            if not head then return end
            local myHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if not myHead then return end
            local ray = Instance.new("Part")
            ray.Size = Vector3.new(0.05, 0.05, 1)
            ray.Anchored = true
            ray.CanCollide = false
            ray.Material = Enum.Material.Neon
            ray.Color = Color3.new(0, 0.6, 1)
            ray.Transparency = 0
            ray.Parent = Workspace
            rays[pl] = ray
        end

        local function updateRays()
            if not rayOn then return end
            local myHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if not myHead then
                for _, r in pairs(rays) do r.Transparency = 1 end
                return
            end
            for pl, r in pairs(rays) do
                local ch = pl.Character
                if ch then
                    local head = ch:FindFirstChild("Head")
                    if head then
                        local p1 = myHead.Position
                        local p2 = head.Position
                        local mid = (p1 + p2) / 2
                        local dir = (p2 - p1).Unit
                        local dist = (p2 - p1).Magnitude
                        r.CFrame = CFrame.lookAt(mid, mid + dir)
                        r.Size = Vector3.new(0.05, 0.05, dist)
                        r.Position = mid
                        r.Transparency = 0
                    else
                        r.Transparency = 1
                    end
                else
                    r.Transparency = 1
                end
            end
        end

        local function refreshRays()
            for _, r in pairs(rays) do r:Destroy() end
            rays = {}
            if not rayOn then return end
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then makeRay(pl) end
            end
        end

        -- FLY
        local function toggleFly()
            flyOn = not flyOn
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local hum = char:FindFirstChild("Humanoid")

            if flyOn then
                if flyBody then flyBody:Destroy() end
                flyBody = Instance.new("BodyVelocity")
                flyBody.Velocity = Vector3.new(0, 0, 0)
                flyBody.MaxForce = Vector3.new(4000, 4000, 4000)
                flyBody.Parent = hrp
                if hum then hum.PlatformStand = true end
                flyBtn.Text = "✈️ FLY: ON"
                flyBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            else
                if flyBody then flyBody:Destroy(); flyBody = nil end
                if hum then hum.PlatformStand = false end
                flyBtn.Text = "✈️ FLY: OFF"
                flyBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end

        local function updateFly()
            if not flyOn or not flyBody then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                local move = hum.MoveDirection
                if move.Magnitude > 0 then
                    flyBody.Velocity = move * 50 + Vector3.new(0, 2, 0)
                else
                    flyBody.Velocity = Vector3.new(0, 0.5, 0)
                end
            end
        end

        -- BUTTON EVENTS
        rayBtn.MouseButton1Click:Connect(function()
            rayOn = not rayOn
            if rayOn then
                refreshRays()
                RunService.RenderStepped:Connect(updateRays)
                rayBtn.Text = "🔴 RAY: ON"
                rayBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            else
                for _, r in pairs(rays) do r:Destroy() end
                rays = {}
                rayBtn.Text = "🔴 RAY: OFF"
                rayBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end)

        espBtn.MouseButton1Click:Connect(function()
            espOn = not espOn
            if espOn then
                for _, pl in pairs(Players:GetPlayers()) do addESP(pl) end
                Players.PlayerAdded:Connect(addESP)
                Players.PlayerRemoving:Connect(removeESP)
                RunService.RenderStepped:Connect(function()
                    for pl, data in pairs(espObjects) do
                        local ch = pl.Character
                        if ch and ch:FindFirstChild("HumanoidRootPart") then
                            local r = ch.HumanoidRootPart
                            local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart and (LocalPlayer.Character.HumanoidRootPart.Position - r.Position).Magnitude or 0))
                            data.label.Text = pl.Name .. " " .. dist .. "m"
                        else
                            removeESP(pl)
                        end
                    end
                end)
                espBtn.Text = "🔵 ESP: ON"
                espBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            else
                for pl in pairs(espObjects) do removeESP(pl) end
                espBtn.Text = "🔵 ESP: OFF"
                espBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end)

        flyBtn.MouseButton1Click:Connect(toggleFly)

        tpBtn.MouseButton1Click:Connect(function()
            playerListFrame.Visible = not playerListFrame.Visible
            tpNowBtn.Visible = playerListFrame.Visible
            if playerListFrame.Visible then updatePlayerList() end
        end)

        closeBtn.MouseButton1Click:Connect(function()
            mainGui:Destroy()
            toggleGui:Destroy()
            for _, r in pairs(rays) do r:Destroy() end
            for pl in pairs(espObjects) do removeESP(pl) end
            if flyBody then flyBody:Destroy() end
        end)

        RunService.RenderStepped:Connect(updateFly)

        LocalPlayer.CharacterAdded:Connect(function()
            if flyBody then flyBody:Destroy(); flyBody = nil end
            flyOn = false
            flyBtn.Text = "✈️ FLY: OFF"
            flyBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        end)

    else
        statusLabel.Text = "❌ INVALID KEY! TRY AGAIN"
        statusLabel.TextColor3 = Color3.new(1, 0, 0)
        textBox.Text = ""
        task.wait(1)
        textBox.TextColor3 = Color3.new(1, 1, 1)
    end
end)

textBox.FocusLost:Connect(function(enter)
    if enter then activateBtn.MouseButton1Click:Fire() end
end)
