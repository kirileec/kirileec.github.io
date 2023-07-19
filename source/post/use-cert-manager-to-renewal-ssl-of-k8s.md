title: use cert-manager to renewal ssl of k8s
date: 2023-02-08 11:51:35 +0800
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



# cert-manager 自动续期k8s中的证书
以aliyun域名为例

## 安装cert-manager

yaml
```bash
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
```

helm
```
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```

## 安装alidns-webhook
如果服务器有公网IP，则可以使用cert-manager的HTTP01模式，更加简单，省去了很多步骤。 我这是内网使用，所以使用DNS方式


### 安装

```
# Install alidns-webhook to cert-manager namespace. 
kubectl apply -f https://raw.githubusercontent.com/pragkent/alidns-webhook/master/deploy/bundle.yaml
```
创建Secret，放入AK SK 

```
apiVersion: v1
kind: Secret
metadata:
  name: alidns-secret
  namespace: cert-manager
data:
  access-key: YOUR_ACCESS_KEY
  secret-key: YOUR_SECRET_KEY
```

创建ClusterIssuer


```yaml
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: 邮箱地址
    preferredChain: ''
    privateKeySecretRef:
      name: letsencrypt-account-key
    server: 'https://acme-v02.api.letsencrypt.org/directory'
    solvers:
      - dns01:
          webhook:
            config:
              accessKeySecretRef:
                key: access-key
                name: alidns-secret
              region: ''
              secretKeySecretRef:
                key: secret-key
                name: alidns-secret
            groupName: acme.linx.run  # 这里随便填一个
            solverName: alidns


```
在你需要获取证书的命名空间创建Certificate
```
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: pvelinxrun
  namespace: linx
spec:
  commonName: '*.pve.linx.run'
  dnsNames:
    - '*.pve.linx.run'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: pvelinxrun
```

不过这里需要自行先创建一个名为pvelinxrun的Secret，并且里面先填好有效 tls.pem和tls.key。不会自动创建，暂时还不知道是因为啥


Kuboard可以在自定义资源里找到 cert-manager.io/Certificate , 点击YAML即可查看证书的生成情况，正常会看到 Certificate is up to date and has not expired
