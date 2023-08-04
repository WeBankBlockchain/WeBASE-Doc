# 区块链教程 | 使用达梦数据库(DM)对WeBASE进行适配 (二)
作者：梁锦辉

作为一个开放、功能丰富的区块链平台， WeBASE致力于提高区块链开发者的运维与管理效率。同时为使用者提供可以适配达梦数据库(DM)(信创环境)的兼容特性;

以下演示，我们通过**WeBASE-Node-Manager**,为例子做的适配改造。

### |前期准备
#### 达数据库的安装
安装指南可以从达梦数据库(DM)官网获取：https://eco.dameng.com/document/dm/zh-cn/start/install-dm-linux-prepare.html

#### 获取达蒙数据库依赖配置
可以在maven或者gradle配置中引入

``` maven依赖配置示例
<dependency>
<groupId>com.dameng</groupId>
<artifactId>DmJdbcDriver18</artifactId>
<version>8.1.1.193</version>
</dependency>
```

``` gradle依赖配置示例
 compile 'com.dameng:DmJdbcDriver18:8.1.1.193'
```
   

如果不同DM版本可以从数据库的安装目录下相关说明文档下获取到，
配置方法也可以在数据库安装目录下的\dmdbms\drivers\jdbc\readme.txt中看到依赖配置信息。

### |DM结合WeBASE-Node-Manager的适配实现
当前WeBASE-Node-Manager是使用的MYSQL作为数据库，达梦数据对MYSQL的兼容性也是比较优化，但存在有些关键语法的问题导致SQL执行不通过；
设计思路，此次改造通过增加使用开关来决定是否达启用达梦数据库(DM)，同时也不影响原来WeBASE-Node-Manager支持MYSQL的能力，改造结果就是同时能支持MYSQL或者达梦数据库(DM)；


修改配置文件：src/main/resources/application.yml
- 切换jdbc的driver为DmDriver
- 设置mybatis的`isDm8`变量

```
driver-class-name: com.mysql.cj.jdbc.Driver
    driver-class-name: dm.jdbc.driver.DmDriver
    hikari:
      connection-test-query: SELECT 1 FROM DUAL
      connection-timeout: 30000



mybatis: 
  mapper-locations: classpath:mapper/*.xml
  configuration:
    variables:
      isDm8: true

```

由于DM的sql语法和mysql有部分差异，因此修改：

修改相关mapper的Java类或xml文件，通过mybatis的`isDm8`变量进行判断
- `tb_stat`表的mapper Java类修改
- `tb_trans_hash`表的mapper xml文件修改
- `tb_block`表的mapper xml文件修改
- `tb_node`表的mapper xml文件修改
- `tb_trans_daily`表的mapper xml文件修改

``` 由于当前版本的mysql是关联查询删除，DM对这样语法支持不太友好，于是修改为通过子持查询方式删除，mysql和DM都支持的；
public interface TbStatMapper {

    @Delete({ "delete from tb_stat", "where group_id = #{groupId,jdbcType=INTEGER}" })
    int deleteByGroupId(String groupId);

    /**
     * Delete block height.
     */
    @Delete({
        "delete from tb_stat as tb ",
        "where tb.group_id = #{groupId}",
        " and tb.block_number <= (SELECT max(block_number) maxBlock FROM tb_stat where group_id = #{groupId}) - ${blockRetainMax}"})
    Integer remove(@Param("groupId") String groupId, @Param("blockRetainMax") BigInteger blockRetainMax);
....

}

```

修改映射文件：src/main/resources/mapper/TranHashMapper.xml （关于myql和DM 忽略插入语法差异，做了适配处理）
```
  <insert id="add">
    <choose>
      <when test="${isDm8}">
        insert /*+IGNORE_ROW_ON_DUPKEY_INDEX(${tableName}(trans_hash)) */ into ${tableName}(trans_hash,trans_from,trans_to,block_number,block_timestamp,create_time,modify_time)
        values(#{trans.transHash},#{trans.transFrom},#{trans.transTo},#{trans.blockNumber},#{trans.blockTimestamp},NOW(),NOW())
      </when>
      <otherwise>
        insert ignore into ${tableName}(trans_hash,trans_from,trans_to,block_number,block_timestamp,create_time,modify_time)
        values(#{trans.transHash},#{trans.transFrom},#{trans.transTo},#{trans.blockNumber},#{trans.blockTimestamp},NOW(),NOW())
      </otherwise>
    </choose>

  </insert>

```

