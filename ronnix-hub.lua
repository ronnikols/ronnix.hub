local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    Players.PlayerAdded:Wait()
    localPlayer = Players.LocalPlayer
end

if _G.RONNIXHUB and typeof(_G.RONNIXHUB.ScreenGui) == "Instance" and _G.RONNIXHUB.ScreenGui.Parent then
    _G.RONNIXHUB.ScreenGui:Destroy()
end
_G.RONNIXHUB = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RONNIXHUB"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")
_G.RONNIXHUB.ScreenGui = ScreenGui

local ExpandButton = Instance.new("TextButton")
ExpandButton.Name = "ExpandButton"
ExpandButton.Text = ">"
ExpandButton.Font = Enum.Font.GothamBold
ExpandButton.TextSize = 16
ExpandButton.TextColor3 = Color3.fromRGB(0, 200, 255)
ExpandButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ExpandButton.BorderSizePixel = 0
ExpandButton.Size = UDim2.new(0, 30, 0, 30)
ExpandButton.Position = UDim2.new(1, -40, 0, 10)
ExpandButton.Visible = false
ExpandButton.Parent = ScreenGui

local ExpandCorner = Instance.new("UICorner")
ExpandCorner.CornerRadius = UDim.new(0, 8)
ExpandCorner.Parent = ExpandButton

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 400, 0, 480)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "RONNIX HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "Minimize"
MinimizeButton.Text = "_"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "Close"
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.BackgroundTransparency = 1
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Parent = TopBar

local function setupButtonHover(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {TextColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {TextColor3 = normalColor}):Play()
    end)
end

setupButtonHover(MinimizeButton, Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200))
setupButtonHover(CloseButton, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 100, 100))

local originalSize = UDim2.new(0, 400, 0, 480)
local function minimizeGUI()
    local tween = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    tween:Play()
    
    tween.Completed:Wait()
    MainFrame.Visible = false
    ExpandButton.Visible = true
end

local function expandGUI()
    ExpandButton.Visible = false
    MainFrame.Visible = true
    local tween = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = originalSize}
    )
    tween:Play()
end

MinimizeButton.MouseButton1Click:Connect(minimizeGUI)
ExpandButton.MouseButton1Click:Connect(expandGUI)

local purple_isBombActive = false
local purple_playerStates = {}
local purple_masterConnection = nil

_G.StopPurpleBomb = function()
    if purple_masterConnection then
        purple_masterConnection:Disconnect()
        purple_masterConnection = nil
    end
    purple_isBombActive = false
    print("Purple Bomb: Остановлена.")
end

CloseButton.MouseButton1Click:Connect(function()
    if _G.stopFarmingFarm then _G.stopFarmingFarm() end
    if _G.StopPurpleBomb then _G.StopPurpleBomb() end
    ScreenGui:Destroy()
    if _G.BringConnection then _G.BringConnection:Disconnect() end
    if _G.OrbitConnection then _G.OrbitConnection:Disconnect() end
    if _G.AutoClickerConnection then _G.AutoClickerConnection:Disconnect() end
    _G.BringActive = false
    _G.OrbitActive = false
    _G.AutoClickerActive = false
end)

local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -20, 0, 30)
TabButtons.Position = UDim2.new(0, 10, 0, 35)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local UIListLayoutTabs = Instance.new("UIListLayout")
UIListLayoutTabs.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutTabs.Padding = UDim.new(0, 10)
UIListLayoutTabs.Parent = TabButtons

local TabContainer = Instance.new("Frame")
TabContainer.Name = "Tabs"
TabContainer.Size = UDim2.new(1, -20, 1, -75)
TabContainer.Position = UDim2.new(0, 10, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local tabs = {"Main", "Settings", "Farm Bot", "Purple Bomb"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName.."Tab"
    TabButton.Text = tabName
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 13
    TabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    TabButton.AutoButtonColor = false
    TabButton.Size = UDim2.new(0.25, -8, 1, 0)
    TabButton.Parent = TabButtons
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = TabButton
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = tabName
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.ScrollBarThickness = 6
    TabFrame.Visible = false
    TabFrame.Parent = TabContainer
    
    local UIListLayoutFrame = Instance.new("UIListLayout")
    UIListLayoutFrame.Padding = UDim.new(0, 8)
    UIListLayoutFrame.Parent = TabFrame
    
    tabFrames[tabName] = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
        
        for _, btn in ipairs(TabButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(
                    btn,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = Color3.fromRGB(45, 45, 60), TextColor3 = Color3.fromRGB(180, 180, 200)}
                ):Play()
            end
        end
        TweenService:Create(
            TabButton,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 150, 200), TextColor3 = Color3.fromRGB(255, 255, 255)}
        ):Play()
    end)
