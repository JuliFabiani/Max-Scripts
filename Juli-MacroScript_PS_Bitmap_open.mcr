macroScript PS_Bitmap_open
category:"#Juli"
tooltip:"Bitmap Operator"
Buttontext:"Bitmap Operator"
Icon:#("maxtools",1)
(
	nodes = #()

	rollout Dialog "Bitmap Operator" (

		group "Open" (
			button btn1 "Photoshop"
			button btn2 "File Explorer"
		)
		group "Resize to Fit"(

			radiobuttons dir "" labels:#("Width", "Height") columns:2

			button btn3 "512" width:80
			button btn4 "1024" width:80
			button btn5 "2048" width:80
			button btn6 "4096" width:80

		)

		fn getSelNodes = (

			nodes = #()
			viewNode = sme.GetView (sme.activeView)
			for i = 1 to viewNode.GetNumNodes() do (
			    local node = viewNode.GetNode i
			    if node.selected and (superclassof (node.reference) == textureMap) then (
			        append nodes node
			    )

			)
			if nodes.count == 0 then (dotnetclass "system.media.systemsounds").beep.play()
		)

		fn transform_node node _t = (

			local map = (node.reference)
			local mWidth = (getBitmapInfo (node.reference).filename)[3]
			local mHeight = (getBitmapInfo (node.reference).filename)[4]
			local tWidth = 0.0
			local tHeight = 0.0

			if dir.state == 1 then (
				tWidth = _t
				tHeight = (((tWidth*1.0)/mWidth)*mHeight) as integer
			)

			if dir.state == 2 then (
				tHeight = _t
				tWidth = (((tHeight*1.0)/mHeight)*mWidth) as integer
			)

			local _f = replace (node.reference).filename (findString (node.reference).filename ".") 1 ("_"+tWidth as string+"_"+tHeight as string+".")

			rm = renderMap (node.reference) size:[tWidth,tHeight] \
			fileName:_f
			save rm
			close rm

			format "* %\nFrom [%,%] to [%,%]\n\n" _f mWidth mHeight tWidth tHeight

	        (sme.getView sme.activeView).CreateNode (CoronaBitmap name:(node.name+"_"+tWidth as string+"_"+tHeight as string) filename:_f) [ (node.position).x-200 , (node.position).y ]

		)


		on btn1 pressed do (
			getSelNodes()

			local exepath = getIniSetting (getMAXIniFile()) "photoshop" "path"
			if exepath == "" do
			(
				local _ps = getOpenFileName caption:"Please locate Photoshop.exe" filename:"c:/program files/Photoshop.exe" types:"Executable Files(*.exe)|*.exe"
				setINISetting (getMAXIniFile()) "photoshop" "path" _ps
				exepath = _ps
			)
			if exepath == "" do return false

			for n in nodes do shelllaunch exepath (n.reference).filename
		)
		on btn2 pressed do (
			getSelNodes()
			local exepath = "explorer.exe"

			for n in nodes do shelllaunch exepath ("/select,"+(n.reference).filename)
		)
		on btn3 pressed do (
			getSelNodes()
			print nodes
			for n in nodes do transform_node n 512
		)
		on btn4 pressed do (
			getSelNodes()
			for n in nodes do transform_node n 1024
		)
		on btn5 pressed do (
			getSelNodes()
			for n in nodes do transform_node n 2048
		)
		on btn6 pressed do (
			getSelNodes()
			for n in nodes do transform_node n 4096
		)
		


	)
	try destroyDialog Dialog catch ()

    theParent = windows.getChildHWND 0 "Slate Material Editor"
    createdialog Dialog pos:(mouse.screenpos - [32,32]) parent:theParent[1]
)
