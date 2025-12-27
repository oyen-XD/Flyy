-- FlyyGUI_v2.3.lua - Galaxy Edition (REFINED)
-- BAGIAN 1: Setup, Core Functions, Window Structure
-- FREE NOT FOR SALE

repeat task.wait() until game:IsLoaded()

-- ============================================
-- USAGE EXAMPLE - Paste at top of your GUI
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

repeat task.wait() until localPlayer:FindFirstChild("PlayerGui")

-- Detect if mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function new(class, props)
    local inst = Instance.new(class)
    for k,v in pairs(props or {}) do inst[k] = v end
    return inst
end

-- Load Security Loader (upload SecurityLoader.lua to GitHub first)
local SecurityLoader = loadstring(game:HttpGet("https://raw.githubusercontent.com/akmiliadevi/Tugas_Kuliah/refs/heads/main/SecurityLoader.lua"))()

-- Load all modules (replace all your loadstring calls)
local instant = SecurityLoader.LoadModule("instant")
local instant2 = SecurityLoader.LoadModule("instant2")
local blatantv1 = SecurityLoader.LoadModule("blatantv1")
local UltraBlatant = SecurityLoader.LoadModule("UltraBlatant")
local blatantv2 = SecurityLoader.LoadModule("blatantv2")
local blatantv2fix = SecurityLoader.LoadModule("blatantv2fix")
local NoFishingAnimation = SecurityLoader.LoadModule("NoFishingAnimation")
local LockPosition = SecurityLoader.LoadModule("LockPosition")
local AutoEquipRod = SecurityLoader.LoadModule("AutoEquipRod")
local DisableCutscenes = SecurityLoader.LoadModule("DisableCutscenes")
local DisableExtras = SecurityLoader.LoadModule("DisableExtras")
local AutoTotem3X = SecurityLoader.LoadModule("AutoTotem3X")
local SkinAnimation = SecurityLoader.LoadModule("SkinAnimation")
local WalkOnWater = SecurityLoader.LoadModule("WalkOnWater")
local TeleportModule = SecurityLoader.LoadModule("TeleportModule")
local TeleportToPlayer = SecurityLoader.LoadModule("TeleportToPlayer")
local SavedLocation = SecurityLoader.LoadModule("SavedLocation")
local AutoQuestModule = SecurityLoader.LoadModule("AutoQuestModule")
local AutoTemple = SecurityLoader.LoadModule("AutoTemple")
local TempleDataReader = SecurityLoader.LoadModule("TempleDataReader")
local AutoSell = SecurityLoader.LoadModule("AutoSell")
local AutoSellTimer = SecurityLoader.LoadModule("AutoSellTimer")
local MerchantSystem = SecurityLoader.LoadModule("MerchantSystem")
local RemoteBuyer = SecurityLoader.LoadModule("RemoteBuyer")
local FreecamModule = SecurityLoader.LoadModule("FreecamModule")
local UnlimitedZoomModule = SecurityLoader.LoadModule("UnlimitedZoomModule")
local AntiAFK = SecurityLoader.LoadModule("AntiAFK")
local UnlockFPS = SecurityLoader.LoadModule("UnlockFPS")
local FPSBooster = SecurityLoader.LoadModule("FPSBooster")
local AutoBuyWeather = SecurityLoader.LoadModule("AutoBuyWeather")
local Notify = SecurityLoader.LoadModule("Notify")
local GoodPerfectionStable = SecurityLoader.LoadModule("GoodPerfectionStable")

-- Continue with rest of your GUI code...
print("✅ All modules loaded securely!")

-- Galaxy Color Palette
local colors = {
    primary = Color3.fromRGB(255, 140, 0),       -- Purple
    secondary = Color3.fromRGB(147, 112, 219),    -- Medium purple
    accent = Color3.fromRGB(186, 85, 211),        -- Orchid
    galaxy1 = Color3.fromRGB(123, 104, 238),      -- Medium slate blue
    galaxy2 = Color3.fromRGB(72, 61, 139),        -- Dark slate blue
    success = Color3.fromRGB(34, 197, 94),        -- Green
    warning = Color3.fromRGB(251, 191, 36),       -- Amber
    danger = Color3.fromRGB(239, 68, 68),         -- Red
    
    bg1 = Color3.fromRGB(10, 10, 10),             -- Deep black
    bg2 = Color3.fromRGB(18, 18, 18),             -- Dark gray
    bg3 = Color3.fromRGB(25, 25, 25),             -- Medium gray
    bg4 = Color3.fromRGB(35, 35, 35),             -- Light gray
    
    text = Color3.fromRGB(255, 255, 255),
    textDim = Color3.fromRGB(180, 180, 180),
    textDimmer = Color3.fromRGB(120, 120, 120),
    
    border = Color3.fromRGB(50, 50, 50),
    glow = Color3.fromRGB(138, 43, 226),
}

