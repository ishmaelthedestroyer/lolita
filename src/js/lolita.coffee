# # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # #

Lolita = (container, options) ->
  if !(@ instanceof Lolita)
    return new Lolita container, options

  @_container = container

  # set and extend defaults
  defaults =
    api:
      list: '/api/comments'
      create: '/api/comments'
      find: '/api/comments/:id'
      update: '/api/comments/:id'
      remove: '/api/comments/:id'
    autoload: true
    escapeHTML: true
    escapeJavascript: true
    maxDepth: 5
    comments: []

  @_options = extend defaults, options || {}
  # # # # #

  # call function to initialize elements
  _init @

  return @

# # # # # # # # # #

Lolita::clear = () ->
  @_comments = []
  _clearAll @

  return @

# # # # # # # # # #

Lolita::load = (comments, push) ->
  if !push
    @_comments = comments
  else

# # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # #

# expose to window
window.Lolita = Lolita