title: Pascalscripts Unable to Register Type TDatasetErrorEvent
date: 2018-11-05 18:55:25 +0800
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


Pascalscripts Unable to Register Type TDatasetErrorEvent
<!--more-->
line about 892, comment the code as follow

```pascal
//cl.addTypeS('TDataSetErrorEvent', 'procedure (Dataset: TDataSet; E: TObject; var Action: TDataAction)');
```
