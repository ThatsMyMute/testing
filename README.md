# Linear Velocity Movement System (LVMS)

A lightweight, modular movement system for Roblox built on LinearVelocity.  
LVMS enables controlled, physics-based character movement across predefined points using velocity instead of default humanoid walking.

---

## Overview

LVMS moves a character using constraints rather than traditional movement systems.  
It calculates direction each frame and applies velocity toward target positions.

This allows for:
- Smooth path traversal
- Full control over speed and direction
- Consistent physics-based movement

---

## Features

- Path-based movement using Vector3 waypoints  
- Uses LinearVelocity for smooth motion  
- Optional rotation stabilization with AlignOrientation  
- Supports forward and reverse traversal  
- Modular and reusable  

---

## Installation

1. Create a ModuleScript in `ReplicatedStorage`
2. Name it:
   ```
   MovementModule
   ```
3. Paste your LVMS code inside

---

## Basic Usage

```lua
local Movement = require(game.ReplicatedStorage.MovementModule)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

Movement.FollowPath(char, points, 120)
```

---

## Path Example

```lua
local points = {
    Vector3.new(0, 2, 0),
    Vector3.new(100, 2, 50),
    Vector3.new(200, 2, 0),
}
```

---

## Reverse Path
*I highly recommend just using another table I will work to improve this later*
```lua
local function reversePoints(points)
    local reversed = {}
    for i = #points, 1, -1 do
        table.insert(reversed, points[i])
    end
    return reversed
end
```

---

## Looping Example

```lua
local currentPoints = points

while true do
    Movement.FollowPath(char, currentPoints, 120)
    task.wait(10)
    currentPoints = reversePoints(currentPoints)
end
```

## Full Script Example
*Yes you have to add commas to table while using more than 1 Path/Vector*

```lua
local Movement = loadstring or require(script)
local start = {
    Vector3.new(-1842.9215087890625, 3.2445058822631836, -3.4413368701934814)
}

local speed = 200
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
while true do
task.wait()
Movement.FollowPath(char, start, speed)
end
```

# 

---

## Using with loadstring (HTTP) for people using Executors or Devs trying to detect its use! USE MOST RECENT VERSION I WILL EVENTUALLY MAKE A MAIN ONCE I FINISH Updating this

If your game allows HTTP requests, LVMS can be loaded dynamically:

```lua
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThatsMyMute/testing/refs/heads/main/V1.75"))()
```

Requirements:
- HTTP Enabled in Game Settings  
- Script hosted on a raw file URL (e.g. GitHub raw)

---

## Configuration

| Setting | Description |
|--------|-------------|
| Speed | Movement speed |
| Threshold | Distance to switch nodes |
| Responsiveness | Rotation smoothness |

---

## Common Issues

### Not moving
- Ensure HumanoidRootPart is not anchored  
- Ensure MaxForce is high enough  

### Spinning
- Add AlignOrientation  
- Control rotation each frame  

### Jitter
- Increase node threshold  
- Smooth velocity using Lerp  

---

## Notes

- Designed for client-side control  
- Uses Humanoid Physics state  
- Not intended for secure server-side validation  

---

## Summary

LVMS provides a simple, flexible way to move characters using velocity-based physics.  
It is best suited for systems that require smooth, controlled movement along predefined paths.
