title: WPF 用ListBox实现RadioGroup的效果
date: "2016-09-28 14:43:18"
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



```xml
<GroupBox Grid.Row="2" Header="类型">
            <ListBox ItemsSource="{Binding roomTypeLists}" SelectedItem="{Binding selectedType, UpdateSourceTrigger=PropertyChanged}">
                <ListBox.Template>
                    <ControlTemplate TargetType="{x:Type ListBox}">
                        <ScrollViewer HorizontalScrollBarVisibility="Disabled" VerticalScrollBarVisibility="Auto">
                            <WrapPanel IsItemsHost="True"
                                       Orientation="Horizontal"
                                       ScrollViewer.CanContentScroll="True" />
                        </ScrollViewer>
                    </ControlTemplate>
                </ListBox.Template>
                <ListBox.ItemContainerStyle>
                    <Style TargetType="{x:Type ListBoxItem}">
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="{x:Type ListBoxItem}">
                                    <RadioButton Content="{Binding Path=content}" IsChecked="{Binding RelativeSource={RelativeSource TemplatedParent}, Path=IsSelected}" />
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                </ListBox.ItemContainerStyle>

            </ListBox>

        </GroupBox>
```
