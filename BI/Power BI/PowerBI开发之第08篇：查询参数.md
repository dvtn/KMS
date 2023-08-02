# [PowerBI开发 第八篇：查询参数 ](https://www.cnblogs.com/ljhdo/p/4488599.html)

在PowerBI Desktop中，用户可以定义一个或多个查询参数（Query Parameter），参数的功能是为了实现PowerBI的参数化编程，使得Data Source的属性、替换值和过滤数据行可以参数化。注意：参数不管有多少个可能的值（Available Value），只能有一个当前值，所谓引用参数值，实际上是指引用参数的当前值（Current Value）。参数的当前值，只能在手动修改，不能动态变化。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，参数的属性**

在查询编辑器（Query Editor）中，用户通过菜单“Manage Parameters”创建和管理参数，

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928185934278-1925760612.png)

参数有Name属性、当前值是否必需（Required）、参数值的数据类型（Type）、以及参数的建议值（Suggested Values）、当前值（Current Value）等属性。

![](https://img2018.cnblogs.com/blog/628084/201811/628084-20181102192556003-1074688006.png)

如果勾选Required，那么Current Value必须赋值。参数最重要的属性是Suggested Values，共有三种类型：

* **Any Value** ：用于手动枚举参数的值
* **List of Values** ：指定一个List查询，参数的值是List查询的值
* **Query** ：参数的建议值是一个Query

用户可以创建多个参数，并且参数同样是一个Query，能够被DAX引用。

## 二，创建参数

本文创建Suggested Values为Query类型的参数来演示，首先需要有一个List Query，创建List Query的详细过程，请参考《[PowerBI开发 第三篇：报表设计技巧](http://www.cnblogs.com/ljhdo/p/4579181.html)》。创建ListQuery的步骤是：打开查询编辑器（Query Editor），选中已经存在的Query的某一列，右击弹出快捷菜单，点击“Add as New Query”，这样创建的Query就是List类型的Query。新建的List Query的Name是选中的字段名，该ListQuery只有一列，初始的列名是List。ListQuery是特殊类型的Query，同样位于左侧的“Queries”列表中，默认是被加载到Data Model中，其属性“Enable Load”默认是勾选的，ListQuery的图标不同于常规的查询，例如，名字为Area的ListQuery的图标是：![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928213325637-659237038.png)。

例如，创建ListQuery类型的参数，输入参数的Name，参数的数据类型，选择参数的类型（Suggested Values）为Query（即参数类型是ListQuery），选择参数引用的ListQuery（下图中参数的值从Area中获取），勾选必需（Required）属性表示：用户必须指定参数的当前值（Current Value），新建的参数如下图所示：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928213538372-1151930755.png)

创建参数之后，在左侧的“Queries”列表中出现一个查询（Query），查询的Name是参数的Name。参数和常规的查询一样，能够被其他查询引用，能够被加载到数据模型（Data Model），也能够被其他DAX表达式引用。默认情况下，查询参数是不会被加载到Data Model中，用户必需手动启用数据加载选项：选中参数，右击弹出快捷菜单，点击“Enable Load”，使PowerBI把参数加载到Data Model中。

例如，创建Text类型的Parameter1，当前值是host1，勾选“Enable Load”，启用参数的加载属性：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928193024637-1699849486.png)

## **三，引用参数**

参数的值可能有很多，而引用的是参数的当前值（Current Value），用户可以在查询编辑器（Query Editor）中手动修改参数的当前值，参数通常用于“Get Data” 和 “Query Editor”，也可用于DAX表达式中。

PowerBI通常把参数用于：

* 参数化数据源（Data Sources）
* 替换值（Replace Value）
* 过滤数据行（Filter Rows）
* 用于DAX表达式中

**1，在创建数据查询时，引用参数**

通过 **“Get Data”** 新建SQL Server类型的数据查询时，可以通过参数设置数据源的Server，Database等属性，如图：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928193230372-985789649.png)

如果PowerBI报表中引用多个查询，而查询使用的底层数据源是相同的，在这样的场景下，用户可以创建参数，参数值是用于连接数据源的连接字符串（Connection String），例如，SQL Server实例，SQL Server Database的名称等，在新建查询时，只需要选中参数，便于统一管理数据源的连接字符串等属性。

**2，使用参数替换查询的值**

在查询编辑器（Query Editor）中，通过“Replace Values”菜单，图标是：![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928194344450-2106504311.png)，用户使用参数，查找已经存在的值，替换为其他参数的值。

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928195853528-34056593.png)

**3，使用参数过滤查询的值**

在查询编辑器（Query Editor）中，选中Text类型的Column，点击向下的三角“![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928195614715-1310487302.png)”，弹出快捷菜单，选择“Text Filters”：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928195731544-680118782.png)

弹出“Filter Rows”的窗体，引用参数查询字段值，并把查找的值替换为其他值，而替换的值也可以通过参数来配置：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170928195747481-1435514041.png)

**4，DAX表达式引用查询参数**

参数和常规的查询是一样的，是关系数据（tabular data），能够用于DAX表达式的表表达式（Table Expression）中。

```
measure_name = "max parameter="& MAX(Parameter1[Parameter1])
```

## **四，编辑查询参数**

在开发PowerBI报表时，参数的值只能手动来设置，不能动态改变。使用参数，可以统一管理连接字符串（Connection String）。当然，用户可以通过手动变更参数的当前值，然后刷新数据。

用户可以通过“Edit Queries”来查看和编辑参数的当前值：

![](https://img2018.cnblogs.com/blog/628084/201811/628084-20181102195755889-90759215.png)

参考文档：

[Using Parameters in Power BI](https://www.mssqltips.com/sqlservertip/4475/using-parameters-in-power-bi/)

[Deep Dive into Query Parameters and Power BI Templates](https://powerbi.microsoft.com/en-us/blog/deep-dive-into-query-parameters-and-power-bi-templates/)

[POWER BI DESKTOP QUERY PARAMETERS, PART 1](http://biinsight.com/power-bi-desktop-query-parameters-part-1/)

[Power BI Introduction: Working with Parameters in Power BI Desktop — Part 4](https://www.red-gate.com/simple-talk/sql/bi/power-bi-introduction-working-with-parameters-in-power-bi-desktop-part-4/)
