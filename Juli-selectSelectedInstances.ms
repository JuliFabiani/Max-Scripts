(
    arr = for o in selection collect o.baseObject
    newsel = #()
    newsel = for o in objects where (findItem arr o.baseObject) collect o
    ClearNodeSelection
    select newsel
)