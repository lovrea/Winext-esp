# ESP System for Roblox

This is a custom **ESP (Extrasensory Perception)** system for Roblox. It allows you to add visual markers around other players to track them more easily in the game. The system displays information such as:

- **ESP Box**: A red box around players.
- **Billboard Symbol**: A customizable symbol displayed above players' heads.
- **Allowance**:Yes you are allowed to do whatever you want with this source, Do whatever you want just make it good
## Screenshots

![ESP Image 1](https://i.ibb.co/mFYfQ5MK/image.png)


## Controls

- **Press "Q"**: Toggle the ESP system on/off.
    - When **enabled**, the system will display ESP boxes, billboards, and player information.
    - When **disabled**, it removes all ESP features.

## Code only for the esp that is helded by the Billboard

```lua
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local symbol = " " -- Put your fucking symbol here as for my case it put the swastika
local isHighlighting = false
local espEnabled = false
local boxSize = Vector3.new(4, 6, 2)

local function createBillboard(player)
    if player.Character then
        local part = player.Character:FindFirstChild("UpperTorso") or player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("HumanoidRootPart")
        
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