修改映射文件：src/main/resources/mapper/BlockMapper.xml （关于myql和DM 忽略插入语法差异，做了适配处理）
```
  <insert id="add">
    <choose>
      <when test="${isDm8}">
        insert  /*+IGNORE_ROW_ON_DUPKEY_INDEX(${tableName}(pk_hash)) */ into ${tableName}
        (pk_hash,block_number,block_timestamp,trans_count,sealer_index,create_time,modify_time)
        values
        (#{block.pkHash},#{block.blockNumber},#{block.blockTimestamp},#{block.transCount},#{block.sealerIndex},NOW(),NOW())
      </when>
      <otherwise>
        insert ignore into ${tableName}
        (pk_hash,block_number,block_timestamp,trans_count,sealer_index,create_time,modify_time)
        values
        (#{block.pkHash},#{block.blockNumber},#{block.blockTimestamp},#{block.transCount},#{block.sealerIndex},NOW(),NOW())
      </otherwise>
    </choose>

  </insert>

...

  <delete id="remove">
    DELETE  from ${tableName} as tb
    where tb.block_number &lt;= (SELECT max(block_number) maxBlock FROM ${tableName}) - ${blockRetainMax}
  </delete>


```


修改映射文件：src/main/resources/mapper/NodeMapper.xml （关于myql和DM 忽略插入语法差异，做了适配处理）
```
  <insert id="add" parameterType="com.webank.webase.node.mgr.node.entity.TbNode">
    <choose>
      <when test="${isDm8}">
        insert /*+IGNORE_ROW_ON_DUPKEY_INDEX(tb_node(node_id)) */ into tb_node
        (node_id,node_name,group_id,node_ip,p2p_port,description,create_time,modify_time)
        values(#{nodeId},#{nodeName},#{groupId},#{nodeIp},#{p2pPort},#{description},NOW(),NOW())
      </when>
      <otherwise>
        insert ignore into tb_node
        (node_id,node_name,group_id,node_ip,p2p_port,description,create_time,modify_time)
        values(#{nodeId},#{nodeName},#{groupId},#{nodeIp},#{p2pPort},#{description},NOW(),NOW())
      </otherwise>
    </choose>
  </insert>

```
修改映射文件：src/main/resources/mapper/TransDailyMapper.xml （关于myql和DM 忽略插入语法差异，做了适配处理）
```
  <select id="listSeventDayOfTransDaily" resultMap="seventDayOfTransMap">
		select group_id,trans_day,trans_count from tb_trans_daily where group_id = #{groupId} and trans_day &gt;= DATE_SUB(CURDATE(), INTERVAL '7' DAY)
  </select>

  <insert id="addTransDailyRow" parameterType="com.webank.webase.node.mgr.transdaily.TbTransDaily">
	  <choose>
		  <when test="${isDm8}">
			  insert  /*+IGNORE_ROW_ON_DUPKEY_INDEX(tb_trans_daily(group_id)) */ into tb_trans_daily(group_id,trans_day,trans_count,block_number,create_time,modify_time)
			  values(#{groupId},#{transDay},#{transCount},#{blockNumber},NOW(),NOW())
		  </when>
		  <otherwise>
			  insert ignore into tb_trans_daily(group_id,trans_day,trans_count,block_number,create_time,modify_time)
			  values(#{groupId},#{transDay},#{transCount},#{blockNumber},NOW(),NOW())
		  </otherwise>
	  </choose>

	</insert>

```


使用开关"${isDm8}"适配MYSQL和DMDB;








