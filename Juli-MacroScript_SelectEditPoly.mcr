macroScript MacroScript_SelectEditPoly

category:"#Juli"
tooltip:"Select Poly Mod"
buttonText:"Sel Poly Mod"
(
    if MS_SED_1 == undefined do global MS_SED_1 = 10
    stamp = 0
    stamp += timeStamp()
    local simpleClick = (stamp-MS_SED_1) > 700
    local onlyOne = (selection.count == 1)


    print (stamp-MS_SED_1)
    if simpleClick == false then return clearSelection()
    MS_SED_1 = stamp

    if selection.count == 1 then (

        if modPanel.getCurrentObject() == undefined then max modify mode

        if modPanel.getCurrentObject() == $.baseObject then (

            if (try(getSelectionLevel selection[1] == #edge and selection[1].selectededges.count != 0) catch (false)) or (try(getSelectionLevel selection[1] == #face and selection[1].selectedfaces.count != 0) catch(false)) then (

                local tryElements = 0
                try ( if (getSelectionLevel(selection[1]) == #edge) do      tryElements += selection[1].selectededges.count ) catch ( 3 )
                try ( if (getSelectionLevel(selection[1]) == #face) do      tryElements += selection[1].selectedfaces.count ) catch ( 4 )
                print tryElements

                if (tryElements != 0) then (
                    result = queryBox "¿Cambiar setSelectionLevel = #object?" title:"setSelectionLevel" beep:false
                    if result == true then setSelectionLevel $.baseObject #object
                )
            )
            else try ( setSelectionLevel $.baseObject #object ) catch (false)
            return try (modPanel.setCurrentObject selection[1].modifiers[1]) catch (false)
        )
        else return modPanel.setCurrentObject $.baseObject
    )
)