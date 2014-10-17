class AutoSave extends SimpleModule
  opts:
    el: ""
    sessionStorage: false

  _init: ->
    @opts.el = "[data-autosave]" unless @opts.el
    @fields = $(@opts.el)
    return unless @fields.length
    @storage = if @opts.sessionStorage then sessionStorage else localStorage

    url = simple.url()
    #use data saved before
    @fields.each (index, field) =>
      field = $(field)
      field.data 'key', 'autosave:' + url.pathname + ':' + field.attr('name')
      if @getStorage field.data('key')
        field.val @getStorage field.data('key')

    @_bind()

  _bind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.on 'keyup.autosave', =>
        try
          @setStorage field.data('key'), field.val()
          @trigger 'save'
        catch e
          @trigger 'error'

  _unbind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.off 'keyup.autosave'

  clear: ->
    @fields.each (index, field) =>
      field = $(field)
      @removeStorage field.data('key')
      @trigger "clear"

  destroy: ->
    @_unbind()

  setStorage: (path, value) ->
    @storage.setItem path, value

  getStorage: (path) ->
    @storage.getItem path

  removeStorage: (path) ->
    @storage.removeItem path

autosave = (opts) ->
  new AutoSave(opts)
