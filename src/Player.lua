Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.respect = 50
    self.afterFigthing = false
    self.score = 0
    self.perverts_defeated = 0
    self.perverts_passed = 0
end

function Player:update(dt)
    Entity.update(self, dt)
end

-- function Player:collides(target)
--     local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
--     return not (self.x + self.width < target.x or self.x > target.x + target.width or
--                 selfY + selfHeight < target.y or selfY > target.y + target.height)
-- end

function Player:render()
    Entity.render(self)
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end
