# BBInputAccessoryViewForWebView
UIWebView自定义InputAccessoryView

# 使用指南
先设置accessoryView，再调用reloadCustomedInputViews方法重新加载。
若要移除webView自动带有的表单accessoryView，将该属性设为空即可。
```
_webView.accessoryView = view;
[_webView reloadCustomedInputViews];
```
