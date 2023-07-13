# 通过K8S部署WeBASE教程
* 说明： k8s v1.17.3 以上 webase v1.5.3 以上, ${} 取自定义的名称
## 1.部署webase-front
```shell
# 进入脚本目录
cd webase-front
# 修改 application.yml 里面 fisco 的配置 把sdk文件复制到当前目录
# 部署命令
kubectl apply -k .
# 查看部署结果 READY 1/1 成功 
kubectl get po -n ${namespace}
# 失败可以用 查看具体错误原因
kubectl describe pod ${podname} -n ${namespace}
kubectl logs -f ${podname} -n ${namespace}
```
## 2.部署webase-sign 和webase-node-manager
```shell
# 修改 application.yml 里面 数据库链接
# 部署命令
kubectl apply -k .
# 查看部署结果 READY 1/1 成功
kubectl get po -n ${namespace}
# 失败可以用 查看具体错误原因
kubectl describe pod ${podname} -n ${namespace}
kubectl logs -f ${podname} -n ${namespace}
```
## 3.部署webase-web
```shell
# 修改 default 里面 webasenodemanager 链接
# 修改ingress 里面web 域名 配置到本地host就可以用这个域名访问web了
# 部署命令
kubectl apply -k .
# 查看部署结果 READY 1/1 成功
kubectl get po -n ${namespace}
# 失败可以用 查看具体错误原因
kubectl describe pod ${podname} -n ${namespace}
kubectl logs -f ${podname} -n ${namespace}
```
*  以上webae的部署就完成了，k8s 其他操作可以参考官方文档
   https://kubernetes.io/zh/docs/home/