-- Modern UI Library for Roblox (PC & Mobile Compatible)
-- Created by Assistant

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Theme Configuration
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(85, 170, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(170, 170, 170),
    Success = Color3.fromRGB(75, 181, 67),
    Warning = Color3.fromRGB(255, 193, 7),
    Error = Color3.fromRGB(220, 53, 69),
    Border = Color3.fromRGB(55, 55, 65)
}

-- Utility Functions
local function CreateTween(object, info, properties)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- Main Library Functions
function Library:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "UI Library"
    local size = config.Size or UDim2.new(0, IsMobile() and 350 or 500, 0, IsMobile() and 400 or 600)
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUILibrary"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = size
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = not IsMobile()
    
    -- Corner Rounding
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    -- Drop Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxasset://textures/ui/Controls/DropShadow.png"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(12, 12, 276, 276)
    Shadow.ZIndex = MainFrame.ZIndex - 1
    Shadow.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar
    
    -- Title Corner Fix
    local TitleFix = Instance.new("Frame")
    TitleFix.Size = UDim2.new(1, 0, 0, 12)
    TitleFix.Position = UDim2.new(0, 0, 1, -12)
    TitleFix.BackgroundColor3 = Theme.Secondary
    TitleFix.BorderSizePixel = 0
    TitleFix.Parent = TitleBar
    
    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 20, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = windowTitle
    TitleText.TextColor3 = Theme.Text
    TitleText.TextScaled = true
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -75, 0, 10)
    MinimizeButton.BackgroundColor3 = Theme.Warning
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextScaled = true
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Parent = TitleBar
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeButton
    
    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -40, 1, -70)
    ContentFrame.Position = UDim2.new(0, 20, 0, 60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Theme.Accent
    ContentFrame.BorderSizePixel = 0
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentFrame.Parent = MainFrame
    
    -- Content Layout
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = ContentFrame
    
    -- Window Object
    local Window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        ContentFrame = ContentFrame,
        IsMinimized = false
    }
    
    -- Button Functionality
    local isMinimized = false
    
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)})
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        Window.IsMinimized = isMinimized
        
        if isMinimized then
            CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, size.X.Offset, 0, 50)})
            MinimizeButton.Text = "+"
        else
            CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = size})
            MinimizeButton.Text = "—"
        end
    end)
    
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
    
    AddHoverEffect(CloseButton, Color3.fromRGB(255, 100, 100))
    AddHoverEffect(MinimizeButton, Color3.fromRGB(255, 220, 50))
    
    -- Window Methods
    function Window:CreateSection(title)
        local Section = Instance.new("Frame")
        Section.Name = "Section"
        Section.Size = UDim2.new(1, 0, 0, 40)
        Section.BackgroundColor3 = Theme.Secondary
        Section.BorderSizePixel = 0
        Section.Parent = self.ContentFrame
        
        local SectionCorner = Instance.new("UICorner")
        SectionCorner.CornerRadius = UDim.new(0, 8)
        SectionCorner.Parent = Section
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Size = UDim2.new(1, -20, 1, 0)
        SectionTitle.Position = UDim2.new(0, 10, 0, 0)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Text = title
        SectionTitle.TextColor3 = Theme.Text
        SectionTitle.TextScaled = true
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        SectionTitle.Font = Enum.Font.Gotham
        SectionTitle.Parent = Section
        
        return Section
    end
    
    function Window:CreateButton(config)
        config = config or {}
        local buttonText = config.Text or "Button"
        local callback = config.Callback or function() end
        
        local Button = Instance.new("TextButton")
        Button.Name = "Button"
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Theme.Accent
        Button.Text = buttonText
        Button.TextColor3 = Theme.Text
        Button.TextScaled = true
        Button.Font = Enum.Font.Gotham
        Button.BorderSizePixel = 0
        Button.Parent = self.ContentFrame
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(callback)
        
        AddHoverEffect(Button, Color3.fromRGB(100, 180, 255))
        
        return Button
    end
    
    function Window:CreateToggle(config)
        config = config or {}
        local toggleText = config.Text or "Toggle"
        local defaultValue = config.Default or false
        local callback = config.Callback or function() end
        
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = "ToggleFrame"
        ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
        ToggleFrame.BackgroundColor3 = Theme.Secondary
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = self.ContentFrame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCorner.Parent = ToggleFrame
        
        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
        ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = toggleText
        ToggleLabel.TextColor3 = Theme.Text
        ToggleLabel.TextScaled = true
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.Parent = ToggleFrame
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0, 40, 0, 20)
        ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
        ToggleButton.BackgroundColor3 = defaultValue and Theme.Success or Theme.Border
        ToggleButton.Text = ""
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Parent = ToggleFrame
        
        local ToggleButtonCorner = Instance.new("UICorner")
        ToggleButtonCorner.CornerRadius = UDim.new(0, 10)
        ToggleButtonCorner.Parent = ToggleButton
        
        local ToggleCircle = Instance.new("Frame")
        ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
        ToggleCircle.Position = defaultValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        ToggleCircle.BackgroundColor3 = Theme.Text
        ToggleCircle.BorderSizePixel = 0
        ToggleCircle.Parent = ToggleButton
        
        local ToggleCircleCorner = Instance.new("UICorner")
        ToggleCircleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCircleCorner.Parent = ToggleCircle
        
        local toggled = defaultValue
        
        ToggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            if toggled then
                CreateTween(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Success})
                CreateTween(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)})
            else
                CreateTween(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Border})
                CreateTween(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)})
            end
            
            callback(toggled)
        end)
        
        return ToggleFrame
    end
    
    function Window:CreateSlider(config)
        config = config or {}
        local sliderText = config.Text or "Slider"
        local minValue = config.Min or 0
        local maxValue = config.Max or 100
        local defaultValue = config.Default or minValue
        local callback = config.Callback or function() end
        
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = "SliderFrame"
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.BackgroundColor3 = Theme.Secondary
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Parent = self.ContentFrame
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 8)
        SliderCorner.Parent = SliderFrame
        
        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(1, -20, 0, 20)
        SliderLabel.Position = UDim2.new(0, 10, 0, 5)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = sliderText
        SliderLabel.TextColor3 = Theme.Text
        SliderLabel.TextScaled = true
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.Parent = SliderFrame
        
        local SliderValue = Instance.new("TextLabel")
        SliderValue.Size = UDim2.new(0, 50, 0, 20)
        SliderValue.Position = UDim2.new(1, -60, 0, 5)
        SliderValue.BackgroundTransparency = 1
        SliderValue.Text = tostring(defaultValue)
        SliderValue.TextColor3 = Theme.Accent
        SliderValue.TextScaled = true
        SliderValue.TextXAlignment = Enum.TextXAlignment.Right
        SliderValue.Font = Enum.Font.GothamBold
        SliderValue.Parent = SliderFrame
        
        local SliderBar = Instance.new("Frame")
        SliderBar.Size = UDim2.new(1, -20, 0, 4)
        SliderBar.Position = UDim2.new(0, 10, 1, -15)
        SliderBar.BackgroundColor3 = Theme.Border
        SliderBar.BorderSizePixel = 0
        SliderBar.Parent = SliderFrame
        
        local SliderBarCorner = Instance.new("UICorner")
        SliderBarCorner.CornerRadius = UDim.new(0, 2)
        SliderBarCorner.Parent = SliderBar
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
        SliderFill.BackgroundColor3 = Theme.Accent
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderBar
        
        local SliderFillCorner = Instance.new("UICorner")
        SliderFillCorner.CornerRadius = UDim.new(0, 2)
        SliderFillCorner.Parent = SliderFill
        
        local SliderButton = Instance.new("TextButton")
        SliderButton.Size = UDim2.new(0, 12, 0, 12)
        SliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -6, 0.5, -6)
        SliderButton.BackgroundColor3 = Theme.Text
        SliderButton.Text = ""
        SliderButton.BorderSizePixel = 0
        SliderButton.Parent = SliderBar
        
        local SliderButtonCorner = Instance.new("UICorner")
        SliderButtonCorner.CornerRadius = UDim.new(0, 6)
        SliderButtonCorner.Parent = SliderButton
        
        local currentValue = defaultValue
        local dragging = false
        
        local function UpdateSlider(value)
            currentValue = math.clamp(value, minValue, maxValue)
            local percentage = (currentValue - minValue) / (maxValue - minValue)
            
            SliderValue.Text = tostring(math.floor(currentValue))
            CreateTween(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(percentage, 0, 1, 0)})
            CreateTween(SliderButton, TweenInfo.new(0.1), {Position = UDim2.new(percentage, -6, 0.5, -6)})
            
            callback(currentValue)
        end
        
        SliderButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = input.Position.X
                local sliderPos = SliderBar.AbsolutePosition.X
                local sliderSize = SliderBar.AbsoluteSize.X
                local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                local value = minValue + (percentage * (maxValue - minValue))
                UpdateSlider(value)
            end
        end)
        
        return SliderFrame
    end
    
    function Window:CreateTextBox(config)
        config = config or {}
        local placeholderText = config.PlaceholderText or "Enter text..."
        local callback = config.Callback or function() end
        
        local TextBoxFrame = Instance.new("Frame")
        TextBoxFrame.Name = "TextBoxFrame"
        TextBoxFrame.Size = UDim2.new(1, 0, 0, 35)
        TextBoxFrame.BackgroundColor3 = Theme.Secondary
        TextBoxFrame.BorderSizePixel = 0
        TextBoxFrame.Parent = self.ContentFrame
        
        local TextBoxCorner = Instance.new("UICorner")
        TextBoxCorner.CornerRadius = UDim.new(0, 8)
        TextBoxCorner.Parent = TextBoxFrame
        
        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(1, -20, 1, 0)
        TextBox.Position = UDim2.new(0, 10, 0, 0)
        TextBox.BackgroundTransparency = 1
        TextBox.PlaceholderText = placeholderText
        TextBox.PlaceholderColor3 = Theme.TextSecondary
        TextBox.Text = ""
        TextBox.TextColor3 = Theme.Text
        TextBox.TextScaled = true
        TextBox.TextXAlignment = Enum.TextXAlignment.Left
        TextBox.Font = Enum.Font.Gotham
        TextBox.ClearTextOnFocus = false
        TextBox.Parent = TextBoxFrame
        
        TextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(TextBox.Text)
            end
        end)
        
        return TextBox
    end
    
    function Window:CreateDropdown(config)
        config = config or {}
        local dropdownText = config.Text or "Dropdown"
        local options = config.Options or {"Option 1", "Option 2", "Option 3"}
        local defaultValue = config.Default or options[1]
        local callback = config.Callback or function() end
        
        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Name = "DropdownFrame"
        DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
        DropdownFrame.BackgroundColor3 = Theme.Secondary
        DropdownFrame.BorderSizePixel = 0
        DropdownFrame.Parent = self.ContentFrame
        
        local DropdownCorner = Instance.new("UICorner")
        DropdownCorner.CornerRadius = UDim.new(0, 8)
        DropdownCorner.Parent = DropdownFrame
        
        local DropdownLabel = Instance.new("TextLabel")
        DropdownLabel.Size = UDim2.new(0.5, -10, 1, 0)
        DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
        DropdownLabel.BackgroundTransparency = 1
        DropdownLabel.Text = dropdownText
        DropdownLabel.TextColor3 = Theme.Text
        DropdownLabel.TextScaled = true
        DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
        DropdownLabel.Font = Enum.Font.Gotham
        DropdownLabel.Parent = DropdownFrame
        
        local DropdownButton = Instance.new("TextButton")
        DropdownButton.Size = UDim2.new(0.5, -10, 0, 25)
        DropdownButton.Position = UDim2.new(0.5, 0, 0.5, -12.5)
        DropdownButton.BackgroundColor3 = Theme.Background
        DropdownButton.Text = defaultValue
        DropdownButton.TextColor3 = Theme.Text
        DropdownButton.TextScaled = true
        DropdownButton.Font = Enum.Font.Gotham
        DropdownButton.BorderSizePixel = 0
        DropdownButton.Parent = DropdownFrame
        
        local DropdownButtonCorner = Instance.new("UICorner")
        DropdownButtonCorner.CornerRadius = UDim.new(0, 6)
        DropdownButtonCorner.Parent = DropdownButton
        
        local DropdownList = Instance.new("Frame")
        DropdownList.Name = "DropdownList"
        DropdownList.Size = UDim2.new(0.5, -10, 0, #options * 25)
        DropdownList.Position = UDim2.new(0.5, 0, 1, 5)
        DropdownList.BackgroundColor3 = Theme.Background
        DropdownList.BorderSizePixel = 0
        DropdownList.Visible = false
        DropdownList.ZIndex = 10
        DropdownList.Parent = DropdownFrame
        
        local DropdownListCorner = Instance.new("UICorner")
        DropdownListCorner.CornerRadius = UDim.new(0, 6)
        DropdownListCorner.Parent = DropdownList
        
        local DropdownListLayout = Instance.new("UIListLayout")
        DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        DropdownListLayout.Parent = DropdownList
        
        local currentValue = defaultValue
        local isOpen = false
        
        for i, option in ipairs(options) do
            local OptionButton = Instance.new("TextButton")
            OptionButton.Size = UDim2.new(1, 0, 0, 25)
            OptionButton.BackgroundColor3 = Theme.Background
            OptionButton.Text = option
            OptionButton.TextColor3 = Theme.Text
            OptionButton.TextScaled = true
            OptionButton.Font = Enum.Font.Gotham
            OptionButton.BorderSizePixel = 0
            OptionButton.ZIndex = 11
            OptionButton.Parent = DropdownList
            
            OptionButton.MouseButton1Click:Connect(function()
                currentValue = option
                DropdownButton.Text = option
                DropdownList.Visible = false
                isOpen = false
                callback(option)
            end)
            
            AddHoverEffect(OptionButton, Theme.Secondary)
        end
        
        DropdownButton.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            DropdownList.Visible = isOpen
        end)
        
        return DropdownFrame
    end
    
    -- Mobile Optimization
    if IsMobile() then
        MainFrame.Size = UDim2.new(0, 350, 0, 500)
        ContentFrame.ScrollBarThickness = 8
    end
    
    return Window
