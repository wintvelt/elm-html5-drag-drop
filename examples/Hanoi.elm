module Examples.Hanoi exposing 
    ( Poles, Pole, Disk
    , moveDisk, canMove, isDroppableOn
    )
{- Model, update and view helpers for Towers of Hanoi Game
-}


---- MODEL Helpers

type alias Poles =
    List (List Disk)


type alias Disk =
    Int

type alias Pole =
    Int


---- UPDATE helpers

{- move a disk from one pole to another
will return poles unchanged if move is illegal:

    - to-pole is out of bounds
    - moving disk is larger than top of to-pole

-}
moveDisk : Disk -> Pole -> Poles -> Poles
moveDisk movingDisk toPole poles =
    poles
        |> List.map
            (List.filter (\disk -> disk /= movingDisk))
        |> List.indexedMap (moveDiskHelper movingDisk toPole)


moveDiskHelper : Disk -> Pole -> Int -> List Disk -> List Disk
moveDiskHelper movingDisk targetPole currentPole disksOnPole =
    if currentPole == targetPole then
        movingDisk :: disksOnPole
    else
        disksOnPole



----- VIEW helpers

{- Checks if a disk (int) can move, based on whatever is on top of the 3 poles 
If no pole is empty or has a larger disk on top, the result is false
-}
canMove : Disk -> Poles -> Bool
canMove disk poles =
    poles
        |> List.map List.head
        |> List.foldl (canMoveHelper disk) False

canMoveHelper : Disk -> Maybe Disk -> Bool -> Bool
canMoveHelper disk topOfPole previous =
    if previous then
        True
    else
        case topOfPole of
            Nothing ->
                True

            Just topDisk ->
                topDisk > disk


{- Checks if a moving disk can be dropped on a disklist
True if list is empty or if top of list is larger than moving disk
-}
isDroppableOn : List Disk -> Disk -> Bool
isDroppableOn disksOnPole movingDisk =
    List.head disksOnPole
        |> Maybe.map (\top -> top > movingDisk)
        |> Maybe.withDefault True


