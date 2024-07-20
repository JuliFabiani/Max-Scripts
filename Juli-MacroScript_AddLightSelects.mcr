macroScript MacroScript_AddLightSelects

category:"#Juli"
tooltip:"Add Lights to Render Elements"
buttonText:"Lights to RE"
(
    local reMgr = maxOps.GetCurRenderElementMgr()
    local allLights = lights as array

    local coronaLightsMapped = for i in getclassinstances CShading_LightSelect collect i
    local clist = #()
    for i in coronaLightsMapped do join clist i.includedNodes
    -- for i in coronaLightsMapped do print i.includedNodes

    fn removeBaseNumber inputString =
    (
        -- Definir la expresión regular para los números
        local regex = dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]?\d+$"

        -- Buscar el primer número en la cadena
        local match = regex.Match inputString

        -- Si se encuentra un número, devolver su posición, de lo contrario devolver undefined
        if match.Success then
            return substring inputString 1 match.index
        else
            return inputString
    )

    ------------------------------------------
    msgtxt = ""

    local reMgr = maxOps.GetCurRenderElementMgr()

    for light in allLights where (classOf light != TargetObject) do
    (
--         format "Light: %\n" light.name 
--         format "| dependencias de $.baseObject: %\n"  (refs.dependentNodes light.baseObject)
--         format "| Nombre del conjunto: %\n" (removeBaseNumber light.name)

        local reExists = false
        for re in getclassinstances CShading_LightSelect while reExists==false do (
            if (removeBaseNumber light.name) == re.name do (
                reExists = true
                if(findItem re.includedNodes light == 0) do (
                    append re.includedNodes light
                    msgtxt = msgtxt + ("ADDED: " + light.name + " --> " + re.name + ".\n")
                )
            )
        )
        if(reExists == false) do (
            reMgr.AddRenderElement ( CShading_LightSelect elementname:(removeBaseNumber light.name) includedNodes:(refs.dependentNodes light.baseObject) )

            msgtxt = msgtxt + ("CREATED: " + (removeBaseNumber light.name) + ".\n")
            for a in (refs.dependentNodes light.baseObject) do (
                msgtxt = msgtxt + "ADDED: " + a.name + " --> " + (removeBaseNumber light.name) + ".\n"
            )
        )        
    )

    if (msgtxt == "") do msgtxt = "No changes found."

    messageBox msgtxt title:"Lights to Render Elements"
)
