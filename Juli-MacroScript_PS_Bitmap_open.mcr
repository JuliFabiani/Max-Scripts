macroScript PS_Bitmap_open
category:"#Juli"
tooltip:"Open Bitmap"
Buttontext:"Open Bitmap"
Icon:#("maxtools",1)
(

	selectedNodes = (sme.GetView sme.activeView).GetSelectedNodes()
    
    if selectedNodes.count > 0 then
    (
    	files = #()
		viewNode = sme.GetView (sme.activeView)
		for i = 1 to viewNode.GetNumNodes() do (
		    local node = viewNode.GetNode i
		    if node.selected then (
		        append files (node.reference).filename
		    )
		)

		rollout Dialog "Open" width:100 (
			button btn1 "Photoshop"
			button btn2 "File Explorer"

			on btn1 pressed do (

				local exepath = getIniSetting (getMAXIniFile()) "photoshop" "path"
				if exepath == "" do
				(
					local _ps = getOpenFileName caption:"Please locate Photoshop.exe" filename:"c:/program files/Photoshop.exe" types:"Executable Files(*.exe)|*.exe"
					setINISetting (getMAXIniFile()) "photoshop" "path" _ps
					exepath = _ps
				)
				if exepath == "" do return false

				for f in files do shelllaunch exepath f
				DestroyDialog Dialog 
			)
			on btn2 pressed do (
				local exepath = "explorer.exe"

				for f in files do shelllaunch exepath final
				DestroyDialog Dialog
			)
		)
		CreateDialog Dialog

    )
    else
    (
        format "No nodes selected in the Slate Material Editor.\n"
    )
)