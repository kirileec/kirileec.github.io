title: GongSolutions.Wpf.DragDrop 实现WPF拖拽
date: "2016-10-18 12:36:31"
update: ""
author: me
tags:
- Nexus 6p
categories:
- Nexus 6p
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



## XAML

```xml
<ListBox ItemTemplate="{StaticResource HandBrandShowTemplate}"
         ItemsSource="{Binding showHandBrands,
                               Mode=TwoWay,
                               IsAsync=True}"
         SelectedItem="{Binding selectedHandBrand,
                                Mode=TwoWay}"
         x:Name="handBrandListbox" 
         dd:DragDrop.IsDragSource="True" 
         dd:DragDrop.IsDropTarget="True"
         dd:DragDrop.DropHandler="{Binding}">
```

## ViewModel
implement interface `IDropTarget`

```csharp
        public void DragOver(IDropInfo dropInfo)
        {
            HandBrandItemViewModel sourceItem = dropInfo.Data as HandBrandItemViewModel;
            HandBrandItemViewModel targetItem = dropInfo.TargetItem as HandBrandItemViewModel;

            if (sourceItem != null && targetItem != null && targetItem.CanAcceptChildren)
            {
                dropInfo.DropTargetAdorner = DropTargetAdorners.Highlight;
                dropInfo.Effects = DragDropEffects.Copy;
            }
        }

        public void Drop(IDropInfo dropInfo)
        {
            HandBrandItemViewModel sourceItem = dropInfo.Data as HandBrandItemViewModel;
            HandBrandItemViewModel targetItem = dropInfo.TargetItem as HandBrandItemViewModel;
            targetItem.Children.Add(sourceItem);

            var msg = new HostMessage("正在进行房间拖拽操作...."
                + "\n 源手牌号:" + sourceItem.handBrand.handBrandShowId
                + "\n 目标手牌号:" + targetItem.handBrand.handBrandShowId

                , "HandBrandDialog");
        }

```
