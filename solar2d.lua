local displayWidth = display.contentWidth
local displayHeight = display.contentHeight

particle = {}
particle.__index = particle
ActiveParticle = {}

function particle.new()
	local instance = setmetatable({}, particle)
	instance.x = math.random(4, displayWidth)
	instance.y = math.random(4, displayHeight)
	instance.xVel = math.random(-3, 3)
	instance.yVel = math.random(-3, 3)
	instance.width = 4
	instance.height = 4
	instance.body = display.newRect(instance.x, instance.y,
	instance.width, instance.height)
	table.insert(ActiveParticle, instance)
end

function particle:nullSpeed()
	if self.xVel == 0 then
		self.xVel = math.random(1,3)
	end

	if self.yVel == 0 then
		self.yVel = math.random(1,3)
	end

end

function particle:collision()
	if self.body.x <= 0 then
		self.xVel = self.xVel * -1
	end
	
	if self.body.x >= displayWidth then
		self.xVel = -self.xVel
	end

	 if self.body.y >= displayHeight then
	 	self.yVel = self.yVel * -1
	 end

	 if self.body.y <= 0 then
	 	self.yVel = -self.yVel
	 end

end

function particle:move()
	self.body.x = self.body.x - self.xVel
	self.body.y = self.body.y + self.yVel
end

function particle.updateAll()
	for i,instance in ipairs(ActiveParticle) do
		instance:move()
		instance:collision()
		instance:nullSpeed()
	end
end

function onUpdate(event)
	particle.updateAll()
end

function initGame()
	for i = 1, 5000 do
		particle.new()
	end
end

initGame()
Runtime:addEventListener("enterFrame", onUpdate)