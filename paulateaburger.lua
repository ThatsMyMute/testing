local Movement = {}

local RunService = game:GetService("RunService")

function Movement.MoveTo(character, target, speed)
	local hrp = character:WaitForChild("HumanoidRootPart")

	-- cleanup existing
	if hrp:FindFirstChild("LV") then hrp.LV:Destroy() end
	if hrp:FindFirstChild("LV_Att") then hrp.LV_Att:Destroy() end

	-- attachment
	local att = Instance.new("Attachment")
	att.Name = "LV_Att"
	att.Parent = hrp

	-- linear velocity
	local lv = Instance.new("LinearVelocity")
	lv.Name = "LV"
	lv.Attachment0 = att
	lv.MaxForce = 100000
	lv.RelativeTo = Enum.ActuatorRelativeTo.World
	lv.Parent = hrp

	-- optional: stop humanoid interference
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end

	local connection
	connection = RunService.Heartbeat:Connect(function()
		if not character or not character.Parent then
			connection:Disconnect()
			return
		end

		-- support both Vector3 and objects
		local targetPos = typeof(target) == "Vector3" and target or target.Position

		local dir = targetPos - hrp.Position
		local dist = dir.Magnitude

		if dist < 5 then
			lv.VectorVelocity = Vector3.zero
			connection:Disconnect()
			return
		end

		-- flatten for ground movement (optional)
		dir = Vector3.new(dir.X, 0, dir.Z)

		if dir.Magnitude > 0 then
			lv.VectorVelocity = dir.Unit * (speed or 60)
		end
	end)

	return lv
end

return Movement