end

tabFrames[tabs[1]].Visible = true
local firstTabButton = TabButtons:FindFirstChild(tabs[1].."Tab")
if firstTabButton then
    firstTabButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    firstTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local mainFrame = tabFrames.Main

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "PLAYER CONTROL SYSTEM"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Parent = mainFrame

local PlayersFrame = Instance.new("ScrollingFrame")
PlayersFrame.Name = "PlayersList"
PlayersFrame.Size = UDim2.new(1, 0, 0, 150)
PlayersFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
PlayersFrame.BorderSizePixel = 0
PlayersFrame.ScrollBarThickness = 4
PlayersFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayersFrame.Parent = mainFrame

local PlayersLayout = Instance.new("UIListLayout")
PlayersLayout.Padding = UDim.new(0, 5)
PlayersLayout.Parent = PlayersFrame

local BringButton = Instance.new("TextButton")
BringButton.Name = "BringButton"
BringButton.Text = "START BRINGING"
BringButton.Font = Enum.Font.GothamBold
BringButton.TextSize = 14
BringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BringButton.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
BringButton.AutoButtonColor = false
BringButton.Size = UDim2.new(0.49, 0, 0, 40)
BringButton.Position = UDim2.new(0, 0, 0, 190)
BringButton.Parent = mainFrame

local BringCorner = Instance.new("UICorner")
BringCorner.CornerRadius = UDim.new(0, 6)
BringCorner.Parent = BringButton

local OrbitButton = Instance.new("TextButton")
OrbitButton.Name = "OrbitButton"
OrbitButton.Text = "START ORBITING"
OrbitButton.Font = Enum.Font.GothamBold
OrbitButton.TextSize = 14
OrbitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OrbitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
OrbitButton.AutoButtonColor = false
OrbitButton.Size = UDim2.new(0.49, 0, 0, 40)
OrbitButton.Position = UDim2.new(0.51, 0, 0, 190)
OrbitButton.Parent = mainFrame

local OrbitCorner = Instance.new("UICorner")
OrbitCorner.CornerRadius = UDim.new(0, 6)
OrbitCorner.Parent = OrbitButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "Status"
StatusLabel.Text = "Status: Inactive"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 13
StatusLabel.TextColor3 = Color3.fromRGB(200, 150, 150)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 240)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = mainFrame

_G.BringTargetPlayer = nil
_G.OrbitTargetPlayer = nil
_G.BringActive = false
_G.OrbitActive = false
_G.BringConnection = nil
_G.OrbitConnection = nil
_G.OrbitAngle = 0
_G.OrbitRadius = 5
_G.OrbitSpeed = 2
_G.OriginalCollisionState = {}
_G.AutoClickerActive = false
_G.AutoClickerSpeed = 10
_G.AutoClickerConnection = nil
_G.LastClickTime = 0

local function setPlayerCollision(player, enable)
    if not player or not player.Character then return end
    
    local character = player.Character
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if enable then
                if _G.OriginalCollisionState[part] ~= nil then
                    part.CanCollide = _G.OriginalCollisionState[part]
                end
            else
                _G.OriginalCollisionState[part] = part.CanCollide
                part.CanCollide = false
            end
        end
    end
end

