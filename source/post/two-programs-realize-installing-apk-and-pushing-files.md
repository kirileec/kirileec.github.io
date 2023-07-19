title: two programs realize installing *.apk and pushing files
date: "2014-03-04 11:00:00"
update: ""
author: me
tags:
- other
categories:
- other
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



```c
/*
 * =====================================================================================
 *
 *       Filename:  install.c
 *    Description:  Install *.apk file to your android phone by draging an apk file to the program
 *        Version:  1.0
 *        Created:  2014/3/4 10:35:12
 *       Revision:  none
 *       Compiler:  gcc
 *         Author:  Sumit.lc, sulinke1133@gmail.com
 *
 * =====================================================================================
 */

#include <stdio.h>
int main ( int argc, char *argv[] )
{
    char total[256]={0};                         
    sprintf(total, "%s%s", "adb install ", argv[1]);         /* add commands together  */
    printf ( "Waiting for device online...n" );            /* make sure the device is connected */
    system("adb wait-for-device");
    system(total);                              /* run the command */
    return 0;
}
```
```c
/*
 * =====================================================================================
 *
 *       Filename:  push.c
 *    Description:  Push file to "/sdcard/" and the filename not be changed
 *        Version:  1.0
 *        Created:  2014/3/4 10:46:56
 *       Revision:  none
 *       Compiler:  gcc
 *         Author:  Sumit.lc (), sulinke1133@gmail.com
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <libgen.h>
int main ( int argc, char *argv[] )
{
    char total[256]={0};
	sprintf(total, "%s%s %s%s", "adb push ",argv[1],"/sdcard/",basename(argv[1]) );
    printf ( "Waiting for device online...n" );
    system("adb wait-for-device");
    system(total);
    return 0;
}
```
