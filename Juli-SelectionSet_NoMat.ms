(
    NoMatObjects = #()
    for obj in geometry do (
        if obj.material == undefined then append NoMatObjects obj
    )
    selectionSets["NoMat_Objects"] = NoMatObjects

    if(queryBox "Apply default CoronaPhysicalMaterial?") then (
        mat = CoronaPhysicalMtl name:"Default_Material" diffuse:(color 187 0 0)
        for obj in NoMatObjects do (
            obj.material = mat
        )
    )
    try ( renderers.current.mtlOverride = mat ) catch ()

    NoMatObjects = undefined
)