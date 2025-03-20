local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local symbol = "卍" --i decided to make the esp Billboard system so that we can kill the niggers and black people jkjk so that it's easy to render
local isHighlighting = false
local espEnabled = false
local boxSize = Vector3.new(4, 6, 2)

local function createBillboard(player)
    if player.Character then
        local character = player.Character
        local part = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
        
        if part then
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = part
            billboard.Parent = part
            billboard.Size = UDim2.new(0, 80, 0, 80)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            
            local label = Instance.new("TextLabel")
            label.Text = symbol
            label.Font = Enum.Font.SourceSans
            label.TextSize = 60
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Parent = billboard
        end
    end
end

local function removeBillboard(player)
    if player.Character then
        local character = player.Character
        local part = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
        
        if part then
            for _, obj in pairs(part:GetChildren()) do
                if obj:IsA("BillboardGui") then
                    obj:Destroy()
                end
            end
        end
    end
end

local function createESP(player)
    if player.Character then
        local character = player.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoid and rootPart then
            local box = Instance.new("Frame")
            box.Size = UDim2.new(0, boxSize.X, 0, boxSize.Y)
            box.Position = UDim2.new(0.5, -boxSize.X/2, 0, -boxSize.Y/2)
            box.BorderSizePixel = 1
            box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            box.Visible = true
            box.Name = "ESPBox"
            box.Parent = game:GetService("CoreGui") 

            local usernameLabel = Instance.new("TextLabel")
            usernameLabel.Text = player.Name
            usernameLabel.Font = Enum.Font.SourceSans
            usernameLabel.TextSize = 14
            usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            usernameLabel.BackgroundTransparency = 1
            usernameLabel.Size = UDim2.new(1, 0, 0, 20)
            usernameLabel.Position = UDim2.new(0, 0, 0, -20)
            usernameLabel.Parent = box
          --Just so you know i don't know how to make the HP display with Text labels so i mma leave this like this and seprate so that it will show us the error but won't break the fucking code
            local healthPercentage = math.floor(humanoid.Health / humanoid.MaxHealth * 100)
            local healthLabel = Instance.new("TextLabel")
            healthLabel.Text = "HP: " .. healthPercentage .. "%"
            healthLabel.Font = Enum.Font.SourceSans
            healthLabel.TextSize = 14
            healthLabel.TextColor3 = healthPercentage < 50 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
            healthLabel.BackgroundTransparency = 1
            healthLabel.Size = UDim2.new(1, 0, 0, 20)
            healthLabel.Position = UDim2.new(0, 0, 0, 20)
            healthLabel.Parent = box

            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Text = "Distance: " .. tostring((player.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
            distanceLabel.Font = Enum.Font.SourceSans
            distanceLabel.TextSize = 14
            distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.Size = UDim2.new(1, 0, 0, 20)
            distanceLabel.Position = UDim2.new(0, 0, 0, 40)
            distanceLabel.Parent = box
        end
    end
end

local function removeESP(player)
    for _, child in pairs(game:GetService("CoreGui"):GetChildren()) do
        if child.Name == "ESPBox" then
            child:Destroy()
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Q then
        isHighlighting = not isHighlighting
        espEnabled = not espEnabled
        
        if isHighlighting then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player then
                    createBillboard(p)
                    if espEnabled then
                        createESP(p)
                    end
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player then
                    removeBillboard(p)
                    removeESP(p)
                end
            end
        end
    end
end)

local function transformPosition(camera, position)
    local cameraPosition = camera.CFrame.Position
    local relativePosition = position - cameraPosition
    return relativePosition
end

local function advancedRenderingLogic(shapes, camera)
    local frameData = {}
    for _, shape in pairs(shapes) do
        local transformedPos = transformPosition(camera, shape.Position)
        if transformedPos.X > 0 and transformedPos.Y > 0 then
            table.insert(frameData, shape)
        end
    end
    local optimizedData = optimizeRendering(frameData)
    asyncRenderBatch(optimizedData, 0.5)
end

local function skibidi(camera, shapes, settings)
    camera.FieldOfView = settings.FOV
    camera.CFrame = CFrame.new(settings.Position) * CFrame.Angles(math.rad(settings.Rotation.X), math.rad(settings.Rotation.Y), math.rad(settings.Rotation.Z))
    advancedRenderingLogic(shapes, camera)
end

local function initDrawing()
    local camera = game.Workspace.CurrentCamera
    local shapes = {
        {Type = "Line", Start = Vector3.new(0, 0, 0), Finish = Vector3.new(10, 0, 0), Color = Color3.fromRGB(255, 0, 0)},
        {Type = "Rectangle", TopLeft = Vector3.new(5, 0, 0), BottomRight = Vector3.new(10, 0, 5), Color = Color3.fromRGB(0, 255, 0)},
        {Type = "Circle", Center = Vector3.new(5, 0, 0), Radius = 3, Color = Color3.fromRGB(0, 0, 255)}
    }
    skibidi(camera, shapes, {FOV = 90, Position = Vector3.new(0, 5, 20), Rotation = Vector3.new(0, 0, 0)})
end

registerHook("onCalculationDone", function(result)
    print("Calculation completed: " .. tostring(result))
end)

initDrawing()
