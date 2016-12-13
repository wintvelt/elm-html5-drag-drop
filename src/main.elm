{- Example implementation of Drag and Drop using Html5 events
-}
import Html exposing (beginnerProgram, Html, div, p, h2, text)
import Html.Attributes exposing (style)
import Dict exposing (Dict)


import Styles exposing (..)
--import Events exposing (onDragStart, onDragOver, onDragEnd)



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
    { board : Board
    , isMoving : Maybe Move
    }

type alias Board = Dict Position Cell

type alias Position = String

type alias Cell =
    { occupiedBy : Maybe Piece 
    }

type alias Piece =
    { color : Color 
    , role : Role
    }

type Color = Black | White
type Role = Knight

type Move = Moving Position Position

model =
    { board = 
        allCellPositions
        |> List.map (\pos -> (pos, Cell Nothing))
        |> Dict.fromList
        |> Dict.insert "C4" (Cell <| Just <| Piece White Knight)
    , isMoving =
        Nothing
    }

allCellPositions : List Position
allCellPositions =
    [ "A", "B", "C", "D", "E", "F", "G", "H" ]
    |> List.map 
        (\l -> 
            List.map 
                (\n -> l ++ n)
                [ "1", "2", "3", "4", "5", "6", "7", "8" ]
        )
    |> List.concat

blackCells : List Position
blackCells =
    allCellPositions
    |> List.indexedMap (\i pos -> (i, pos))
    |> List.filterMap (\(i, pos) -> if i % 2 == 0 then Just pos else Nothing)


--- UPDATE


type Msg =
    NoOp



update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model




--- VIEW
view : Model -> Html Msg
view model =
    div 
        [ style Styles.maindiv ]
        <| List.map (viewCell model.isMoving) <| Dict.toList model.board


viewCell : Maybe Move -> (Position, Cell) -> Html Msg
viewCell move (pos, cell) =
    div
        [ style Styles.celldiv ]
        [ text pos ]