-- Compact Window Size
local windowSize = UDim2.new(0, 420, 0, 280)
local minWindowSize = Vector2.new(380, 250)
local maxWindowSize = Vector2.new(550, 400)

-- Sidebar state (Always expanded, no toggle)
local sidebarWidth = 140

local gui = new("ScreenGui",{
    Name="FlyyGUI_Galaxy",
    Parent=localPlayer.PlayerGui,
    IgnoreGuiInset=true,
    ResetOnSpawn=false,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
    DisplayOrder=999999999
})

local function bringToFront()
    -- Langsung set ke nilai maksimal DisplayOrder
    gui.DisplayOrder = 2147483647  -- Nilai Int32 maksimal
    print("🔥 GUI forced to max DisplayOrder:", gui.DisplayOrder)
end

-- Main Window Container - ULTRA TRANSPARENT
local win = new("Frame",{
    Parent=gui,
    Size=windowSize,
    Position=UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
    BackgroundColor3=colors.bg1,
    BackgroundTransparency=0.25,
    BorderSizePixel=0,
    ClipsDescendants=false,
    ZIndex=3
})
new("UICorner",{Parent=win, CornerRadius=UDim.new(0, 12)})

-- Subtle outer glow
new("UIStroke",{
    Parent=win,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.9,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border
})

-- Inner shadow effect
local innerShadow = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, -2, 1, -2),
    Position=UDim2.new(0, 1, 0, 1),
    BackgroundTransparency=1,
    BorderSizePixel=0,
    ZIndex=2
})
new("UICorner",{Parent=innerShadow, CornerRadius=UDim.new(0, 11)})
new("UIStroke",{
    Parent=innerShadow,
    Color=Color3.fromRGB(0, 0, 0),
    Thickness=1,
    Transparency=0.8
})

-- Sidebar (Below header, always visible, ULTRA transparent)
local sidebar = new("Frame",{
    Parent=win,
    Size=UDim2.new(0, sidebarWidth, 1, -45),
    Position=UDim2.new(0, 0, 0, 45),
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.75,
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=4
})
new("UICorner",{Parent=sidebar, CornerRadius=UDim.new(0, 12)})

-- Sidebar subtle border
new("UIStroke",{
    Parent=sidebar,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95
})

-- Script Header (INSIDE window, at the top, ULTRA transparent)
local scriptHeader = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, 0, 0, 45),
    Position=UDim2.new(0, 0, 0, 0),
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.75,
    BorderSizePixel=0,
    ZIndex=5
})
new("UICorner",{Parent=scriptHeader, CornerRadius=UDim.new(0, 12)})

-- Subtle gradient overlay
local gradient = new("UIGradient",{
    Parent=scriptHeader,
    Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 61, 139))
    },
    Rotation=45,
    Transparency=NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.97),
        NumberSequenceKeypoint.new(1, 0.99)
    }
})

-- Drag Handle for Header (More subtle)
local headerDragHandle = new("Frame",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 40, 0, 3),
    Position=UDim2.new(0.5, -20, 0, 8),
    BackgroundColor3=colors.primary,
    BackgroundTransparency=0.8,
    BorderSizePixel=0,
    ZIndex=6
})
new("UICorner",{Parent=headerDragHandle, CornerRadius=UDim.new(1, 0)})

-- Drag handle glow effect
new("UIStroke",{
    Parent=headerDragHandle,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.85
})

-- Title with glow effect
local titleLabel = new("TextLabel",{
    Parent=scriptHeader,
    Text="Flyy",
    Size=UDim2.new(0, 80, 1, 0),
    Position=UDim2.new(0, 15, 0, 0),
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=17,
    TextColor3=colors.primary,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextStrokeTransparency=0.9,
    TextStrokeColor3=colors.primary,
    ZIndex=6
})

-- Title glow effect
local titleGlow = new("TextLabel",{
    Parent=scriptHeader,
    Text="Flyy",
    Size=titleLabel.Size,
    Position=titleLabel.Position,
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=17,
    TextColor3=colors.primary,
    TextTransparency=0.7,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=5
})

