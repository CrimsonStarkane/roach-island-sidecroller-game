Blue = Class{}

function Blue:init(x, y, index)
    self.index = index

    self.width = 16
    self.height = 16

    self.x = x
    self.y = y

    self.texture = love.graphics.newImage('graphics/crystals/blue.png')
    self.frames = generateQuads(self.texture, 16, 16)

    self.anim = Animation {
        texture = self.texture,
        frames = self.frames,
        interval = 0.4
    }

    self.pickedUp = false
    self.duration = 20
    self.timer = 0
end

function Blue:collidesPlayer()
    if player.x > self.x + self.width - 1 or player.x + player.width - 1 < self.x then
        return false
    end

    if player.y > self.y + self.height - 1 or player.y + player.height - 1 < self.y then
        return false
    end

    return true
end

function Blue:update(dt)
    self.anim:update(dt)

    if self:collidesPlayer() then
        player:increaseFireRate()
        self.pickedUp = true
    end

    if self.pickedUp == true then
        self.timer = self.timer + dt

        if self.timer >= self.duration then
            player:normalizeFireRate()
            self.timer = 0
            self.pickedUp = false
        end
    end
end

function Blue:render()
    love.graphics.draw(self.anim:getTexture(), self.anim:getCurrentFrame(), self.x, self.y, 0, 0.5, 0.5) 
end