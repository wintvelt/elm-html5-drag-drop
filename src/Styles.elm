module Styles exposing (..)
{- Styles to use in examples
-}

type alias StyleList = List (String, String)

main : StyleList
main =
    [ ( "display", "flex" )
    , ( "width", "420px" )
    , ( "height", "300px" )
    , ( "align-items", "flex-end" )
    ]


column : StyleList
column =
    [ ( "flex", "0 0 180px" )
    , ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "center" )
    , ( "justify-content", "center" )
    , ( "position", "relative" )
    ]

disk : StyleList
disk =
    [ ( "width", "80px" )
    , ( "height", "20px" )
    , ( "margin", "2px" )
    , ( "background-color", "lightblue" )
    , ( "user-select", "none" )
    , ( "border-radius", "2px" )
    , ( "box-shadow", "0 2px 4px rgba(0,0,0,.17)" )
    , ( "z-index", "1" )
    ]

pole : StyleList
pole =
    [ ( "width", "16px" )
    , ( "height", "200px" )
    , ( "background-color", "#795548" )
    , ( "border-radius", "8px 8px 0 0" )
    , ( "position", "absolute" )
    , ( "bottom", "0" )
    , ( "left", "82px" )
    ]