-- Animated glow pulse
task.spawn(function()
    while true do
        TweenService:Create(titleGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency=0.4
        }):Play()
        task.wait(2)
        TweenService:Create(titleGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency=0.7
        }):Play()
        task.wait(2)
    end
end)

-- Separator with glow
local separator = new("Frame",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 2, 0, 25),
    Position=UDim2.new(0, 95, 0.5, -12.5),
    BackgroundColor3=colors.primary,
    BackgroundTransparency=0.3,
    BorderSizePixel=0,
    ZIndex=6
})
new("UICorner",{Parent=separator, CornerRadius=UDim.new(1, 0)})
new("UIStroke",{
    Parent=separator,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.7
})

local subtitleLabel = new("TextLabel",{
    Parent=scriptHeader,
    Text="Free Not For Sale",
    Size=UDim2.new(0, 150, 1, 0),
    Position=UDim2.new(0, 105, 0, 0),
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=9,
    TextColor3=colors.textDim,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextTransparency=0.3,
    ZIndex=6
})

-- Minimize button in header - more polished
local btnMinHeader = new("TextButton",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 30, 0, 30),
    Position=UDim2.new(1, -38, 0.5, -15),
    BackgroundColor3=colors.bg4,
    BackgroundTransparency=0.5,
    BorderSizePixel=0,
    Text="─",
    Font=Enum.Font.GothamBold,
    TextSize=18,
    TextColor3=colors.textDim,
    TextTransparency=0.3,
    AutoButtonColor=false,
    ZIndex=7
})
new("UICorner",{Parent=btnMinHeader, CornerRadius=UDim.new(0, 8)})

local btnStroke = new("UIStroke",{
    Parent=btnMinHeader,
    Color=colors.primary,
    Thickness=0,
    Transparency=0.8
})

btnMinHeader.MouseEnter:Connect(function()
    TweenService:Create(btnMinHeader, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundColor3=colors.galaxy1,
        BackgroundTransparency=0.2,
        TextColor3=colors.text,
        TextTransparency=0,
        Size=UDim2.new(0, 32, 0, 32)
    }):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.25), {
        Thickness=1.5,
        Transparency=0.4
    }):Play()
end)

btnMinHeader.MouseLeave:Connect(function()
    TweenService:Create(btnMinHeader, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundColor3=colors.bg4,
        BackgroundTransparency=0.5,
        TextColor3=colors.textDim,
        TextTransparency=0.3,
        Size=UDim2.new(0, 30, 0, 30)
    }):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.25), {
        Thickness=0,
        Transparency=0.8
    }):Play()
end)

-- Navigation Container
local navContainer = new("ScrollingFrame",{
    Parent=sidebar,
    Size=UDim2.new(1, -8, 1, -12),
    Position=UDim2.new(0, 4, 0, 6),
    BackgroundTransparency=1,
    ScrollBarThickness=2,
    ScrollBarImageColor3=colors.primary,
    BorderSizePixel=0,
    CanvasSize=UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ClipsDescendants=true,
    ZIndex=5
})
new("UIListLayout",{
    Parent=navContainer,
    Padding=UDim.new(0, 4),
    SortOrder=Enum.SortOrder.LayoutOrder
})

-- Content Area
local contentBg = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, -(sidebarWidth + 10), 1, -52),
    Position=UDim2.new(0, sidebarWidth + 5, 0, 47),
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.8,
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=4
})
new("UICorner",{Parent=contentBg, CornerRadius=UDim.new(0, 12)})

new("UIStroke",{
    Parent=contentBg,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95
})

-- Top Bar
local topBar = new("Frame",{
    Parent=contentBg,
    Size=UDim2.new(1, -8, 0, 32),
    Position=UDim2.new(0, 4, 0, 4),
    BackgroundColor3=colors.bg3,
    BackgroundTransparency=0.8,
    BorderSizePixel=0,
    ZIndex=5
})
new("UICorner",{Parent=topBar, CornerRadius=UDim.new(0, 10)})

new("UIStroke",{
    Parent=topBar,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95
})

local pageTitle = new("TextLabel",{
    Parent=topBar,
    Text="Main Dashboard",
    Size=UDim2.new(1, -20, 1, 0),
    Position=UDim2.new(0, 12, 0, 0),
    Font=Enum.Font.GothamBold,
    TextSize=11,
    BackgroundTransparency=1,
    TextColor3=colors.text,
    TextTransparency=0.2,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=6
})

