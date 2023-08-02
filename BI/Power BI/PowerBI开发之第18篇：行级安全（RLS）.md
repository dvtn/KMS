# [PowerBI开发 第十八篇：行级安全（RLS）](https://www.cnblogs.com/ljhdo/p/14719074.html)

PowerBI可以通过RLS(Row-level security)限制用户对数据的访问，过滤器在行级别限制数据的访问，用户可以在角色中定义过滤器，通过角色来限制数据的访问。在PowerBI Service中，workspace中的member能够访问Workspace中的Dataset，RLS不会限制数据的访问。

PowerBI 只支持Import 和 DirectQuery 连接模式，Live Connection to Analysis Services需要在on-premises模型中处理。也就是说，当数据模型采用Import模式，可以在PowerBI的数据模型中配置RLS；当dataset使用DirectQuery模式时，关系型数据源也可以在PowerBI中配置RLS，比如SQL Server。但是对于Analysis Services 或 Azure Analysis Services数据源，由于使用的 lives connection，需要在模型中配置RLS，而不是在PowerBI Desktop中。

行级安全实际上分为两块：开发人员首先在PowerBI Desktop中定义Role和身份验证的规则，然后在PowerBI Service中添加Role的成员。

## 一，在PowerBI Desktop中定义Role和Rule

在PowerBI Desktop中定义Role和Rule，当把PBI文件发布（publish）时，也会把Role的定义发布到PowerBI Service。

**1，定义Role和Rule**

从PowerBI Desktop的 Modeling菜单中选择“Manage Roles”

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429180054767-273547981.png)

点击“Create”按钮创建Role：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429180110159-114697512.png)

 在“Table filter DAX expression”中输入DAX表达式，这个表达式返回True或False，这个表达式就是Role的规则(Rule)。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429180248578-1593235513.png)

你也可以输入在表达式中嵌入函数username()，注意该函数返回的格式是：DOMAIN\username，也可以使用函数 userprincipalname() 返回用户安全主体名称，格式是：username@contoso.com

**2，动态的RLS**

用户不能在PowerBI Desktop中把一个user 分配到一个role中，但是可以在PowerBI Service中进行分配。通过使用函数username() 或 userprincipalname()，可以实现动态的RLS设置。

默认情况下，不管关系设置的是单向过滤方向，还是双向过滤方向，RLS都是使用单向的过滤器来过滤用户。开发人员可以手动启用双向交叉过滤的RLS，这只需要勾选“Apply security filter in both directions”。

 ![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429225211023-360961734.png)

** 3，验证Role**

当创建Role之后，可以通过“View as”菜单来进行验证。

 ![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429225450928-1773975290.png)

 选择要验证的Role，或者Other user。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429225457804-904664672.png)

当选择特定的Role或Other user之后，根据这个Role或 Other user把报表的数据重新渲染。

## 二，在PowerBI Service中管理数据模型中的安全设置

开发人员可以在PowerBI Service中管理模型的安全设置。

**1，打开菜单**

在PowerBI Service中，从Workspace中选择Dataset，打开“Open menu”

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429225848604-367127200.png)

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230101440-1977450089.png)

**2，选择 Security**

Security 菜单将打开Role-Level Security页面，这是为你在PowerBI Desktop中创建的Role添加member的地方。只有dataset的Owner可以看到Security 菜单。

用户只能在PowerBI Desktop中创建Role，只能在PowerBI Service中为Role添加member。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230137663-1445278262.png)

**3，为Role添加member**

在PowerBI Service中，开发人员可以通过email 地址、用户的名称、或者Security Group的名称来添加member。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230416291-315265012.png)

在为Role添加成员之后，Role名称后面会显示成员的数量。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230616962-521934867.png)

**4，验证角色**

在PowerBI Service中，用户可以通过(...)来验证Role，当选择“Test as role”时，

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230720861-1382533475.png)

开发人员会以角色来查看报表，报表会显示“Now viewing as: role_name”，如下图所示：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429230834552-1506029831.png)

如果要测试其他用户或角色，可以点击“Now viewing as”，弹出以下窗口：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429231301245-2090864060.png)

要返回常规窗口，请点击“Back to Row-Level Security”。

## **三，动态RLS设置**

通过使用函数username() 或 userprincipalname()，可以实现动态的RLS设置。

username()函数返回的格式是：DOMAIN\username，函数 userprincipalname() 返回用户安全主体名称，格式是：username@contoso.com。

案例：用户通过邮箱登陆，PowerBI通过邮箱配置来限制用户查看数据。

**1，在PowerBI Desktop中定义Role和Rule**

**step1：建立一个用户表**

用户表的结构如下图（表名：DM_D_Permission）

 ![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429232421311-52346662.png)

**step2，建立Role和Table filter之间的关系**

 ![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429232436679-1928826390.png)

**step3，建立关系表**

在建立多对一的关系时，一定要注意在Cross Filter Direction中，选择Both并点选 “Apply security filter in both directions”

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429232636583-1442515757.png)

选择OK，在PowerBI Desktop上的操作完成，需要Publish到PowerBI Service上。

**2，在PowerBI Service中定义成员**

选择Report的Dataset，选择“Security”：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429232920254-225086331.png)

为角色增加成员，成员可以是email 地址、用户的名称、或者Security Group的名称。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210429232952855-1360517676.png)

PowerBI Service上的配置完成，每一个访问Report的用户都会被Dataset上的安全设置所限制。

参考文档：

[Row-Level Security with PowerBI](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-rls)

[Power BI 中的RLS权限控制设置简要说明](https://zhuanlan.zhihu.com/p/46486682)
