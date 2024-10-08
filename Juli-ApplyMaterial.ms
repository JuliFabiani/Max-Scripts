(
    rollout Juli_Clone "Make Unique" (
        group "Material" (
            radiobuttons matb labels:#("Unique", "Same")
        )
        button but "_MAKEBUTTON_" width:150

        on matb changed state do (
            if matb.state == 1 then but.text = "Apply 'Material_n' "
            if matb.state == 2 then but.text = "Apply First 'Material' to All"
        )



        on but pressed do (

            ::newMat
            for i=1 to selection.count do (
               
                if matb.state == 1 then (
                    
                    newMat = copy selection[i].material
                    newMat.name = newMat.name + " _" + i as string

                    countn = 0
                   
                    for m in scenematerials do (
                        if newMat.name == m.name then countn += 1
                    )
                    print countn
                    if countn > 0 then newMat.name = newMat.name + " " + (countn+1) as string

                    selection[i].material = newMat
                )
                else (
                    selection[i].material = selection[1].material
                )
                    
            )            

        )

    )
    
    CreateDialog Juli_Clone 
    Juli_Clone.matb.changed(state)
)