(
    re = maxOps.GetCurRenderElementMgr()

    rollout Juli_LightMixAdd "Add selection to LightMix" width:305 (
        edittext lbl_name "Group Name" width:210 pos:[5,10]
        button lbl_create "Create" pos:[220, 7] width:70
        button lbl_mix "LightMix Element" pos:[5, 35] width:95
        button lbl_env "Env. Element" pos:[105, 35] width:95
        button lbl_rest "Rest Element" pos:[205, 35] width:95

        on lbl_create pressed do (

            reflights = for o in selection where (superclassof o == light) collect o

            pass = -1
            for n=0 to re.numrenderelements()-1 do (
                if (re.GetRenderElement n).elementName == lbl_name.text then pass=n
            )

            if pass == -1 then  (
                element = CShading_LightSelect()
                element.includedNodes = reflights
                element.elementname = lbl_name.text
                re.addrenderelement element

            )

            else (
                element = re.GetRenderElement pass
                
                arr = join (element.includedNodes as array) reflights
                element.includedNodes = arr
            )
        )
        on lbl_env pressed do (

            exists = false

            for n=0 to re.numrenderelements()-1 do (
                try (if not exists and (re.GetRenderElement n).addEnvironment == true then exists = true) catch ()
            )

            if not exists then (
                el = CShading_LightSelect()
                el.elementname = "Environment Light"
                el.addEnvironment = true
                re.addrenderelement el
            )
        )
        on lbl_rest pressed do (

            exists = false

            for n=0 to re.numrenderelements()-1 do (
                try (if not exists and (re.GetRenderElement n).nodeSource == 1 then exists = true) catch ()
            )

            if not exists then (
                el = CShading_LightSelect()
                el.elementname = "Rest Lights"
                el.nodeSource = 1
                re.addrenderelement el
            )
        )

        on lbl_mix pressed do (

            exists = false

            for n=0 to re.numrenderelements()-1 do (
                try (if not exists and classof (re.GetRenderElement n) == CShading_LightMix then exists = true) catch ()
            )

            if not exists then (
                el = CShading_LightMix()
                re.addrenderelement el
            )
        )
    )
    createDialog Juli_LightMixAdd
)

