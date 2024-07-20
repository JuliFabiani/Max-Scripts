macroScript MacroScript_ScriptLoader

category:"#Juli"
tooltip:"Script Loader"
buttonText:"Script Loader"
(
    local scripts = getFiles ("Z:\\usermacros\\ScriptLoader" + "\\*.ms")
    local scriptNames = for s in scripts collect (filenameFromPath s)

	try ( DestroyDialog ScriptList ) catch ( false )
	rollout ScriptList "Script List" width:324 height:320 (
	    
		listbox lbl_lista "Scripts" items:scriptNames height:20 width:300
		button lbl_execute "Ejecutar" pos:[12,292] width:302

		on lbl_execute pressed do (
			fileIn scripts[lbl_lista.selection]
		)
	)
	createDialog ScriptList
)