local function bringPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    
    local humanoidRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local humanoid = targetChar:FindFirstChild("Humanoid")
    
    if humanoidRoot and localRoot and humanoid then
        local forwardDirection = localRoot.CFrame.LookVector
        local targetPosition = localRoot.Position + 
                              (forwardDirection * 4) +
                              (localRoot.CFrame.RightVector * 2)
        
        local newCFrame = CFrame.new(targetPosition) * CFrame.Angles(0, localRoot.CFrame:ToEulerAnglesXYZ())
        humanoidRoot.CFrame = newCFrame
        
        humanoid.PlatformStand = true
        task.wait(0.05)
        humanoid.PlatformStand = false
    end
end

local function updateOrbit(dt)
    if not _G.OrbitActive or not _G.OrbitTargetPlayer then return end
    local targetChar = _G.OrbitTargetPlayer.Character
    local localChar = localPlayer.Character
    if not targetChar or not localChar then return end

    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return end

    _G.OrbitAngle = (_G.OrbitAngle or 0) + _G.OrbitSpeed * dt
    
    local offset = Vector3.new(math.cos(_G.OrbitAngle) * _G.OrbitRadius, 0, math.sin(_G.OrbitAngle) * _G.OrbitRadius)
    local newPosition = targetRoot.Position + offset
    
    newPosition = Vector3.new(newPosition.X, targetRoot.Position.Y, newPosition.Z)
    
    localRoot.CFrame = CFrame.new(newPosition, targetRoot.Position)
end

local function startBringLoop()
    if _G.BringConnection then _G.BringConnection:Disconnect() end
    _G.BringConnection = RunService.Heartbeat:Connect(function()
        if _G.BringActive and _G.BringTargetPlayer then
            pcall(function() bringPlayer(_G.BringTargetPlayer) end)
        end
    end)
end

local function startOrbitLoop()
    if _G.OrbitConnection then _G.OrbitConnection:Disconnect() end
    _G.OrbitConnection = RunService.Heartbeat:Connect(function(dt)
        if _G.OrbitActive and _G.OrbitTargetPlayer then
            pcall(function() updateOrbit(dt) end)
        end
    end)
end

