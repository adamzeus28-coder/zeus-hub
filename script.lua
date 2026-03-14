local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)

-- LOGO
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0,200)
logo.Text = "🌶"
logo.TextScaled = true
logo.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- MENU
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,250,0,170)
frame.Position = UDim2.new(0.7,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = false
frame.Active = true
frame.Draggable = true

logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "SÁT THỦ THẦM LẶNG"
title.Font = Enum.Font.Arcade
title.TextScaled = true

-- RAINBOW TITLE
task.spawn(function()
	while true do
		for i=0,1,0.02 do
			title.TextColor3 = Color3.fromHSV(i,1,1)
			task.wait(0.05)
		end
	end
end)

-- HỆ THỐNG THÔNG BÁO
local notifyFrame = Instance.new("Frame", gui)
notifyFrame.Size = UDim2.new(0,260,0,40)
notifyFrame.Position = UDim2.new(1,-270,0,20)
notifyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
notifyFrame.Visible = false

local notifyText = Instance.new("TextLabel", notifyFrame)
notifyText.Size = UDim2.new(1,0,1,0)
notifyText.BackgroundTransparency = 1
notifyText.TextColor3 = Color3.fromRGB(255,255,255)
notifyText.TextScaled = true
notifyText.Font = Enum.Font.Arcade

function notify(msg)

	notifyFrame.Visible = true
	notifyText.Text = msg

	task.wait(3)

	notifyFrame.Visible = false

end

-- Thông báo khi chạy script
task.spawn(function()
	task.wait(1)
	notify("Cảm ơn đã sử dụng script của tui TikTok @zeus_brainrot")
end)

-- ESP BUTTON
local esp = Instance.new("TextButton", frame)
esp.Size = UDim2.new(0.8,0,0,40)
esp.Position = UDim2.new(0.1,0,0.4,0)
esp.Text = "ESP PLAYER"

-- TP RANDOM
local tp = Instance.new("TextButton", frame)
tp.Size = UDim2.new(0.8,0,0,40)
tp.Position = UDim2.new(0.1,0,0.65,0)
tp.Text = "TP RANDOM"

-- RAINBOW TEXT
local function rainbow(label)
	task.spawn(function()
		while label.Parent do
			for i=0,1,0.02 do
				label.TextColor3 = Color3.fromHSV(i,1,1)
				task.wait(0.05)
			end
		end
	end)
end

-- ESP FUNCTION
esp.MouseButton1Click:Connect(function()

	for _,p in pairs(Players:GetPlayers()) do

		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then

			if not p.Character:FindFirstChild("ESPBOX") then

				local box = Instance.new("BoxHandleAdornment")
				box.Name = "ESPBOX"
				box.Adornee = p.Character.HumanoidRootPart
				box.Size = Vector3.new(4,6,2)
				box.Color3 = Color3.fromRGB(0,255,0)
				box.AlwaysOnTop = true
				box.Transparency = 0.4
				box.Parent = p.Character

				local bill = Instance.new("BillboardGui")
				bill.Size = UDim2.new(0,100,0,20)
				bill.StudsOffset = Vector3.new(0,3,0)
				bill.AlwaysOnTop = true
				bill.Parent = p.Character

				local name = Instance.new("TextLabel")
				name.Size = UDim2.new(1,0,1,0)
				name.BackgroundTransparency = 1
				name.Text = p.Name
				name.TextScaled = true
				name.Font = Enum.Font.Arcade
				name.Parent = bill

				rainbow(name)

			end

		end

	end

	notify("ESP đã bật")

end)

-- TP RANDOM (KHÔNG NGÃ)
tp.MouseButton1Click:Connect(function()

	local targets = {}

	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
		
			local pos = p.Character.HumanoidRootPart.Position
			
			if pos.Y < 200 then
				table.insert(targets,p)
			end
			
		end
	end

	if #targets > 0 then

		local target = targets[math.random(1,#targets)]

		local char = LocalPlayer.Character
		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")

		if root and hum then

			hum.PlatformStand = true
			hum.AutoRotate = false

			root.Velocity = Vector3.new(0,0,0)
			root.RotVelocity = Vector3.new(0,0,0)

			root.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,0)

			task.wait(0.2)

			hum.PlatformStand = false
			hum.AutoRotate = true

			notify("Đã teleport tới player")

		end

	else

		notify("Không tìm thấy player trong map")

	end

end)
