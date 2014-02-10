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
  return one;# # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # #

# Lolita Private Functions

_init = (obj) ->
  # initialize container
  obj._container = document.querySelector obj._container

  if !obj._container
    return throw new Error 'Lolita target element does not exist!'

  # remove any children elements in div
  obj._container.innerHTML = ''
  obj._container.className = 'lolita-wrapper'

  # comments container
  element = document.createElement 'ul'
  element.className = 'lolita-comments'
  obj._container.appendChild element

  _renderComments element, obj._options.comments || [], 0

_clearAll = (obj) ->
  _init obj

_renderComments = (container, comments, depth) ->
  return if !comments.length

  _render = (comment, parent) ->
    if depth is 0
      divide = document.createElement 'div'
      divide.className = 'lolita-divide'
      container.appendChild divide

    clear = document.createElement 'div'
    clear.className = 'lolita-clear-20'
    parent.appendChild clear

    element = document.createElement 'li'
    element.className = 'lolita-comment'
    parent.appendChild element

    avatarWrapper = document.createElement 'div'
    avatarWrapper.className = 'lolita-avatar-wrapper'
    element.appendChild avatarWrapper

    avatar = document.createElement 'img'
    avatar.className = 'lolita-avatar'
    avatar.src = '/dist/img/avatar.png'
    avatarWrapper.appendChild avatar

    commentWrapper = document.createElement 'div'
    commentWrapper.className = 'lolita-comment-wrapper'
    element.appendChild commentWrapper

    commentHeader = document.createElement 'div'
    commentHeader.className = 'lolita-comment-header'
    commentHeader.innerHTML = '<p class="lolita-comment-author-text">' +
      comment.author + '</p>'
    commentWrapper.appendChild commentHeader

    commentBody = document.createElement 'div'
    commentBody.className = 'lolita-comment-body'
    commentBody.innerHTML = '<p class="lolita-comment-text">' +
      comment.body + '</p>'
    commentWrapper.appendChild commentBody

    _renderComments element, comment.replies || [], depth + 1

  _render comment, container for comment in comments

  return @;# # # # # # # # # # # # # # # # # # # #
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