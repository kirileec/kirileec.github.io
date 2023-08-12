title: C# Linq动态多条件查询
date: "2016-10-04 22:27:43"
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



如果是预先知道的多条件可以直接`||`或者`&&`把多个条件拼在一起然后放在`Where()`子句里就可以，不过如果是不确定的条件，就不能用这种方法了，作为一个菜鸟，本来还想着是不是可以一直`.Where`下去，发现不行

先上辅助扩展类
```csharp
public static class PredicateBuilder
{
    public static Expression<Func<T, bool>> True<T>() 
    { return f => true; }
    public static Expression<Func<T, bool>> False<T>() 
    { return f => false; }
    public static Expression<Func<T, bool>> Or<T>(this Expression<Func<T, bool>> expr1,Expression<Func<T, bool>> expr2)
    {
        var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast<Expression>());
        return Expression.Lambda<Func<T, bool>>(Expression.Or(expr1.Body, invokedExpr), expr1.Parameters);
    }
    public static Expression<Func<T, bool>> And<T>(this Expression<Func<T, bool>> expr1, Expression<Func<T, bool>> expr2)
    {
        var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast<Expression>());
        return Expression.Lambda<Func<T, bool>>(Expression.And(expr1.Body, invokedExpr), expr1.Parameters);
    }
}
```
使用方法很简单，先 
```csharp
var Predicate = PredicateBuilder.True<T>();  //T 为需要进行过滤和查询的类型
```
在循环或者遍历的时候
```csharp
predicate = predicate.And(lambda);
or
predicate = predicate.Or(lambda);

```
一步步构建需要的表达式
最后`Where(predicate)`这样既可
