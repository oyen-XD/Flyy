-- FlyyGUI_Loader.lua - Main Loader with Key System
-- Execute script ini dari GitHub

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

repeat task.wait() until localPlayer:FindFirstChild("PlayerGui")

-- ============================
-- LOAD KEY SYSTEM MODULE
-- ============================
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/oyen-XD/Flyy/main/KeySystem.lua"))()

print("🔐 FlyyGUI - Loading Key System...")

-- ============================
-- CHECK IF ALREADY ACTIVATED
-- ============================
if KeySystem.IsActivated() then
    print("✅ License already activated! Loading GUI...")
    
    -- Load main GUI
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oyen-XD/Flyy/main/FlyyGUI.lua"))()
    return
end

print("⚠️ License not found. Please activate.")

-- ============================
-- CREATE KEY INPUT UI
-- ============================
local function new(class, props)
    local inst = Instance.new(class)
    for k,v in pairs(props or {}) do inst[k] = v end
    return inst
end

-- Colors
local colors = {
    primary = Color3.fromRGB(138, 43, 226),
    secondary = Color3.fromRGB(72, 61, 139),
    success = Color3.fromRGB(34, 197, 94),
    danger = Color3.fromRGB(239, 68, 68),
    bg1 = Color3.fromRGB(10, 10, 10),
    bg2 = Color3.fromRGB(18, 18, 18),
    bg3 = Color3.fromRGB(25, 25, 25),
    text = Color3.fromRGB(255, 255, 255),
    textDim = Color3.fromRGB(180, 180, 180)
}

local gui = new("ScreenGui", {
    Name = "FlyyGUI_KeySystem",
    Parent = localPlayer.PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Main Frame
local mainFrame = new("Frame", {
    Parent = gui,
    Size = UDim2.new(0, 450, 0, 500),
    Position = UDim2.new(0.5, -225, 0.5, -250),
    BackgroundColor3 = colors.bg1,
    BorderSizePixel = 0,
    ZIndex = 1
})
new("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 16)})

-- Gradient Background
local gradient = new("UIGradient", {
    Parent = mainFrame,
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colors.primary),
        ColorSequenceKeypoint.new(1, colors.secondary)
    },
    Rotation = 45,
    Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.95),
        NumberSequenceKeypoint.new(1, 0.98)
    }
})

-- Border Glow
new("UIStroke", {
    Parent = mainFrame,
    Color = colors.primary,
    Thickness = 2,
    Transparency = 0.6
})

-- Header
local header = new("TextLabel", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 60),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundTransparency = 1,
    Text = "🔐 FlyyGUI License Activation",
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextColor3 = colors.text,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 2
})

-- Subtitle
local subtitle = new("TextLabel", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.new(0, 20, 0, 75),
    BackgroundTransparency = 1,
    Text = "Activate your license to use FlyyGUI",
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextColor3 = colors.textDim,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 2
})

-- HWID Container
local hwidContainer = new("Frame", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 100),
    Position = UDim2.new(0, 20, 0, 120),
    BackgroundColor3 = colors.bg2,
    BorderSizePixel = 0,
    ZIndex = 2
})
new("UICorner", {Parent = hwidContainer, CornerRadius = UDim.new(0, 10)})
new("UIStroke", {Parent = hwidContainer, Color = colors.primary, Thickness = 1, Transparency = 0.8})

local hwidLabel = new("TextLabel", {
    Parent = hwidContainer,
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    Text = "Your HWID:",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3
})

local hwidText = new("TextLabel", {
    Parent = hwidContainer,
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundTransparency = 1,
    Text = KeySystem.GetHWIDForDisplay(),
    Font = Enum.Font.Code,
    TextSize = 10,
    TextColor3 = colors.primary,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextWrapped = true,
    ZIndex = 3
})

-- Copy HWID Button
local copyHWIDBtn = new("TextButton", {
    Parent = hwidContainer,
    Size = UDim2.new(0, 100, 0, 28),
    Position = UDim2.new(1, -110, 1, -38),
    BackgroundColor3 = colors.primary,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Text = "📋 Copy HWID",
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextColor3 = colors.text,
    AutoButtonColor = false,
    ZIndex = 3
})
new("UICorner", {Parent = copyHWIDBtn, CornerRadius = UDim.new(0, 6)})

copyHWIDBtn.MouseButton1Click:Connect(function()
    setclipboard(KeySystem.GetHWIDForDisplay())
    copyHWIDBtn.Text = "✅ Copied!"
    task.wait(2)
    copyHWIDBtn.Text = "📋 Copy HWID"
end)

