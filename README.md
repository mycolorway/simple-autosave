# Simple AutoSave

一个简单的自动保存组件，可以实现数据在localStorage的自动保存

依赖项：

- JQuery 2.0+
- [Simple Module](https://github.com/mycolorway/simple-module)

### 使用方法
首先，需要在页面里引用相关脚本

```html
<script type="text/javascript" src="path/to/jquery.min.js"></script>
<script type="text/javascript" src="path/to/module.js"></script>
<script type="text/javascript" src="path/to/autosave.js"></script>

<input class='autosave' name='test'/>

```

初始化实例，返回AutoSave对象

```js
simple.autosave({
  el: '.autosave',
  local: true,
});

```

### API 文档

####初始化选项

初始化的时候，会初始化保存的路径，如果该元素有data-autosave属性，那么将会用其值加上'/autosave/'保存（兼容mcw.autosave），否则保存路径为url.pathname + this.attr('name') + '/autosave/'

__el__

需要自动保存的元素的选择器，默认为'[data-autosave]'
  
__sessionStorage__

Boolean，是否保存在sessionStorage，默认为false


#### 方法

`clear()` 清除已经保存的数据

`destroy()` 取消自动保存

#### 事件

__save__ 

自动保存成功

__error__ 

自动保存失败

__clear__

移除保存的数据成功