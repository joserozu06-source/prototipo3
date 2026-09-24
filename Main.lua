local jugador20 = require "jugador"
local jugador20 = require "enemigo"

------------------------------------------------------INICIALIZACION------------------------------------------------
function love.load ()
    Spritespersonajes()
    Spritesenemigo()
     tiempo = 15
end

gameState = "playing"
timer = 0
winTime = 10

scale = 0.06



---FONDO
backround = love.graphics.newImage("sprites/background.png")

--Pantallas finales
winImage = love.graphics.newImage("sprites/ganar.png")
loseImage = love.graphics.newImage("sprites/perder.png")


---MUSICA
music = love.audio.newSource("musica/musica.wav","stream")
love.audio.play(music)
winSound = love.audio.newSource("musica/win.mp3", "static")
loseSound = love.audio.newSource("musica/gameover.mp3", "static")
catchSound = love.audio.newSource("musica/bau_te_agarra.wav", "static")

--Huellas del enemigo
footprints = {}

footImages = {
    love.graphics.newImage("sprites/huellas 1.png"),
    love.graphics.newImage("sprites/huellas 2.png"),
    love.graphics.newImage("sprites/huellas 3.png"),
    love.graphics.newImage("sprites/huellas 4.png")
}

footTimer = 0



-----------------------------------------------------ACTUALIZACION-------------------------------------------------
function love.update(dt)
  if gameState == "playing" then

    -------------------------------MOVIMIENTO------------------------------------------------------------------------------------
    Moviento(dt)
         


     -- Animación jugador
    player.frame = player.frame + player.frameSpeed * dt

    if player.frame >= #player.anim + 1 then
        player.frame = 1
    end

    -- Animación enemigo
    enemy.frame = enemy.frame + enemy.frameSpeed * dt

    if enemy.frame >= #enemy.anim + 1 then
        enemy.frame = 1
        if player.x > enemy.x then
            enemy.direction = 1   --  derecha
        else
            enemy.direction = -1  --izq
        end
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

      
-----ia enemigo
    if dist_x > dist_y then
        if dist_x > 40 then
           if enemy.x < player.x then
              enemy.x = enemy.x + (enemy.speed * dt)
           elseif enemy.x > player.x then
             enemy.x = enemy.x - (enemy.speed * dt)
            end
         end
    else
      if dist_y > 40 then
         if enemy.y < player.y then
              enemy.y = enemy.y + (enemy.speed * dt)
             elseif enemy.y > player.y then
              enemy.y = enemy.y - (enemy.speed * dt)
           end
      end  
    end
  end
end

--------------------------------------------------------RENDERIZADO------------------------------------------

function love.draw()
    local playerFrame = math.floor(player.frame)
    local enemyFrame = math.floor(enemy.frame)

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

        -- Enemigo
        love.graphics.draw(
            enemy.anim[enemyFrame],
            enemy.x,
            enemy.y,
            0,
            scale * enemy.direction,
            scale,
            enemy.anim[enemyFrame]:getWidth() / 2,
            enemy.anim[enemyFrame]:getHeight() / 2
        )

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