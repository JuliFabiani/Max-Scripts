macroScript MacroScript_FastSelect

category:"#Juli"
tooltip:"Fast Select"
buttonText:"Fast Select"
(
	try ( DestroyDialog rolloutFastSelect) catch()

	rollout rolloutFastSelect "Fast Select" width:200
	(
		fn function_fastselect_addgeometry = ( selectMore geometry )
		fn function_fastselect_removegeometry = ( deselect geometry )	
		fn function_fastselect_invertgeometry = (
			newSelection = selection as array
		    for i in geometry do (
		        if (findItem newSelection i) != 0 then (
		            deleteItem newSelection (findItem newSelection i)
		        )
		        else append newSelection i
		    )	    
	    	select newSelection
		)

		fn function_fastselect_addlights = ( selectMore lights )
		fn function_fastselect_removelights = ( deselect lights )	
		fn function_fastselect_invertlights = (
			newSelection = selection as array
		    for i in lights do (
		        if (findItem newSelection i) != 0 then (
		            deleteItem newSelection (findItem newSelection i)
		        )
		        else append newSelection i
		    )	    
	    	select newSelection
		)

		fn function_fastselect_addcameras = ( selectMore cameras )
		fn function_fastselect_removecameras = ( deselect cameras )	
		fn function_fastselect_invertcameras = (
			newSelection = selection as array
		    for i in cameras do (
		        if (findItem newSelection i) != 0 then (
		            deleteItem newSelection (findItem newSelection i)
		        )
		        else append newSelection i
		    )	    
	    	select newSelection
		)


	    -- Título de la primera columna
	    label lblColumn1 "Geometry" pos:[5,8]
	    button btn1 "Add" pos:[5,30] width:60
	    button btn2 "Remove" pos:[5,55] width:60
	    button btn3 "Invert" pos:[5,80] width:60

	    -- Título de la segunda columna
	    label lblColumn2 "Lights" pos:[70,8]
	    button btn4 "Add" pos:[70,30] width:60
	    button btn5 "Remove" pos:[70,55] width:60
	    button btn6 "Invert" pos:[70,80] width:60

		label lblColumn3 "Cameras" pos:[135,8]
	    button btn7 "Add" pos:[135,30] width:60
	    button btn8 "Remove" pos:[135,55] width:60
	    button btn9 "Invert" pos:[135,80] width:60

		on btn1 pressed do function_fastselect_addgeometry()
		on btn2 pressed do function_fastselect_removegeometry()
		on btn3 pressed do function_fastselect_invertgeometry()
		on btn4 pressed do function_fastselect_addlights()
		on btn5 pressed do function_fastselect_removelights()
		on btn6 pressed do function_fastselect_invertlights()
		on btn7 pressed do function_fastselect_addcameras()
		on btn8 pressed do function_fastselect_removecameras()
		on btn9 pressed do function_fastselect_invertcameras()
	)
	
	createDialog rolloutFastSelect
	cui.RegisterDialogBar rolloutFastSelect
)
