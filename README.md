# Elm Drag and drop example using Html5 events

## Installation

- Clone this repository
- Run with Elm-reactor

```
git clone https://github.com/wintvelt/elm-html5-drag-drop.git
cd elm-html5-drag-drop
cd examples
elm-reactor
```

## Background

The official Elm site has a [drag and drop example](http://elm-lang.org/examples/drag), which uses the `mousedown` event to start a drag action, and subscriptions to `Mouse.moves` and `Mouse.ups`. The example is a nice and simple demonstration of using subscriptions. It shows how you can make your own custom handler for javascript events.

However, drag and drop is also supported in HTML5 out-of-the-box. By using only custom event handlers, and no subscriptions, you can use drag and drop without subscriptions in Elm.

There are however some caveats. These are described in [this article on Medium.com](https://medium.com/@wintvelt/html5-drag-and-drop-in-elm-88d149d3558f). The article also contains the tutorial to implement drag and drop in the example.

## Contents of this repo

* `/src`
  * `DragEvents.elm`  - custom elm handlers for all drag and drop events
  * `DragEvents.md`  - overview of HTML5 drag and drop events

* `/examples`
  * `Hanoi.elm`  - helpers for game logic
  * `Styles.elm` - helpers for styling game elements
  * `tutorial-finished.elm`  - example implementation of HTML5 drag and drop
  * `tutorial-start.elm` - starter file if you follow the tutorial in the Medium.com article
