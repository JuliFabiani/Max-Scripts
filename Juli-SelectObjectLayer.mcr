macroScript SelectObjectLayer

category:"#Juli"
tooltip:"Select Object Layer"
buttonText:"Select Object Layer"
(
	fn selectObjectsInSameLayer = 
	(
		if selection.count == 0 then
		(
			messageBox "Seleccionar objeto!"
			return 0
		)
	
-- 		local selectedLayer = selection[1].layer
-- 		local objectsInSameLayer = for obj in objects where obj.layer == selectedLayer collect obj		
-- 		return select objectsInSameLayer
	
		local selectedLayers = #() -- Aquí creamos un array vacío para almacenar las capas seleccionadas
        for obj in selection do -- Recorremos los objetos seleccionados
        (
            appendIfUnique selectedLayers obj.layer -- Añadimos la capa del objeto al array solo si no está ya presente
        )
		
		local objectsInSameLayers = #() -- Aquí creamos un array vacío para almacenar los objetos de las capas seleccionadas
        for obj in objects do -- Recorremos todos los objetos
        (
            if findItem selectedLayers obj.layer != 0 then -- Verificamos si la capa del objeto está en las capas seleccionadas
            (
                append objectsInSameLayers obj -- Si es así, agregamos el objeto al array
            )
        )
		

		return select objectsInSameLayers
		
	)
	selectObjectsInSameLayer()

)
