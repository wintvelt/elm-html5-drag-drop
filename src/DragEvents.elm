module DragEvents exposing (..)
{- custom events for Html5 drag and drop
-}
import Html.Events exposing (on, onWithOptions)
import Html exposing (Attribute)
import Json.Decode as JD

-- when drag of element starts
onDragStart : msg -> Attribute msg

-- when element is being dragged (fires multiple times between dragStart and dragEnd)
onDrag : msg -> Attribute msg

-- when this element is no longer being dragged
onDragEnd : msg -> Attribute msg


-- when another dragged element enters this element
onDragEnter : msg -> Attribute msg


-- when another dragged element is over this element (fired multiple times during drag)
onDragOver : msg -> Attribute msg


-- when another dragged element leaves this element (moved outside border)
onDragLeave : msg -> Attribute msg


-- when another dragged element is dropped over this element
onDrop : msg -> Attribute msg


