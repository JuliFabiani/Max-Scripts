macroScript Randomizer

category:"QUANG"
tooltip:"Randomizer"
buttonText:"Randomizer"
(
rollout Randomizer "Randomizer" width:250 height:800
(
	--UI
	label 'lbl_randomize' "Randomize Script" width:88 height:24 align:#center
	subRollout subRandomizer "Randomizer"
)--end Main UI

rollout randSelect "Random Select" width:184 height:97
(
	--Random select UI
	button 'btn_randSelect' "Random Select (%)" pos:[8,8] width:144 height:24 align:#left
	spinner 'spn_randSelect' "" pos:[8,40] width:144 height:16 range:[0,100,0] type:#integer align:#left
	
		
	/*
	chuyen doi so phan tram thanh so luong (so luong phai la integer)
	tao ra mot array rong
	tao mot gia tri random trong khoang 0 va 1. Neu ra 1 thi chon, ra 0 thi thoi. Giong nhu tro choi tung dong xu 
	vong lap qua toan bo selection de kiem tra cac dieu kien sau:
	+ neu random == 1
	+ neu object hien tai ko co trong array
	+ neu so luong object trong array nho hon so luong phan tram
	thoa man ca ba dieu kien thi bo object vao trong array
	*/
	fn randomSelect = 
	(
		numOfRandomSelect = floor (spn_randSelect.value * selection.count / 100) as integer -- chuyen doi so luong phan tram thanh so luong objects muon chon
		--selection.count tuong duong voi 100%
		
		selectArray = #() --array nay se chua cac objects duoc chon
		
		while selectArray.count < numOfRandomSelect do 
		(
			for o in selection do 
			(
				randomNumber = random 0 1 --tung dong xu, neu ra 1 thi chon, ra 0 thi thoi
				is_o_in_selectArray = findItem selectArray o --gia tri nay de kiem tra xem "o" co trong selectArray chua? Neu ra 0 thi chua co
				if (randomNumber == 1) and (is_o_in_selectArray == 0) and (selectArray.count < numOfRandomSelect) do 
				(
					append selectArray o
				)--end if
			)--end for
		)--end while
		select selectArray
	)--end fn randomSelect
	
	
	
	on btn_randSelect pressed do
	(
		undo on (
			randomSelect()
		)
	)--end Random Select btn
)--end randSelect

rollout randTransform "Random Transform" width:184 height:464
(
	--Transform UI
	spinner 'spn_transformFrom' "" pos:[16,40] width:64 height:16 enabled:true range:[-100000,100000,0] align:#left
	spinner 'spn_transformTo' "" pos:[104,41] width:64 height:16 range:[-100000,100000,0] type:#float align:#left
	label 'lbl_to' "to" pos:[88,41] width:16 height:16 align:#left
	button 'btnTransformX' "X" pos:[16,65] width:40 height:24 align:#left
	button 'btnTransformY' "Y" pos:[64,65] width:48 height:24 align:#left
	button 'btnTransformZ' "Z" pos:[120,65] width:40 height:24 align:#left
	button 'btnTransformAll' "Transform All" pos:[16,97] width:144 height:24 align:#left
	
	--scale UI
	spinner 'spn_scaleFrom' "" pos:[13,178] width:64 height:16 enabled:true range:[0,100000,1] align:#left
	spinner 'spn_scaleTo' "" pos:[104,176] width:64 height:16 range:[0,100000,1] type:#float align:#left
	label 'lbl_to2' "to" pos:[80,176] width:16 height:16 align:#left
	button 'btnScaleX' "X" pos:[16,200] width:40 height:24 align:#left
	button 'btnScaleY' "Y" pos:[64,200] width:48 height:24 align:#left
	button 'btnScaleZ' "Z" pos:[120,200] width:40 height:24 align:#left
	button 'btnScaleNonUniform' "Scale Non-Uniform" pos:[16,232] width:152 height:24 align:#left
	button 'btnScaleUniform' "Scale Uniform" pos:[16,264] width:152 height:24 align:#left
	
	--rotate UI
	spinner 'spnRotFrom' "" pos:[16,344] width:64 height:16 enabled:true range:[-360,360,0] align:#left
	spinner 'spnRotTo' "" pos:[104,344] width:64 height:16 range:[-360,360,0] type:#float align:#left
	label 'lbl_to3' "to" pos:[88,344] width:16 height:16 align:#left
	button 'btnRotX' "X" pos:[16,368] width:40 height:24 align:#left
	button 'btnRotY' "Y" pos:[64,368] width:48 height:24 align:#left
	button 'btnRotZ' "Z" pos:[120,368] width:40 height:24 align:#left
	button 'btnRotAll' "Rotate All" pos:[16,400] width:144 height:24 align:#left
	GroupBox 'grpRandScale' "Random Scale" pos:[8,160] width:168 height:136 align:#left
	GroupBox 'grpRandTranslation' "Random Translation" pos:[8,8] width:168 height:128 align:#left
	GroupBox 'grpRandRot' "Random Rotate" pos:[8,320] width:168 height:120 align:#left
	
	
	fn randomTransform axis = 
	(
		for o in selection do 
		(
			randTransformAll = random spn_transformFrom.value spn_transformTo.value
			randTransformX = random spn_transformFrom.value spn_transformTo.value
			randTransformY = random spn_transformFrom.value spn_transformTo.value
			randTransformZ = random spn_transformFrom.value spn_transformTo.value
			if axis == "x" then
			(
				move o [randTransformAll, 0, 0]
			)
			else if (axis == "y") then
			(
				move o [0, randTransformAll, 0]
			)
			else if (axis == "z") then
			(
				move o [0, 0, randTransformAll]
			)
			else 
			(
				move o [randTransformX, randTransformY, randTransformZ]
			) --end if
		)--end for
	)--end fn randomTransform
	
	
	fn randomScale axis = 
	(
		for o in selection do 
		(
			randScaleUniform = random spn_scaleFrom.value spn_scaleTo.value
			randScaleX = random spn_scaleFrom.value spn_scaleTo.value
			randScaleY = random spn_scaleFrom.value spn_scaleTo.value
			randScaleZ = random spn_scaleFrom.value spn_scaleTo.value
			
			if axis == "x" then
			(
				scale o [randScaleX, 1, 1]
			) 
			else if axis == "y" then
			(
				scale o [1, randScaleY, 1]
			)
			else if axis == "z" then
			(
				scale o [1, 1, randScaleZ]
			)
			else if axis == "nonUniform" then 
			(
				scale o [randScaleX, randScaleY, randScaleZ]
			)
			else 
			(
				scale o [randScaleUniform, randScaleUniform, randScaleUniform]
			)--end if
		)--end for
	)--end fn randomScale
	
	
	fn randomRotate axis =
	(
		for o in selection do 
		(
			rotX = eulerAngles (random spnRotFrom.value spnRotTo.value) 0 0
			rotY = eulerAngles 0 (random spnRotFrom.value spnRotTo.value) 0
			rotZ = eulerAngles 0 0 (random spnRotFrom.value spnRotTo.value)
			rotAll = eulerAngles (random spnRotFrom.value spnRotTo.value) (random spnRotFrom.value spnRotTo.value) (random spnRotFrom.value spnRotTo.value)
			if axis =="x" then 
			(
				rotate o rotX
			)
			else if axis == "y" then 
			(
				rotate o rotY
			)
			else if axis == "z" then 
			(
				rotate o rotZ
			)
			else 
			(
				rotate o rotAll
			)--end if
		)--end for
	)--end fn randomRotate
	
	
	on btnTransformX pressed do
	(
		undo on (
			randomTransform "x"
		)
	)--end btnTransformX
	on btnTransformY pressed do
	(
		undo on (
			randomTransform "y"
		)
	)--end btnTransformY
	on btnTransformZ pressed do
	(
		undo on (
			randomTransform "z"
		)
	)--end btnTransformZ
	on btnTransformAll pressed do
	(
		undo on (
			randomTransform "all"
		)
	)--end btnTransformAll
	on btnScaleX pressed do
	(
		undo on (
			randomScale "x"
		)
	)--end btnTransformX
	on btnScaleY pressed do
	(
		undo on (
			randomScale "y"
		)
	)--end btnTransformY
	on btnScaleZ pressed do
	(
		undo on (
			randomScale "z"
		)
	)--end btnTransformZ
	on btnScaleNonUniform pressed do
	(
		undo on (
			randomScale "nonUniform"
		)
	)--end btnScaleAll
	on btnScaleUniform pressed do
	(
		undo on (
			randomScale "uniform"
		)
	)--end btnScaleUniform
	on btnRotX pressed do
	(
		undo on (
			randomRotate "x"
		)
	)--end btnRotX
	on btnRotY pressed do
	(
		undo on (
			randomRotate "y"
		)
	)--end btnRotY
	on btnRotZ pressed do
	(
		undo on (
			randomRotate "z"
		)
	)--end btnRotZ
	on btnRotAll pressed do
	(
		undo on (
			randomRotate "all"
		)
	)--end btnRotAll
)--end randTransform

rollout randColor "Random WireColor" width:184 (
	--Wirecolor UI
	button 'btn_randWire' "Random Wirecolor Selection"  width:160 height:24 align:#left
	
	fn randomWirecolor = 
	(
		for o in selection do 
		(
			colorR = random 0 255
			colorG = random 0 255
			colorB = random 0 255
			o.wirecolor = [colorR, colorG, colorB]
		)--end for
	)--end fn randomWirecolor
	
	on btn_randWire pressed do
	(
		undo on (
			randomWirecolor()
		)
	)--end btn btn_randWire
)--end randColor

rollout randMat "Random Material" width:184 height:256
(
	--Material UI
	button 'btn_randMat' "Random Material " pos:[16,56] width:152 height:24 align:#left
	spinner 'spnRandMatFrom' "" pos:[16,32] width:64 height:16 range:[1,24,1] type:#integer align:#left
	spinner 'spnRandMatTo' "" pos:[104,32] width:64 height:16 range:[1,24,24] type:#integer align:#left
	label 'lbl26' "to" pos:[88,32] width:16 height:16 align:#left
	GroupBox 'grpRandMat' "Random Material" pos:[8,8] width:168 height:88 align:#left
	GroupBox 'grpRemoveMat' "Remove Material" pos:[8,184] width:168 height:56 align:#left
	button 'btnResetCorona' "Corona" pos:[72,128] width:48 height:24 align:#left
	button 'btnResetVray' "Vray" pos:[128,128] width:48 height:24 align:#left
	button 'btnResetStandard' "Standard" pos:[16,128] width:48 height:24 align:#left
	GroupBox 'grp3' "Reset Material Editor" pos:[8,114] width:168 height:64 align:#left
	button 'btnRemoveMat' "Remove Material Selection" pos:[16,208] width:152 height:24 align:#left
	
	
	
	fn randMaterial = (
		for o in $ do (
			randMatID = random spnRandMatFrom.value spnRandMatTo.value
			o.mat = mEditMaterials[randMatID]
		)--end for
	)--end fn randMaterial
	
	fn resetMaterialEditor mat = (
		for i=1 to 24 do (
			mEditMaterials[i] = mat()
			mEditMaterials[i].name = (i as string) + " - Default"
			try (
				mEditMaterials[i].diffuse = [random 0 255, random 0 255, random 0 255]
			) catch ()
			try (
				mEditMaterials[i].colorDiffuse = [random 0 255, random 0 255, random 0 255]
			) catch ()
		)--end for
	) --end fn resetStandardMat
	
	

	on btn_randMat pressed do(
		undo on (
			randMaterial()
		)
	)--end btn_randMat
	on btnResetCorona pressed do (
		try (
			resetMaterialEditor coronaMtl	
		) catch (
			messageBox "Corona not installed yet"
		)
	)--end btnResetCorona
	on btnResetVray pressed do (
		try (
			resetMaterialEditor vrayMtl	
		) catch (
			messageBox "Vray not installed yet"
		)
	)--end btnResetVray
	on btnResetStandard pressed do (
		resetMaterialEditor standardMaterial
	)--end btnResetStandard
	on btnRemoveMat pressed do (
		undo on (
			$.mat = undefined 
		)
	)--end btnRemoveMat
)

rollout randInfo "Info" width:184 (		
	--info UI
	label 'lbl_Author' "Author: Nhat Quang" width:144 height:16 align:#left
	label 'lbl_Email' "Email: hoquang1202@gmail.com" width:144 height:32 align:#left
)--end randInfo

-----------------------------------------------
	createDialog Randomizer
	addSubRollout Randomizer.subRandomizer randSelect
	Randomizer.subRandomizer.height += 200
	addSubRollout Randomizer.subRandomizer randTransform
	Randomizer.subRandomizer.height += 200
	addSubRollout Randomizer.subRandomizer randColor
	Randomizer.subRandomizer.height += 200
	addSubRollout Randomizer.subRandomizer randMat
	Randomizer.subRandomizer.height += 200
	addSubRollout Randomizer.subRandomizer randInfo
	Randomizer.subRandomizer.height 

)