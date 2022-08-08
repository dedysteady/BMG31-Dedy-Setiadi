local LiftingPlatform = {}
local part = nil
local maxPosition = Vector3.new(0, 12, 0)
local minPosition = Vector3.new(0, 2, 0)
local initialPosition = Vector3.new(0, 5, 0)
local speed = 0.05
local nextPosition = nil
local intervalVector = nil
local timer = nil

local maxPositionStayTime = 5 * 20
local minPositionStayTime = 3 * 20

local function Move()
  local distance = Vector3.Distance(part.WorldPosition, nextPosition)
  
  if distance < 0.5 then
    local isMinPosition = nextPosition == minPosition
    nextPosition = isMinPosition and maxPosition or minPosition
    local direction = nextPosition - Block.WorldPosition
    intervalVector = direction.Normalized * speed
    
    timer.Delay = isMinPosition and minPositionStayTime or maxPositionStayTime
  else
    Block.WorldPosition = Block.WorldPosition + intervalVector
    
    timer.Delay = 1
  end
  
  
end


function LiftingPlatform:Start(map)
  Block = map.Root:FindFirstChild("LiftingPlatform", true)
  Block.WorldPosition = initialPosition
  
  nextPosition = minPosition
  local direction = nextPosition - part.WorldPosition
  intervalVector = direction.normalized * speed
  
  timer = Timer.new(1, Move)
  timer.Loop = true
  timer:Start()

return LiftingPlatform