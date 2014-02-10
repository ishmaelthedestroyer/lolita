(function() {
  var Lolita, br2nl, extend, nl2br, trim, _clearAll, _init, _renderComments;

  trim = function(text) {
    return text.replace(/^\s+|\s+$/g, "");
  };

  nl2br = function(str) {
    return str.replace(/\n/g, '<br />');
  };

  br2nl = function(str) {
    return str.replace(/<br\s*\/?>/mg, '\n');
  };

  extend = function(one, two) {
    var k, keys, _i, _len;
    if (!one) {
      return {};
    }
    if (!two || typeof two !== 'object') {
      return one;
    }
    keys = Object.keys(two);
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      k = keys[_i];
      one[k] = two[k];
    }
    return one;
  };

  _init = function(obj) {
    var element;
    obj._container = document.querySelector(obj._container);
    if (!obj._container) {
      throw new Error('Lolita target element does not exist!');
    }
    obj._container.innerHTML = '';
    obj._container.className = 'lolita-wrapper';
    element = document.createElement('ul');
    element.className = 'lolita-comments';
    obj._container.appendChild(element);
    return _renderComments(element, obj._options.comments || [], 0);
  };

  _clearAll = function(obj) {
    return _init(obj);
  };

  _renderComments = function(container, comments, depth) {
    var comment, _i, _len, _render;
    if (!comments.length) {
      return;
    }
    _render = function(comment, parent) {
      var avatar, avatarWrapper, clear, commentBody, commentHeader, commentWrapper, divide, element;
      if (depth === 0) {
        divide = document.createElement('div');
        divide.className = 'lolita-divide';
        container.appendChild(divide);
      }
      clear = document.createElement('div');
      clear.className = 'lolita-clear-20';
      parent.appendChild(clear);
      element = document.createElement('li');
      element.className = 'lolita-comment';
      parent.appendChild(element);
      avatarWrapper = document.createElement('div');
      avatarWrapper.className = 'lolita-avatar-wrapper';
      element.appendChild(avatarWrapper);
      avatar = document.createElement('img');
      avatar.className = 'lolita-avatar';
      avatar.src = '/dist/img/avatar.png';
      avatarWrapper.appendChild(avatar);
      commentWrapper = document.createElement('div');
      commentWrapper.className = 'lolita-comment-wrapper';
      element.appendChild(commentWrapper);
      commentHeader = document.createElement('div');
      commentHeader.className = 'lolita-comment-header';
      commentHeader.innerHTML = '<p class="lolita-comment-author-text">' + comment.author + '</p>';
      commentWrapper.appendChild(commentHeader);
      commentBody = document.createElement('div');
      commentBody.className = 'lolita-comment-body';
      commentBody.innerHTML = '<p class="lolita-comment-text">' + comment.body + '</p>';
      commentWrapper.appendChild(commentBody);
      return _renderComments(element, comment.replies || [], depth + 1);
    };
    for (_i = 0, _len = comments.length; _i < _len; _i++) {
      comment = comments[_i];
      _render(comment, container);
    }
    return this;
  };

  Lolita = function(container, options) {
    var defaults;
    if (!(this instanceof Lolita)) {
      return new Lolita(container, options);
    }
    this._container = container;
    defaults = {
      api: {
        list: '/api/comments',
        create: '/api/comments',
        find: '/api/comments/:id',
        update: '/api/comments/:id',
        remove: '/api/comments/:id'
      },
      autoload: true,
      escapeHTML: true,
      escapeJavascript: true,
      maxDepth: 5,
      comments: []
    };
    this._options = extend(defaults, options || {});
    _init(this);
    return this;
  };

  Lolita.prototype.clear = function() {
    this._comments = [];
    _clearAll(this);
    return this;
  };

  Lolita.prototype.load = function(comments, push) {
    if (!push) {
      return this._comments = comments;
    } else {

    }
  };

  window.Lolita = Lolita;

}).call(this);

/*
//@ sourceMappingURL=lolita.js.map
*/