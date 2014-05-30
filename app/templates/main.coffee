#<% if (isPhysics) { %>import coffeephysics.coffee <% } %>

class Prototype
  # sketch instance
  sketch : null
  _isMouseDown : false

  mouse: x:0, y:0

  constructor: ->
    @createSketch()
    @addListeners()

  addListeners: ->
    @sketch.draw = @draw
    @sketch.mousemove = @onmousemove
    @sketch.mouseup = @onmouseup
    @sketch.mousedown = @onmousedown
    @sketch.mouseleave = @onmouseleave

  createSketch:->
    options =
      container : document.body

    @sketch = Sketch.create options

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


window.onload = (-> new Prototype() )
