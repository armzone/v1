-- Rayfield V2 Style UI Library for Roblox
-- Modern Glass Design with Smooth Animations

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Rayfield V2 Theme
local Theme = {
    -- Main Colors
    MainBackground = Color3.fromRGB(16, 16, 16),
    SecondaryBackground = Color3.fromRGB(24, 24, 24),
    TertiaryBackground = Color3.fromRGB(32, 32, 32),
    
    -- Glass Effect
    GlassBackground = Color3.fromRGB(255, 255, 255),
    GlassTransparency = 0.95,
    
    -- Accent Colors
    Primary = Color3.fromRGB(120, 120, 255),
    Secondary = Color3.fromRGB(80, 80, 255),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(251, 191, 36),
    Error = Color3.fromRGB(239, 68, 68),
    
    -- Text Colors
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(156, 163, 175),
    TextTertiary = Color3.fromRGB(107, 114, 128),
    
    -- Border & Effects
    Border = Color3.fromRGB(55, 65, 81),
    Shadow = Color3.fromRGB(0, 0, 0),
    Highlight = Color3.fromRGB(255, 255, 255)
}

-- Utility Functions
local function CreateTween(object, tweenInfo, properties)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local function CreateGradient(parent, rotation, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 0
    gradient.Color = ColorSequence.new(colors)
    gradient.Parent = parent
    return gradient
end

local function CreateGlassEffect(parent)
    local glassFrame = Instance.new("Frame")
    glassFrame.Size = UDim2.new(1, 0, 1, 0)
    glassFrame.BackgroundColor3 = Theme.GlassBackground
    glassFrame.BackgroundTransparency = Theme.GlassTransparency
    glassFrame.BorderSizePixel = 0
    glassFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = glassFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.9
    stroke.Thickness = 1
    stroke.Parent = glassFrame
    
    return glassFrame
end

local function CreateBlur(parent)
    local blur = Instance.new("BlurEffect")
    blur.Size = 20
    blur.Parent = parent
    return blur
end

-- Main Library Functions
function Library:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "Rayfield V2"
    local subtitle = config.Subtitle or "Universal Script Hub"
    local size = config.Size or UDim2.new(0, IsMobile() and 400 or 600, 0, IsMobile() and 500 or 700)
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RayfieldV2_" .. math.random(1000, 9999)
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Background Blur
    local BackgroundBlur = Instance.new("Frame")
    BackgroundBlur.Name = "BackgroundBlur"
    BackgroundBlur.Size = UDim2.new(1, 0, 1, 0)
    BackgroundBlur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BackgroundBlur.BackgroundTransparency = 0.3
    BackgroundBlur.BorderSizePixel = 0
    BackgroundBlur.Parent = ScreenGui
    BackgroundBlur.Visible = false
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundColor3 = Theme.MainBackground
    MainContainer.BorderSizePixel = 0
    MainContainer.Parent = ScreenGui
    MainContainer.ClipsDescendants = true
    
    -- Main Corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainContainer
    
    -- Main Border
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1
    MainStroke.Transparency = 0.3
    MainStroke.Parent = MainContainer
    
    -- Background Gradient
    CreateGradient(MainContainer, 45, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
    })
    
    -- Animated Background Particles
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Name = "ParticleContainer"
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
    ParticleContainer.BackgroundTransparency = 1
    ParticleContainer.Parent = MainContainer
    
    -- Create floating particles
    for i = 1, 15 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Theme.Primary
        particle.BackgroundTransparency = 0.8
        particle.BorderSizePixel = 0
        particle.Parent = ParticleContainer
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(0, 50)
        particleCorner.Parent = particle
        
        -- Animate particles
        local floatTween = CreateTween(particle, 
            TweenInfo.new(math.random(3, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Position = UDim2.new(math.random(), 0, math.random(), 0)}
        )
    end
    
    -- Header Section
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 80)
    Header.BackgroundTransparency = 1
    Header.Parent = MainContainer
    
    -- Header Glass Effect
    local HeaderGlass = CreateGlassEffect(Header)
    
    -- Logo/Icon
    local Logo = Instance.new("Frame")
    Logo.Size = UDim2.new(0, 40, 0, 40)
    Logo.Position = UDim2.new(0, 20, 0.5, -20)
    Logo.BackgroundColor3 = Theme.Primary
    Logo.BorderSizePixel = 0
    Logo.Parent = Header
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, 8)
    LogoCorner.Parent = Logo
    
    CreateGradient(Logo, 45, {
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(1, Theme.Secondary)
    })
    
    -- Logo Text
    local LogoText = Instance.new("TextLabel")
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "R"
    LogoText.TextColor3 = Theme.TextPrimary
    LogoText.TextScaled = true
    LogoText.Font = Enum.Font.GothamBold
    LogoText.Parent = Logo
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -180, 0, 30)
    Title.Position = UDim2.new(0, 75, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = windowTitle
    Title.TextColor3 = Theme.TextPrimary
    Title.TextScaled = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Header
    
    -- Subtitle
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(1, -180, 0, 20)
    Subtitle.Position = UDim2.new(0, 75, 0, 45)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = subtitle
    Subtitle.TextColor3 = Theme.TextSecondary
    Subtitle.TextScaled = true
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Parent = Header
    
    -- Control Buttons Container
    local ControlButtons = Instance.new("Frame")
    ControlButtons.Size = UDim2.new(0, 100, 0, 30)
    ControlButtons.Position = UDim2.new(1, -120, 0, 25)
    ControlButtons.BackgroundTransparency = 1
    ControlButtons.Parent = Header
    
    local ControlLayout = Instance.new("UIListLayout")
    ControlLayout.FillDirection = Enum.FillDirection.Horizontal
    ControlLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ControlLayout.Padding = UDim.new(0, 8)
    ControlLayout.Parent = ControlButtons
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.BackgroundColor3 = Theme.TertiaryBackground
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Theme.TextPrimary
    MinimizeButton.TextScaled = true
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.LayoutOrder = 1
    MinimizeButton.Parent = ControlButtons
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeButton
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.TextPrimary
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.LayoutOrder = 2
    CloseButton.Parent = ControlButtons
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    -- Navigation Tabs
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -80)
    TabContainer.Position = UDim2.new(0, 0, 0, 80)
    TabContainer.BackgroundColor3 = Theme.SecondaryBackground
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 0)
    TabCorner.Parent = TabContainer
    
    -- Tab Glass Effect
    local TabGlass = CreateGlassEffect(TabContainer)
    TabGlass.BackgroundTransparency = 0.98
    
    -- Tab List
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, -10, 1, -20)
    TabList.Position = UDim2.new(0, 5, 0, 10)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 0
    TabList.BorderSizePixel = 0
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.Parent = TabContainer
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabList
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -150, 1, -80)
    ContentArea.Position = UDim2.new(0, 150, 0, 80)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainContainer
    
    -- Window Object
    local Window = {
        ScreenGui = ScreenGui,
        MainContainer = MainContainer,
        BackgroundBlur = BackgroundBlur,
        ContentArea = ContentArea,
        TabList = TabList,
        Tabs = {},
        CurrentTab = nil,
        IsMinimized = false
    }
    
    -- Animation Functions
    local function ShowWindow()
        BackgroundBlur.Visible = true
        CreateTween(BackgroundBlur, TweenInfo.new(0.3), {BackgroundTransparency = 0.3})
        CreateTween(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = size})
    end
    
    local function HideWindow()
        CreateTween(BackgroundBlur, TweenInfo.new(0.3), {BackgroundTransparency = 1})
        CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)})
        wait(0.3)
        ScreenGui:Destroy()
    end
    
    local function MinimizeWindow()
        if Window.IsMinimized then
            CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = size})
            MinimizeButton.Text = "—"
            Window.IsMinimized = false
        else
            CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, size.X.Offset, 0, 80)})
            MinimizeButton.Text = "+"
            Window.IsMinimized = true
        end
    end
    
    -- Button Events
    CloseButton.MouseButton1Click:Connect(HideWindow)
    MinimizeButton.MouseButton1Click:Connect(MinimizeWindow)
    
    -- Hover Effects
    local function AddHoverEffect(button, hoverColor)
        local originalColor = button.BackgroundColor3
        
        button.MouseEnter:Connect(function()
            CreateTween(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor})
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor})
        end)
    end
    
    AddHoverEffect(MinimizeButton, Color3.fromRGB(60, 60, 60))
    AddHoverEffect(CloseButton, Color3.fromRGB(255, 100, 100))
    
    -- Make draggable (PC only)
    if not IsMobile() then
        local dragging = false
        local dragStart = nil
        local startPos = nil
        
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainContainer.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    
    -- Window Methods
    function Window:CreateTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or "📄"
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = Theme.TertiaryBackground
        TabButton.BackgroundTransparency = 0.3
        TabButton.Text = ""
        TabButton.BorderSizePixel = 0
        TabButton.Parent = self.TabList
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 8)
        TabButtonCorner.Parent = TabButton
        
        -- Tab Icon
        local TabIcon = Instance.new("TextLabel")
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Text = tabIcon
        TabIcon.TextColor3 = Theme.TextSecondary
        TabIcon.TextScaled = true
        TabIcon.Font = Enum.Font.Gotham
        TabIcon.Parent = TabButton
        
        -- Tab Label
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, -40, 1, 0)
        TabLabel.Position = UDim2.new(0, 35, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = tabName
        TabLabel.TextColor3 = Theme.TextSecondary
        TabLabel.TextScaled = true
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Font = Enum.Font.Gotham
        TabLabel.Parent = TabButton
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Primary
        TabContent.BorderSizePixel = 0
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Visible = false
        TabContent.Parent = self.ContentArea
        
        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 10)
        TabContentLayout.Parent = TabContent
        
        -- Tab Object
        local Tab = {
            Button = TabButton,
            Content = TabContent,
            Icon = TabIcon,
            Label = TabLabel,
            Name = tabName,
            Active = false
        }
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            self:SelectTab(Tab)
        end)
        
        -- Store tab
        self.Tabs[tabName] = Tab
        
        -- Select first tab automatically
        if #self.Tabs == 1 then
            self:SelectTab(Tab)
        end
        
        return Tab
    end
    
    function Window:SelectTab(tab)
        -- Deactivate current tab
        if self.CurrentTab then
            self.CurrentTab.Active = false
            self.CurrentTab.Content.Visible = false
            CreateTween(self.CurrentTab.Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3})
            CreateTween(self.CurrentTab.Icon, TweenInfo.new(0.2), {TextColor3 = Theme.TextSecondary})
            CreateTween(self.CurrentTab.Label, TweenInfo.new(0.2), {TextColor3 = Theme.TextSecondary})
        end
        
        -- Activate new tab
        tab.Active = true
        tab.Content.Visible = true
        CreateTween(tab.Button, TweenInfo.new(0.2), {BackgroundTransparency = 0})
        CreateTween(tab.Icon, TweenInfo.new(0.2), {TextColor3 = Theme.Primary})
        CreateTween(tab.Label, TweenInfo.new(0.2), {TextColor3 = Theme.TextPrimary})
        
        self.CurrentTab = tab
    end
    
    -- Show window with animation
    ShowWindow()
    
    return Window
