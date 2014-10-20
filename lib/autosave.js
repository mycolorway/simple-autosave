(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define('simple-autosave', ["jquery",
      "simple-module",
      "simple-url"], function ($, SimpleModule, simpleUrl) {
      return (root.returnExportsGlobal = factory($, SimpleModule, simpleUrl));
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like enviroments that support module.exports,
    // like Node.
    module.exports = factory(require("jquery"),
      require("simple-module"),
      require("simple-url"));
  } else {
    root.simple = root.simple || {};
    root.simple['autosave'] = factory(jQuery,
      SimpleModule,
      simple.url);
  }
}(this, function ($, SimpleModule, simpleUrl) {

var AutoSave, autosave,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AutoSave = (function(_super) {
  __extends(AutoSave, _super);

  function AutoSave() {
    return AutoSave.__super__.constructor.apply(this, arguments);
  }

  AutoSave.prototype.opts = {
    el: '[data-autosave]',
    sessionStorage: false
  };

  AutoSave.prototype._init = function() {
    var url;
    this.fields = $(this.opts.el);
    if (!this.fields.length) {
      return;
    }
    this.storage = this.opts.sessionStorage ? sessionStorage : localStorage;
    url = simple.url();
    this.fields.each((function(_this) {
      return function(index, field) {
        field = $(field);
        if (field.data('autosave')) {
          field.data('autosave:key', field.data('autosave') + '/autosave/');
        } else {
          field.data('autosave:key', url.pathname + ':' + field.attr('name') + '/autosave/');
        }
        if (_this.getStorage(field.data('autosave:key'))) {
          return field.val(_this.getStorage(field.data('autosave:key')));
        }
      };
    })(this));
    return this._bind();
  };

  AutoSave.prototype._bind = function() {
    return this.fields.each((function(_this) {
      return function(index, field) {
        field = $(field);
        return field.on('keyup.autosave', function() {
          var e;
          try {
            _this.setStorage(field.data('autosave:key'), field.val());
            return _this.triggerHandler('save', _this);
          } catch (_error) {
            e = _error;
            return _this.triggerHandler('error', _this);
          }
        });
      };
    })(this));
  };

  AutoSave.prototype._unbind = function() {
    return this.fields.each((function(_this) {
      return function(index, field) {
        field = $(field);
        return field.off('keyup.autosave');
      };
    })(this));
  };

  AutoSave.prototype.clear = function() {
    this.fields.each((function(_this) {
      return function(index, field) {
        field = $(field);
        return _this.removeStorage(field.data('autosave:key'));
      };
    })(this));
    return this.triggerHandler('clear', this);
  };

  AutoSave.prototype.destroy = function() {
    return this._unbind();
  };

  AutoSave.prototype.setStorage = function(path, value) {
    return this.storage.setItem(path, value);
  };

  AutoSave.prototype.getStorage = function(path) {
    return this.storage.getItem(path);
  };

  AutoSave.prototype.removeStorage = function(path) {
    return this.storage.removeItem(path);
  };

  return AutoSave;

})(SimpleModule);

autosave = function(opts) {
  return new AutoSave(opts);
};


return autosave;


}));

