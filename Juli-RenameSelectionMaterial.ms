(
    rollout RenameMaterials "Rename" width:210 (
        edittext prefname "Name Prefix"
        button renamebtn "Rename Selection Material" width:200
        on renamebtn pressed do (

            if prefname.text == "" then (

                arr = #()
                for o in selection where o.material != undefined do (
                    appendIfUnique arr o
                )

                for m=1 to arr.count do (            
                    try(arr[m].material.name = "Mtl_"+arr[m].name) catch()
                )

            )
            else (
                arr = #()
                for o in selection where o.material != undefined do (
                    appendIfUnique arr o.material
                )

                for m=1 to arr.count where superclassof arr[m] == material do (            
                    if arr.count == 1 then arr[m].name = prefname.text
                    else arr[m].name = prefname.text+(formattedprint (m-1) format:"03d")
                )
            )
        )
    )
    CreateDialog RenameMaterials
)