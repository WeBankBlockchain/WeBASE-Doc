## 走读代码-WeBASE-Node-Manager的NodeService如何判断节点状态是否正常

&nbsp;&nbsp;&nbsp;&nbsp;登录WeBASE管理管理平台，点击“链管理”下的“节点管理”，显示节点的各项信息，其中包括状态，这次走读代码的内容，就是“节点列表”中的“状态”是如何判断的。

### 一、请求路径
&nbsp;&nbsp;&nbsp;&nbsp;在页面上点击右键选择“检查”，或者按F12键，打开浏览器的调试工具，点击“Network”选项卡，查看请求后端请求的地址为：WeBASE-Node-Manager/node/nodeList/1/1/100。

&nbsp;&nbsp;&nbsp;&nbsp;然后查看后端WeBASE-Node-Manager的源代码，在全局java文件中搜索nodeList，在NodeController中找到请求方法为：
```
@GetMapping(value = "/nodeList/{groupId}/{pageNumber}/{pageSize}")
public BasePageResponse queryNodeList(@PathVariable("groupId") Integer groupId,
        @PathVariable("pageNumber") Integer pageNumber,
        @PathVariable("pageSize") Integer pageSize,
        @RequestParam(value = "nodeName", required = false) String nodeName)
        throws NodeMgrException
```
&nbsp;&nbsp;&nbsp;&nbsp;其中第1个参数是groupId群组ID，第2和第3个是分页参数，第4个非必填项是节点名称，表示也可以根据节点名称进行查询。

### 二、判断节点状态并更新到数据库
&nbsp;&nbsp;&nbsp;&nbsp;在NodeController中代码如下：
```
try{
nodeService.checkAndUpdateNodeStatus(groupId);
  }catch (Exception e) {
    log.error("queryNodeList checkAndUpdateNodeStatus groupId:{}, error: []", groupId, e);
        }

```
&nbsp;&nbsp;&nbsp;&nbsp;在NodeService代码中提供了一个根据groupId检查和更新节点状态的方法：
```
public void checkAndUpdateNodeStatus(int groupId)
```
#### 第一步：根据groupId获取保存在数据库的本地节点列表（这个数据库是WeBASE-Node-Manager的本地数据库）。
```
List<TbNode> nodeList = queryByGroupId(groupId);
```
#### 第二步：根据groupId获取共识节点列表（从区块链上）。
```
List<PeerOfConsensusStatus> consensusList = getPeerOfConsensusStatus(groupId);
```
&nbsp;&nbsp;&nbsp;&nbsp;其中在getPeerOfConsensusStatus方法中：

&nbsp;&nbsp;&nbsp;&nbsp;首先用http请求工具RestTemplate调用了web3/consensusStatus接口，返回指定群组内的共识状态信息。

```
ConsensusInfo consensusInfo = frontInterface.getConsensusStatus(groupId);
```
&nbsp;&nbsp;&nbsp;&nbsp;然后判断共识状态信息如果为空，返回null，提示节点状态检查失败。否则获取共识状态信息里的viewInfos信息，读取每个节点的view数量填充到节点共识列表里返回。
```
List<PeerOfConsensusStatus> dataIsList = new ArrayList<>();
List<ViewInfo> viewInfos = consensusInfo.getViewInfos();
for (ViewInfo viewInfo : viewInfos) {
dataIsList.add(
new PeerOfConsensusStatus(viewInfo.getNodeId(), new BigInteger(viewInfo.getView())));
        }
return dataIsList;

```
#### 第三步：根据groupId获取获取群组内观察节点列表（从区块链上）。
```
List<String> observerList = frontInterface.getObserverList(groupId);
```
&nbsp;&nbsp;&nbsp;&nbsp;调用了web3/observerList接口，返回指定群组内的观察节点列表。

#### 第四步：遍历本地节点nodeList：
##### 1、判断是否在检查间隔内
&nbsp;&nbsp;&nbsp;&nbsp;求每个本地节点的修改时间modifyTime到当前时间间隔duration的毫秒数subTime。
如果：