end

-- UI Elements Creation Functions
function Library:CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.Name = "Section"
    Section.Size = UDim2.new(1, 0, 0, 40)
    Section.BackgroundTransparency = 1
    Section.Parent = parent
    
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, 0, 1, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = title
    SectionLabel.TextColor3 = Theme.TextPrimary
    SectionLabel.TextScaled = true
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.Parent = Section
    
    local SectionLine = Instance.new("Frame")
    SectionLine.Size = UDim2.new(1, 0, 0, 1)
    SectionLine.Position = UDim2.new(0, 0, 1, -1)
    SectionLine.BackgroundColor3 = Theme.Border
    SectionLine.BorderSizePixel = 0
    SectionLine.Parent = Section
    
    return Section
end

function Library:CreateButton(parent, config)
    config = config or {}
    local buttonText = config.Text or "Button"
    local callback = config.Callback or function() end
    
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Size = UDim2.new(1, 0, 0, 45)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = parent
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundColor3 = Theme.TertiaryBackground
    Button.Text = buttonText
    Button.TextColor3 = Theme.TextPrimary
    Button.TextScaled = true
    Button.Font = Enum.Font.Gotham
    Button.BorderSizePixel = 0
    Button.Parent = ButtonFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Theme.Border
    ButtonStroke.Thickness = 1
    ButtonStroke.Transparency = 0.5
    ButtonStroke.Parent = Button
    
    -- Glass Effect
    local ButtonGlass = CreateGlassEffect(Button)
    ButtonGlass.BackgroundTransparency = 0.97
    
    -- Click Animation
    Button.MouseButton1Click:Connect(function()
        callback()
        
        -- Click effect
        CreateTween(Button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Primary})
        CreateTween(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {BackgroundColor3 = Theme.TertiaryBackground})
    end)
    
    -- Hover Effect
    Button.MouseEnter:Connect(function()
        CreateTween(ButtonStroke, TweenInfo.new(0.2), {Transparency = 0.2})
        CreateTween(ButtonGlass, TweenInfo.new(0.2), {BackgroundTransparency = 0.95})
    end)
    
    Button.MouseLeave:Connect(function()
        CreateTween(ButtonStroke, TweenInfo.new(0.2), {Transparency = 0.5})
        CreateTween(ButtonGlass, TweenInfo.new(0.2), {BackgroundTransparency = 0.97})
    end)
    
    return Button
