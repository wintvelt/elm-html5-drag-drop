# Javascript events related to Html5 drag and drop


* Events on the __dragged__ element
  * __`ondragstart`__:
    * Fires once, when the user starts to drag the element
  * __`ondrag`__:
    * Fires multiple times (ca every 20ms) while the user is dragging the element
  * __`ondragend`__:
    * Fires once, when the user lets go of the dragged element
    * This event is *not* fired if the user drops the element on a valid drop zone


* Events on the __drop zone__ element
  * __`ondrop`__:
    * Fires once, when something is dropped on the drop zone


* Events fired on __any other__ element
    * __`ondragenter`__:
      * Fires once, when a dragged element is entering over this element (determined by mouse position, not the ghost image)
  * __`ondragover`__:
    * Fires multiple times, when some other dragged element is moving over this element
  * __`ondragleave`__:
    * Fires once, when the dragged element no is no longer over this element
