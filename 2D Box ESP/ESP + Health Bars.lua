-- Preview: https://cdn.discordapp.com/attachments/807887111667056680/815517605074698240/unknown.png
-- Made by Blissful#4992
local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local teamcheck = true

for i, v in pairs(game.Players:GetChildren()) do

    local black = Drawing.new("Quad")
    black.Visible = false
    black.PointA = Vector2.new(0, 0)
    black.PointB = Vector2.new(0, 0)
    black.PointC = Vector2.new(0, 0)
    black.PointD = Vector2.new(0, 0)
    black.Color = Color3.fromRGB(0, 0, 0)
    black.Filled = false
    black.Thickness = 4
    black.Transparency = 1

    local blacktracer = Drawing.new("Line")
    blacktracer.Visible = false
    blacktracer.From = Vector2.new(0, 0)
    blacktracer.To = Vector2.new(0, 0)
    blacktracer.Color = Color3.fromRGB(0, 0, 0)
    blacktracer.Thickness = 3
    blacktracer.Transparency = 1 

    local box = Drawing.new("Quad")
    box.Visible = false
    box.PointA = Vector2.new(0, 0)
    box.PointB = Vector2.new(0, 0)
    box.PointC = Vector2.new(0, 0)
    box.PointD = Vector2.new(0, 0)
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Filled = false
    box.Thickness = 2
    box.Transparency = 1

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.From = Vector2.new(0, 0)
    tracer.To = Vector2.new(0, 0)
    tracer.Color = Color3.fromRGB(255, 0, 0)
    tracer.Thickness = 1
    tracer.Transparency = 1

    local healthbar = Drawing.new("Line")
    healthbar.Visible = false
    healthbar.From = Vector2.new(0, 0)
    healthbar.To = Vector2.new(0, 0)
    healthbar.Color = Color3.fromRGB(0, 0, 0)
    healthbar.Thickness = 6
    healthbar.Transparency = 1 

    local greenhealth = Drawing.new("Line")
    greenhealth.Visible = false
    greenhealth.From = Vector2.new(0, 0)
    greenhealth.To = Vector2.new(0, 0)
    greenhealth.Color = Color3.fromRGB(0, 255, 0)
    greenhealth.Thickness = 4
    greenhealth.Transparency = 1 

    function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name  and v.Character.Humanoid.Health > 0 then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(v.Character.Head.Position)
                    local rootpos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

                    local ratio = (Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude

                    local head2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.Head.Position.Y + 2, v.Character.Head.Position.Z))

                    local root2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.HumanoidRootPart.Position.Y-3, v.Character.Head.Position.Z))

                    black.PointA = Vector2.new(head2.X + ratio*1.1, head2.Y)
                    black.PointB = Vector2.new(head2.X - ratio*1.1, head2.Y)
                    black.PointC = Vector2.new(head2.X - ratio*1.1, root2.Y)
                    black.PointD = Vector2.new(head2.X + ratio*1.1, root2.Y)

                    box.PointA = Vector2.new(head2.X + ratio*1.1, head2.Y)
                    box.PointB = Vector2.new(head2.X - ratio*1.1, head2.Y)
                    box.PointC = Vector2.new(head2.X - ratio*1.1, root2.Y)
                    box.PointD = Vector2.new(head2.X + ratio*1.1, root2.Y)

                    tracer.To = Vector2.new(root2.X, root2.Y)
                    tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    blacktracer.To = Vector2.new(root2.X, root2.Y)
                    blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    local d = (Vector2.new(head2.X - ratio*1.5, head2.Y) - Vector2.new(root2.X - ratio*1.5, root2.Y)).magnitude
                    local green = (100-v.Character.Humanoid.Health) *d /100

                    greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                    healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)

                    healthbar.To = Vector2.new(head2.X - ratio*1.5, head2.Y)
                    healthbar.From = Vector2.new(head2.X - ratio*1.5, root2.Y)

                    greenhealth.To = Vector2.new(head2.X - ratio*1.5, head2.Y + green)
                    greenhealth.From = Vector2.new(head2.X - ratio*1.5, root2.Y)

                    local green = Color3.fromRGB(161, 242, 19)
                    local red = Color3.fromRGB(245, 69, 5)
                    if teamcheck then
                        if v.TeamColor == plr.TeamColor then
                            box.Color = green
                            tracer.Color = green
                        else 
                            box.Color = red
                            tracer.Color = red
                        end
                    end

                    box.Visible = true
                    tracer.Visible = true

                    blacktracer.Visible = true
                    black.Visible = true

                    healthbar.Visible = true
                    greenhealth.Visible = true
                else 
                    box.Visible = false
                    tracer.Visible = false

                    blacktracer.Visible = false
                    black.Visible = false

                    healthbar.Visible = false
                    greenhealth.Visible = false
                end
            else 
                box.Visible = false
                tracer.Visible = false

                blacktracer.Visible = false
                black.Visible = false

                healthbar.Visible = false
                greenhealth.Visible = false
                if game.Players:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

