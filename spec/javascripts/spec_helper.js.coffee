$.fn.press= (key, options) ->
  throw "Unknown key #{key}" if key == undefined
  options ?= {}
  options.shift ?= false
  options.ctrl ?= false
  for n in ['keydown', 'keypress', 'keyup']
    e=jQuery.Event(n)
    e.which = key
    e.keyCode = key
    e.shiftKey=options.shift
    e.ctrlKey=options.ctrl
    @each (index, element) ->
      $(element).trigger(e)
  this