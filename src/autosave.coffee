#TODO: add limit words
#TODO: add type error for element except input&textarea
class AutoSave extends SimpleModule
  opts:
    el: ""
    local: true

  _init: ->
    @opts.el = "[data-autosave]" unless @opts.el
    @fields = $(@opts.el)
    @storage = if @opts.local then localStorage else sessionStorage

    @_render()
    @_bind()


  _render: ->
    @fields.each (index, field) =>
      field = $(field)
      field.data 'key', 'autosave:' + field.attr('name')
      if @getStorage field.data('key')
        field.val @getStorage field.data('key')

  _bind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.on 'keyup.autosave', =>
        try
          @setStorage field.data('key'), field.val()
          @trigger 'autosavesuccess'
        catch e
          @trigger 'autosaveerror'

  _unbind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.off 'keyup.autosave'

  clear: ->
    @fields.each (index, field) =>
      field = $(field)
      @removeStorage field.data('key')
      @trigger "autosaveremovesuccess"

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
