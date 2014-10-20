describe "init method", ->
  inputTpl = '''
    <input class="testCls" data-autosave name="test"/>
  '''
  beforeEach ->
    $(inputTpl).appendTo("body")

  afterEach ->
    localStorage.removeItem simple.url().pathname + ':test/autosave/'
    $('.testCLs').remove()


  it "should save data when keyup event happend", ->

    autosave = simple.autosave()
    el = $('.testCls')
    data = 'test String'
    el.val data
    el.trigger 'keyup'

    expect(localStorage.getItem simple.url().pathname + ':test/autosave/').toBe(data)

  it "should save data when selector is specified", ->
    autosave = simple.autosave({el: '.testCls'})

    el = $('.testCls')
    data = 'test String2'
    el.val data
    el.trigger 'keyup'

    expect(localStorage.getItem simple.url().pathname + ':test/autosave/').toBe(data)

describe 'init render and clear', ->
  inputTpl = '''
    <input class="testCls" data-autosave name="test"/>
  '''
  beforeEach ->
    localStorage.setItem simple.url().pathname + ':test/autosave/', 'this is the test string'
    $(inputTpl).appendTo("body")
  afterEach ->
    localStorage.removeItem simple.url().pathname + ':test/autosave/'
    $('.testCls').remove()

  it 'should init data, when data\'s been saved',  ->
    simple.autosave()
    expect($('.testCls').val()).toBe('this is the test string')

  it 'should remove data when clear method called', ->
    autosave = simple.autosave()
    autosave.clear()
    expect(localStorage.getItem simple.url().pathname + ':test/autosave/').toBeNull()

describe 'destroy', ->
  inputTpl = '''
    <input class="testCls" data-autosave name="test"/>
  '''
  beforeEach ->
    localStorage.setItem simple.url().pathname + ':test/autosave/', 'this is the test string'
    $(inputTpl).appendTo("body")
#  afterEach ->
#    localStorage.removeItem 'autosave:test'
#    $('.testCls').remove()

  it 'should stop autosaving when call destroy', ->
    autosave = simple.autosave()
    autosave.destroy()

    $('.testCls').val('test again').trigger 'keyup'
    expect(localStorage.getItem simple.url().pathname + ':test/autosave/').toBe('this is the test string')

