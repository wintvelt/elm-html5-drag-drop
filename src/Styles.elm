module Styles exposing (..)
{- Styles to use in examples
-}

maindiv = 
    [ ("margin", "16px")
    , ("width","384px")
    , ("box-sizing","content-box")
    , ("border", "1px solid grey")
    , ("display","flex")
    , ("flex-wrap","wrap-reverse")
    ]

celldiv =
    [ ("padding","8px")
    , ("width","48px")
    , ("height","48px")
    , ("border-radius","2px")
    , ("box-sizing","border-box")
    , ("user-select","none")
    , ("display","flex")
    , ("align-items","center")
    , ("justify-content","center")
    ]

black =
    [ ("background-color","lightgrey") ]

white =
    [ ("background-color","white") ]

piece =
    [ ("font-size","32px") 
    , ("cursor","pointer")
    ]