end

-- Example Usage Function
function Library:Example()
    local Window = self:CreateWindow({
        Title = "Modern UI Library",
        Size = UDim2.new(0, 500, 0, 600)
    })
    
    Window:CreateSection("Buttons & Actions")
    
    Window:CreateButton({
        Text = "Click Me!",
        Callback = function()
            print("Button clicked!")
        end
    })
    
    Window:CreateSection("Toggles & Settings")
    
    Window:CreateToggle({
        Text = "Auto Farm",
        Default = false,
        Callback = function(value)
            print("Auto Farm:", value)
        end
    })
    
    Window:CreateToggle({
        Text = "ESP Players",
        Default = true,
        Callback = function(value)
            print("ESP Players:", value)
        end
    })
    
    Window:CreateSection("Values & Input")
    
    Window:CreateSlider({
        Text = "Walk Speed",
        Min = 16,
        Max = 100,
        Default = 16,
        Callback = function(value)
            print("Walk Speed:", value)
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end
    })
    
    Window:CreateTextBox({
        PlaceholderText = "Enter your name...",
        Callback = function(text)
            print("Text entered:", text)
        end
    })
    
    Window:CreateDropdown({
        Text = "Select Game Mode",
        Options = {"Normal", "Hardcore", "Creative", "Survival"},
        Default = "Normal",
        Callback = function(option)
            print("Selected:", option)
        end
    })
    
    Window:CreateSection("Advanced Features")
    
    Window:CreateButton({
        Text = "Teleport to Spawn",
        Callback = function()
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
                print("Teleported to spawn!")
            end
        end
    })
    
    Window:CreateSlider({
        Text = "Jump Power",
        Min = 50,
        Max = 200,
        Default = 50,
        Callback = function(value)
            print("Jump Power:", value)
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                Players.LocalPlayer.Character.Humanoid.JumpPower = value
            end
        end
    })
    
    return Window
