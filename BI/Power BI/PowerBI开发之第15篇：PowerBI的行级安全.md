# [PowerBI开发 第十五篇：Power BI的行级安全](https://www.cnblogs.com/ljhdo/p/10337831.html)

Power BI支持行级安全（Row-Level Security，RLS）的权限控制，用于限制用户对Dashboard、报表和DataSet的访问。用户浏览的报表是相同的，但是看到的数据却是不同的。

RLS内部通过DAX函数 username() 和 userprincipalname()来实现，RLS使得PowerBI能够在行级别上对用户访问的数据进行限制。这两个函数在PowerBI Desktop中返回的都是用户的信息，只不过格式不同：

* **username()** ：返回 domain\user_name
* **userprincipalname()** ：返回 user_name@domain.com

这两个函数在PowerBI Service中返回的格式是相同的：user_name@domain.com。如果需要发布到PowerBI Service中，建议使用 userprincipalname()函数来创建过滤规则。

## 一，实现RLS的组件

RLS的主要组件是：Users、Roles和Rules。用户访问数据时，RLS按照角色中定义的规则对用户的访问进行控制。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101161630040-1595903024.png)

* Users：浏览报表的用户，使用user name 或 email address 来唯一标识。
* Roles：用户属于Role，一个角色是一个Rule的容器。
* Rules：规则（Rule）是过滤数据的断言（Predicate）。

在PowerBI Desktop中创建角色和规则，当发布到PowerBI Service中时，角色和规则也会发布到PowerBI Service中，报表开发人员需要在PowerBI Service中对DataSet的Security进行配置。

## 二，创建用户权限表和关系

实现RLS的关键一步是配置用户权限表，用户权限表用于指定用户有权限访问的数据，而关系是RLS能够起作用的基础，通过关系的交叉过滤功能实现用户访问数据的行级控制。

举个例子，有如下用户权限表：

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101174814432-850263772.png)

在本例中，我们在规则中使用userprincipalname()函数，UserName列是用户的邮件地址，Product列是用户可以访问的产品类型，一个User可以访问多个Product。该表和DimProductCategory创建关系时，设置为“many to 1”的双向关系，通过UserName来过滤用户可以访问的Product。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101170001107-783317041.png)

## 三，创建角色和规则

有了用户权限配置表之后，接下来就是创建角色和规则，角色是用户的集合，角色中的所有用户遵守相同的规则；规则是定义用户是否有访问数据的权限。

在Modeling 选项卡中，选择“Manager Roles”：

![](https://img2018.cnblogs.com/blog/628084/201901/628084-20190130135455204-941925938.png)

点击“Create”按钮，创建一个Role，并命名角色。从Tables列表中添加Filter，在“Table filter DAX expression” 中输入DAX表达式，也就是创建规则，用于对用户进行过滤：

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101175101006-178177771.png)

为了确保规则的正常运行，点击“View as Roles”，查看规则运行的情况：

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101170653501-778098154.png)

也可以选择Other user，输入一个用户名称，检查规则对该用户产生的效果。

## 四，管理角色和规则

在创建角色时，可以创建一个admin的角色，可以访问所有的数据，设置DAX表达式：

```
UserName='admin@domain.com'
```

对于其他用户，其访问数据的权限受到限制，创建常规的角色，设置DAX表达式：

```
UserName = userprincipalname()
```

把PowerBI发布到PowerBI Service中，需要在数据模型中管理RLS。在PowerBI Service的Datasets中，点击Security，把用户添加到角色中：

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101174049443-2049247002.png)

把用户或用户组添加到角色中，用户组中的用户有权限访问报表。在访问报表时，userprincipalname()函数返回的是用户的邮件地址，而不是用户组的邮件地址，从而实现用户的权限控制：

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191101174137982-207184517.png)

报表管理人员，可以创建一个用户组，把用户组添加到角色中，并通过用户组来管理User对报表的访问，以实现RLS。

参考文档：

[Row-level security (RLS) with Power B](https://docs.microsoft.com/en-us/power-bi/service-admin-rls)

[USERPRINCIPALNAME – show user name and use it in RLS (DAX – Power Pivot, Power BI)](https://exceltown.com/en/tutorials/power-bi/powerbi-com-and-power-bi-desktop/dax-query-language-for-power-bi-and-power-pivot/userprincipalname-show-user-name-and-use-it-in-rls-dax-power-pivot-power-bi/)
