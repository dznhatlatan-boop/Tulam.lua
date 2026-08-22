-- // TAN HUB: PROTECTED & STABLE VERSION // --
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local _rS = game:GetService("RunService")
local _fG = Instance.new("ScreenGui")
local _fL = Instance.new("TextLabel")

_fG.Name = "FPS"
_fG.Parent = game.CoreGui
_fL.Parent = _fG
_fL.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
_fL.BackgroundTransparency = 0.5
_fL.Position = UDim2.new(0, 10, 0.5, 0)
_fL.Size = UDim2.new(0, 100, 0, 30)
_fL.Font = Enum.Font.SourceSansBold
_fL.TextColor3 = Color3.fromRGB(255, 255, 255)
_fL.TextSize = 20
_fL.Text = "FPS: 60"

_rS.RenderStepped:Connect(function()
    local _fps = math.floor(1 / _rS.RenderStepped:Wait())
    _fL.Text = "FPS: " .. _fps
end)

local _win = OrionLib:MakeWindow({
    Name = "Tan Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TanHub",
    IntroText = "Tan Hub...",
    IntroIcon = "rbxassetid://4483345998",
    CloseBtnPopup = false
})

local _tMain = _win:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local _tVisual = _win:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local _tMusic = _win:MakeTab({Name = "Music", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local _tSettings = _win:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local _pLR = game:GetService("Players").LocalPlayer

-- [ MAIN TAB ]
_tMain:AddToggle({
    Name = "Fly V3 - By Tan",
    Default = false,
    Callback = function(_val)
        if _val then
            pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
        else
            pcall(function()
                for _, _gui in pairs(game.CoreGui:GetChildren()) do
                    if _gui:IsA("ScreenGui") and _gui:FindFirstChild("Frame") and _gui.Frame:FindFirstChild("up") then _gui:Destroy() end
                end
                if _pLR.Character and _pLR.Character:FindFirstChild("Humanoid") then _pLR.Character.Humanoid.PlatformStand = false end
            end)
        end
    end
})

local _speedEn = false
local _speedVal = 1

_tMain:AddToggle({
    Name = "Enable Speed",
    Default = false,
    Callback = function(_val)
        _speedEn = _val
    end
})

_tMain:AddTextbox({
    Name = "Speed Multiplier",
    Default = "1",
    TextDisappear = false,
    Callback = function(_val)
        local _num = tonumber(_val)
        if _num then
            _speedVal = _num
        end
    end
})

_rS.RenderStepped:Connect(function()
    if _speedEn and _pLR.Character and _pLR.Character:FindFirstChild("HumanoidRootPart") then
        local _humanoid = _pLR.Character:FindFirstChildOfClass("Humanoid")
        if _humanoid and _humanoid.MoveDirection.Magnitude > 0 then
            _pLR.Character.HumanoidRootPart.CFrame = _pLR.Character.HumanoidRootPart.CFrame + (_humanoid.MoveDirection * _speedVal)
        end
    end
end)

local _targetPlayer = nil
local _playerList = {}
local function _updatePlrList()
    _playerList = {}
    for _, _v in pairs(game.Players:GetPlayers()) do
        if _v ~= _pLR then table.insert(_playerList, _v.Name) end
    end
    return _playerList
end

local _dropdown = _tMain:AddDropdown({Name = "Player List", Default = "", Options = _updatePlrList(), Callback = function(_val) _targetPlayer = _val end})
_tMain:AddButton({Name = "Teleport", Callback = function() if _targetPlayer and game.Players:FindFirstChild(_targetPlayer) and game.Players[_targetPlayer].Character then _pLR.Character.HumanoidRootPart.CFrame = game.Players[_targetPlayer].Character.HumanoidRootPart.CFrame end end})
_tMain:AddButton({Name = "Refresh List", Callback = function() _dropdown:Refresh(_updatePlrList(), true) end})

-- [ MUSIC TAB ]
local _soundObj = Instance.new("Sound", workspace)
_tMusic:AddTextbox({
    Name = "Enter Sound ID",
    Default = "",
    TextDisappear = true,
    Callback = function(_val)
        _soundObj.SoundId = "rbxassetid://" .. _val
    end
})
_tMusic:AddButton({Name = "Play", Callback = function() _soundObj:Play() end})
_tMusic:AddButton({Name = "Stop", Callback = function() _soundObj:Stop() end})

_tMusic:AddButton({
    Name = "Fix Lag (Boost FPS)",
    Callback = function()
        local _lighting = game:GetService("Lighting")
        _lighting.GlobalShadows = false
        _lighting.FogEnd = 9e9
        for _, _v in pairs(workspace:GetDescendants()) do
            if _v:IsA("Part") or _v:IsA("UnionOperation") or _v:IsA("MeshPart") then
                _v.Material = Enum.Material.SmoothPlastic
                _v.Reflectance = 0
            elseif _v:IsA("Decal") or _v:IsA("Texture") then
                _v.Transparency = 1
            end
        end
        for _, _v in pairs(_lighting:GetChildren()) do
            if _v:IsA("PostEffect") then _v.Enabled = false end
        end
    end
})

-- [ SETTINGS TAB ]
local _noclipState = false
_rS.Stepped:Connect(function()
    if _noclipState and _pLR.Character then
        for _, _v in pairs(_pLR.Character:GetDescendants()) do
            if _v:IsA("BasePart") then _v.CanCollide = false end
        end
    end
end)

_tSettings:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(_val) _noclipState = _val end
})

_tSettings:AddButton({
    Name = "Destroy Menu",
    Callback = function()
        OrionLib:Destroy()
        _fG:Destroy()
        _soundObj:Destroy()
    end
})

-- [ ESP ]
_tVisual:AddToggle({Name = "ESP", Default = false, Callback = function(_val)
    if _val then
        for _, _v in pairs(game.Players:GetPlayers()) do
            if _v ~= _pLR and _v.Character and _v.Character:FindFirstChild("Head") then
                local _espGui = Instance.new("BillboardGui", _v.Character.Head)
                _espGui.Name = "ESP_Tan"
                _espGui.AlwaysOnTop = true
                _espGui.Size = UDim2.new(0, 100, 0, 50)
                local _label = Instance.new("TextLabel", _espGui)
                _label.Size = UDim2.new(1, 0, 1, 0)
                _label.Text = _v.Name
                _label.TextColor3 = Color3.new(1, 1, 1)
                _label.BackgroundTransparency = 1
            end
        end
    else
        for _, _v in pairs(game.Players:GetPlayers()) do
            if _v.Character and _v.Character:FindFirstChild("Head") and _v.Character.Head:FindFirstChild("ESP_Tan") then
                _v.Character.Head.ESP_Tan:Destroy()
            end
        end
    end
end})

OrionLib:Init()
