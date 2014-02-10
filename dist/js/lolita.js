(function(w, d) {
  var Lolita, br2nl, extend, nl2br, trim;
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
  Lolita = function(container, options) {
    if (!(this instanceof Lolita)) {
      return new Lolita(container, options);
    }
    return this;
  };
  return window.Lolita = Lolita;
})(window, document);

/*
//@ sourceMappingURL=lolita.js.map
*/