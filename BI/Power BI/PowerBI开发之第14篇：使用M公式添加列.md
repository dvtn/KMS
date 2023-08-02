# [PowerBI开发 第十四篇：使用M公式添加列 ](https://www.cnblogs.com/ljhdo/p/4953714.html)

PowerBI的查询编辑器使用Power Query M公式语言来定义查询模型，它是一种富有表现力的数据糅合（Mashup）语言，一个M查询可以计算（Evalute）一个表达式，得到一个值。

对于开发者来说，M公式常用于Power Query编辑器中，用于添加计算列，并对数据进行处理。开发者只需要知道简单的Power Query M公式函数，就可以利用PowerBI提供的UI界面来实现数据的处理。

## 一，访问数据

PowerBI极大地简化了M公式的使用难度，使得开发人员可以使用UI来修改数据模型。

访问数据得函数，例如，Sql.Database 函数，从SQL Server实例中执行TSQL查询脚本返回表值。

## **二，添加列**

打开Power 查询编辑器，切换到“Add Column”主菜单，根据需要向数据模型中添加数据列，添加的列有自定义列和条件列。

1，添加用户列

根据业务需要，开发工程师填写表达式，根据现有的数据列和公式，把结果存储到数据模型中。

添加的M查询，只能用于单个查询中，当M公式引用右侧的可用列时，需要使用中括号[]来指定，比如下面的 [Date]

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180710130813323-1383093722.png)

**2，添加条件列**

在单个查询中，根据列的值的不同，使用不同的表达式，这是条件列的使用场景，Value字段，可以是参数（Parameter）、常量值、或者是数据列（Column）。PowerBI根据条件表达式计算新值，并添加到数据模型中。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180710131111927-1747263035.png)

参考文档：

[Power Query M function reference](https://msdn.microsoft.com/en-us/query-bi/m/power-query-m-function-reference)

[Expressions, values, and let expression](https://msdn.microsoft.com/en-us/query-bi/m/expressions-values-and-let-expression)

[Add a custom column in Power BI Desktop](https://docs.microsoft.com/en-us/power-bi/desktop-add-custom-column)
