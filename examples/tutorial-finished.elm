{- Example implementation of Drag and Drop using Html5 events
-}
import Html exposing (beginnerProgram, Html, div, p, h2, text)
import Html.Keyed as Keyed
import Html.Attributes exposing (style, attribute)
import Html.Events exposing (onClick)
import Dict exposing (Dict)


import Examples.Styles as Styles
import Examples.Hanoi as Hanoi
import DragEvents exposing (onDragStart, onDragOver, onDragEnd, onDrop)



--- MAIN


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model 
        , update = update 
        , view = view
        }





--- MODEL

type alias Model =
    { poles : Hanoi.Poles
    , movingDisk : Maybe Hanoi.Disk
    }

model : Model
model =
    { poles =
        [ List.range 0 6
        , [  ]
        , [  ]
        ]
    , movingDisk = Nothing
    }



--- UPDATE


type Msg
    = Move Hanoi.Disk
    | CancelMove
    | DropOn Hanoi.Pole


update : Msg -> Model -> Model
update msg model =
    case msg of
        Move selectedDisk ->
            { model | movingDisk = Just selectedDisk }

        DropOn newPole ->
            let
                newPoles =
                    model.movingDisk
                        |> Maybe.map 
                            (\movingDisk -> Hanoi.moveDisk movingDisk newPole model.poles)
                        |> Maybe.withDefault
                            model.poles
            in
                { model
                | poles = newPoles
                , movingDisk = Nothing
                }

        CancelMove ->
            { model | movingDisk = Nothing }


--- VIEW
view : Model -> Html Msg
view model =
    div 
        [ style Styles.mainDiv ] <|
        List.indexedMap (viewPole model) model.poles


viewPole : Model -> Hanoi.Pole -> List Hanoi.Disk -> Html Msg
viewPole model pole diskList =
    let
        isDroppable =
            -- True if there is a moving disk and current pole is empty or has larger disk on top
            model.movingDisk
                |> Maybe.map (Hanoi.isDroppableOn diskList)
                |> Maybe.withDefault False

        ( droppableStyles, droppableAttr ) =
            if isDroppable then
                ( [ ( "background-color", "#7CB342" ) ]
                ,   [ attribute "ondragover" "return false"
                    , onDrop <| DropOn pole
                    ]
                )
            else
                ( [], [] )
    in
        div
            ([ style Styles.column ]
                ++ droppableAttr
            )
            <|
            [   div
                    [ style <| Styles.pole ++ droppableStyles ]
                    []
            ]
                ++ List.indexedMap (viewDisk model) diskList


viewDisk : Model -> Int -> Hanoi.Disk -> Html Msg
viewDisk model idx disk =
    let
        width =
            20 * disk + 40

        widthStyles =
            [ ( "width", toString width ++ "px" ) ]

        ( moveableStyles, moveableAttr ) =
            case model.movingDisk of
                Nothing ->
                    -- if there is no moving disk yet, and this is top disk, 
                    -- and there are valid moves to other poles, then we're good
                    if idx == 0 && Hanoi.canMove disk model.poles then
                        ( [ ( "background-color", "#7CB342" ) ]
                        ,   [ attribute "draggable" "true"
                            , onDragStart <| Move disk
                            , attribute "ondragstart"
                                "event.dataTransfer.setData(\"text/plain\", \"dummy\")"
                            ]
                        )
                    else
                        ( [], [] )

                Just movingDisk ->
                    if disk == movingDisk then
                        -- this is the moving disk
                        ( [ ("opacity","0.1") ]
                        ,   [ attribute "draggable" "true"
                            , onDragEnd <| CancelMove
                            ] 
                        )
                    else
                        ( [], [] )
    in
        div
            ([ style <|
                Styles.disk
                    ++ widthStyles
                    ++ moveableStyles
             ]
                ++ moveableAttr
            )
            [ text <| toString disk ]
