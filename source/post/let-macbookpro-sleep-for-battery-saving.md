title: MacBook Pro 设置合盖后睡得更死
date: 2020-05-19 19:31:50 +0800
update: ""
author: linx
tags:
- mac
categories:
- mac
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



众所周知, MacBook Pro是不用关机的 🐶

然而最近一段时间, 早上合盖, 中间并没有打开过, 晚上再看的时候, 电量基本都会下降 `10-30%` 不等, 经过查询搜索, 总结如下

## 查询阻碍进入深度睡眠(唤醒)的原因 

`pmset -g` 查看 `sleep` 那一行, 会有 `sleep prevented by` 的字样, 我看到的是`sharingd`, 根据字面意思, 应该是分享服务, 但是经过检查, 所有分享功能都已经关闭. 我回忆了一下, 也有尝试过合盖前把平时比较耗电的Chrome、IDE、虚拟机啥的都关掉, 还是会掉电

推断可能不是这些前台程序导致的唤醒, 节能选项里也是没有开启小憩的

最后, 找到了 `https://github.com/xinstein/PleaseSleep`, 并在今天进行了简单测试, 晚上回家后一看, 卧槽, 电量100%, 惊了!!!


## 脚本的一点问题

时间有点久了, 脚本里提到的 `Sleepwatcher` 已经从 `2.2` 更新到了 `2.2.1` 因此需要小小修改一下, 把代码贴到这里做个备份

```bash
#!/bin/bash

#To use this script, open the Terminal app and go to the directry
#where this script is located and excecute the following commands:
	# chmod u+x PleaseSleep

	# ./PleaseSleep install
	# -------- OR ---------
	# ./PleaseSleep remove

# Get the argument
set -e
ARG=$1

# quit if any command fails
if [ -z "$1" ] ; then
	echo "Error: No parameter. Use 'PleaseSleep install' or 'PleaseSleep remove'."
	exit 1


# REMOVE EVERYTHING
elif [ "$ARG" == "remove" ] || [ "$ARG" == "uninstall" ]
then
	echo
	echo
	echo "REMOVING PleaseSleep with sleepwatcher 2.2"
	echo "This will remove all PleaseSleep AND all Sleepwatcher files."
	echo "This also includes the sleep and wake scripts."
	echo
	echo "Are you sure you want to continue?"
	echo "Press Enter to continue or Crtl+c to quit"
	read
	echo "-------------------------------------------------------------------"
	echo

	echo "Unloading the LaunchAgent..."
	launchctl unload ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist &> /dev/null
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Removing sleep and wake scripts ..."
	rm ~/.sleep &> /dev/null
	rm ~/.wakeup &> /dev/null
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Removing Sleepwatcher 2.2 and all the files ..."
	sudo rm -r /usr/local/Cellar/sleepwatcher &> /dev/null
	sudo rm -r /usr/local/etc/sleepwatcher &> /dev/null
	sudo rm ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist &> /dev/null
  	#sudo rm /usr/local/share/man/man8/sleepwatcher.8 &> /dev/null
  	#sudo rm /etc/rc.sleep &> /dev/null
  	#sudo rm /etc/rc.wakeup &> /dev/null
  	#sudo rm -r /Library/StartupItems/SleepWatcher &> /dev/null
	sudo rm /usr/local/sbin/sleepwatcher &> /dev/null

	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "-------------------------------------------------------------------"
	echo

	echo "PleaseSleep and Sleepwatcher 2.2 are successfully removed from your lovely Mac!!"
	echo
	echo
	echo


# INSTALL EVERYTHING
elif [ "$1" == "install" ]
then
	echo
	echo
	echo "INSTALLING PleaseSleep with sleepwatcher 2.2"
	echo
	echo "Are you sure you want to continue?"
	echo "Press Enter to continue or Crtl+c to quit"
	read
	echo "-------------------------------------------------------------------"
	echo

	echo "Gaining permissions for /usr/local ..."
	# source: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md
	sudo chown -R $(whoami):admin /usr/local/*
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Installing Sleepwatcher 2.2 (using the brew command)."
	echo "Please follow the instructions when prompted ..."
	echo "(Press ENTER key to continue.)"
	read
	echo
	brew install sleepwatcher
	echo
	echo
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Creating the sleep script ..."
		touch ~/.sleep
		chmod u+x ~/.sleep
		echo "#! /bin/bash" > ~/.sleep
		echo "echo" >> ~/.sleep
		echo "echo `date` \"Sleeping\" >> /tmp/sleep.log" >> ~/.sleep
		echo "/usr/sbin/networksetup setairportpower en0 off" >> ~/.sleep
		echo "echo `date` `/usr/sbin/networksetup getairportpower en0` >> /tmp/sleep.log" >> ~/.sleep
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Creating the wake script ..."
		touch ~/.wakeup
		chmod u+x ~/.wakeup
		echo "#! /bin/bash" > ~/.wakeup
		echo "echo" >> ~/.wakeup
		echo "echo `date` \"Waking up\" >> /tmp/sleep.log" >> ~/.wakeup
		echo "sleep 7" >> ~/.wakeup
		echo "/usr/sbin/networksetup setairportpower en0 on" >> ~/.wakeup
		echo "echo `date` `/usr/sbin/networksetup getairportpower en0` >> /tmp/sleep.log" >> ~/.wakeup
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Copying *.plist file to ~/Library/LaunchAgents ..."
	cp /usr/local/Cellar/sleepwatcher/2.2.1/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist ~/Library/LaunchAgents
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo

	echo "Starting PleaseSleep"
	launchctl load ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist
	echo "Done."
	echo "(Press ENTER key to continue.)"
	read
	echo
	echo
	echo "-------------------------------------------------------------------"
	echo
	echo "Path to wake script: ~/.wakeup"
	echo "Path to sleep script: ~/.sleep"
	echo "Path to logging file: /tmp/sleep.log"
	echo
	echo "Note that WiFi will only turn on 7 seconds AFTER your Mac has been waked"
	echo
	echo "-------------------------------------------------------------------"
	echo
	echo
	echo
	echo "IF NO ERRORS WERE FOUND, THEN INSTALLATION IS COMPLETE."
	echo
	echo "Your lovely Mac will sleep like a boss now!"
	echo
	echo
	echo

fi

```
