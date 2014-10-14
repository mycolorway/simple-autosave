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

__el__

需要自动保存的元素的选择器，默认为'[data-autosave]'，选择的对象必须有name属性
  
__local__

Boolean，是否保存在localStorage，否则保存在sessionStorage


#### 方法

`clear()` 清除已经保存的数据

`destroy()` 取消自动保存的数据绑定

#### 事件

__autosavesuccess__ 

自动保存成功

__autosaveerror__ 

自动保存失败

__autosaveremovesuccess__

移除保存的数据成功