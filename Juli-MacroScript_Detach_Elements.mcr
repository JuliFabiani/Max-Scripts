macroScript macro_Detach_Elements

category:"#Juli"
tooltip:"Detach Elements" 
buttontext:"Detach Elements" 
(
if Detach2Elements != undefined do
	if classOf Detach2Elements == RolloutClass do
		destroyDialog Detach2Elements
rollout Detach2Elements "Detach Elements"
(
	--// Top level Locals
	local srcObjs = #() -- source objs
	local tmpObjs = #() -- temporary
	local endObjs = #() -- for conv2Mesh
	local eleGroups = #() -- for UnGrouping
	--// Functions
	fn DetachToElements obj cPivot &endObjs num:1 = (
		while obj.getNumFaces() != 0 do (
			polyop.setFaceSelection obj #{1}
			obj.selectElement()
			ele = polyop.getFaceSelection obj
			newName = (num as string)
			num += 1 -- pump up counter
			polyop.detachFaces obj ele asNode:true name:newName
			newObj = getNodeByName newName
			append endObjs newObj
			attachObjects obj newObj
		)
		if cPivot do centerPivot obj.children
	)
	mapped fn renameChildren ch = (
		ch.name = ch.parent.name + ch.name
	)
	--// UI
	group "Base Options"
	(
		checkBox keepSource "Keep Source Objects" checked:true
		checkBox UndoOn "Enable Undo" checked:false --enabled:false
	)
	group "New Objects"
	(
		checkBox outMesh "Convert to Mesh" checked:false
		checkBox isGroup "Group by Source" checked:false
		checkBox cPivot "Center Pivot" checked:false
	)
	group ">>>"
	(
		button detach "Detach" width:140
		label feed "..."
		progressbar progBar color:green
	)
	--// this function must be here! (ie after UI def.)
	fn runEntirely = (
		feed.text = "Detaching..."
		local total = (tmpObjs.count as string) -- total objects
		for i = 1 to tmpObjs.count do (
			feed.text = "Detaching... " + (i as string) + "/" + total -- progress
			DetachToElements tmpObjs[i] cPivot.state endObjs
			grp = group tmpObjs[i].children name:(srcObjs[i].name + "_Elements")
			append eleGroups grp -- for UnGrouping ...
			attachObjects srcObjs[i] grp move:false -- link G to source obj.
			renameChildren grp.children -- rename
			progBar.value = 100. * i / tmpObjs.count -- % progress
		)
		progBar.value = 0 -- reset progressbar
		feed.text = "Finalize..."
		eleGroups = for g in eleGroups where isValidNode g collect g -- important!
		if not isGroup.state do ( -- if you rid of groups...
			if not keepSource.state do ( -- and original objs deleted...
				local n = 1 -- get for progressBar
				for g in eleGroups do ( -- to preserve hierarchy...
					holder = point pos:g.pos name:g.name
					g.parent = holder -- replace GroupHead with Point.
					progBar.value = 100. * n / eleGroups.count -- % progress
					n += 1 -- pump up counter
				)
			)
			progBar.value = 0 -- reset progressbar
			ungroup eleGroups -- now ungroup all at once
		)
		if not keepSource.state do (delete srcObjs)
	)
	--// Events
	on detach pressed do
	(
		feed.text = "Initialize..."
		--// filter selection
		srcObjs = for i in selection where canConvertTo i Editable_Poly collect i
		-- save your time
		if srcObjs.count == 0 then (
			feed.text = "* Nothing to proceed *"
		)
		else ( --// Runtime...
			disableSceneRedraw()
			feed.text = "Preparation..."
			max create mode
			setWaitCursor() -------------------
			TimeStart = timestamp()
			numObjs = objects.count
			snapshot srcObjs -- make copies...
			tmpObjs = ( -- and collect 'em
				for i = (numObjs + 1) to objects.count collect objects[i]
			)
			convertTo tmpObjs Editable_Poly
			--// the "core" in Undo context
			with undo "Detach" UndoOn.state ( runEntirely() )
			delete tmpObjs -- KEEP this Out Off Undo context !!!
			---------------------
			endObjs = for i in endObjs where isValidNode i collect i -- important!
			if outMesh.state do convertToMesh endObjs
			select endObjs
			feed.text = "Done!"
			TimeEnd = (timestamp() - TimeStart) / 1000.
			setArrowCursor() --------------------
			enableSceneRedraw()
			redrawViews()
			format "Time:\t%sec.\n" TimeEnd
		) -- end (Runtime)
	) -- end (on detach pressed)
) -- end of rollout

	createDialog Detach2Elements
)