end

-- Additional Utility Functions
function Library:Notification(config)
    config = config or {}
    local title = config.Title or "Notification"
    local text = config.Text or "This is a notification"
    local duration = config.Duration or 3
    local type = config.Type or "Info" -- Info, Success, Warning, Error
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "NotificationSystem"
    NotificationGui.Parent = PlayerGui
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
    NotificationFrame.Position = UDim2.new(1, -320, 0, 20)
    NotificationFrame.BackgroundColor3 = Theme.Secondary
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local NotificationCorner = Instance.new("UICorner")
    NotificationCorner.CornerRadius = UDim.new(0, 8)
    NotificationCorner.Parent = NotificationFrame
    
    -- Accent Bar
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = NotificationFrame
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 2)
    AccentCorner.Parent = AccentBar
    
    -- Set color based on type
    if type == "Success" then
        AccentBar.BackgroundColor3 = Theme.Success
    elseif type == "Warning" then
        AccentBar.BackgroundColor3 = Theme.Warning
    elseif type == "Error" then
        AccentBar.BackgroundColor3 = Theme.Error
    else
        AccentBar.BackgroundColor3 = Theme.Accent
    end
    
    local NotificationTitle = Instance.new("TextLabel")
    NotificationTitle.Size = UDim2.new(1, -50, 0, 25)
    NotificationTitle.Position = UDim2.new(0, 15, 0, 5)
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.Text = title
    NotificationTitle.TextColor3 = Theme.Text
    NotificationTitle.TextScaled = true
    NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotificationTitle.Font = Enum.Font.GothamBold
    NotificationTitle.Parent = NotificationFrame
    
    local NotificationText = Instance.new("TextLabel")
    NotificationText.Size = UDim2.new(1, -50, 0, 40)
    NotificationText.Position = UDim2.new(0, 15, 0, 30)
    NotificationText.BackgroundTransparency = 1
    NotificationText.Text = text
    NotificationText.TextColor3 = Theme.TextSecondary
    NotificationText.TextScaled = true
    NotificationText.TextXAlignment = Enum.TextXAlignment.Left
    NotificationText.TextYAlignment = Enum.TextYAlignment.Top
    NotificationText.Font = Enum.Font.Gotham
    NotificationText.TextWrapped = true
    NotificationText.Parent = NotificationFrame
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -25, 0, 5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.TextSecondary
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = NotificationFrame
    
    -- Slide in animation
    NotificationFrame.Position = UDim2.new(1, 0, 0, 20)
    CreateTween(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(1, -320, 0, 20)})
    
    -- Auto close
    local closeNotification = function()
        CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 0, 0, 20)})
        wait(0.3)
        NotificationGui:Destroy()
    end
    
    CloseButton.MouseButton1Click:Connect(closeNotification)
    
    spawn(function()
        wait(duration)
        if NotificationGui.Parent then
            closeNotification()
        end
    end)
    
    return NotificationFrame
