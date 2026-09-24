local jugador = require "jugador"
local enemigo = require "enemigo"

gameState = "playing"
timer = 0
winTime = 10
scale = 0.06

---------------------------------------------INICIALIZACION------------------------------------------------
function love.load ()
    Spritespersonajes()
   
    enemigos = {
    Enemigo:Nuevo(100, 100),
    Enemigo:Nuevo(300, 200),
    Enemigo:Nuevo(500, 400)
}

for _, enemigo in ipairs(enemigos) do
    enemigo:Sprites()
end

enemy = enemigos[1]


tiempo = 15

     
-----FONDO
backround = love.graphics.newImage("sprites/background.png")


----PANTALLAS FINALES
winImage = love.graphics.newImage("sprites/ganar.png")
loseImage = love.graphics.newImage("sprites/perder.png")


--------MUSICA
music = love.audio.newSource("musica/musica.wav","stream")
love.audio.play(music)
winSound = love.audio.newSource("musica/win.mp3", "static")
loseSound = love.audio.newSource("musica/gameover.mp3", "static")
catchSound = love.audio.newSource("musica/bau_te_agarra.wav", "static")

--HUELLAS ENEMIGO
footprints = {}

footImages = {
    love.graphics.newImage("sprites/huellas 1.png"),
    love.graphics.newImage("sprites/huellas 2.png"),
    love.graphics.newImage("sprites/huellas 3.png"),
    love.graphics.newImage("sprites/huellas 4.png")
}

footTimer = 0

end

-------------------------------------------ACTUALIZACION-------------------------------------------------
function love.update(dt)
  if gameState == "playing" then

   for _, enemigo in ipairs(enemigos) do
    enemigo:Actualizar(player.x, player.y, player.ancho, dt)
    enemigo:Animar(dt, player)
end

    -------------------------------MOVIMIENTO------------------------------------------------------------------------------------
    Moviento(dt)
         

     -- Animación jugador
    player.frame = player.frame + player.frameSpeed * dt

    if player.frame >= #player.anim + 1 then
        player.frame = 1
    end


          -- Temporizador huellas
footTimer = footTimer + dt

if footTimer >= 0.25 then
    footTimer = 0

    table.insert(footprints,{
    x = enemy.x - (20 * enemy.direction),
    y = enemy.y + 35,
    img = footImages[love.math.random(#footImages)],
    alpha = 1,
    direction = enemy.direction
})
end

-- Desvanecer huellas
for i = #footprints,1,-1 do
    footprints[i].alpha = footprints[i].alpha - dt * 0.6

    if footprints[i].alpha <= 0 then
        table.remove(footprints,i)
    end
end


      ------- Colisión
        if player.x < enemy.x + enemy.ancho and
      player.x + player.ancho > enemy.x and
      player.y < enemy.y + enemy.alto and
      player.y + player.alto > enemy.y then

          if gameState ~= "lose" then
              love.audio.stop(music)        
              love.audio.play(loseSound)  
              gameState = "lose"
          end
      end
        
     ------- Tiempo
        timer = timer + dt
        if timer >= winTime then
            if gameState ~= "win" then
                love.audio.stop(music)     
                love.audio.play(winSound)  
                gameState = "win"
            end
        end

      local dist_x = math.abs(enemy.x - player.x)
      local dist_y = math.abs(enemy.y - player.y)
    
  end
end

------------------------------------------------RENDERIZADO------------------------------------------

function love.draw()
    local playerFrame = math.floor(player.frame)

    love.graphics.draw(backround, 0, 0) --fondo

    if gameState == "playing" then

        -- === DIBUJAR HUELLAS 
        for _, foot in ipairs(footprints) do
            love.graphics.setColor(1, 1, 1, foot.alpha) -- transparencia de la huella
            local escala = 0.05
            love.graphics.draw(
                foot.img,
                foot.x,
                foot.y,
                0,
                escala * foot.direction,
                escala,
                foot.img:getWidth() / 2,
                foot.img:getHeight() / 2
            )
        end
        
       --Reseteamos el color a blanco total
        love.graphics.setColor(1, 1, 1, 1) 

        -- Jugador
        love.graphics.draw(
            player.anim[playerFrame],
            player.x,
            player.y,
            0,
            scale * player.direction,
            scale,
            player.anim[playerFrame]:getWidth() / 2,
            player.anim[playerFrame]:getHeight() / 2
        )

        for _, enemigo in ipairs(enemigos) do
    enemigo:Dibujar(scale)
end


        love.graphics.print(
            "Sobrevive 10 segundos! Tiempo: " .. math.max(0, math.ceil(winTime - timer)),
            10,
            10
        )

    elseif gameState == "win" then
        local imageScale = 0.25
        love.graphics.draw(
            winImage,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2,
            0,
            imageScale,
            imageScale,
            winImage:getWidth() / 2,
            winImage:getHeight() / 2
        )

    elseif gameState == "lose" then
        local imageScale = 0.25
        love.graphics.draw(
            loseImage,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2,
            0,
            imageScale,
            imageScale,
            loseImage:getWidth() / 2,
            loseImage:getHeight() / 2
        )
    end

    love.graphics.print(math.ceil(timer), 380, 20)
end