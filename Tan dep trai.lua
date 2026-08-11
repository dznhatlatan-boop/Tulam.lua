-- ============================================
-- TÂN BÁ ĐẠO (FULL + FLY MENU GIỐNG ẢNH)
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
title.Text = "🔥 TÂN BÁ ĐẠO"
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
activateBtn.Text = "🔥 ACTIVATE"
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
        print("🔥 TÂN BÁ ĐẠO ACTIVATED!")

        -- ============================================
        -- MAIN SCRIPT (FULL + FLY MENU)
        -- ============================================
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Workspace = game:GetService("Workspace")

        local espOn = false
        local rayOn = false
        local flyOn = false
        local selectedTarget = nil
        local espObjects = {}
        local rays = {}
        local flyBody = nil
        local flySpeed = 3

        -- ===== FLY MENU (GIỐNG ẢNH) =====
        local flyGui = Instance.new("ScreenGui")
        flyGui.Name = "FlyMenu"
        flyGui.ResetOnSpawn = false
        flyGui.Parent = LocalPlayer.PlayerGui

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 190, 0, 57)
        mainFrame.Position = UDim2.new(0.1, 0, 0.38, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
        mainFrame.BorderColor3 = Color3.fromRGB(103, 221, 213)
        mainFrame.BorderSizePixel = 1
        mainFrame.Draggable = true
        mainFrame.Active = true
        mainFrame.Parent = flyGui

        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 45, 0, 28)
        closeBtn.Position = UDim2.new(0, 0, -1, 27)
        closeBtn.Text = "X"
        closeBtn.TextColor3 = Color3.new(1, 1, 1)
        closeBtn.TextSize = 30
        closeBtn.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
        closeBtn.Parent = mainFrame

        local minBtn = Instance.new("TextButton")
        minBtn.Size = UDim2.new(0, 45, 0, 28)
        minBtn.Position = UDim2.new(0, 44, -1, 27)
        minBtn.Text = "-"
        minBtn.TextColor3 = Color3.new(1, 1, 1)
        minBtn.TextSize = 40
        minBtn.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
        minBtn.Parent = mainFrame

        local maxBtn = Instance.new("TextButton")
        maxBtn.Size = UDim2.new(0, 45, 0, 28)
        maxBtn.Position = UDim2.new(0, 44, -1, 57)
        maxBtn.Text = "+"
        maxBtn.TextColor3 = Color3.new(1, 1, 1)
        maxBtn.TextSize = 40
        maxBtn.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
        maxBtn.Visible = false
        maxBtn.Parent = mainFrame

        local titleFly = Instance.new("TextLabel")
        titleFly.Size = UDim2.new(0, 100, 0, 28)
        titleFly.Position = UDim2.new(0.47, 0, 0, 0)
        titleFly.Text = "FLY GUI V3"
        titleFly.TextColor3 = Color3.new(0, 0, 0)
        titleFly.TextScaled = true
        titleFly.TextWrapped = true
        titleFly.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
        titleFly.Parent = mainFrame

        local upBtn = Instance.new("TextButton")
        upBtn.Size = UDim2.new(0, 44, 0, 28)
        upBtn.Position = UDim2.new(0, 0, 0, 0)
        upBtn.Text = "UP"
        upBtn.TextColor3 = Color3.new(0, 0, 0)
        upBtn.TextSize = 14
        upBtn.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
        upBtn.Parent = mainFrame

        local downBtn = Instance.new("TextButton")
        downBtn.Size = UDim2.new(0, 44, 0, 28)
        downBtn.Position = UDim2.new(0, 0, 0.49, 0)
        downBtn.Text = "DOWN"
        downBtn.TextColor3 = Color3.new(0, 0, 0)
        downBtn.TextSize = 14
        downBtn.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
        downBtn.Parent = mainFrame

        local plusBtn = Instance.new("TextButton")
        plusBtn.Size = UDim2.new(0, 45, 0, 28)
        plusBtn.Position = UDim2.new(0.23, 0, 0, 0)
        plusBtn.Text = "+"
        plusBtn.TextColor3 = Color3.new(0, 0, 0)
        plusBtn.TextScaled = true
        plusBtn.TextWrapped = true
        plusBtn.TextSize = 14
        plusBtn.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
        plusBtn.Parent = mainFrame

        local minusBtn = Instance.new("TextButton")
        minusBtn.Size = UDim2.new(0, 45, 0, 29)
        minusBtn.Position = UDim2.new(0.23, 0, 0.49, 0)
        minusBtn.Text = "-"
        minusBtn.TextColor3 = Color3.new(0, 0, 0)
        minusBtn.TextScaled = true
        minusBtn.TextWrapped = true
        minusBtn.TextSize = 14
        minusBtn.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
        minusBtn.Parent = mainFrame

        local speedLabel = Instance.new("TextLabel")
        speedLabel.Size = UDim2.new(0, 44, 0, 28)
        speedLabel.Position = UDim2.new(0.47, 0, 0.49, 0)
        speedLabel.Text = "3"
        speedLabel.TextColor3 = Color3.new(0, 0, 0)
        speedLabel.TextScaled = true
        speedLabel.TextWrapped = true
        speedLabel.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
        speedLabel.Parent = mainFrame

        local flyBtn = Instance.new("TextButton")
        flyBtn.Size = UDim2.new(0, 56, 0, 28)
        flyBtn.Position = UDim2.new(0.7, 0, 0.49, 0)
        flyBtn.Text = "fly"
        flyBtn.TextColor3 = Color3.new(0, 0, 0)
        flyBtn.TextSize = 14
        flyBtn.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
        flyBtn.Parent = mainFrame

        -- ===== FLY MENU CHỨC NĂNG =====
        local isMinimized = false
        minBtn.MouseButton1Click:Connect(function()
            isMinimized = true
            upBtn.Visible = false
            downBtn.Visible = false
            flyBtn.Visible = false
            plusBtn.Visible = false
            speedLabel.Visible = false
            minusBtn.Visible = false
            titleFly.Visible = false
            minBtn.Visible = false
            maxBtn.Visible = true
            mainFrame.BackgroundTransparency = 1
            closeBtn.Position = UDim2.new(0, 0, -1, 57)
        end)

        maxBtn.MouseButton1Click:Connect(function()
            isMinimized = false
            upBtn.Visible = true
            downBtn.Visible = true
            flyBtn.Visible = true
            plusBtn.Visible = true
            speedLabel.Visible = true
            minusBtn.Visible = true
            titleFly.Visible = true
            minBtn.Visible = true
            maxBtn.Visible = false
            mainFrame.BackgroundTransparency = 0
            closeBtn.Position = UDim2.new(0, 0, -1, 27)
        end)

        closeBtn.MouseButton1Click:Connect(function()
            flyGui:Destroy()
            if flyBody then flyBody:Destroy() end
        end)

        -- ===== FLY CORE =====
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
                flyBtn.Text = "stop"
                flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            else
                if flyBody then flyBody:Destroy(); flyBody = nil end
                if hum then hum.PlatformStand = false end
                flyBtn.Text = "fly"
                flyBtn.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
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
                    flyBody.Velocity = move * (flySpeed * 10) + Vector3.new(0, 0.5, 0)
                else
                    flyBody.Velocity = Vector3.new(0, 0.5, 0)
                end
            end
        end

        flyBtn.MouseButton1Click:Connect(toggleFly)

        local upHold = false
        upBtn.MouseButton1Down:Connect(function()
            upHold = true
            while upHold and flyOn do
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 1, 0)
                    end
                end
                task.wait(0.05)
            end
        end)
        upBtn.MouseButton1Up:Connect(function()
            upHold = false
        end)

        local downHold = false
        downBtn.MouseButton1Down:Connect(function()
            downHold = true
            while downHold and flyOn do
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, -1, 0)
                    end
                end
                task.wait(0.05)
            end
        end)
        downBtn.MouseButton1Up:Connect(function()
            downHold = false
        end)

        plusBtn.MouseButton1Click:Connect(function()
            flySpeed = flySpeed + 1
            if flySpeed > 10 then flySpeed = 10 end
            speedLabel.Text = flySpeed
        end)

        minusBtn.MouseButton1Click:Connect(function()
            flySpeed = flySpeed - 1
            if flySpeed < 1 then flySpeed = 1 end
            speedLabel.Text = flySpeed
        end)

        RunService.RenderStepped:Connect(updateFly)

        LocalPlayer.CharacterAdded:Connect(function()
            if flyBody then flyBody:Destroy(); flyBody = nil end
            flyOn = false
            flyBtn.Text = "fly"
            flyBtn.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
            upHold = false
            downHold = false
        end)

        -- ===== TOGGLE BUTTON =====
        local toggleGui = Instance.new("ScreenGui")
        toggleGui.Name = "ToggleButton"
        toggleGui.ResetOnSpawn = false
        toggleGui.Parent = LocalPlayer.PlayerGui

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 55, 0, 55)
        toggleBtn.Position = UDim2.new(0.92, -27, 0.8, -27)
        toggleBtn.Text = "🔥"
        toggleBtn.TextScaled = true
        toggleBtn.TextColor3 = Color3.new(0, 1, 1)
        toggleBtn.BackgroundColor3 = Color3.new(0.05, 0.05, 0.1)
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = toggleGui
        Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
        local stroke = Instance.new("UIStroke", toggleBtn)
        stroke.Color = Color3.new(0, 1, 1)
        stroke.Thickness = 2

        -- DRAG
        local dragging = false
        local dragStart = nil
        local startPos = nil

        toggleBtn.MouseButton1Down:Connect(function()
            dragging = true
            dragStart = UserInputService:GetMouseLocation()
            startPos = toggleBtn.Position
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        -- ===== MAIN MENU =====
        local mainGui = Instance.new("ScreenGui")
        mainGui.Name = "Menu"
        mainGui.ResetOnSpawn = false
        mainGui.Parent = LocalPlayer.PlayerGui

        local mainFrame2 = Instance.new("Frame")
        mainFrame2.Size = UDim2.new(0, 220, 0, 280)
        mainFrame2.Position = UDim2.new(0.5, -110, 0.5, -140)
        mainFrame2.BackgroundColor3 = Color3.new(0, 0, 0)
        mainFrame2.BackgroundTransparency = 0.2
        mainFrame2.BorderSizePixel = 0
        mainFrame2.Visible = false
        mainFrame2.Parent = mainGui
        Instance.new("UICorner", mainFrame2).CornerRadius = UDim.new(0, 8)

        local title2 = Instance.new("TextLabel")
        title2.Size = UDim2.new(1, 0, 0, 40)
        title2.Text = "🔥 tân bá đạo"
        title2.TextColor3 = Color3.new(1, 1, 1)
        title2.TextScaled = true
        title2.Font = Enum.Font.GothamBold
        title2.BackgroundTransparency = 1
        title2.Parent = mainFrame2

        local function makeBtn(name, y, color)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.85, 0, 0, 30)
            btn.Position = UDim2.new(0.075, 0, y, 0)
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundColor3 = color or Color3.new(0.2, 0.6, 0.2)
            btn.BorderSizePixel = 0
            btn.Parent = mainFrame2
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            return btn
        end

        local rayBtn = makeBtn("🔴 RAY: OFF", 0.10)
        local espBtn = makeBtn("🔵 ESP: OFF", 0.22)
        local tpBtn = makeBtn("🟢 TP: SELECT", 0.34)
        local closeBtn2 = makeBtn("✕ CLOSE", 0.60, Color3.new(0.5, 0.1, 0.1))

        toggleBtn.MouseButton1Click:Connect(function()
            mainFrame2.Visible = not mainFrame2.Visible
        end)

        -- PLAYER LIST
        local playerListFrame = Instance.new("ScrollingFrame")
        playerListFrame.Size = UDim2.new(0.85, 0, 0, 70)
        playerListFrame.Position = UDim2.new(0.075, 0, 0.46, 0)
        playerListFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
        playerListFrame.BorderSizePixel = 0
        playerListFrame.Parent = mainFrame2
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
                    btn.Size = UDim2.new(1, -10, 0, 22)
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
                    y = y + 26
                end
            end
            playerListFrame.CanvasSize = UDim2.new(0, 0, 0, y + 10)
        end

        -- TP NOW
        local tpNowBtn = Instance.new("TextButton")
        tpNowBtn.Size = UDim2.new(0.4, 0, 0, 25)
        tpNowBtn.Position = UDim2.new(0.3, 0, 0.60, 0)
        tpNowBtn.Text = "🚀 TP NOW"
        tpNowBtn.TextColor3 = Color3.new(1, 1, 1)
        tpNowBtn.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
        tpNowBtn.Parent = mainFrame2
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
            h.FillC
