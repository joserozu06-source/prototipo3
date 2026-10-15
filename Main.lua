require "jugador"
require "enemigo"
require "interfaz"

gameState = "playing"
timer = 0
winTime = 10
scale = 0.06
enemyScale = 0.045

---------------------------------------------INICIALIZACION------------------------------------------------
function love.load ()
    
    player = Jugador:Nuevo()
    player:Sprites()
   
    enemigos = {
    Enemigo:Nuevo(50, 50),
    Enemigo:Nuevo(200, 100),
    Enemigo:Nuevo(50, 200)
}
cartelObjetivo = love.graphics.newImage("sprites/cartel.png")

fuenteHUD = love.graphics.newFont("fonts/PixelifySans-Regular.ttf", 20)

hud = Interfaz:Nueva()


for _, enemigo in ipairs(enemigos) do
    enemigo:Sprites()
end

     
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
    player:Actualizar(dt)
         

     -- Temporizador huellas
footTimer = footTimer + dt

if footTimer >= 0.25 then
    footTimer = 0

    for _, enemigo in ipairs(enemigos) do
        table.insert(footprints,{
            x = enemigo.x - (20 * enemigo.direction),
            y = enemigo.y + 35,
            img = footImages[love.math.random(#footImages)],
            alpha = 1,
            direction = enemigo.direction
        })
    end
end

-- Desvanecer huellas
for i = #footprints,1,-1 do
    footprints[i].alpha = footprints[i].alpha - dt * 0.6

    if footprints[i].alpha <= 0 then
        table.remove(footprints,i)
    end
end


     ------- Colisión
for _, enemigo in ipairs(enemigos) do

    if player.x < enemigo.x + enemigo.ancho and 
       player.x + player.ancho > enemigo.x and 
       player.y < enemigo.y + enemigo.alto and 
       player.y + player.alto > enemigo.y then 

        if gameState ~= "lose" then
            love.audio.stop(music)
            love.audio.play(loseSound)
            gameState = "lose"
        end

        break
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

     
    
  end
end

------------------------------------------------RENDERIZADO------------------------------------------

function love.draw()

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
      player:Dibujar(scale)

        ----------------------ENEMIGO---------
        for _, enemigo in ipairs(enemigos) do
    enemigo:Dibujar(enemyScale)

end

----------------------------------INTERFAZ-------------
        hud:Dibujar(winTime, timer, gameState)

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
end