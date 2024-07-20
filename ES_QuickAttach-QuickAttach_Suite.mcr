macroScript QuickAttach_Suite
category: "ES_QuickAttach"
tooltip: "QuickAttach"
icon:#("ES_qa_icon", 1)

(
with redraw off 
	(
		selectedObjects = getCurrentSelection()

for obj in selectedObjects do
(
    if (superClassOf obj != GeometryClass) or (classOf obj == Targetobject) or (classOf obj == LinkComposite) or (classOf obj == Body_Object) do
    (
		
        deselect obj
    )
)

selectedObjects = getCurrentSelection()

if selectedObjects.count > 0 then
(
    mainObject = selectedObjects[1]
    mainObject = convertToPoly mainObject

    for i = 2 to selectedObjects.count do
    (
        obj = convertToPoly selectedObjects[i]
        polyop.attach mainObject obj
    )

    format "All objects have been merged into: %\n" mainObject.name
)
else
(
    format "No objects selected.\n"
)
	)

)
