# 存证合约模板

## 简介
Evidence 示例合约，使用分层的智能合约结构： 

- 工厂合约（EvidenceSignersData.sol），由存证各方事前约定，存储存证生效条件，并管理存证的生成。 
- 存证合约（Evidence.sol），由工厂合约生成，存储存证id，hash和各方签名（每张存证一个合约）。 

## 使用步骤：
1. 部署EvidenceSignersData合约，并在构造函数中指定存证生效条件（需要哪些机构进行认证确认）。 
2. 存证时通过newEvidence接口在区块链上创建具体存证合约。 
3. 解析newEvidence调用返回的receipt，将解析出来的存证合约地址保存在应用系统。 
4. 仲裁等认证机构利用存证合约地址调用addSignatures来对存证进行确认。 
5. 取证时利用存证合约地址调用getEvidence接口进行取证。 