-- Resize Handle
local resizeHandle = new("TextButton",{
    Parent=win,
    Size=UDim2.new(0, 18, 0, 18),
    Position=UDim2.new(1, -18, 1, -18),
    BackgroundColor3=colors.bg3,
    BackgroundTransparency=0.6,
    BorderSizePixel=0,
    Text="⋰",
    Font=Enum.Font.GothamBold,
    TextSize=11,
    TextColor3=colors.textDim,
    TextTransparency=0.4,
    AutoButtonColor=false,
    ZIndex=100
})
new("UICorner",{Parent=resizeHandle, CornerRadius=UDim.new(0, 6)})

local resizeStroke = new("UIStroke",{
    Parent=resizeHandle,
    Color=colors.primary,
    Thickness=0,
    Transparency=0.8
})

resizeHandle.MouseEnter:Connect(function()
    TweenService:Create(resizeHandle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundTransparency=0.3,
        TextTransparency=0,
        Size=UDim2.new(0, 20, 0, 20)
    }):Play()
    TweenService:Create(resizeStroke, TweenInfo.new(0.25), {
        Thickness=1.5,
        Transparency=0.5
    }):Play()
end)

resizeHandle.MouseLeave:Connect(function()
    if not resizing then
        TweenService:Create(resizeHandle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundTransparency=0.6,
            TextTransparency=0.4,
            Size=UDim2.new(0, 18, 0, 18)
        }):Play()
        TweenService:Create(resizeStroke, TweenInfo.new(0.25), {
            Thickness=0,
            Transparency=0.8
        }):Play()
    end
end)

-- Pages
local pages = {}
local currentPage = "Main"
local navButtons = {}

local function createPage(name)
    local page = new("ScrollingFrame",{
        Parent=contentBg,
        Size=UDim2.new(1, -16, 1, -44),
        Position=UDim2.new(0, 8, 0, 40),
        BackgroundTransparency=1,
        ScrollBarThickness=3,
        ScrollBarImageColor3=colors.primary,
        BorderSizePixel=0,
        CanvasSize=UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=false,
        ClipsDescendants=true,
        ZIndex=5
    })
    new("UIListLayout",{
        Parent=page,
        Padding=UDim.new(0, 8),
        SortOrder=Enum.SortOrder.LayoutOrder
    })
    new("UIPadding",{
        Parent=page,
        PaddingTop=UDim.new(0, 4),
        PaddingBottom=UDim.new(0, 4),
        PaddingLeft=UDim.new(0, 0),
        PaddingRight=UDim.new(0, 0)
    })
    pages[name] = page
    return page
end

local mainPage = createPage("Main")
local teleportPage = createPage("Teleport")
local questPage = createPage("Quest")
local shopPage = createPage("Shop")
local webhookPage = createPage("Webhook")
local cameraViewPage = createPage("CameraView")
local settingsPage = createPage("Settings")
local infoPage = createPage("Info")
mainPage.Visible = true

-- FlyyGUI_v2.3.lua - Galaxy Edition (REFINED)
-- BAGIAN 2: Navigation, UI Components (Toggle, Input Horizontal, Dropdown, Button, Category)

-- Nav Button
local function createNavButton(text, icon, page, order)
    local btn = new("TextButton",{
        Parent=navContainer,
        Size=UDim2.new(1, 0, 0, 38),
        BackgroundColor3=page == currentPage and colors.bg3 or Color3.fromRGB(0, 0, 0),
        BackgroundTransparency=page == currentPage and 0.7 or 1,
        BorderSizePixel=0,
        Text="",
        AutoButtonColor=false,
        LayoutOrder=order,
        ZIndex=6
    })
    new("UICorner",{Parent=btn, CornerRadius=UDim.new(0, 9)})
    
    local indicator = new("Frame",{
        Parent=btn,
        Size=UDim2.new(0, 3, 0, 20),
        Position=UDim2.new(0, 0, 0.5, -10),
        BackgroundColor3=colors.primary,
        BorderSizePixel=0,
        Visible=page == currentPage,
        ZIndex=7
    })
    new("UICorner",{Parent=indicator, CornerRadius=UDim.new(1, 0)})
    
    new("UIStroke",{
        Parent=indicator,
        Color=colors.primary,
        Thickness=2,
        Transparency=0.7
    })
    
    local iconLabel = new("TextLabel",{
        Parent=btn,
        Text=icon,
        Size=UDim2.new(0, 30, 1, 0),
        Position=UDim2.new(0, 10, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=15,
        TextColor3=page == currentPage and colors.primary or colors.textDim,
        TextTransparency=page == currentPage and 0 or 0.3,
        ZIndex=7
    })
    
    local textLabel = new("TextLabel",{
        Parent=btn,
        Text=text,
        Size=UDim2.new(1, -45, 1, 0),
        Position=UDim2.new(0, 40, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=page == currentPage and colors.text or colors.textDim,
        TextTransparency=page == currentPage and 0.1 or 0.4,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=7
    })
    
    btn.MouseEnter:Connect(function()
        if page ~= currentPage then
            TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                BackgroundTransparency=0.8
            }):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {
                TextTransparency=0,
                TextColor3=colors.primary
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.3), {
                TextTransparency=0.2
            }):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if page ~= currentPage then
            TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                BackgroundTransparency=1
            }):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {
                TextTransparency=0.3,
                TextColor3=colors.textDim
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.3), {
                TextTransparency=0.4
            }):Play()
        end
    end)
    
    navButtons[page] = {btn=btn, icon=iconLabel, text=textLabel, indicator=indicator}
    
    return btn
