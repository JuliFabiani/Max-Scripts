(
    NoChamferObjects = #()
    for obj in geometry do (
        if classof obj.modifiers[1] != Chamfer then append NoChamferObjects obj
    )
    selectionSets["NoChamfer_Objects"] = NoChamferObjects

)