(
    -- Función para generar un color aleatorio
    fn randomColor =
    (
        color (random 0 255) (random 0 255) (random 0 255)
    )
    
    -- Obtiene el gestor de capas (Layer Manager)
--     local layerManager = LayerManager
    
    -- Recorre todas las capas y asigna un color aleatorio
    for i = 0 to (layerManager.count-1) do
    (
        local layer = layerManager.getLayer i
        layer.wirecolor = randomColor()
    )
    
    print "Se han asignado colores aleatorios a todas las capas."
)