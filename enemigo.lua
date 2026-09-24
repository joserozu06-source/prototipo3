-- -----------TABLA ENEMIGO----------------------------------------------
enemy = {
x = 0,
y = 0,
speed = 120,
alto = 45,
ancho = 45,
anim ={},
frame = 1,
frameSpeed = 6,
direction = 1
}  

-----------ANIMACION ENEMIGO---------------
function Spritesenemigo()
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher1.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher2.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher3.png"))
table.insert(enemy.anim, love.graphics.newImage("sprites/baucher4.png"))
end