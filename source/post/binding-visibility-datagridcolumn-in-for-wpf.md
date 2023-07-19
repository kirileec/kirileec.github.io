title: Binding Visibility for DataGridColumn in WPF
date: "2016-12-20 12:40:23"
update: ""
author: me
tags:
- CSharp-WPF
- binding
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



First you need a `BooleanToVisibilityConverter` to Converter `bool` to `Visibility`

MaterialDesignThemes has already owned one

add follow code to your xaml file
```xml
xmlns:converters="clr-namespace:MaterialDesignThemes.Wpf.Converters;assembly=MaterialDesignThemes.Wpf"
```
```xml
<converters:BooleanToVisibilityConverter x:Key="booleanToVisibilityConverter" />
```

refer to 

> http://stackoverflow.com/questions/22073740/binding-visibility-for-datagridcolumn-in-wpf

`DataGridTextColumn` or any other supported dataGrid columns doesn't lie in Visual tree of `DataGrid`, so the solution is:

we add 
```xml
<FrameworkElement x:Name="dummyElement" Visibility="Collapsed" />
```
to `UserControl` under `Grid`

just like this

```xml
    <Grid>
        <FrameworkElement x:Name="dummyElement" Visibility="Collapsed" />
.....
.....
</Grid>
```

then use it 
```xml
<DataGridTemplateColumn Width="Auto"                                                  Header="MyColumn"                                                 Visibility="{Binding DataContext.isVisible,                                                                   Converter={StaticResource booleanToVisibilityConverter},                                                                      Source={x:Reference dummyElement}}">

```

done
