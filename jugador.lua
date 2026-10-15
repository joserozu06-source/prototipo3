Jugador = {}
Jugador.__index = Jugador

function Jugador:Nuevo()
    local o = setmetatable({}, Jugador)

    o.x = (love.graphics.getWidth() / 2) - (125 * 0.5 / 2)
    o.y = (love.graphics.getHeight() / 2) - (125 * 0.5 / 2)
    o.speed = 120
    o.alto = 45
    o.ancho = 45
    o.anim = {}
    o.frame = 1
    o.frameSpeed = 8
    o.direction = 1

    return o
end

function Jugador:Sprites()
    table.insert(self.anim, love.graphics.newImage("sprites/wiki1.png"))
    table.insert(self.anim, love.graphics.newImage("sprites/wiki2.png"))
    table.insert(self.anim, love.graphics.newImage("sprites/wiki3.png"))
    table.insert(self.anim, love.graphics.newImage("sprites/wiki4.png"))
end

function Jugador:Actualizar(dt)
    if love.keyboard.isDown("d", "right") then
        self.x = self.x + self.speed * dt
        self.direction = 1
    end

    if love.keyboard.isDown("a", "left") then
        self.x = self.x - self.speed * dt
        self.direction = -1
    end

    if love.keyboard.isDown("s", "down") then
        self.y = self.y + self.speed * dt
    end

    if love.keyboard.isDown("w", "up") then
        self.y = self.y - self.speed * dt
    end

    self.frame = self.frame + self.frameSpeed * dt

    if self.frame >= #self.anim + 1 then
        self.frame = 1
    end
end

function Jugador:Dibujar(scale)
    local frame = math.floor(self.frame)

    love.graphics.draw(
        self.anim[frame],
        self.x,
        self.y,
        0,
        scale * self.direction,
        scale,
        self.anim[frame]:getWidth() / 2,
        self.anim[frame]:getHeight() / 2
    )
end

return Jugador