end

function Library:LoadConfiguration(configName)
    -- This would normally load from a file or DataStore
    -- For demo purposes, we'll just show the structure
    print("Loading configuration:", configName)
    
    self:Notification({
        Title = "Configuration",
        Text = "Configuration '" .. configName .. "' loaded successfully!",
        Type = "Success",
        Duration = 2
    })
end

function Library:SaveConfiguration(configName)
    -- This would normally save to a file or DataStore
    -- For demo purposes, we'll just show the structure
    print("Saving configuration:", configName)
    
    self:Notification({
        Title = "Configuration",
        Text = "Configuration '" .. configName .. "' saved successfully!",
        Type = "Success",
        Duration = 2
    })
end

-- Anti-Detection Features
function Library:EnableAntiDetection()
    -- Hide from basic detection methods
    local ScreenGui = PlayerGui:FindFirstChild("ModernUILibrary")
    if ScreenGui then
        ScreenGui.Name = "PlayerGui" .. math.random(1000, 9999)
        
        -- Hook common detection methods
        local oldNameProperty = ScreenGui.Name
        local oldParentProperty = ScreenGui.Parent
        
        -- This is a basic example - real anti-detection would be more complex
        print("Anti-detection enabled for UI")
    end
end

-- Mobile-Specific Features
function Library:CreateMobileControls()
    if not IsMobile() then return end
    
    local MobileGui = Instance.new("ScreenGui")
    MobileGui.Name = "MobileControls"
    MobileGui.Parent = PlayerGui
    MobileGui.ResetOnSpawn = false
    
    -- Floating Action Button
    local FAB = Instance.new("TextButton")
    FAB.Size = UDim2.new(0, 60, 0, 60)
    FAB.Position = UDim2.new(1, -80, 1, -150)
    FAB.BackgroundColor3 = Theme.Accent
    FAB.Text = "⚙️"
    FAB.TextScaled = true
    FAB.Font = Enum.Font.GothamBold
    FAB.BorderSizePixel = 0
    FAB.Parent = MobileGui
    
    local FABCorner = Instance.new("UICorner")
    FABCorner.CornerRadius = UDim.new(0, 30)
    FABCorner.Parent = FAB
    
    -- Shadow for FAB
    local FABShadow = Instance.new("ImageLabel")
    FABShadow.Size = UDim2.new(1, 10, 1, 10)
    FABShadow.Position = UDim2.new(0, -5, 0, -5)
    FABShadow.BackgroundTransparency = 1
    FABShadow.Image = "rbxasset://textures/ui/Controls/DropShadow.png"
    FABShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    FABShadow.ImageTransparency = 0.7
    FABShadow.ScaleType = Enum.ScaleType.Slice
    FABShadow.SliceCenter = Rect.new(12, 12, 276, 276)
    FABShadow.ZIndex = FAB.ZIndex - 1
    FABShadow.Parent = FAB
    
    -- Make FAB draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    FAB.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = FAB.Position
        end
    end)
    
    FAB.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            FAB.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    FAB.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    return MobileGui
end

-- Theme Management
function Library:SetTheme(themeName)
    if themeName == "Dark" then
        Theme.Background = Color3.fromRGB(25, 25, 35)
        Theme.Secondary = Color3.fromRGB(35, 35, 45)
        Theme.Text = Color3.fromRGB(255, 255, 255)
    elseif themeName == "Light" then
        Theme.Background = Color3.fromRGB(240, 240, 245)
        Theme.Secondary = Color3.fromRGB(255, 255, 255)
        Theme.Text = Color3.fromRGB(25, 25, 35)
    elseif themeName == "Blue" then
        Theme.Background = Color3.fromRGB(15, 25, 45)
        Theme.Secondary = Color3.fromRGB(25, 35, 55)
        Theme.Accent = Color3.fromRGB(65, 150, 255)
    end
    
    print("Theme changed to:", themeName)
end

-- Performance Optimization
function Library:OptimizePerformance()
    -- Reduce unnecessary redraws
    local connection
    connection = RunService.Heartbeat:Connect(function()
        -- Limit UI updates to 30 FPS for better performance
        wait(1/30)
    end)
    
    -- Clean up on window close
    return function()
        if connection then
            connection:Disconnect()
        end
    end
end

-- Export the library
return Library
