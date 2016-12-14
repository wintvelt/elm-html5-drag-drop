module DragEvents exposing (..)
{- custom events for Html5 drag and drop
-}
import Html.Events exposing (on, onWithOptions)

-- when drag of element starts
onDragStart : 

-- when element is being dragged (fires multiple times between dragStart and dragEnd)
onDrag : 

-- when this element is no longer being dragged
onDragEnd :


-- when another dragged element enters this element
onDragEnter :


-- when another dragged element is over this element (fired multiple times during drag)
onDragOver :


-- when another dragged element leaves this element (moved outside border)
onDragLeave :


-- when another dragged element is dropped over this element
onDrop : 


