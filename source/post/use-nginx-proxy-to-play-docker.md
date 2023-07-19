title: export kube config from an imported cluster of kuboard
date: 2023-01-31 10:34:21 +0800
update: ""
author: linx
tags: []
categories: []
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



# 从Kuboard中导出已导入的kube config

Kuboard使用的内置的etcd存储配置数据, 我这里是docker运行的Kuboard，其他运行方案也类似

```bash
docker exec -it {kuboard容器ID} bash
etcdctl get --prefix / | grep {导入的集群名}
# 一般是 /kind/KubernetesCluster/cluster/{导入的集群名}/{导入的集群名} 这样的key

etcdctl get /kind/KubernetesCluster/cluster/{导入的集群名}/{导入的集群名}
```
复制json其中的kubeconfig内容，把换行什么的删一删，最终拼成下面这样的yaml文件即可导入到其他kuboard中去

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: xxx
    server: https://xxxxxx:6443
  name: xxx
contexts:
- context:
    cluster: xxxx
    namespace: xxx
    user: xxxx
  name: config
current-context: config
kind: Config
preferences: {}
users:
- name: xxxx
  user:
    client-certificate-data: xxx
```
