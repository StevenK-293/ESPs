local Settings = {
    Enabled = false,
    DistFromCenter = 80,
    TriangleHeight = 16,
    TriangleWidth = 16,
    TriangleFilled = true,
    TriangleTransparency = 0,
    TriangleThickness = 1,
    TriangleColor = Color3.fromRGB(255, 255, 255),
    AntiAliasing = false
}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")

local V2 = Vector2.new
local CF = CFrame.new
local COS = math.cos
local SIN = math.sin
local RAD = math.rad
local DRAWING = Drawing.new
local CWRAP = coroutine.wrap
local ROUND = math.round

local function GetRelative(pos, char)
    if not char then return V2(0, 0) end

    local rootP = char.PrimaryPart.Position
    local camP = Camera.CFrame.Position
    local relative = CF(V3(rootP.X, camP.Y, rootP.Z), camP):PointToObjectSpace(pos)

    return V2(relative.X, relative.Z)
end

local function RelativeToCenter(v)
    return Camera.ViewportSize / 2 - v
end

local function RotateVect(v, a)
    a = RAD(a)
    local x = v.x * COS(a) - v.y * SIN(a)
    local y = v.x * SIN(a) + v.y * COS(a)

    return V2(x, y)
end

local function DrawTriangle(color)
    local l = DRAWING("Triangle")
    l.Visible = false
    l.Color = color
    l.Filled = Settings.TriangleFilled
    l.Thickness = Settings.TriangleThickness
    l.Transparency = 1 - Settings.TriangleTransparency
    return l
end

local function AntiA(v)
    if (not Settings.AntiAliasing) then return v end
    return V2(ROUND(v.x), ROUND(v.y))
end

local function ShowArrow(player)
    if not Settings.Enabled then return end

    local arrow = DrawTriangle(Settings.TriangleColor)

    local function Update()
        local connection
        connection = RS.RenderStepped:Connect(function()
            if player and player.Character then
                local character = player.Character
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid and character.PrimaryPart and humanoid.Health > 0 then
                    local _, isVisible = Camera:WorldToViewportPoint(character.PrimaryPart.Position)
                    if not isVisible then
                        local relative = GetRelative(character.PrimaryPart.Position, Player.Character)
                        local direction = relative.unit

                        local base = direction * Settings.DistFromCenter
                        local sideLength = Settings.TriangleWidth / 2
                        local baseL = base + RotateVect(direction, 90) * sideLength
                        local baseR = base + RotateVect(direction, -90) * sideLength

                        local tip = direction * (Settings.DistFromCenter + Settings.TriangleHeight)

                        arrow.PointA = AntiA(RelativeToCenter(baseL))
                        arrow.PointB = AntiA(RelativeToCenter(baseR))
                        arrow.PointC = AntiA(RelativeToCenter(tip))

                        arrow.Visible = true
                    else
                        arrow.Visible = false
                    end
                else
                    arrow.Visible = false
                end
            else
                arrow.Visible = false

                if not player or not player.Parent then
                    arrow:Remove()
                    connection:Disconnect()
                end
            end
        end)
    end

    CWRAP(Update)()
end

for _, player in ipairs(Players:GetPlayers()) do
    if player.Name ~= Player.Name then
        ShowArrow(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player.Name ~= Player.Name then
        ShowArrow(player)
    end
end)
