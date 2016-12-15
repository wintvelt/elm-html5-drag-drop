{- Example implementation of Drag and Drop using Html5 events
-}
import Html exposing (beginnerProgram, Html, div, p, h2, text)
import Html.Keyed as Keyed
import Html.Attributes exposing (style, attribute)
import Html.Events exposing (onClick)
import Dict exposing (Dict)


import Styles
import Hanoi
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
    | MoveTo Hanoi.Pole
    | CancelMove


update : Msg -> Model -> Model
update msg model =
    case msg of
        Move disk ->
            { model | movingDisk = Just disk }

        MoveTo newPole ->
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
        List.indexedMap (viewColumn model) model.poles


viewColumn : Model -> Hanoi.Pole -> List Hanoi.Disk -> Html Msg
viewColumn model pole diskList =
    let
        isDroppable =
            model.movingDisk
                |> Maybe.map (Hanoi.isDroppableOn diskList)
                |> Maybe.withDefault False

        ( droppableStyles, droppableAttr ) =
            if isDroppable then
                ( [ ( "background-color", "#7CB342" ) ]
                ,   [ onClick <| MoveTo pole 
                    , attribute "ondragenter" "return false"
                    , onDrop <| MoveTo pole
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
                    if idx == 0 && Hanoi.canMove disk model.poles then
                        ( [ ( "background-color", "#7CB342" ) ]
                        ,   [ onClick <| Move disk 
                            , attribute "draggable" "true"
                            , onDragStart <| Move disk
                            ]
                        )
                    else
                        ( [], [] )

                Just movingDisk ->
                    if disk == movingDisk then
                        ( [ ("opacity","0") ]
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