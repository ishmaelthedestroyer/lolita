# Basic Helper Functions

trim = (text) ->
  return text.replace /^\s+|\s+$/g,""

# # # # # # # # # #

nl2br = (str) ->
  return str.replace /\n/g, '<br />'

# # # # # # # # # #

br2nl = (str) ->
  return str.replace /<br\s*\/?>/mg,'\n'

# # # # # # # # # #

extend = (one, two) ->
  # make sure valid objects
  return {} if !one
  return one if !two or typeof two isnt 'object'

  # get keys in object two
  keys = Object.keys two

  # iterate over keys, add to object one
  one[k] = two[k] for k in keys

  # return object
  return one