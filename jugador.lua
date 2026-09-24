--------------TABLA JUGADOR--------------
player = {
x = (love.graphics.getWidth() / 2) - (125 * 0.5 / 2), 
y = (love.graphics.getHeight() / 2) - (125 * 0.5 / 2), 
speed = 120, 
alto = 45,
ancho = 45,
anim ={},
frame = 1,
frameSpeed = 8,
direction = 1
}   

---------ANIMACION JUGADOR---------------
function Spritespersonajes()

table.insert(player.anim, love.graphics.newImage("sprites/wiki1.png"))
table.insert(player.anim, love.graphics.newImage("sprites/wiki2.png"))
table.insert(player.anim, love.graphics.newImage("sprites/wiki3.png"))
table.insert(player.anim, love.graphics.newImage("sprites/wiki4.png"))
end


function Moviento(dt)
if love.keyboard.isDown("d") then
         player.x = player.x + player.speed * dt
          player.direction = 1
    end
     if love.keyboard.isDown("a") then
         player.x = player.x - player.speed * dt
           player.direction = -1
         
    end
     if love.keyboard.isDown("s") then
         player.y = player.y + player.speed* dt
          
    end
     if love.keyboard.isDown("w") then
         player.y = player.y - player.speed * dt
    end
    
    if love.keyboard.isDown("right") then
         player.x = player.x + player.speed * dt
           player.direction = 1
    end
     if love.keyboard.isDown("left") then
         player.x = player.x - player.speed * dt
           player.direction = -1
    end
     if love.keyboard.isDown("down") then
         player.y = player.y + player.speed * dt
    end
     if love.keyboard.isDown("up") then
         player.y = player.y - player.speed * dt
    end
end