class AutoSave extends SimpleModule
  opts:
    el: '[data-autosave]'
    sessionStorage: false

  _init: ->
    @fields = $(@opts.el)
    return unless @fields.length
    @storage = if @opts.sessionStorage then sessionStorage else localStorage

    url = simple.url()
    #use data saved before
    @fields.each (index, field) =>
      field = $(field)
      if field.data 'autosave'
        field.data 'autosave:key', field.data('autosave') + '/autosave/'
      else
        field.data 'autosave:key', url.pathname + ':' + field.attr('name') + '/autosave/'
      if @getStorage field.data('autosave:key')
        field.val @getStorage field.data('autosave:key')

    @_bind()

  _bind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.on 'keyup.autosave', =>
        try
          @setStorage field.data('autosave:key'), field.val()
          @triggerHandler 'save', @
        catch e
          @triggerHandler 'error', @

  _unbind: ->
    @fields.each (index, field) =>
      field = $(field)
      field.off 'keyup.autosave'

  clear: ->
    @fields.each (index, field) =>
      field = $(field)
      @removeStorage field.data('autosave:key')
    @triggerHandler 'clear', @

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
