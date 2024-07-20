macroScript convertToPoly

category:"#Juli"
tooltip:"Convert To Poly"
buttonText:"Convert To Poly"
(
	if selection.count > 0 then (
		for i = 1 to selection.count do convertToPoly selection[i]
	) else (
		print "No objects selected."
	)
)