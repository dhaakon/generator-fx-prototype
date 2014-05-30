class Prototype
  # sketch instanace
  sketch : null
  isMouseDown : false

  constructor: ->
    options =
      container : document.body

    @sketch = Sketch.create options

    @sketch.draw = @draw
    @sketch.mousemove = @onmousemove
    @sketch.mouseup = @onmouseup
    @sketch.mousedown = @onmousedown
    @sketch.mouseleave = @onmouseleave

  draw: =>

  onmousemove:(event)=>
    @mouse.x = event.x
    @mouse.y = event.y

  onmouseup:=>
    @isMouseDown = false

  onmousedown:=>
    @isMouseDown = true

  onmouseleave:=>
    @isMouseDown = false

window.onload = (-> new Prototype() )
