macroScript DeleteAllModifiers
	category:"bgaTools"
	buttontext:"DAM"
	tooltip:"Delete All Modifiers"
(
	if GetCommandPanelTaskMode() != #create do SetCommandPanelTaskMode #create
	if selection.count > 0 do with redraw off 
	(
		with undo on for o in selection where o.modifiers.count > 0 do (for m = o.modifiers.count to 1 by -1 do deleteModifier o m)
	)
)