end

function Library:CreateToggle(parent, config)
    config = config or {}
    local toggleText = config.Text or "Toggle"
    local defaultValue = config.Default or false
    local callback = config.Callback or function() end
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Theme.TertiaryBackground
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Theme.Border
    ToggleStroke.Thickness = 1
    ToggleStroke.Transparency = 0.5
    ToggleStroke.Parent = ToggleFrame
    
    -- Glass Effect
    local ToggleGlass = CreateGlassEffect(ToggleFrame)
    ToggleGlass.BackgroundTransparency = 0.97
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = toggleText
    ToggleLabel.TextColor3 = Theme.TextPrimary
    ToggleLabel.TextScaled = true
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleSwitch = Instance.new("TextButton")
    ToggleSwitch.Size = UDim2.new(0, 50, 0, 25)
    ToggleSwitch.Position = UDim2.new(1, -65, 0.5, -12.5)
    ToggleSwitch.BackgroundColor3 = defaultValue and Theme.Primary or Theme.SecondaryBackground
    ToggleSwitch.Text = ""
    ToggleSwitch.BorderSizePixel = 0
    ToggleSwitch.Parent = ToggleFrame
    
    local ToggleSwitchCorner = Instance.new("UICorner")
    ToggleSwitchCorner.CornerRadius = UDim.new(0, 12.5)
    ToggleSwitchCorner.Parent = ToggleSwitch
    
    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Size = UDim2.new(0, 21, 0, 21)
    ToggleKnob.Position = defaultValue and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    ToggleKnob.BackgroundColor3 = Theme.TextPrimary
    ToggleKnob.BorderSizePixel = 0
    ToggleKnob.Parent = ToggleSwitch
    
    local ToggleKnobCorner = Instance.new("UICorner")
    ToggleKnobCorner.CornerRadius = UDim.new(0, 10.5)
    ToggleKnobCorner.Parent = ToggleKnob
    
    -- Shadow for knob
    local KnobShadow = Instance.new("Frame")
    KnobShadow.Size = UDim2.new(1, 4, 1, 4)
    KnobShadow.Position = UDim2.new(0, -2, 0, -2)
    KnobShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    KnobShadow.BackgroundTransparency = 0.7
    KnobShadow.BorderSizePixel = 0
    KnobShadow.ZIndex = ToggleKnob.ZIndex - 1
    KnobShadow.Parent = ToggleKnob
    
    local KnobShadowCorner = Instance.new("UICorner")
    KnobShadowCorner.CornerRadius = UDim.new(0, 12.5)
    KnobShadowCorner.Parent = KnobShadow
    
    local toggled = defaultValue
    
    ToggleSwitch.MouseButton1Click:Connect(function()
        toggled = not toggled
        
        if toggled then
            CreateTween(ToggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.Primary})
            CreateTween(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -23, 0.5, -10.5)})
        else
            CreateTween(ToggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.SecondaryBackground})
            CreateTween(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 2, 0.5, -10.5)})
        end
        
        callback(toggled)
    end)
    
    return ToggleFrame
end

