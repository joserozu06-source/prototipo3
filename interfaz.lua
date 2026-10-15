Interfaz = {}
Interfaz.__index = Interfaz

function Interfaz:Nueva()
    local o = setmetatable({}, Interfaz)
    return o
end

function Interfaz:Dibujar(winTime, timer, gameState)

    if gameState == "playing" then

        local ancho = love.graphics.getWidth()

        -- CARTEL CENTRADO ARRIBA
        local escala = math.min(
    0.12,
    (ancho - 40) / cartelObjetivo:getWidth()
)
        love.graphics.draw(
            cartelObjetivo,
            ancho / 2,
            15,
            0,
            escala,
            escala,
            cartelObjetivo:getWidth() / 2,
            0
        )

        -- CONTADOR DEBAJO DEL CARTEL
love.graphics.setFont(fuenteHUD)

local altoCartel = cartelObjetivo:getHeight() * escala

love.graphics.printf(
    "Tiempo: " .. math.max(0, math.ceil(winTime - timer)),
    0,
    550,
    ancho,
    "center"
)

    end

end

return Interfaz