macroScript MacroScript_PreScriptManager
category:"#Juli"
tooltip:"PreScript Manager"
buttonText:"PreScript Manager"
(
	MacroScript_PreScriptManager_changes = ""
	MacroScript_PreScriptManager_backup = copy renderers.current

	try (DestroyDialog rolloutRenderB) catch false

	rollout rolloutRenderB_compare "RenderB Compare" width:600
	(
	 	edittext lbl_changes "Changes" text:MacroScript_PreScriptManager_changes fieldWidth:590 height:400 labelOnTop:true multiLine:true pos:[5,10]		
	)

	rollout rolloutRenderB "RenderB" width:800
	(
		local path_1 = "Z:\\usermacros\\RenderB\\prescript-pc.ms"
	 	local path_2 = "Z:\\usermacros\\RenderB\\prescript-note.ms"

		fn fn_load file = (
			local fsa = openFile file mode:"r"
			local fileContent = ""
			while (eof fsa == false) do (
		        local line_ = readLine fsa
		        fileContent += line_ + "\n"
		    )
		    close fsa
		    return fileContent
		)

		local ms1 = fn_load path_1
	 	edittext lbl_ms1 "prescript-pc.ms" text:ms1 fieldWidth:390 height:400 labelOnTop:true multiLine:true pos:[5,10]
		local ms2 = fn_load path_2
	 	edittext lbl_ms2 "prescript-note.ms" text:ms2 fieldWidth:390 height:400 labelOnTop:true multiLine:true pos:[405,10]
	 	button lbl_ms1_exec "execute" pos:[340,5]
	 	button lbl_ms2_exec "execute" pos:[740,5]
	 	button lbl_show_prop "showproperties renderers.current" pos:[5,435]
	 	button lbl_compare "Compare" pos:[250,435]


		on lbl_ms1 entered text do (
	    	fsa = createFile path_1 mode:"w"
	    	format "%\n" lbl_ms1.text to:fsa
	    	close fsa
		)
		on lbl_ms2 entered text do (
	    	fsa = createFile path_2 mode:"w"
	    	format "%\n" lbl_ms2.text to:fsa
	    	close fsa
		)

		on lbl_ms1_exec pressed do fileIn path_1
		on lbl_ms2_exec pressed do fileIn path_2
		on lbl_show_prop pressed do showproperties renderers.current
		on lbl_compare pressed do (
			MacroScript_PreScriptManager_changes = ""
			try (DestroyDialog rolloutRenderB_compare) catch false

			props = getPropNames renderers.current

			ignore = #(
				"mtlOverride",
				"overrideMtl_exclude",
				"dr_slaveAddresses",
				"dr_slaveResolvedNames",
				"renderSelected_list",
				"colorMap_lightmixColors",
				"colorMap_lightmixIntensities",
				"obsoleteTabParam",
				"system_vfbRegions",
				"colormap_lightselect_elementNames",
				"colorMap_lightmixEnabledLayers",
				"dr_slaveEnabled",
				"bg_colorList",
				"bg_texmapList",
				"caustic_excludeList",
				"colorMap_pipeline",
				"bg_exclude",
				"colormap_lightmix_elementNames"
			)

			for p = 1 to props.count do (
				val_current = (getProperty renderers.current props[p]) as string
				val_backup = (getProperty MacroScript_PreScriptManager_backup props[p]) as string

				if (val_current != val_backup and (findItem ignore (props[p] as string) == 0)) do (
					MacroScript_PreScriptManager_changes = MacroScript_PreScriptManager_changes + "renderers.current."+(props[p] as string)+" = ("+val_backup+")->("+val_current+")\n"
				)
			)
			createDialog rolloutRenderB_compare
		)
	)

	createDialog rolloutRenderB
)