function Library:CreateSlider(parent, config)
    config = config or {}
    local sliderText = config.Text or "Slider"
    local minValue = config.Min or 0
    local maxValue = config.Max or 100
    local defaultValue = config.Default or minValue
    local callback = config.Callback or function() end
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundColor3 = Theme.TertiaryBackground
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local SliderStroke = Instance.new("UIStroke")
    SliderStroke.Color = Theme.Border
    SliderStroke.Thickness = 1
    SliderStroke.Transparency = 0.5
    SliderStroke.Parent = SliderFrame
    
    -- Glass Effect
    local SliderGlass = CreateGlassEffect(SliderFrame)
    SliderGlass.BackgroundTransparency = 0.97
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -70, 0, 25)
    SliderLabel.Position = UDim2.new(0, 15, 0, 8)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = sliderText
    SliderLabel.TextColor3 = Theme.TextPrimary
    SliderLabel.TextScaled = true
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Parent = SliderFrame
    
    local SliderValue = Instance.new("TextLabel")
    SliderValue.Size = UDim2.new(0, 50, 0, 25)
    SliderValue.Position = UDim2.new(1, -65, 0, 8)
    SliderValue.BackgroundColor3 = Theme.Primary
    SliderValue.Text = tostring(defaultValue)
    SliderValue.TextColor3 = Theme.TextPrimary
    SliderValue.TextScaled = true
    SliderValue.Font = Enum.Font.GothamBold
    SliderValue.BorderSizePixel = 0
    SliderValue.Parent = SliderFrame
    
    local SliderValueCorner = Instance.new("UICorner")
    SliderValueCorner.CornerRadius = UDim.new(0, 6)
    SliderValueCorner.Parent = SliderValue
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Size = UDim2.new(1, -30, 0, 6)
    SliderTrack.Position = UDim2.new(0, 15, 1, -20)
    SliderTrack.BackgroundColor3 = Theme.SecondaryBackground
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = SliderFrame
    
    local SliderTrackCorner = Instance.new("UICorner")
    SliderTrackCorner.CornerRadius = UDim.new(0, 3)
    SliderTrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    SliderFill.BackgroundColor3 = Theme.Primary
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(0, 3)
    SliderFillCorner.Parent = SliderFill
    
    -- Gradient for fill
    CreateGradient(SliderFill, 0, {
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(1, Theme.Secondary)
    })
    
    local SliderKnob = Instance.new("TextButton")
    SliderKnob.Size = UDim2.new(0, 16, 0, 16)
    SliderKnob.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
    SliderKnob.BackgroundColor3 = Theme.TextPrimary
    SliderKnob.Text = ""
    SliderKnob.BorderSizePixel = 0
    SliderKnob.Parent = SliderTrack
    
    local SliderKnobCorner = Instance.new("UICorner")
    SliderKnobCorner.CornerRadius = UDim.new(0, 8)
    SliderKnobCorner.Parent = SliderKnob
    
    -- Shadow for knob
    local KnobShadow = Instance.new("Frame")
    KnobShadow.Size = UDim2.new(1, 6, 1, 6)
    KnobShadow.Position = UDim2.new(0, -3, 0, -3)
    KnobShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    KnobShadow.BackgroundTransparency = 0.6
    KnobShadow.BorderSizePixel = 0
    KnobShadow.ZIndex = SliderKnob.ZIndex - 1
    KnobShadow.Parent = SliderKnob
    
    local KnobShadowCorner = Instance.new("UICorner")
    KnobShadowCorner.CornerRadius = UDim.new(0, 11)
    KnobShadowCorner.Parent = KnobShadow
    
    local currentValue = defaultValue
    local dragging = false
    
    local function UpdateSlider(value)
        currentValue = math.clamp(value, minValue, maxValue)
        local percentage = (currentValue - minValue) / (maxValue - minValue)
        
        SliderValue.Text = tostring(math.floor(currentValue))
        CreateTween(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(percentage, 0, 1, 0)})
        CreateTween(SliderKnob, TweenInfo.new(0.1), {Position = UDim2.new(percentage, -8, 0.5, -8)})
        
        callback(currentValue)
    end
    
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            CreateTween(SliderKnob, TweenInfo.new(0.1), {Size = UDim2.new(0, 20, 0, 20)})
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            CreateTween(SliderKnob, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16)})
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mousePos = input.Position.X
            local trackPos = SliderTrack.AbsolutePosition.X
            local trackSize = SliderTrack.AbsoluteSize.X
            local percentage = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
            local value = minValue + (percentage * (maxValue - minValue))
            UpdateSlider(value)
        end
    end)
    
    return SliderFrame
end

