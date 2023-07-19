title: CxGrid筛选自动添加百分号和默认旧的滚动条样式
date: "2018-10-29 19:41:40"
update: ""
author: me
tags:
- Delphi
categories:
- Delphi
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



# cxGrid支持使用like过滤时自动添加百分号

默认状态下， 不会添加 `%%` 到过滤串中， 修改源码如下

`cxFilter.pas` 在 `\Library\Sources\cxFilter.pas` 和 `\ExpressDataController\Sources\cxFilter.pas` 两个地方都有一个，一起修改掉

`cxFilter.pas` 的 `TcxFilterCriteria.AddItem` 改成这样

```pascal
  //if AParent = nil then
  //  AParent := Root;
  //Result := AParent.AddItem(AItemLink, AOperatorKind, AValue, ADisplayValue);
    if AParent = nil then
    AParent := Root;
  if AOperatorKind in [foLike, foNotLike] then
    Result := AParent.AddItem(AItemLink, AOperatorKind, '%' + AValue + '%', ADisplayValue)
  else
    Result := AParent.AddItem(AItemLink, AOperatorKind, AValue, ADisplayValue);
```

`cxFilterDialog.pas` 在 `Library\Sources\cxFilterDialog.pas`和`ExpressQuantumGrid\Sources\cxFilterDialog.pas` 

```pascal
// TcxFilterDialog.AddFilterItem

procedure TcxFilterDialog.AddFilterItem(AParent: TcxFilterCriteriaItemList;
  AComboBox: TcxComboBox; AValue: Variant; ADisplayValue: string);
var
  AOperator: TcxFilterControlOperator;
begin
  AOperator := GetOperator(AComboBox);
  if AOperator = fcoNone then Exit;
  
  //edited by lero 09-11-18  如果是like,而且没有输入%时,自动在前后加入%
  if AOperator in [fcoLike, fcoNotLike] then
  begin
    if VarIsStr(AValue) and (AValue <> '') and (Pos('%', AValue) = 0) then
      AValue := '%' + AValue + '%';
  end;

  if AOperator in [fcoBlanks, fcoNonBlanks] then
    AValue := Null;
  if VarIsNull(AValue) or (VarIsStr(AValue) and (AValue = '')) then
    ADisplayValue := cxGetResourceString(@cxSFilterBlankCaption);

  Criteria.AddItem(AParent, ItemLink, GetFilterOperatorKind(AOperator), AValue, ADisplayValue);
end;
```



# DevExpress控件滚动条默认使用旧的经典滚动条样式

新版本， 应该是17还是多少版本开始，默认使用触摸的滚动条样式， 查询了官方的论坛之后， 可以修改如下

搜索`cxVer.inc` 在 `\Library\Sources\cxVer.inc` 和 `\ExpressCore Library\Sources\cxVer.inc` 两个地方各有一个

打开后， 搜索 `USETOUCHSCROLLUIMODEASDEFAULT` 在 `$DEFINE` 前面加个点即可

```pascal
{.$DEFINE USETOUCHSCROLLUIMODEASDEFAULT}
```

# DevExpress下拉lookup控件加入输入时自动定位

- 单元 `cxCustomData.pas` `Library\Sources\cxCustomData.pas` `ExpressDataController\Sources\cxCustomData.pas` 修改如下

```pascal
function TcxCustomDataController.DoIncrementalFilterRecord(ARecordIndex: Integer): Boolean;
var
  S: string;
  I: Integer;
begin
  //edited by lero---
  Result := False;
  for I := 0 to Fields.ItemCount - 1 do
  begin
    S := GetInternalDisplayText(ARecordIndex, Fields[i]);
    Result := DataCompareText(S, FIncrementalFilterText, True);
    if Result then
    begin
      FDisplayIndex := i;
      Exit;
    end;
  end;
  //S := GetInternalDisplayText(ARecordIndex, FIncrementalFilterField);
  //Result := DataCompareText(S, FIncrementalFilterText, True, FIncrementalFilteringFromAnyPos);
end;
```

在`SortingBySummaryDataItemIndex`属性下方添加, 不要忘了在private节下加入 `FDisplayIndex:Integer;`

```pascal
property DisplayIndex: Integer  read FDisplayIndex write FDisplayIndex;   //add by lero
```

- 单元 `cxLookupEdit.pas` 分别在 `Library\Sources\cxLookupEdit.pas` 和 `ExpressEditors Library\Sources\cxLookupEdit.pas`

```pascal
// TcxCustomLookupEditLookupData.Locate


    if ARecordIndex <> -1 then
      begin
        DataController.ChangeFocusedRecordIndex(ARecordIndex);
        DoSetCurrentKey(ARecordIndex);
        Result := True;
        //此处为添加代码   add by lero---
        if DataController.DisplayIndex > -1 then
        begin
          S := DataController.DisplayTexts[ARecordIndex, DataController.DisplayIndex];
          DataController.DisplayIndex := -1;
        end
        else
        begin
          S := DataController.DisplayTexts[ARecordIndex, AItemIndex];
        end;
      //结束
        //S := DataController.DisplayTexts[ARecordIndex, AItemIndex];
        if IsLikeTypeFiltering then
          ATail := ''
        else
        begin
          AText := Copy(S, 1, Length(AText));
          ATail := Copy(S, Length(AText) + 1, Length(S));
        end;
        DoSetKeySelection(True);
      end
      else
        DoSetKeySelection(False);
```

最后的最后，使用编译工具重新编译安装即可
