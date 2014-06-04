class PrototypeSketch
  # sketch instance
  sketch : null
  _isMouseDown : false
  mouse: x:0, y:0

  constructor: (@options) ->
    @sketch = Sketch.create @options
    @addListeners()

  draw: =>

  onmousemove:(event)=>
    @mouse.x = event.x
    @mouse.y = event.y

  onmouseup:=>
    @isMouseDown(false)

  onmousedown:=>
    @isMouseDown(true)

  onmouseleave:=>
    @isMouseDown(false)

  isMouseDown: (bool)->
    @_isMouseDown = bool

  addListeners: ->
    @sketch.draw = @draw
    @sketch.mousemove = @onmousemove
    @sketch.mouseup = @onmouseup
    @sketch.mousedown = @onmousedown
    @sketch.mouseleave = @onmouseleave

