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
	
		local selectedLayers = #() -- Aqu� creamos un array vac�o para almacenar las capas seleccionadas
        for obj in selection do -- Recorremos los objetos seleccionados
        (
            appendIfUnique selectedLayers obj.layer -- A�adimos la capa del objeto al array solo si no est� ya presente
        )
		
		local objectsInSameLayers = #() -- Aqu� creamos un array vac�o para almacenar los objetos de las capas seleccionadas
        for obj in objects do -- Recorremos todos los objetos
        (
            if findItem selectedLayers obj.layer != 0 then -- Verificamos si la capa del objeto est� en las capas seleccionadas
            (
                append objectsInSameLayers obj -- Si es as�, agregamos el objeto al array
            )
        )
		

		return select objectsInSameLayers
		
	)
	selectObjectsInSameLayer()

)
