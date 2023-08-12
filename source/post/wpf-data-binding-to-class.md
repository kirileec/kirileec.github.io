title: WPF 数据绑定到类
date: "2016-08-17 19:12:12"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



首先, 类的声明需要做一些手脚

`using System.ComponetModel;`

```c#
public class Status : INotifyPropertyChanged
    {
        private string _status;

        public string status
        {
            get { return _status;}

            set {
                _status = value;
                OnPropertyChanged("status");
            }

        }


        public event PropertyChangedEventHandler PropertyChanged;
        private void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }
    }
```

基本上是固定的设置
只要在
`setter` 部分执行`OnPropertyChanged(属性名)` 即可正确地讲当次改动通知到对应的binding, 准确的说是通知到`DataContext`

窗口处理 (*.xaml.cs)

```c#
private Status status = new Status();
```

设置组件的数据
```c#
this.DataContext = status;
```
或者
```c#
label.DataContext = status;
```
都可以

界面(*.xaml)

```xaml
<Label x:Name="label" Content="{Binding Path=status}" HorizontalAlignment="Left" FontSize="50"  Height="75" Margin="90,93,0,0" VerticalAlignment="Top" Width="317"/>
```
