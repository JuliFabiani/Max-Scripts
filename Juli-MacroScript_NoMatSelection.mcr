macroScript MacroScript_NoMatSelection

category:"#Juli"
tooltip:"No Material Selection"
buttonText:"No Material Selection"
(
    NoMatObjects = #()
    MatObjects = #()
    for obj in objects do (
        if obj.material == undefined then append NoMatObjects obj
        else append MatObjects obj
    )
    selectionSets["NoMat_Objects"] = NoMatObjects
    selectionSets["Mat_Objects"] = MatObjects

    NoMatObjects = undefined
    MatObjects = undefined
)