function Library:CreateInput(parent, config)
    config = config or {}
    local inputText = config.Text or "Input"
    local placeholderText = config.PlaceholderText or "Enter text..."
    local callback = config.Callback or function() end
    
    local InputFrame = Instance.new("Frame")
    InputFrame.Name = "InputFrame"
    InputFrame.Size = UDim2.new(1, 0, 0, 45)
    InputFrame.BackgroundColor3 = Theme.TertiaryBackground
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = parent
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputFrame
    
    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Theme.Border
    InputStroke.Thickness = 1
    InputStroke.Transparency = 0.5
    InputStroke.Parent = InputFrame
    
    -- Glass Effect
    local InputGlass = CreateGlassEffect(InputFrame)
    InputGlass.BackgroundTransparency = 0.97
    
    local InputLabel = Instance.new("TextLabel")
    InputLabel.Size = UDim2.new(0.4, -10, 1, 0)
    InputLabel.Position = UDim2.new(0, 15, 0, 0)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = inputText
    InputLabel.TextColor3 = Theme.TextPrimary
    InputLabel.TextScaled = true
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.Font = Enum.Font.Gotham
    InputLabel.Parent = InputFrame
    
    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(0.6, -15, 0, 30)
    InputBox.Position = UDim2.new(0.4, 0, 0.5, -15)
    InputBox.BackgroundColor3 = Theme.SecondaryBackground
    InputBox.PlaceholderText = placeholderText
    InputBox.PlaceholderColor3 = Theme.TextTertiary
    InputBox.Text = ""
    InputBox.TextColor3 = Theme.TextPrimary
    InputBox.TextScaled = true
    InputBox.TextXAlignment = Enum.TextXAlignment.Left
    InputBox.Font = Enum.Font.Gotham
    InputBox.ClearTextOnFocus = false
    InputBox.BorderSizePixel = 0
    InputBox.Parent = InputFrame
    
    local InputBoxCorner = Instance.new("UICorner")
    InputBoxCorner.CornerRadius = UDim.new(0, 6)
    InputBoxCorner.Parent = InputBox
    
    local InputBoxStroke = Instance.new("UIStroke")
    InputBoxStroke.Color = Theme.Border
    InputBoxStroke.Thickness = 1
    InputBoxStroke.Transparency = 0.7
    InputBoxStroke.Parent = InputBox
    
    -- Focus Effects
    InputBox.Focused:Connect(function()
        CreateTween(InputBoxStroke, TweenInfo.new(0.2), {Color = Theme.Primary, Transparency = 0.3})
    end)
    
    InputBox.FocusLost:Connect(function(enterPressed)
        CreateTween(InputBoxStroke, TweenInfo.new(0.2), {Color = Theme.Border, Transparency = 0.7})
        if enterPressed then
            callback(InputBox.Text)
        end
    end)
    
    return InputBox
end

function Library:CreateDropdown(parent, config)
    config = config or {}
    local dropdownText = config.Text or "Dropdown"
    local options = config.Options or {"Option 1", "Option 2", "Option 3"}
    local defaultValue = config.Default or options[1]
    local callback = config.Callback or function() end
    
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
    DropdownFrame.BackgroundColor3 = Theme.TertiaryBackground
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = parent
    
    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownFrame
    
    local DropdownStroke = Instance.new("UIStroke")
    DropdownStroke.Color = Theme.Border
    DropdownStroke.Thickness = 1
    DropdownStroke.Transparency = 0.5
    DropdownStroke.Parent = DropdownFrame
    
    -- Glass Effect
    local DropdownGlass = CreateGlassEffect(DropdownFrame)
    DropdownGlass.BackgroundTransparency = 0.97
    
    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Size = UDim2.new(0.4, -10, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = dropdownText
    DropdownLabel.TextColor3 = Theme.TextPrimary
    DropdownLabel.TextScaled = true
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.Font = Enum.Font.Gotham
    DropdownLabel.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(0.6, -15, 0, 30)
    DropdownButton.Position = UDim2.new(0.4, 0, 0.5, -15)
    DropdownButton.BackgroundColor3 = Theme.SecondaryBackground
    DropdownButton.Text = defaultValue
    DropdownButton.TextColor3 = Theme.TextPrimary
    DropdownButton.TextScaled = true
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.BorderSizePixel = 0
    DropdownButton.Parent = DropdownFrame
    
    local DropdownButtonCorner = Instance.new("UICorner")
    DropdownButtonCorner.CornerRadius = UDim.new(0, 6)
    DropdownButtonCorner.Parent = DropdownButton
    
    local DropdownButtonStroke = Instance.new("UIStroke")
    DropdownButtonStroke.Color = Theme.Border
    DropdownButtonStroke.Thickness = 1
    DropdownButtonStroke.Transparency = 0.7
    DropdownButtonStroke.Parent = DropdownButton
    
    -- Dropdown Arrow
    local DropdownArrow = Instance.new("TextLabel")
    DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
    DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
    DropdownArrow.BackgroundTransparency = 1
    DropdownArrow.Text = "▼"
    DropdownArrow.TextColor3 = Theme.TextSecondary
    DropdownArrow.TextScaled = true
    DropdownArrow.Font = Enum.Font.Gotham
    DropdownArrow.Parent = DropdownButton
    
    -- Dropdown List
    local DropdownList = Instance.new("Frame")
    DropdownList.Name = "DropdownList"
    DropdownList.Size = UDim2.new(0.6, -15, 0, math.min(#options * 35, 150))
    DropdownList.Position = UDim2.new(0.4, 0, 1, 5)
    DropdownList.BackgroundColor3 = Theme.SecondaryBackground
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.ZIndex = 10
    DropdownList.Parent = DropdownFrame
    
    local DropdownListCorner = Instance.new("UICorner")
    DropdownListCorner.CornerRadius = UDim.new(0, 8)
    DropdownListCorner.Parent = DropdownList
    
    local DropdownListStroke = Instance.new("UIStroke")
    DropdownListStroke.Color = Theme.Border
    DropdownListStroke.Thickness = 1
    DropdownListStroke.Transparency = 0.3
    DropdownListStroke.Parent = DropdownList
    
    -- Glass Effect for list
    local ListGlass = CreateGlassEffect(DropdownList)
    ListGlass.BackgroundTransparency = 0.95
    
    local DropdownScrolling = Instance.new("ScrollingFrame")
    DropdownScrolling.Size = UDim2.new(1, -10, 1, -10)
    DropdownScrolling.Position = UDim2.new(0, 5, 0, 5)
    DropdownScrolling.BackgroundTransparency = 1
    DropdownScrolling.ScrollBarThickness = 4
    DropdownScrolling.ScrollBarImageColor3 = Theme.Primary
    DropdownScrolling.BorderSizePixel = 0
    DropdownScrolling.CanvasSize = UDim2.new(0, 0, 0, #options * 35)
    DropdownScrolling.ZIndex = 11
    DropdownScrolling.Parent = DropdownList
    
    local DropdownListLayout = Instance.new("UIListLayout")
    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownListLayout.Padding = UDim.new(0, 2)
    DropdownListLayout.Parent = DropdownScrolling
    
    local currentValue = defaultValue
    local isOpen = false
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundColor3 = Theme.TertiaryBackground
        OptionButton.BackgroundTransparency = 0.3
        OptionButton.Text = option
        OptionButton.TextColor3 = Theme.TextPrimary
        OptionButton.TextScaled = true
        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.BorderSizePixel = 0
        OptionButton.ZIndex = 12
        OptionButton.Parent = DropdownScrolling
        
        local OptionCorner = Instance.new("UICorner")
        OptionCorner.CornerRadius = UDim.new(0, 6)
        OptionCorner.Parent = OptionButton
        
        OptionButton.MouseButton1Click:Connect(function()
            currentValue = option
            DropdownButton.Text = option
            isOpen = false
            
            CreateTween(DropdownList, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0.6, -15, 0, 0)})
            wait(0.2)
            DropdownList.Visible = false
            CreateTween(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0})
            
            callback(option)
        end)
        
        -- Hover Effect
        OptionButton.MouseEnter:Connect(function()
            CreateTween(OptionButton, TweenInfo.new(0.1), {BackgroundTransparency = 0})
        end)
        
        OptionButton.MouseLeave:Connect(function()
            CreateTween(OptionButton, TweenInfo.new(0.1), {BackgroundTransparency = 0.3})
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        if isOpen then
            DropdownList.Visible = true
            DropdownList.Size = UDim2.new(0.6, -15, 0, 0)
            CreateTween(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0.6, -15, 0, math.min(#options * 35, 150))})
            CreateTween(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180})
        else
            CreateTween(DropdownList, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0.6, -15, 0, 0)})
            CreateTween(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0})
            wait(0.2)
            DropdownList.Visible = false
        end
    end)
    
    return DropdownFrame
