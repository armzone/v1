local player = game.Players.LocalPlayer

-- ฟังก์ชันสำหรับการรีเซ็ตตัวละคร
local function onCharacterAdded(character)
    local rootPart = character:WaitForChild("HumanoidRootPart") -- รอให้โหลด HumanoidRootPart
    local playerGui = player:WaitForChild("PlayerGui")

    -- สร้าง UI เพียงครั้งเดียว
    local screenGui = playerGui:FindFirstChild("RaidStatusGui") or Instance.new("ScreenGui", playerGui)
    screenGui.Name = "RaidStatusGui"

    local raidStatusLabel = screenGui:FindFirstChild("RaidStatusLabel") or Instance.new("TextLabel", screenGui)
    raidStatusLabel.Name = "RaidStatusLabel"
    raidStatusLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
    raidStatusLabel.Position = UDim2.new(0, 10, 0, 10)
    raidStatusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    raidStatusLabel.BackgroundTransparency = 0.5
    raidStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    raidStatusLabel.Font = Enum.Font.SourceSans
    raidStatusLabel.TextSize = 24
    raidStatusLabel.Text = "Initializing..."

    local raidSummon = workspace:WaitForChild("Map"):WaitForChild("Boat Castle"):WaitForChild("RaidSummon2")
    local raid1 = raidSummon:FindFirstChild("Raid1")
    local raid2 = raidSummon:FindFirstChild("Raid2")
    local raid3 = raidSummon:FindFirstChild("Raid3")

    local function selectRaid()
        if _G.raidSelection == 1 then
            raidStatusLabel.Text = "Raid 1 is selected explicitly via _G."
            return raid1
        elseif _G.raidSelection == 2 then
            raidStatusLabel.Text = "Raid 2 is selected explicitly via _G."
            return raid2
        elseif _G.raidSelection == 3 then
            raidStatusLabel.Text = "Raid 3 is selected explicitly via _G."
            return raid3
        else
            raidStatusLabel.Text = "Invalid _G.raidSelection value. Defaulting to Raid 1."
            return raid1
        end
    end

    -- ลูปตรวจสอบและเลือก Raid อัตโนมัติ
    spawn(function()
        local errorCount = 0
        while true do
            wait(1) -- ลดภาระระบบ

            -- ตรวจสอบ Timer ด้วยคุณสมบัติ Visible
            local timer = playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("Timer")
            if timer and timer:IsA("TextLabel") and timer.Visible then
                raidStatusLabel.Text = "Timer is active. Pausing actions..."
                repeat
                    wait(1)
                    timer = playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("Timer")
                until not (timer and timer:IsA("TextLabel") and timer.Visible)
                raidStatusLabel.Text = "Timer is gone. Resuming actions..."
            end

            local selectedRaid = selectRaid()

            if selectedRaid then
                local success, message = pcall(function()
                    local hitbox = selectedRaid:FindFirstChild("Hitbox")
                    if hitbox and hitbox:FindFirstChild("TouchInterest") and rootPart:IsDescendantOf(workspace) then
                        -- Interact with Hitbox
                        raidStatusLabel.Text = "Interacting with " .. selectedRaid.Name
                        firetouchinterest(rootPart, hitbox, 0)
                        wait(0.1)
                        firetouchinterest(rootPart, hitbox, 1)
                    else
                        raidStatusLabel.Text = "Hitbox or TouchInterest not found. Retrying..."
                    end
                end)

                if not success then
                    errorCount = errorCount + 1
                    raidStatusLabel.Text = "Error: " .. message
                    if errorCount >= 5 then
                        raidStatusLabel.Text = "Too many errors. Retrying in 5 seconds."
                        wait(5)
                        errorCount = 0
                    end
                end
            else
                raidStatusLabel.Text = "No Raid selected. Retrying..."
            end
        end
    end)
end

-- เชื่อมต่อฟังก์ชันสำหรับการรีเซ็ตตัวละคร
player.CharacterAdded:Connect(onCharacterAdded)

-- เรียกใช้ฟังก์ชันสำหรับตัวละครปัจจุบัน (หากมี)
if player.Character then
    onCharacterAdded(player.Character)
end
