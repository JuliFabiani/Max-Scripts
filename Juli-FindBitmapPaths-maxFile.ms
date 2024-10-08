(
    fileList = #()
    pathList = #()

--     files = (getFiles (maxFilePath+"\\*.*") recurse:true)
    files = (getFiles ("Z:\\models\\*.*") recurse:true)

    for f in files do (
        p = filterString f "\\"
        append fileList (p[p.count])
        append pathList f
    )
    bmaps = ((getClassInstances CoronaBitmap) + (getClassInstances VRayBitmap) + (getClassInstances BitmapTexture))

    format "% bitmaps. % files.\n" bmaps.count fileList.count

    for m in bmaps do (
        p = filterString m.fileName "\\"
        index = (findItem fileList p[p.count])

        if index != 0 then (
            m.fileName = pathList[index]
            format "* [OK] % --> %\n" p[p.count] m.fileName
        )
        else format "* [!!] % not found\n" p[p.count]
    )
    OK
)