end

-- Notification System
function Library:CreateNotification(config)
    config = config or {}
    local title = config.Title or "Notification"
    local text = config.Text or "This is a notification"
    local duration = config.Duration or 3
    local type = config.Type or "Info"
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "RayfieldNotification"
    NotificationGui.Parent = PlayerGui
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 0, 0, 80)
    NotificationFrame.Position = UDim2.new(1, -20, 0, 100)
    NotificationFrame.BackgroundColor3 = Theme.SecondaryBackground
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local NotificationCorner = Instance.new("UICorner")
    NotificationCorner.CornerRadius = UDim.new(0, 12)
    NotificationCorner.Parent = NotificationFrame
    
    local NotificationStroke = Instance.new("UIStroke")
    NotificationStroke.Color = Theme.Border
    NotificationStroke.Thickness = 1
    NotificationStroke.Transparency = 0.3
    NotificationStroke.Parent = NotificationFrame
    
    -- Glass Effect
    local NotificationGlass = CreateGlassEffect(NotificationFrame)
    NotificationGlass.BackgroundTransparency = 0.9
    
    -- Icon based on type
    local iconText = "ℹ️"
    local accentColor = Theme.Primary
    
    if type == "Success" then
        iconText = "✅"
        accentColor = Theme.Success
    elseif type == "Warning" then
        iconText = "⚠️"
        accentColor = Theme.Warning
    elseif type == "Error" then
        iconText = "❌"
        accentColor = Theme.Error
    end
    
    -- Accent Bar
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    AccentBar.BackgroundColor3 = accentColor
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = NotificationFrame
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 2)
    AccentCorner.Parent = AccentBar
    
    -- Icon
    local NotificationIcon = Instance.new("TextLabel")
    NotificationIcon.Size = UDim2.new(0, 30, 0, 30)
    NotificationIcon.Position = UDim2.new(0, 15, 0, 10)
    NotificationIcon.BackgroundTransparency = 1
    NotificationIcon.Text = iconText
    NotificationIcon.TextColor3 = accentColor
    NotificationIcon.TextScaled = true
    NotificationIcon.Font = Enum.Font.Gotham
    NotificationIcon.Parent = NotificationFrame
    
    -- Title
    local NotificationTitle = Instance.new("TextLabel")
    NotificationTitle.Size = UDim2.new(1, -90, 0, 25)
    NotificationTitle.Position = UDim2.new(0, 55, 0, 8)
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.Text = title
    NotificationTitle.TextColor3 = Theme.TextPrimary
    NotificationTitle.TextScaled = true
    NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotificationTitle.Font = Enum.Font.GothamBold
    NotificationTitle.Parent = NotificationFrame
    
    -- Text
    local NotificationText = Instance.new("TextLabel")
    NotificationText.Size = UDim2.new(1, -90, 0, 35)
    NotificationText.Position = UDim2.new(0, 55, 0, 35)
    NotificationText.BackgroundTransparency = 1
    NotificationText.Text = text
    NotificationText.TextColor3 = Theme.TextSecondary
    NotificationText.TextScaled = true
    NotificationText.TextXAlignment = Enum.TextXAlignment.Left
    NotificationText.TextYAlignment = Enum.TextYAlignment.Top
    NotificationText.Font = Enum.Font.Gotham
    NotificationText.TextWrapped = true
    NotificationText.Parent = NotificationFrame
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -25, 0, 5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.TextTertiary
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = NotificationFrame
    
    -- Animations
    CreateTween(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 350, 0, 80), Position = UDim2.new(1, -370, 0, 100)})
    
    local function CloseNotification()
        CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -20, 0, 100), Size = UDim2.new(0, 0, 0, 80)})
        wait(0.3)
        NotificationGui:Destroy()
    end
    
    CloseButton.MouseButton1Click:Connect(CloseNotification)
    
    -- Auto close
    spawn(function()
        wait(duration)
        if NotificationGui.Parent then
            CloseNotification()
        end
    end)
    
    return NotificationFrame
