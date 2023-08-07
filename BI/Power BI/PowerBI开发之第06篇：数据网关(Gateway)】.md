# [PowerBI开发 第六章：数据网关（Gateway） ](https://www.cnblogs.com/ljhdo/p/5125235.html)

Power BI的本地数据网管（On-Premises Data Gateway）是运行在组织内部的软件，用于管控外部用户访问内部(on-premises)数据的权限。PowerBI的网管像是一个尽职的门卫，监听来自外部网络（云端服务，Cloud Service）的连接请求，验证其身份信息。对于合法的请求，网管执行查询请求；否则，拒绝执行。云端（PowerBI Service）程序向网管发送查询内网数据的请求，网管访问企业内网（On-Presmises）的数据库执行查询（Query）请求，网管把查询结果加密和压缩之后传送到云端，保证数据的传输安全。总而言之，网管的作用就像一座桥，桥的两端是内网的数据和云端的PowerBI Service，网管使得企业私有的内部数据，能够安全地应用于云端的PowerBI Service。使用网管能够设置调度程序，定时把内网数据刷新到PowerBI Service的Datasets中，从而实现报表数据的自动更新。

单词 Premises可以翻译为组织的生产/营业场所，“On-Premises”是指：在组织的建筑内的，在本地的，与之对应的反义词是云端，On-Premises Data是指在组织所在的经营场所中存储的数据，可以翻译为本地数据，内网数据。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，本地网管的工作原理**

本地网管是一个软件，用于监控云端服务对组织内部的、私有网络内的数据的访问。当一个交互式的查询发生时，云端（PowerBI Service）和内网网管的工作流程如下图：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925185612995-1529214966.png)

流程图显示，内网数据网管充当的是一个桥梁的角色，位于云端服务（Cloud Service，例如PowerBI Service）和内部数据（On-Premises Data）的中间，接收云端的查询请求，在内网执行请求，并把查询结果返回给云端：

* step1：PowerBI 创建查询（Query），把加密的凭证发送到云端网管（Gateway Cloud Service）进行处理，Azure Service Bus接收云端网管的请求，并转发到内网网关（On-Premises Gateway）；
* step2：内网网管接收到Azure Service Bus的查询（Query），解密凭证（decrypt credentials），并使用凭证连接数据源（Data Source）
* step3：内网网管把查询发送到数据源执行，并把查询的结果返回给云端；

PowerBI提供两种类型的网管：

* On-premises data gateway (personal mode) ：个人模式，只允许一个User连接到内网数据源（On-Premises Data Source）
* On-premises data gateway ：标准模式，允许多个User连接到内网数据源

## **二，网管的安装**

本地网管（On-Premises Data Gateway），必须安装在企业的私有网络的服务器上，用于响应云端的连接请求，对传输到云端的数据进行加密和压缩处理，配置数据的调度刷新。

**1，下载安装包**

为了安装网管，首先需要下载安装包，用户打开PowerBI Service，点击浏览器右侧的“下载”菜单，选择“Data Gateway”，跳转到[PowerBI Gateway](https://powerbi.microsoft.com/en-us/gateway/)的下载页面，如图：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925181706323-384183180.png)

**2，开始安装数据网管**

安装包下载完成之后，点击“PowerBIGatewayInstaller.exe”安装程序，开始安装网管：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925182623870-156140634.png)

在安装过程中个，用于需要选择网管的类型，推荐使用标准模式，允许多人共享使用网管：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925182854182-887651101.png)

**3，输入管理账户，注册网管**

输入网管的初始管理员账户，该账户必须能够登陆到PowerBI Service，该账户用于配置和管理网管，点击“Next”按钮，开始注册网管

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925183158932-1898068108.png)

注册完成之后，输入还原键（Recovery Key），还原键用于恢复网管的配置，点击“Next”，网管安装完成。

## **三，管理网管**

网管创建之后，需要创建Data Source，添加管理员，和添加访问DataSource的用户（User）。初始管理员需要登陆到PowerBI Service，点击右侧的“设置”菜单，选择“Manage gateways”，

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925183621198-68226373.png)

**1，添加管理员**

在左侧面板中，选中新建的网管名称，点击Administrators，添加Gateway的管理员

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925184617901-951659588.png)

** **2，** 添加数据源**

选中新建的网管，点击“ADD DATA SOURCE”，创建新的数据源，每一个数据源都有一个Name和类型，如果想要创建的数据源是SQL Server数据库，在Data Source Type列表中，选择SQL Server，在展开的选项中，配置SQL Server 数据库实例的主机，数据库名称，验证方式和验证信息，点击“Add”按钮，把数据源添加到网管中：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925184754885-928945387.png)

在向网管添加数据源时，管理员必须提供访问数据源的凭证信息，凭证信息在存储到云端之前被加密处理，PowerBI Service把凭证信息从云端发送到网管进行解密，使用解密之后的凭证访问数据源。

**3，添加数据源的用户（User）**

选中已添加的数据源，授予用户权限访问该数据源，默认情况下，管理员有权限访问网管中的所有数据源：

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170925184521854-1660771855.png)

参考文档：

[Getting started with Power BI Gateways](https://powerbi.microsoft.com/en-us/documentation/powerbi-gateway-getting-started/)
