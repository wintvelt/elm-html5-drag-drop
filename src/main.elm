{- Example implementation of Drag and Drop using Html5 events
-}
import Html exposing (beginnerProgram, Program, Html, div, p, h2, text)
import Html.Attributes exposing (style)
import Dict


import Styles exposing (..)
import Events exposing (onDragStart, onDragOver, onDragEnd)



--- MAIN


main : Program Never Model Msg
main =
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
        List.map2 (++)
            [ "A", "B", "C", "D", "E", "F", "G", "H" ]
            [ "1", "2", "3", "4", "5", "6", "7", "8" ]
        |> List.map (\pos -> (pos, Cell Nothing))
        |> Dict.fromList
        |> Dict.insert "C4" (Cell <| Just <| Piece White Knight)
    }




--- UPDATE


type Msg =