copyHWIDBtn.MouseEnter:Connect(function()
    TweenService:Create(copyHWIDBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
end)

copyHWIDBtn.MouseLeave:Connect(function()
    TweenService:Create(copyHWIDBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

-- Key Input Container
local keyContainer = new("Frame", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 80),
    Position = UDim2.new(0, 20, 0, 240),
    BackgroundColor3 = colors.bg2,
    BorderSizePixel = 0,
    ZIndex = 2
})
new("UICorner", {Parent = keyContainer, CornerRadius = UDim.new(0, 10)})
new("UIStroke", {Parent = keyContainer, Color = colors.primary, Thickness = 1, Transparency = 0.8})

local keyLabel = new("TextLabel", {
    Parent = keyContainer,
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    Text = "License Key:",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3
})

local keyInput = new("TextBox", {
    Parent = keyContainer,
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.new(0, 10, 0, 38),
    BackgroundColor3 = colors.bg3,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "FLYY-XXXX-XXXX",
    Font = Enum.Font.Code,
    TextSize = 13,
    TextColor3 = colors.text,
    PlaceholderColor3 = colors.textDim,
    ClearTextOnFocus = false,
    ZIndex = 3
})
new("UICorner", {Parent = keyInput, CornerRadius = UDim.new(0, 6)})
new("UIPadding", {Parent = keyInput, PaddingLeft = UDim.new(0, 10)})

-- Activate Button
local activateBtn = new("TextButton", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 45),
    Position = UDim2.new(0, 20, 0, 340),
    BackgroundColor3 = colors.primary,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    Text = "🔓 Activate License",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = colors.text,
    AutoButtonColor = false,
    ZIndex = 2
})
new("UICorner", {Parent = activateBtn, CornerRadius = UDim.new(0, 10)})

local activateBtnStroke = new("UIStroke", {
    Parent = activateBtn,
    Color = colors.primary,
    Thickness = 2,
    Transparency = 0.5
})

activateBtn.MouseEnter:Connect(function()
    TweenService:Create(activateBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(activateBtnStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
end)

activateBtn.MouseLeave:Connect(function()
    TweenService:Create(activateBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(activateBtnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
end)

-- Status Message
local statusMsg = new("TextLabel", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.new(0, 20, 0, 400),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextColor3 = colors.textDim,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 2
})

-- Discord Button
local discordBtn = new("TextButton", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 35),
    Position = UDim2.new(0, 20, 0, 445),
    BackgroundColor3 = Color3.fromRGB(88, 101, 242),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Text = "💬 Get Key from Discord",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    AutoButtonColor = false,
    ZIndex = 2
})
new("UICorner", {Parent = discordBtn, CornerRadius = UDim.new(0, 8)})

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/Y3QJ5WjEU")
    discordBtn.Text = "✅ Discord Link Copied!"
    task.wait(2)
    discordBtn.Text = "💬 Get Key from Discord"
end)

discordBtn.MouseEnter:Connect(function()
    TweenService:Create(discordBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
end)

discordBtn.MouseLeave:Connect(function()
    TweenService:Create(discordBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

-- Activate Button Click
activateBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    
    if key == "" then
        statusMsg.Text = "⚠️ Please enter a key!"
        statusMsg.TextColor3 = colors.danger
        return
    end
    
    activateBtn.Text = "⏳ Validating..."
    activateBtn.BackgroundColor3 = colors.textDim
    
    statusMsg.Text = "🔄 Checking license..."
    statusMsg.TextColor3 = colors.textDim
    
    task.wait(1)
    
    local success, message = KeySystem.Activate(key)
    
    if success then
        statusMsg.Text = "✅ " .. message
        statusMsg.TextColor3 = colors.success
        activateBtn.Text = "✅ Activated!"
        activateBtn.BackgroundColor3 = colors.success
        
        task.wait(1.5)
        
        -- Destroy key UI
        gui:Destroy()
        
        -- Load main GUI
        print("✅ Loading FlyyGUI...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oyen-XD/Flyy/main/FlyyGUI.lua"))()
    else
        statusMsg.Text = "❌ " .. message
        statusMsg.TextColor3 = colors.danger
        activateBtn.Text = "🔓 Activate License"
        activateBtn.BackgroundColor3 = colors.primary
    end
end)

-- Opening Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1

task.wait(0.1)

TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 500)
}):Play()

TweenService:Create(mainFrame, TweenInfo.new(0.4), {
    BackgroundTransparency = 0
}):Play()

print("🔐 FlyyGUI Key System loaded. Please activate your license.")
