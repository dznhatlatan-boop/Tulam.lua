-- ============================================
-- TYRANT OF JURASSIC (KEY + LINK GUIDE)
-- ============================================

local keyCorrect = "tan"

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.Parent = game.Players.LocalPlayer.PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 380, 0, 260)
keyFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
keyFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 0, 3)
border.BackgroundColor3 = Color3.new(1, 0.7, 0)
border.Parent = keyFrame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
header.BorderSizePixel = 0
header.Parent = keyFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Text = "🦖 TYRANT OF JURASSIC"
title.TextColor3 = Color3.new(1, 0.7, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.BackgroundTransparency = 1
title.Parent = header

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.75, 0, 0, 45)
textBox.Position = UDim2.new(0.12, 0, 0.33, 0)
textBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.Text = ""
textBox.PlaceholderText = "ENTER ACTIVATION KEY..."
textBox.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)
textBox.Font = Enum.Font.GothamMedium
textBox.TextScaled = true
textBox.Parent = keyFrame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.4, 0, 0, 40)
activateBtn.Position = UDim2.new(0.3, 0, 0.58, 0)
activateBtn.Text = "⚡ ACTIVATE"
activateBtn.TextColor3 = Color3.new(1, 1, 1)
activateBtn.BackgroundColor3 = Color3.new(1, 0.7, 0)
activateBtn.Font = Enum.Font.GothamBold
activateBtn.TextScaled = true
activateBtn.Parent = keyFrame
Instance.new("UICorner", activateBtn).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0.82, 0)
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextScaled = true
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = keyFrame

-- ===== HƯỚNG DẪN LẤY KEY (CÓ THỂ SAO CHÉP) =====
local guideLabel = Instance.new("TextLabel")
guideLabel.Size = UDim2.new(1, 0, 0, 35)
guideLabel.Position = UDim2.new(0, 0, 0.92, 0)
guideLabel.Text = "⚠️ No key? Get it here:\nhttps://raw.githubusercontent.com/dznhatlatan-boop/Tan/main/key.txt"
guideLabel.TextColor3 = Color3.new(0.5, 0.8, 1)
guideLabel.TextScaled = true
guideLabel.Font = Enum.Font.GothamMedium
guideLabel.BackgroundTransparency = 1
guideLabel.TextWrapped = true
guideLabel.Parent = keyFrame

