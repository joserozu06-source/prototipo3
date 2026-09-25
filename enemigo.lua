------------- CLASE ENEMIGO --------------------------------
Enemigo = {}
Enemigo.__index = Enemigo


function Enemigo:Nuevo(x, y, sprites)

    local o = setmetatable({}, Enemigo)
    o.x = x
    o.y = y
    o.speed = 110
    o.alto = 45
    o.ancho = 45
    o.anim = {}
    o.frame = 1
    o.frameSpeed = 6
    o.direction = 1
    o.sprites = sprites

    return o
end



function Enemigo:Sprites()
table.insert(self.anim, love.graphics.newImage("sprites/baucher1.png"))
table.insert(self.anim, love.graphics.newImage("sprites/baucher2.png"))
table.insert(self.anim, love.graphics.newImage("sprites/baucher3.png"))
table.insert(self.anim, love.graphics.newImage("sprites/baucher4.png"))
end


---------------------ACTUALIZACION-------------------------
function Enemigo:Actualizar(x, y, a, dt)

    local dist_x = math.abs(self.x - x)
    local dist_y = math.abs(self.y - y)

    if dist_x > dist_y then
        if dist_x > a then

            if self.x < x then
                self.x = self.x + (self.speed * dt)

            elseif self.x > x then
                self.x = self.x - (self.speed * dt)
            end

        end

    else
        if dist_y > a then

            if self.y < y then
                self.y = self.y + (self.speed * dt)

            elseif self.y > y then
                self.y = self.y - (self.speed * dt)
            end

        end
    end

end

-----------ANIMACION ENEMIGO---------------
function Enemigo:Animar(dt, player)

    self.frame = self.frame + self.frameSpeed * dt

    if self.frame >= #self.anim + 1 then
        self.frame = 1

        if player.x > self.x then
            self.direction = 1
        else
            self.direction = -1
        end
    end

end

function Enemigo:Dibujar(enemyScale)

    local enemyFrame = math.floor(self.frame)

      love.graphics.draw(
        self.anim[enemyFrame],
        self.x,
        self.y,
        0,
        enemyScale * self.direction,
        enemyScale,
        self.anim[enemyFrame]:getWidth() / 2,
        self.anim[enemyFrame]:getHeight() / 2
    )
end