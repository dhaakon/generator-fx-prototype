class Main
  sketch : null
  constructor: ->
    options =
      container : document.body

    @sketch = Sketch.create options

    @sketch.draw = @draw
    @sketch.mousemove = @onmousemove
    @sketch.mouseup = @onmouseup
    @sketch.mousedown = @onmousedown

  draw: ->
  onmousemove:->
  onmouseup:->
  onmousedown:->

window.onload = (-> new Main() )
