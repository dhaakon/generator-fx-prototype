#<% if (isPhysics) { %>import coffeephysics.coffee <% } %>
#<% if (isSketch) { %>import sketch.coffee <% } %>

class Prototype
  constructor: -> <% if (isSketch) { %>
    @createSketch()
  createSketch:->
    options =
      container : document.body

    @sketch = new PrototypeSketch options
    <% } %>

window.onload = (-> new Prototype() )
