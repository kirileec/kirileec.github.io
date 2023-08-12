title: Use webhook to deploy Hugo
date: "2018-07-24 13:07:25"
update: ""
author: me
tags:
- hugo
- webhook
- Linux
categories:
- Linux
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



First, make sure your hugo blog files are hosted on Github or any other git hosting server where you can access to through network.
Github is suggested.

in your server

```bash
apt-get install hugo
wget https://github.com/adnanh/webhook/releases/download/2.6.8/webhook-linux-amd64.tar.gz
tar -zxvf webhook-linux-amd64.tar.gz
mv webhook-linux-amd64 webhook && cd webhook
chmod +x webhook
vim hooks.json
```

```json
[
  {
    "id": "redeploy-webhook",
    "execute-command": "/pathto/hookscripts.sh",
    "command-working-directory": "/directory/to/webhook"
  }
]
```

```bash
cd ~/webhook
./webhook -hooks hooks.json -verbose -port 1234 -hotreload &
```

or add

```bash
/pathto/webhook -hooks /pathto/hooks.json -verbose -port 1234 -hotreload &
```

to `/etc/rc.local`

when started, you can test it use

```bash
curl -X POST http://example.com:1234/hooks/redeploy-webhook
```

here is my `hugo.sh`

```bash
#!/bin/sh
GIT_REPO=https://github.com/kirileec/llinx.me
TMP_GIT_CLONE=/tmp/blog
NGINX_HTML=/var/www
rm -rf ${TMP_GIT_CLONE}
git clone $GIT_REPO $TMP_GIT_CLONE
cd $TMP_GIT_CLONE/llinx.me
hugo
rm -rf ${NGINX_HTML}/*
cp -rf ${TMP_GIT_CLONE}/llinx.me/public/* ${NGINX_HTML}
```