BringButton.MouseButton1Click:Connect(function()
    if not _G.BringTargetPlayer then
        TweenService:Create(BringButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        BringButton.Text = "SELECT PLAYER!"
        task.wait(1)
        TweenService:Create(BringButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        BringButton.Text = "START BRINGING"
        return
    end
    
    if _G.OrbitActive then
        _G.OrbitActive = false
        setPlayerCollision(localPlayer, true)
        if _G.OrbitConnection then _G.OrbitConnection:Disconnect() end
        TweenService:Create(OrbitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        OrbitButton.Text = "START ORBITING"
    end
    
    _G.BringActive = not _G.BringActive
    
    if _G.BringActive then
        setPlayerCollision(_G.BringTargetPlayer, false)
        TweenService:Create(BringButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        BringButton.Text = "STOP BRINGING"
        StatusLabel.Text = "Status: Bringing ".._G.BringTargetPlayer.Name
        StatusLabel.TextColor3 = Color3.fromRGB(50, 200, 100)
        startBringLoop()
    else
        setPlayerCollision(_G.BringTargetPlayer, true)
        TweenService:Create(BringButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        BringButton.Text = "START BRINGING"
        StatusLabel.Text = "Status: Inactive"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 150, 150)
        if _G.BringConnection then _G.BringConnection:Disconnect() end
    end
end)

OrbitButton.MouseButton1Click:Connect(function()
    if not _G.OrbitTargetPlayer then
        TweenService:Create(OrbitButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        OrbitButton.Text = "SELECT PLAYER!"
        task.wait(1)
        TweenService:Create(OrbitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        OrbitButton.Text = "START ORBITING"
        return
    end
    
    if _G.BringActive then
        _G.BringActive = false
        setPlayerCollision(_G.BringTargetPlayer, true)
        if _G.BringConnection then _G.BringConnection:Disconnect() end
        TweenService:Create(BringButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        BringButton.Text = "START BRINGING"
    end
    
    _G.OrbitActive = not _G.OrbitActive
    
    if _G.OrbitActive then
        setPlayerCollision(localPlayer, false)
        TweenService:Create(OrbitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        OrbitButton.Text = "STOP ORBITING"
        StatusLabel.Text = "Status: Orbiting ".._G.OrbitTargetPlayer.Name
        StatusLabel.TextColor3 = Color3.fromRGB(50, 200, 100)
        startOrbitLoop()
    else
        setPlayerCollision(localPlayer, true)
        TweenService:Create(OrbitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
        OrbitButton.Text = "START ORBITING"
        StatusLabel.Text = "Status: Inactive"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 150, 150)
        if _G.OrbitConnection then _G.OrbitConnection:Disconnect() end
    end
end)

local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Name = "Player_"..player.UserId
    button.Text = player.Name
    button.Font = Enum.Font.Gotham
    button.TextSize = 13
    button.TextColor3 = Color3.fromRGB(220, 220, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    button.AutoButtonColor = false
    button.Size = UDim2.new(1, -10, 0, 25)
    button.Parent = PlayersFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        for _, btn in ipairs(PlayersFrame:GetChildren()) do
            if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70) end
        end
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        _G.BringTargetPlayer = player
        _G.OrbitTargetPlayer = player
        StatusLabel.Text = "Selected: "..player.Name
        StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    end)
    return button
end

local function updateMainTabPlayersList()
    for _, child in ipairs(PlayersFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then createPlayerButton(player) end
    end
    PlayersFrame.CanvasSize = UDim2.new(0, 0, 0, PlayersLayout.AbsoluteContentSize.Y)
end

local settingsFrame = tabFrames.Settings

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Text = "ORBIT SETTINGS"
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 16
settingsTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Size = UDim2.new(1, 0, 0, 30)
settingsTitle.Parent = settingsFrame

local function createMobileSlider(parent, label, min, max, current, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Text = label
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 14
    sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Size = UDim2.new(0.4, 0, 0.5, 0)
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(0.6, 0, 0, 12)
    sliderBackground.Position = UDim2.new(0.4, 0, 0.5, -6)
    sliderBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderBackground.Parent = sliderFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = sliderBackground
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((current - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.Parent = sliderBackground
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Text = ""
    sliderButton.AutoButtonColor = false
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Size = UDim2.new(0, 24, 0, 24)
    sliderButton.Position = UDim2.new(sliderFill.Size.X.Scale, 0, 0.5, -12)
    sliderButton.ZIndex = 2
    sliderButton.Parent = sliderBackground
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = sliderButton
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Text = string.format("%.1f", current)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(1, 0, 0.5, 0)
    valueLabel.Position = UDim2.new(0, 0, 0.5, 0)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = sliderFrame
    
    local function updateSlider(value)
        value = math.clamp(value, min, max)
        local fraction = (value - min) / (max - min)
        sliderFill.Size = UDim2.new(fraction, 0, 1, 0)
        sliderButton.Position = UDim2.new(fraction, 0, 0.5, -12)
        valueLabel.Text = string.format("%.1f", value)
        if callback then callback(value) end
    end
    
    local sliderDragging = false
    local function onInput(input)
        if sliderDragging then
            local relX = (input.Position.X - sliderBackground.AbsolutePosition.X)
            local frac = math.clamp(relX / sliderBackground.AbsoluteSize.X, 0, 1)
            local newVal = min + frac * (max - min)
            updateSlider(newVal)
        end
    end

    sliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then sliderDragging = true end end)
    sliderBackground.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then sliderDragging = true; onInput(input) end end)
    UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then onInput(input) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then sliderDragging = false end end)
    
    updateSlider(current)
    return sliderFill, sliderButton, valueLabel
end

local orbitSliderFill, orbitSliderButton = createMobileSlider(settingsFrame, "Orbit Radius:", 1, 50, _G.OrbitRadius, function(value)
    _G.OrbitRadius = value
end)

local autoClickerTitle = Instance.new("TextLabel")
autoClickerTitle.Text = "AUTO CLICKER SETTINGS"
autoClickerTitle.Font = Enum.Font.GothamBold
autoClickerTitle.TextSize = 16
autoClickerTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
autoClickerTitle.BackgroundTransparency = 1
autoClickerTitle.Size = UDim2.new(1, 0, 0, 30)
autoClickerTitle.Parent = settingsFrame

local autoClickerButton = Instance.new("TextButton")
autoClickerButton.Name = "AutoClickerButton"
autoClickerButton.Text = "AUTOCLICKER: OFF"
autoClickerButton.Font = Enum.Font.GothamBold
autoClickerButton.TextSize = 14
autoClickerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoClickerButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
autoClickerButton.Size = UDim2.new(1, 0, 0, 35)
autoClickerButton.Parent = settingsFrame

local acCorner = Instance.new("UICorner")
acCorner.CornerRadius = UDim.new(0, 6)
acCorner.Parent = autoClickerButton

local clickerSliderFill, clickerSliderButton, clickerValueLabel = createMobileSlider(settingsFrame, "Click Speed (CPS):", 1, 50, _G.AutoClickerSpeed, function(value)
    _G.AutoClickerSpeed = value
end)

local function isMouseOverGui()
    local mouseLocation = UserInputService:GetMouseLocation()
    local objects = game:GetService("PlayerGui"):GetGuiObjectsAtPosition(mouseLocation.X, mouseLocation.Y)
    for _, obj in ipairs(objects) do
        if obj:IsDescendantOf(ScreenGui) then
            return true
        end
    end
    return false
end

local function startAutoClicker()
    if _G.AutoClickerConnection then _G.AutoClickerConnection:Disconnect() end
    _G.AutoClickerConnection = RunService.RenderStepped:Connect(function()
        if _G.AutoClickerActive then 
            if (tick() - _G.LastClickTime) >= (1 / _G.AutoClickerSpeed) then
                _G.LastClickTime = tick()
                
                local viewportSize = workspace.CurrentCamera.ViewportSize
                local centerX = viewportSize.X / 2
                local centerY = viewportSize.Y / 2
                
                pcall(function()
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                end)
            end
        end
    end)
end

autoClickerButton.MouseButton1Click:Connect(function()
    _G.AutoClickerActive = not _G.AutoClickerActive
    if _G.AutoClickerActive then
        autoClickerButton.Text = "AUTOCLICKER: ON"
        TweenService:Create(autoClickerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 50)}):Play()
        startAutoClicker()
    else
        autoClickerButton.Text = "AUTOCLICKER: OFF"
        TweenService:Create(autoClickerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        if _G.AutoClickerConnection then _G.AutoClickerConnection:Disconnect() end
    end
end)

local themes = {
    {name = "Neon Blue", colors = {background=Color3.fromRGB(30,30,40),topBar=Color3.fromRGB(25,25,35),accent=Color3.fromRGB(0,200,255),buttons=Color3.fromRGB(0,120,180),text=Color3.fromRGB(220,220,255)}},
    {name = "Crimson Red", colors = {background=Color3.fromRGB(40,20,25),topBar=Color3.fromRGB(35,15,20),accent=Color3.fromRGB(255,50,80),buttons=Color3.fromRGB(180,40,60),text=Color3.fromRGB(255,200,200)}},
    {name = "Emerald Green", colors = {background=Color3.fromRGB(20,35,25),topBar=Color3.fromRGB(15,30,20),accent=Color3.fromRGB(0,220,120),buttons=Color3.fromRGB(0,160,90),text=Color3.fromRGB(200,255,220)}},
    {name = "Royal Purple", colors = {background=Color3.fromRGB(30,20,40),topBar=Color3.fromRGB(25,15,35),accent=Color3.fromRGB(170,0,255),buttons=Color3.fromRGB(130,0,200),text=Color3.fromRGB(220,200,255)}},
    {name = "Sunset Orange", colors = {background=Color3.fromRGB(40,25,20),topBar=Color3.fromRGB(35,20,15),accent=Color3.fromRGB(255,120,0),buttons=Color3.fromRGB(200,90,0),text=Color3.fromRGB(255,220,200)}},
    {name = "Cyber Pink", colors = {background=Color3.fromRGB(35,20,35),topBar=Color3.fromRGB(30,15,30),accent=Color3.fromRGB(255,0,170),buttons=Color3.fromRGB(200,0,130),text=Color3.fromRGB(255,200,240)}},
    {name = "Aqua Marine", colors = {background=Color3.fromRGB(20,30,35),topBar=Color3.fromRGB(15,25,30),accent=Color3.fromRGB(0,220,220),buttons=Color3.fromRGB(0,160,160),text=Color3.fromRGB(200,255,255)}},
    {name = "Gold Luxe", colors = {background=Color3.fromRGB(35,30,20),topBar=Color3.fromRGB(30,25,15),accent=Color3.fromRGB(255,200,0),buttons=Color3.fromRGB(200,160,0),text=Color3.fromRGB(255,240,200)}},
    {name = "Ice Blue", colors = {background=Color3.fromRGB(25,30,40),topBar=Color3.fromRGB(20,25,35),accent=Color3.fromRGB(100,200,255),buttons=Color3.fromRGB(70,150,200),text=Color3.fromRGB(220,240,255)}},
    {name = "Mystic Purple", colors = {background=Color3.fromRGB(25,20,35),topBar=Color3.fromRGB(20,15,30),accent=Color3.fromRGB(180,100,255),buttons=Color3.fromRGB(150,80,200),text=Color3.fromRGB(230,220,255)}},
    {name = "Forest Green", colors = {background=Color3.fromRGB(20,30,20),topBar=Color3.fromRGB(15,25,15),accent=Color3.fromRGB(0,180,80),buttons=Color3.fromRGB(0,140,60),text=Color3.fromRGB(200,255,220)}},
    {name = "Lava Red", colors = {background=Color3.fromRGB(35,20,20),topBar=Color3.fromRGB(30,15,15),accent=Color3.fromRGB(255,80,40),buttons=Color3.fromRGB(200,60,30),text=Color3.fromRGB(255,220,200)}},
    {name = "Ocean Blue", colors = {background=Color3.fromRGB(15,25,35),topBar=Color3.fromRGB(10,20,30),accent=Color3.fromRGB(0,150,220),buttons=Color3.fromRGB(0,110,170),text=Color3.fromRGB(200,230,255)}},
    {name = "Sun Yellow", colors = {background=Color3.fromRGB(35,30,15),topBar=Color3.fromRGB(30,25,10),accent=Color3.fromRGB(255,220,0),buttons=Color3.fromRGB(200,180,0),text=Color3.fromRGB(255,250,200)}},
    {name = "Rose Gold", colors = {background=Color3.fromRGB(35,25,30),topBar=Color3.fromRGB(30,20,25),accent=Color3.fromRGB(255,150,180),buttons=Color3.fromRGB(200,120,150),text=Color3.fromRGB(255,230,240)}},
    {name = "Electric Blue", colors = {background=Color3.fromRGB(15,20,35),topBar=Color3.fromRGB(10,15,30),accent=Color3.fromRGB(0,180,255),buttons=Color3.fromRGB(0,140,200),text=Color3.fromRGB(200,230,255)}},
    {name = "Neon Green", colors = {background=Color3.fromRGB(20,35,20),topBar=Color3.fromRGB(15,30,15),accent=Color3.fromRGB(100,255,100),buttons=Color3.fromRGB(70,200,70),text=Color3.fromRGB(220,255,220)}},
    {name = "Deep Space", colors = {background=Color3.fromRGB(10,10,20),topBar=Color3.fromRGB(5,5,15),accent=Color3.fromRGB(150,100,255),buttons=Color3.fromRGB(120,80,200),text=Color3.fromRGB(220,220,255)}},
    {name = "Candy Pink", colors = {background=Color3.fromRGB(35,20,30),topBar=Color3.fromRGB(30,15,25),accent=Color3.fromRGB(255,100,180),buttons=Color3.fromRGB(220,80,150),text=Color3.fromRGB(255,230,240)}},
    {name = "Midnight Blue", colors = {background=Color3.fromRGB(10,15,25),topBar=Color3.fromRGB(5,10,20),accent=Color3.fromRGB(50,150,255),buttons=Color3.fromRGB(40,120,200),text=Color3.fromRGB(200,220,255)}}
}

local currentTheme = 1

local farm_nameLabel, farm_nameDisplay, farm_setBtn, farm_farmBtn, resetLabel, sliderButton, marker
local farming
local abilityViewers = {}

local function applyTheme(themeIndex)
    currentTheme = themeIndex
    local theme = themes[themeIndex].colors
    
    MainFrame.BackgroundColor3 = theme.background
    TopBar.BackgroundColor3 = theme.topBar
    Title.TextColor3 = theme.accent
    
    for _, tabName in ipairs(tabs) do
        local tabButton = TabButtons:FindFirstChild(tabName.."Tab")
        if tabButton then
            if tabFrames[tabName].Visible then tabButton.BackgroundColor3 = theme.accent
            else tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60) end
            tabButton.TextColor3 = theme.text
        end
    end
    
    BringButton.BackgroundColor3 = theme.buttons
    OrbitButton.BackgroundColor3 = theme.buttons
    
    if PlayersFrame then
        PlayersFrame.BackgroundColor3 = theme.topBar
        for _, playerButton in ipairs(PlayersFrame:GetChildren()) do
            if playerButton:IsA("TextButton") then
                playerButton.TextColor3 = theme.text
                local player = Players:FindFirstChild(string.sub(playerButton.Name, 7))
                if player == _G.BringTargetPlayer or player == _G.OrbitTargetPlayer then
                    playerButton.BackgroundColor3 = theme.accent
                else
                    playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
            end
        end
    end

    if orbitSliderFill then orbitSliderFill.BackgroundColor3 = theme.accent end
    if clickerSliderFill then clickerSliderFill.BackgroundColor3 = theme.accent end
    if clickerValueLabel then clickerValueLabel.TextColor3 = theme.accent end
    
    titleLabel.TextColor3 = theme.accent
    settingsTitle.TextColor3 = theme.accent
    autoClickerTitle.TextColor3 = theme.accent
	if abilityViewerTitle then abilityViewerTitle.TextColor3 = theme.accent end
    
    if farm_nameLabel then farm_nameLabel.TextColor3 = theme.accent end
    if farm_nameDisplay then farm_nameDisplay.TextColor3 = theme.text end
    if farm_setBtn then farm_setBtn.BackgroundColor3 = theme.buttons end
    if farm_farmBtn then
        if farming then farm_farmBtn.BackgroundColor3 = theme.accent
        else farm_farmBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30) end
    end
    if resetLabel then resetLabel.TextColor3 = theme.accent end
    if sliderButton then sliderButton.BackgroundColor3 = theme.accent end
    
    if marker then
        marker.Color = theme.accent
        if marker:FindFirstChild("PointLight") then marker.PointLight.Color = theme.accent end
    end
	
	for _, viewer in pairs(abilityViewers) do
        if viewer and viewer:FindFirstChild("AbilityName") then
            viewer.AbilityName.TextColor3 = theme.accent
        end
    end

    if purple_Title then purple_Title.TextColor3 = theme.accent end
    if purple_Info then purple_Info.TextColor3 = theme.text end
    if purple_PlayersFrame then
        purple_PlayersFrame.BackgroundColor3 = theme.topBar
        for _, playerButton in ipairs(purple_PlayersFrame:GetChildren()) do
            if playerButton:IsA("TextButton") then
                playerButton.TextColor3 = theme.text
                local player = Players:FindFirstChild(playerButton.Name)
                if player then
                    local currentState = purple_playerStates[player] or 0
                    if currentState == 1 then playerButton.BackgroundColor3 = Color3.fromRGB(180, 80, 0)
                    elseif currentState == 2 then playerButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
                    else playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70) end
                else
                    playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
            end
        end
    end
    
    if purple_ToggleButton then
        purple_ToggleButton.TextColor3 = theme.text
        if purple_isBombActive then
            purple_ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        else
            purple_ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end
end

local abilityViewerTitle = Instance.new("TextLabel")
abilityViewerTitle.Text = "ABILITY VIEWER"
abilityViewerTitle.Font = Enum.Font.GothamBold
abilityViewerTitle.TextSize = 16
abilityViewerTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
abilityViewerTitle.BackgroundTransparency = 1
abilityViewerTitle.Size = UDim2.new(1, 0, 0, 30)
abilityViewerTitle.Parent = settingsFrame

local abilityViewerToggleButton = Instance.new("TextButton")
abilityViewerToggleButton.Name = "AbilityViewerToggle"
abilityViewerToggleButton.Text = "ABILITY VIEWER: ON"
abilityViewerToggleButton.Font = Enum.Font.GothamBold
abilityViewerToggleButton.TextSize = 14
abilityViewerToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
abilityViewerToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
abilityViewerToggleButton.Size = UDim2.new(1, 0, 0, 35)
abilityViewerToggleButton.Parent = settingsFrame

local avCorner = Instance.new("UICorner")
avCorner.CornerRadius = UDim.new(0, 6)
avCorner.Parent = abilityViewerToggleButton

local isViewerActive = true

local function updateAbilityViewer(player)
    if not abilityViewers[player] then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "AbilityViewer"
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
        billboardGui.AlwaysOnTop = true
        
        local textLabel = Instance.new("TextLabel", billboardGui)
        textLabel.Name = "AbilityName"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 16
        textLabel.TextStrokeTransparency = 0
        textLabel.TextColor3 = themes[currentTheme].colors.accent
        
        abilityViewers[player] = billboardGui
    end

    local billboardGui = abilityViewers[player]
    local character = player.Character

    if character and character:FindFirstChild("Head") then
        local head = character.Head
        if billboardGui.Adornee ~= head then
            billboardGui.Adornee = head
            billboardGui.Parent = head
        end
        
        billboardGui.Enabled = true

        local textLabel = billboardGui:FindFirstChild("AbilityName")
        if textLabel then
            local currentTool = character:FindFirstChildOfClass("Tool")
            if not currentTool then
                local backpack = player:FindFirstChildOfClass("Backpack")
                if backpack then
                    currentTool = backpack:FindFirstChildOfClass("Tool")
                end
            end
            
            if currentTool then
                textLabel.Text = currentTool.Name
            else
                textLabel.Text = ""
            end
        end
    else
        billboardGui.Enabled = false
    end
end

local function destroyAllViewers()
    for player, viewer in pairs(abilityViewers) do
        if viewer then
            viewer:Destroy()
        end
    end
    abilityViewers = {}
end

abilityViewerToggleButton.MouseButton1Click:Connect(function()
    isViewerActive = not isViewerActive
    if isViewerActive then
        abilityViewerToggleButton.Text = "ABILITY VIEWER: ON"
        TweenService:Create(abilityViewerToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 50)}):Play()
    else
        abilityViewerToggleButton.Text = "ABILITY VIEWER: OFF"
        TweenService:Create(abilityViewerToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)}):Play()
        destroyAllViewers()
    end
end)