game.Players.PlayerAdded:Connect(function(newplr) --Parameter gets the new player that has been added

    local black = Drawing.new("Quad")
    black.Visible = false
    black.PointA = Vector2.new(0, 0)
    black.PointB = Vector2.new(0, 0)
    black.PointC = Vector2.new(0, 0)
    black.PointD = Vector2.new(0, 0)
    black.Color = Color3.fromRGB(0, 0, 0)
    black.Filled = false
    black.Thickness = 4
    black.Transparency = 1

    local blacktracer = Drawing.new("Line")
    blacktracer.Visible = false
    blacktracer.From = Vector2.new(0, 0)
    blacktracer.To = Vector2.new(0, 0)
    blacktracer.Color = Color3.fromRGB(0, 0, 0)
    blacktracer.Thickness = 3
    blacktracer.Transparency = 1 

    local box = Drawing.new("Quad")
    box.Visible = false
    box.PointA = Vector2.new(0, 0)
    box.PointB = Vector2.new(0, 0)
    box.PointC = Vector2.new(0, 0)
    box.PointD = Vector2.new(0, 0)
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Filled = false
    box.Thickness = 2
    box.Transparency = 1

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.From = Vector2.new(0, 0)
    tracer.To = Vector2.new(0, 0)
    tracer.Color = Color3.fromRGB(255, 0, 0)
    tracer.Thickness = 1
    tracer.Transparency = 1

    local healthbar = Drawing.new("Line")
    healthbar.Visible = false
    healthbar.From = Vector2.new(0, 0)
    healthbar.To = Vector2.new(0, 0)
    healthbar.Color = Color3.fromRGB(0, 0, 0)
    healthbar.Thickness = 6
    healthbar.Transparency = 1 

    local greenhealth = Drawing.new("Line")
    greenhealth.Visible = false
    greenhealth.From = Vector2.new(0, 0)
    greenhealth.To = Vector2.new(0, 0)
    greenhealth.Color = Color3.fromRGB(0, 255, 0)
    greenhealth.Thickness = 4
    greenhealth.Transparency = 1 

    function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name  and newplr.Character.Humanoid.Health > 0 then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(newplr.Character.Head.Position)
                    local rootpos = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)

                    local ratio = (Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude

                    local head2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.Head.Position.Y + 2, newplr.Character.Head.Position.Z))

                    local root2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.HumanoidRootPart.Position.Y-3, newplr.Character.Head.Position.Z))

                    black.PointA = Vector2.new(head2.X + ratio*1.1, head2.Y)
                    black.PointB = Vector2.new(head2.X - ratio*1.1, head2.Y)
                    black.PointC = Vector2.new(head2.X - ratio*1.1, root2.Y)
                    black.PointD = Vector2.new(head2.X + ratio*1.1, root2.Y)

                    box.PointA = Vector2.new(head2.X + ratio*1.1, head2.Y)
                    box.PointB = Vector2.new(head2.X - ratio*1.1, head2.Y)
                    box.PointC = Vector2.new(head2.X - ratio*1.1, root2.Y)
                    box.PointD = Vector2.new(head2.X + ratio*1.1, root2.Y)

                    tracer.To = Vector2.new(root2.X, root2.Y)
                    tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    blacktracer.To = Vector2.new(root2.X, root2.Y)
                    blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    local d = (Vector2.new(head2.X - ratio*1.5, head2.Y) - Vector2.new(root2.X - ratio*1.5, root2.Y)).magnitude
                    local green = (100-newplr.Character.Humanoid.Health) *d /100

                    greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                    healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)

                    healthbar.To = Vector2.new(head2.X - ratio*1.5, head2.Y)
                    healthbar.From = Vector2.new(head2.X - ratio*1.5, root2.Y)

                    greenhealth.To = Vector2.new(head2.X - ratio*1.5, head2.Y + green)
                    greenhealth.From = Vector2.new(head2.X - ratio*1.5, root2.Y)

                    local green = Color3.fromRGB(161, 242, 19)
                    local red = Color3.fromRGB(245, 69, 5)
                    if teamcheck then
                        if newplr.TeamColor == plr.TeamColor then
                            box.Color = green
                            tracer.Color = green
                        else 
                            box.Color = red
                            tracer.Color = red
                        end
                    end

                    box.Visible = true
                    tracer.Visible = true

                    blacktracer.Visible = true
                    black.Visible = true

                    healthbar.Visible = true
                    greenhealth.Visible = true
                else 
                    box.Visible = false
                    tracer.Visible = false

                    blacktracer.Visible = false
                    black.Visible = false

                    healthbar.Visible = false
                    greenhealth.Visible = false
                end
            else 
                box.Visible = false
                tracer.Visible = false

                blacktracer.Visible = false
                black.Visible = false

                healthbar.Visible = false
                greenhealth.Visible = false
                if game.Players:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)