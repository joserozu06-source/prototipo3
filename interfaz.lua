Interfaz = {}
Interfaz.__index = Interfaz

function Interfaz:Nueva()
    local o = setmetatable({}, Interfaz)
    return o
end

function Interfaz:Dibujar(winTime, timer, gameState)

    love.graphics.setFont(fuenteHUD)

    if gameState == "playing" then
        love.graphics.print(
            "Sobrevive 10 segundos! Tiempo: "
            .. math.max(0, math.ceil(winTime - timer)),
            10,
            10
        )
    end

    love.graphics.print(math.ceil(timer), 380, 20)

end

return Interfaz