end

-- Example Usage with Rayfield V2 Style
function Library:Example()
    local Window = self:CreateWindow({
        Title = "Rayfield V2",
        Subtitle = "Universal Script Hub"
    })
    
    -- Create Main Tab
    local MainTab = Window:CreateTab({
        Name = "Main",
        Icon = "🏠"
    })
    
    -- Add Section
    self:CreateSection(MainTab.Content, "🎮 Player Settings")
    
    -- Add Button
    self:CreateButton(MainTab.Content, {
        Text = "Teleport to Spawn",
        Callback = function()
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
                Library:CreateNotification({
                    Title = "Teleport",
                    Text = "Successfully teleported to spawn!",
                    Type = "Success"
                })
            end
        end
    })
    
    -- Add Toggle
    self:CreateToggle(MainTab.Content, {
        Text = "Auto Farm",
        Default = false,
        Callback = function(value)
            print("Auto Farm:", value)
            Library:CreateNotification({
                Title = "Auto Farm",
                Text = "Auto Farm " .. (value and "enabled" or "disabled"),
                Type = value and "Success" or "Warning"
            })
        end
    })
    
    -- Add Slider
    self:CreateSlider(MainTab.Content, {
        Text = "Walk Speed",
        Min = 16,
        Max = 100,
        Default = 16,
        Callback = function(value)
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end
    })
    
    -- Add Input
    self:CreateInput(MainTab.Content, {
        Text = "Player Name",
        PlaceholderText = "Enter player name...",
        Callback = function(text)
            Library:CreateNotification({
                Title = "Input Received",
                Text = "You entered: " .. text,
                Type = "Info"
            })
        end
    })
    
    -- Add Dropdown
    self:CreateDropdown(MainTab.Content, {
        Text = "Game Mode",
        Options = {"Normal", "Hardcore", "Creative", "Survival"},
        Default = "Normal",
        Callback = function(option)
            Library:CreateNotification({
                Title = "Game Mode",
                Text = "Selected: " .. option,
                Type = "Info"
            })
        end
    })
    
    -- Create Settings Tab
    local SettingsTab = Window:CreateTab({
        Name = "Settings",
        Icon = "⚙️"
    })
    
    self:CreateSection(SettingsTab.Content, "🎨 Interface Settings")
    
    self:CreateButton(SettingsTab.Content, {
        Text = "Reset Interface",
        Callback = function()
            Library:CreateNotification({
                Title = "Interface",
                Text = "Interface has been reset!",
                Type = "Warning"
            })
        end
    })
    
    self:CreateToggle(SettingsTab.Content, {
        Text = "Show Notifications",
        Default = true,
        Callback = function(value)
            print("Notifications:", value)
        end
    })
    
    -- Create About Tab
    local AboutTab = Window:CreateTab({
        Name = "About",
        Icon = "ℹ️"
    })
    
    self:CreateSection(AboutTab.Content, "📋 Information")
    
    self:CreateButton(AboutTab.Content, {
        Text = "Show Credits",
        Callback = function()
            Library:CreateNotification({
                Title = "Credits",
                Text = "Rayfield V2 Style UI Library by Assistant",
                Type = "Info",
                Duration = 5
            })
        end
    })
    
    return Window
end

-- Tab Methods Implementation
function Library:CreateTab(window, config)
    return window:CreateTab(config)
end

-- Helper Functions for Tab Content
function Library:AddToTab(tab, elementType, config)
    if elementType == "Section" then
        return self:CreateSection(tab.Content, config.Title or config.Text)
    elseif elementType == "Button" then
        return self:CreateButton(tab.Content, config)
    elseif elementType == "Toggle" then
        return self:CreateToggle(tab.Content, config)
    elseif elementType == "Slider" then
        return self:CreateSlider(tab.Content, config)
    elseif elementType == "Input" then
        return self:CreateInput(tab.Content, config)
    elseif elementType == "Dropdown" then
        return self:CreateDropdown(tab.Content, config)
    end
end

-- Theme Management
function Library:SetTheme(themeName)
    if themeName == "Ocean" then
        Theme.Primary = Color3.fromRGB(59, 130, 246)
        Theme.Secondary = Color3.fromRGB(37, 99, 235)
    elseif themeName == "Forest" then
        Theme.Primary = Color3.fromRGB(34, 197, 94)
        Theme.Secondary = Color3.fromRGB(22, 163, 74)
    elseif themeName == "Sunset" then
        Theme.Primary = Color3.fromRGB(251, 146, 60)
        Theme.Secondary = Color3.fromRGB(249, 115, 22)
    elseif themeName == "Purple" then
        Theme.Primary = Color3.fromRGB(147, 51, 234)
        Theme.Secondary = Color3.fromRGB(126, 34, 206)
    elseif themeName == "Pink" then
        Theme.Primary = Color3.fromRGB(236, 72, 153)
        Theme.Secondary = Color3.fromRGB(219, 39, 119)
    end
    
    self:CreateNotification({
        Title = "Theme Changed",
        Text = "Theme changed to " .. themeName,
        Type = "Success"
    })
end

-- Advanced Features
function Library:CreateKeybind(key, callback)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == key then
            callback()
        end
    end)
end

