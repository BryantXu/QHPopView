# QHPopView
集合了卡片动画和弹出动画，动画层和视图层完全分离，所以你只需要继承相应的父类，UI完全自己定义，不需要写任何动画代码就可以动画弹出一些View,简化写代码的量，当然也可以重写父类的动画方法来实现自己的动画<p>
 使用的时候只需要把QHPopView里面的RootPopView这个文件夹拖到自己项目就好了 使用的时候UIView继承一下父类就好了 详情请看 ExamplePopView里面的各种列子 <p>当然 例子也是直接可以用的，比如选择视图，选择日期，选择地址，卡片式引导页，卡片式通知提示页等<p>
 
另外，还有一种通过Present弹出Viewcontroller的方法是通过自己实现弹出协议来实现的，具体请看另一种是使用present那个文件夹里面的例子

<p>demo中用到第三方动画POP，你需要在自己的pod中添加POP，请 用QHPopView.xcworkspace打开工程

<p>具体效果请看:http://v.youku.com/v_show/id_XMTQyMjQ0MzI0NA==.html

