------------- CLASE ENEMIGO --------------------------------
Enemigo = {}
Enemigo.__index = Enemigo


function Enemigo:Nuevo(x, y)

    local o = setmetatable({}, Enemigo)
    o.x = x
    o.y = y
    o.speed = 120
    o.alto = 45
    o.ancho = 45
    o.anim = {}
    o.frame = 1
    o.frameSpeed = 6
    o.direction = 1

    return o
end


-----------ANIMACION ENEMIGO---------------
function Spritesenemigo()
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher1.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher2.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher3.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher4.png"))
end