activateBtn.MouseButton1Click:Connect(function()
    if textBox.Text == keyCorrect then
        statusLabel.Text = "✅ KEY VALID! LOADING..."
        statusLabel.TextColor3 = Color3.new(0, 1, 0)
        task.wait(0.8)
        keyGui:Destroy()
        print("🦖 TYRANT ACTIVATED!")

        -- ============================================
        -- MAIN SCRIPT (FULL FEATURES)
        -- ============================================
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Workspace = game:GetService("Workspace")

        local espOn = false
        local rayOn = false
        local aimOn = false
        local flyOn = false
        local speedOn = false
        local noclipOn = false
        local espObjects = {}
        local rays = {}
        local flyBody = nil

        -- TOGGLE BUTTON
        local toggleGui = Instance.new("ScreenGui")
        toggleGui.Name = "ToggleButton"
        toggleGui.Parent = LocalPlayer.PlayerGui

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 50, 0, 50)
        toggleBtn.Position = UDim2.new(0.92, -25, 0.8, -25)
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

        -- MAIN MENU
        local mainGui = Instance.new("ScreenGui")
        mainGui.Name = "TyrantMenu"
        mainGui.Parent = LocalPlayer.PlayerGui

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 200, 0, 350)
        mainFrame.Position = UDim2.new(0.5, -100, 0.5, -175)
        mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        mainFrame.BackgroundTransparency = 0.2
        mainFrame.BorderSizePixel = 0
        mainFrame.Visible = false
        mainFrame.Parent = mainGui
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

        local title2 = Instance.new("TextLabel")
        title2.Size = UDim2.new(1, 0, 0, 35)
        title2.Text = "⚡ TYRANT MENU"
        title2.TextColor3 = Color3.new(1, 0.7, 0)
        title2.TextScaled = true
        title2.Font = Enum.Font.GothamBold
        title2.BackgroundTransparency = 1
        title2.Parent = mainFrame

        local function makeButton(name, y, color)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.85, 0, 0, 28)
            btn.Position = UDim2.new(0.075, 0, y, 0)
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundColor3 = color or Color3.new(0.2, 0.6, 0.2)
            btn.BorderSizePixel = 0
            btn.Parent = mainFrame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            return btn
        end

        local espBtn = makeButton("🔵 ESP: OFF", 0.08)
        local rayBtn = makeButton("🔴 RAY: OFF", 0.20)
        local flyBtn = makeButton("✈️ FLY: OFF", 0.32)
        local aimBtn = makeButton("🎯 AIMBOT: OFF", 0.44)
        local speedBtn = makeButton("⚡ SPEED: OFF", 0.56)
        local noclipBtn = makeButton("🌀 NOCLIP: OFF", 0.68)
        local tpBtn = makeButton("🟢 TP NEAREST", 0.80)
        local closeBtn = makeButton("✕ CLOSE", 0.92, Color3.new(0.5, 0.1, 0.1))

        toggleBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = not mainFrame.Visible
        end)

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

        -- AIMBOT
        local function doAimbot()
            if not aimOn then return end
            local lc = LocalPlayer.Character
            if not lc then return end
            local lr = lc:FindFirstChild("HumanoidRootPart")
            if not lr then return end

            local nearest = nil
            local minDist = math.huge
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    local ch = pl.Character
                    if ch then
                        local r = ch:FindFirstChild("HumanoidRootPart")
                        if r then
                            local d = (lr.Position - r.Position).Magnitude
                            if d < minDist then
                                minDist = d
                                nearest = pl
                            end
                        end
                    end
                end
            end

            if nearest then
                local ch = nearest.Character
                if ch and ch:FindFirstChild("HumanoidRootPart") then
                    lr.CFrame = CFrame.new(lr.Position, ch.HumanoidRootPart.Position)
                end
            end
        end

        -- SPEED
        local function toggleSpeed()
            speedOn = not speedOn
            if speedOn then
                speedBtn.Text = "⚡ SPEED: ON"
                speedBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            else
                speedBtn.Text = "⚡ SPEED: OFF"
                speedBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end

        local function updateSpeed()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    if speedOn then
                        hum.WalkSpeed = 50
                        hum.JumpPower = 80
                    else
                        hum.WalkSpeed = 16
                        hum.JumpPower = 50
                    end
                end
            end
        end

        -- NOCLIP
        local function toggleNoclip()
            noclipOn = not noclipOn
            if noclipOn then
                noclipBtn.Text = "🌀 NOCLIP: ON"
                noclipBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            else
                noclipBtn.Text = "🌀 NOCLIP: OFF"
                noclipBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end

        local function updateNoclip()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = not noclipOn
                    end
                end
            end
        end

        -- TP NEAREST
        local function teleportNearest()
            local nearest = nil
            local minDist = math.huge
            local lc = LocalPlayer.Character
            if not lc then return end
            local lr = lc:FindFirstChild("HumanoidRootPart")
            if not lr then return end

            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    local ch = pl.Character
                    if ch then
                        local r = ch:FindFirstChild("HumanoidRootPart")
                        if r then
                            local d = (lr.Position - r.Position).Magnitude
                            if d < minDist then
                                minDist = d
                                nearest = pl
                            end
                        end
                    end
                end
            end

            if nearest then
                local ch = nearest.Character
                if ch then
                    local r = ch:FindFirstChild("HumanoidRootPart")
                    if r then
                        lr.CFrame = r.CFrame + Vector3.new(0, 2, 0)
                    end
                end
            end
        end

        -- BUTTON EVENTS
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

        flyBtn.MouseButton1Click:Connect(toggleFly)

        aimBtn.MouseButton1Click:Connect(function()
            aimOn = not aimOn
            if aimOn then
                aimBtn.Text = "🎯 AIMBOT: ON"
                aimBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
                RunService.RenderStepped:Connect(doAimbot)
            else
                aimBtn.Text = "🎯 AIMBOT: OFF"
                aimBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
            end
        end)

        speedBtn.MouseButton1Click:Connect(toggleSpeed)
        noclipBtn.MouseButton1Click:Connect(toggleNoclip)
        tpBtn.MouseButton1Click:Connect(teleportNearest)

        closeBtn.MouseButton1Click:Connect(function()
            mainGui:Destroy()
            toggleGui:Destroy()
            for _, r in pairs(rays) do r:Destroy() end
            for pl in pairs(espObjects) do removeESP(pl) end
            if flyBody then flyBody:Destroy() end
        end)

        RunService.RenderStepped:Connect(updateFly)
        RunService.RenderStepped:Connect(updateSpeed)
        RunService.RenderStepped:Connect(updateNoclip)

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