RunService.RenderStepped:Connect(function()
    if not isViewerActive then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            pcall(updateAbilityViewer, player)
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if abilityViewers[player] then
        abilityViewers[player]:Destroy()
        abilityViewers[player] = nil
    end
end)

local themeLabel = Instance.new("TextLabel")
themeLabel.Text = "GUI THEMES"
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextSize = 16
themeLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
themeLabel.BackgroundTransparency = 1
themeLabel.Size = UDim2.new(1, 0, 0, 30)
themeLabel.Parent = settingsFrame

local themeScroller = Instance.new("ScrollingFrame")
themeScroller.Size = UDim2.new(1, 0, 0, 180)
themeScroller.BackgroundTransparency = 1
themeScroller.ScrollBarThickness = 6
themeScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
themeScroller.Parent = settingsFrame

local themeListLayout = Instance.new("UIListLayout")
themeListLayout.Padding = UDim.new(0, 5)
themeListLayout.Parent = themeScroller

for i, theme in ipairs(themes) do
    local themeButton = Instance.new("TextButton")
    themeButton.Text = theme.name
    themeButton.Size = UDim2.new(1, -10, 0, 30)
    themeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    themeButton.TextColor3 = Color3.new(1,1,1)
    themeButton.Font = Enum.Font.Gotham
    themeButton.TextSize = 14
    themeButton.Parent = themeScroller
    
    local themeCorner = Instance.new("UICorner")
    themeCorner.CornerRadius = UDim.new(0, 
