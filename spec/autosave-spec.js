(function() {
  describe("init method", function() {
    var inputTpl;
    inputTpl = '<input class="testCls" data-autosave name="test"/>';
    beforeEach(function() {
      return $(inputTpl).appendTo("body");
    });
    afterEach(function() {
      localStorage.removeItem('autosave:test');
      return $('.testCLs').remove();
    });
    it("should save data when keyup event happend", function() {
      var autosave, data, el;
      autosave = simple.autosave();
      el = $('.testCls');
      data = 'test String';
      el.val(data);
      el.trigger('keyup');
      return expect(localStorage.getItem('autosave:test')).toBe(data);
    });
    return it("should save data when selector is specified", function() {
      var autosave, data, el;
      autosave = simple.autosave({
        el: '.testClas'
      });
      el = $('.testCls');
      data = 'test String2';
      el.val(data);
      el.trigger('keyup');
      return expect(localStorage.getItem('autosave:test')).toBe(data);
    });
  });

  describe('init render and clear', function() {
    var inputTpl;
    inputTpl = '<input class="testCls" data-autosave name="test"/>';
    beforeEach(function() {
      localStorage.setItem('autosave:test', 'this is the test string');
      return $(inputTpl).appendTo("body");
    });
    afterEach(function() {
      localStorage.removeItem('autosave:test');
      return $('.testCls').remove();
    });
    it('should init data, when data\'s been saved', function() {
      simple.autosave();
      return expect($('.testCls').val()).toBe('this is the test string');
    });
    return it('should remove data when clear method called', function() {
      var autosave;
      autosave = simple.autosave();
      autosave.clear();
      return expect(localStorage.getItem('autosave:test')).toBeNull();
    });
  });

  describe('destroy', function() {
    var inputTpl;
    inputTpl = '<input class="testCls" data-autosave name="test"/>';
    beforeEach(function() {
      localStorage.setItem('autosave:test', 'this is the test string');
      return $(inputTpl).appendTo("body");
    });
    afterEach(function() {
      localStorage.removeItem('autosave:test');
      return $('.testCls').remove();
    });
    return it('should stop autosaving when call destroy', function() {
      var autosave;
      autosave = simple.autosave();
      autosave.destroy();
      $('.testCls').val('test again').trigger('keyup');
      return expect(localStorage.getItem('autosave:test')).toBe('this is the test string');
    });
  });

}).call(this);
