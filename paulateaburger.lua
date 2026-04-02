local Movement = {}

local RunService = game:GetService("RunService")

function Movement.LaunchTo(character, target, settings)
	settings = settings or {}

	local hrp = character:WaitForChild("HumanoidRootPart")

	-- cleanup
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

	-- disable humanoid fighting
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end

	local upwardForce = settings.UpwardForce or 80
	local forwardSpeed = settings.Speed or 80
	local liftTime = settings.LiftTime or 0.25

	local startTime = tick()

	local connection
	connection = RunService.Heartbeat:Connect(function()
		if not character or not character.Parent then
			connection:Disconnect()
			return
		end

		local targetPos = typeof(target) == "Vector3" and target or target.Position
		local elapsed = tick() - startTime

		-- PHASE 1: go upward
		if elapsed < liftTime then
			lv.VectorVelocity = Vector3.new(0, upwardForce, 0)
			return
		end

		-- PHASE 2: move toward target (with slight lift retained)
		local dir = targetPos - hrp.Position
		local dist = dir.Magnitude

		if dist < 5 then
			lv.VectorVelocity = Vector3.zero
			connection:Disconnect()
			return
		end

		dir = dir.Unit

		-- combine forward + slight upward so you arc instead of drop
		local velocity = dir * forwardSpeed + Vector3.new(0, upwardForce * 0.3, 0)

		lv.VectorVelocity = velocity
	end)

	return lv
end

return Movement