end

local function switchPage(pageName, pageTitle_text)
    if currentPage == pageName then return end
    for _, page in pairs(pages) do page.Visible = false end
    
    for name, btnData in pairs(navButtons) do
        local isActive = name == pageName
        TweenService:Create(btnData.btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            BackgroundColor3=isActive and colors.bg3 or Color3.fromRGB(0, 0, 0),
            BackgroundTransparency=isActive and 0.7 or 1
        }):Play()
        btnData.indicator.Visible = isActive
        TweenService:Create(btnData.icon, TweenInfo.new(0.3), {
            TextColor3=isActive and colors.primary or colors.textDim,
            TextTransparency=isActive and 0 or 0.3
        }):Play()
        TweenService:Create(btnData.text, TweenInfo.new(0.3), {
            TextColor3=isActive and colors.text or colors.textDim,
            TextTransparency=isActive and 0.1 or 0.4
        }):Play()
    end
    
    pages[pageName].Visible = true
    pageTitle.Text = pageTitle_text
    currentPage = pageName
end

local btnMain = createNavButton("Dashboard", "🏠", "Main", 1)
local btnTeleport = createNavButton("Teleport", "🌍", "Teleport", 2)
local btnQuest = createNavButton("Quest", "📜", "Quest", 3)
local btnShop = createNavButton("Shop", "🛒", "Shop", 3)
local btnWebhook = createNavButton("Webhook", "🔗", "Webhook", 4)
local btnCameraView = createNavButton("Camera View", "📷", "CameraView", 3)
local btnSettings = createNavButton("Settings", "⚙️", "Settings", 4)
local btnInfo = createNavButton("About", "ℹ️", "Info", 5)

btnMain.MouseButton1Click:Connect(function() switchPage("Main", "Main Dashboard") end)
btnTeleport.MouseButton1Click:Connect(function() switchPage("Teleport", "Teleport System") end)
btnQuest.MouseButton1Click:Connect(function() switchPage("Quest", "Auto Quest") end)
btnShop.MouseButton1Click:Connect(function() switchPage("Shop", "Shop Features") end)
btnWebhook.MouseButton1Click:Connect(function() switchPage("Webhook", "Webhook Page") end)
btnCameraView.MouseButton1Click:Connect(function() switchPage("CameraView", "Camera View Settings") end)
btnSettings.MouseButton1Click:Connect(function() switchPage("Settings", "Settings") end)
btnInfo.MouseButton1Click:Connect(function() switchPage("Info", "About Flyy") end)

-- ==== UI COMPONENTS ====

-- Category
local function makeCategory(parent, title, icon)
    local categoryFrame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 36),
        BackgroundColor3=colors.bg3,
        BackgroundTransparency=0.6,
        BorderSizePixel=0,
        AutomaticSize=Enum.AutomaticSize.Y,
        ClipsDescendants=false,
        ZIndex=6
    })
    new("UICorner",{Parent=categoryFrame, CornerRadius=UDim.new(0, 6)})
    
    local categoryStroke = new("UIStroke",{
        Parent=categoryFrame,
        Color=colors.border,
        Thickness=0,
        Transparency=0.8
    })
    
    local header = new("TextButton",{
        Parent=categoryFrame,
        Size=UDim2.new(1, 0, 0, 36),
        BackgroundTransparency=1,
        Text="",
        AutoButtonColor=false,
        ClipsDescendants=true,
        ZIndex=7
    })
    
    local titleLabel = new("TextLabel",{
        Parent=header,
        Text=title,
        Size=UDim2.new(1, -50, 1, 0),
        Position=UDim2.new(0, 8,