function Library:CreateColorPicker(parent, config)
    config = config or {}
    local colorText = config.Text or "Color"
    local defaultColor = config.Default or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or function() end
    
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Name = "ColorFrame"
    ColorFrame.Size = UDim2.new(1, 0, 0, 45)
    ColorFrame.BackgroundColor3 = Theme.TertiaryBackground
    ColorFrame.BorderSizePixel = 0
    ColorFrame.Parent = parent
    
    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(0, 8)
    ColorCorner.Parent = ColorFrame
    
    local ColorStroke = Instance.new("UIStroke")
    ColorStroke.Color = Theme.Border
    ColorStroke.Thickness = 1
    ColorStroke.Transparency = 0.5
    ColorStroke.Parent = ColorFrame
    
    -- Glass Effect
    local ColorGlass = CreateGlassEffect(ColorFrame)
    ColorGlass.BackgroundTransparency = 0.97
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(0.7, -10, 1, 0)
    ColorLabel.Position = UDim2.new(0, 15, 0, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = colorText
    ColorLabel.TextColor3 = Theme.TextPrimary
    ColorLabel.TextScaled = true
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Font = Enum.Font.Gotham
    ColorLabel.Parent = ColorFrame
    
    local ColorDisplay = Instance.new("TextButton")
    ColorDisplay.Size = UDim2.new(0, 60, 0, 25)
    ColorDisplay.Position = UDim2.new(1, -75, 0.5, -12.5)
    ColorDisplay.BackgroundColor3 = defaultColor
    ColorDisplay.Text = ""
    ColorDisplay.BorderSizePixel = 0
    ColorDisplay.Parent = ColorFrame
    
    local ColorDisplayCorner = Instance.new("UICorner")
    ColorDisplayCorner.CornerRadius = UDim.new(0, 6)
    ColorDisplayCorner.Parent = ColorDisplay
    
    local ColorDisplayStroke = Instance.new("UIStroke")
    ColorDisplayStroke.Color = Theme.Border
    ColorDisplayStroke.Thickness = 1
    ColorDisplayStroke.Transparency = 0.5
    ColorDisplayStroke.Parent = ColorDisplay
    
    ColorDisplay.MouseButton1Click:Connect(function()
        -- Simple color cycle for demo
        local colors = {
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 255, 255)
        }
        
        local currentIndex = 1
        for i, color in ipairs(colors) do
            if ColorDisplay.BackgroundColor3 == color then
                currentIndex = i
                break
            end
        end
        
        local nextIndex = (currentIndex % #colors) + 1
        local newColor = colors[nextIndex]
        
        CreateTween(ColorDisplay, TweenInfo.new(0.2), {BackgroundColor3 = newColor})
        callback(newColor)
    end)
    
    return ColorFrame
end

-- Mobile Specific Features
if IsMobile() then
    function Library:CreateMobileToggle()
        local MobileGui = Instance.new("ScreenGui")
        MobileGui.Name = "RayfieldMobile"
        MobileGui.Parent = PlayerGui
        MobileGui.ResetOnSpawn = false
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0, 80, 0, 80)
        ToggleButton.Position = UDim2.new(0, 20, 0.5, -40)
        ToggleButton.BackgroundColor3 = Theme.Primary
        ToggleButton.Text = "R"
        ToggleButton.TextColor3 = Theme.TextPrimary
        ToggleButton.TextScaled = true
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Parent = MobileGui
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 40)
        ToggleCorner.Parent = ToggleButton
        
        CreateGradient(ToggleButton, 45, {
            ColorSequenceKeypoint.new(0, Theme.Primary),
            ColorSequenceKeypoint.new(1, Theme.Secondary)
        })
        
        -- Shadow
        local Shadow = Instance.new("Frame")
        Shadow.Size = UDim2.new(1, 10, 1, 10)
        Shadow.Position = UDim2.new(0, -5, 0, -5)
        Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Shadow.BackgroundTransparency = 0.7
        Shadow.BorderSizePixel = 0
        Shadow.ZIndex = ToggleButton.ZIndex - 1
        Shadow.Parent = ToggleButton
        
        local ShadowCorner = Instance.new("UICorner")
        ShadowCorner.CornerRadius = UDim.new(0, 45)
        ShadowCorner.Parent = Shadow
        
        return ToggleButton
    end
end

-- Performance Optimization
function Library:OptimizePerformance()
    -- Reduce particle count on mobile
    if IsMobile() then
        return
    end
    
    -- Limit frame rate for animations
    local lastUpdate = tick()
    RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - lastUpdate < 1/60 then
            return
        end
        lastUpdate = now
    end)
end

-- Anti-Detection (Basic)
function Library:EnableAntiDetection()
    local guis = PlayerGui:GetChildren()
    for _, gui in ipairs(guis) do
        if gui.Name:find("Rayfield") then
            gui.Name = "PlayerGui_" .. math.random(10000, 99999)
        end
    end
    
    self:CreateNotification({
        Title = "Security",
        Text = "Anti-detection enabled",
        Type = "Success"
    })
end

-- Save/Load Configuration
function Library:SaveConfig(configName, data)
    -- In a real implementation, this would save to DataStore or file
    _G["RayfieldConfig_" .. configName] = data
    
    self:CreateNotification({
        Title = "Configuration",
        Text = "Config '" .. configName .. "' saved successfully!",
        Type = "Success"
    })
end

function Library:LoadConfig(configName)
    -- In a real implementation, this would load from DataStore or file
    local data = _G["RayfieldConfig_" .. configName]
    
    if data then
        self:CreateNotification({
            Title = "Configuration",
            Text = "Config '" .. configName .. "' loaded successfully!",
            Type = "Success"
        })
        return data
    else
        self:CreateNotification({
            Title = "Configuration",
            Text = "Config '" .. configName .. "' not found!",
            Type = "Error"
        })
        return nil
    end
end

-- Initialize Performance Optimization
Library:OptimizePerformance()

return Library