&nbsp;&nbsp;&nbsp;&nbsp;（1）subTime小于（共识节点和观察节点相加的总数nodeCount乘以1000+3500）； 

&nbsp;&nbsp;&nbsp;&nbsp;（2）并且 本地节点的创建时间createTime在修改时间之前modifyTime。
那么跳过检查，否则继续向下执行。

##### 2、判断每个本地节点的类型
&nbsp;&nbsp;&nbsp;&nbsp;遍历观察节点，如果本地节点的ID和观察节点ID相同，赋值nodeType为1（观察节点），否则为0（共识节点）。

##### 3、根据群组ID和本地节点ID获取群组内同步状态信息里最新的块高latestNumber。

```
BigInteger latestNumber = getBlockNumberOfNodeOnChain(groupId, nodeId);
```
&nbsp;&nbsp;&nbsp;&nbsp;调用了web3/syncStatus接口，获取群组内同步状态信息。

&nbsp;&nbsp;&nbsp;&nbsp;如果本地节点ID和同步状态信息里的nodeId相同，直接获取块高blockNumber；否则就遍历同步状态信息里的节点列表，找到和本地节点ID相同的节点取对应的块高，没有找到的话设置块高为0。

##### 4、根据本地节点ID从共识列表consensusList中获取view数量latestView。

```
BigInteger latestView = consensusList.stream()
.filter(cl -> nodeId.equals(cl.getNodeId())).map(PeerOfConsensusStatus::getView).findFirst()
.orElse(BigInteger.ZERO);

```
##### 5、如果本地节点被判断为共识节点：
&nbsp;&nbsp;&nbsp;&nbsp;如果：

&nbsp;&nbsp;&nbsp;&nbsp;（1）本地节点的块高localBlockNumber和最新的块高latestNumber相同；

&nbsp;&nbsp;&nbsp;&nbsp;（2）并且本地节点的localPbftView和最新的latestView相同。

&nbsp;&nbsp;&nbsp;&nbsp;那么：

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点的nodeActive为INVALID值2。
  
&nbsp;&nbsp;&nbsp;&nbsp;否则：

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点块高为latestNumber，PbftView为latestView。

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点的nodeActive为NORMAL值1。

##### 6、如果本地节点被判断为观察节点：
&nbsp;&nbsp;&nbsp;&nbsp;根据群组ID调用web3/blockNumber接口，获取群组最新块高。

&nbsp;&nbsp;&nbsp;&nbsp;如果：

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最新的块高latestNumber和群组的最新块高不相同，并且本地节点的块高localBlockNumber和最新的块高latestNumber相同，
  
&nbsp;&nbsp;&nbsp;&nbsp;那么：

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点的nodeActive为INVALID值2。

&nbsp;&nbsp;&nbsp;&nbsp;否则：

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点块高为latestNumber，PbftView为latestView。

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置此节点的nodeActive为NORMAL值1。

##### 7、更新节点状态及其它参数
&nbsp;&nbsp;&nbsp;&nbsp;设置本地节点的修改时间，并将块高blockNumber、pbftView、nodeActive等更新保存到本地数据库。

##### 8、如果是手动部署或者区块链的状态是运行：
&nbsp;&nbsp;&nbsp;&nbsp;根据本地节点ID获取前置节点，如果本地节点的状态是NORMAL，那么前置节点的状态为RUNNING；如果本地节点的状态是INVALID，那么前置节点的状态为STOPPED。

&nbsp;&nbsp;&nbsp;&nbsp;把前置节点的状态更新保存到本地数据库。

#### 三、查询保存在数据库的本地节点列表。
&nbsp;&nbsp;&nbsp;&nbsp;回到NodeController代码中，根据groupId和nodeName查询保存在数据库的本地节点列表：

```
List<TbNode> listOfnode = nodeService.queryNodeList(queryParam);
```
返回给前端页面。











