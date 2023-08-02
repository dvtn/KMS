# [PowerBI开发 第九篇：修改查询](https://www.cnblogs.com/ljhdo/p/4548830.html)

在PowerBI的查询编辑器（Query Editor）中，用户可以使用M语言修改Query，或修改Query字段的类型，或向Query中添加数据列（Column），对Query进行修改会导致PowerBI相应地更新数据模型（Data Model），这跟使用DAX表达式修改Data Model有本质的区别：前者是修改数据表，后者是修改数据视图。PowerBI通过查询编辑器来修改数据模型，对Query的每一次修改都是一个step，用户可以根据需要增加或删除step，调整step的顺序，并可以迭代引用先前创建的step，应用这些操作对数据进行再次加工和处理，以满足数据分析的需求。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，修改数据类型**

每一个Query都是由一系列的列和行构成的数据表，每一列都有特定的数据类型，PowerBI为每个数据类型显示特定的图标，最常用的数据类型是number和text，例如：

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424102815547-2009462584.png)

123表示当前列是数字类型，ABC表示当前列是字符类型。有时，从外部数据源导入数据之后，PowerBI不能确定数据的类型，此时，它会在列前方同时标记为123和ABC，用户可以通过”Change Type“把该列转换为合适的数据类型。

## **二，添加数据列**

用户可以添加计算列，从主菜单中切换到”Add Column“面板，点击”Custom Column“，基于M公式创建新的数据列。

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424103744694-1227548806.png)

从左侧可用的列中，添加列和公式，PowerBI基于用户输入的表达式创建新的计算列，并添加到数据模型（Data Model）中：

 ![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424103544325-173046751.png)

## **三，添加排序列**

在对数据进行排序时，有时不能使用DAX表达式，此时必须使用M公式，例如，对班级（Class）进行排序，使用DAX的IF函数，按照班级（Class）名称新建一个字段（Class Ordinal），

```
Class Ordinal = IF(Schools[Class]="一年级",1,IF(Schools[Class]="二年级",2,3))
```

设置Class按照Class Ordinal排序，PowerBI会抛出错误：

![](https://images2017.cnblogs.com/blog/628084/201801/628084-20180123172907740-1950554563.png)

在这种情况下，必须使用M公式，在Schools Query中新增字段：

```
= Table.AddColumn(KustoQuery, "Class Ordinal", 
each if [Class]="一年级" then 1
    else if [Class]="二年级" then 2
    else if [Class]="三年级" then 3
    else 4) 
```

## **四，查询组合**

查询的组合（Combine），用于在Query级别对数据进行修改，PowerBI支持Merge和Append，你使用Merge操作连接数据，或使用Append操作追加数据。

**1，数据的连接**

把查询连接到一起，可以使用Home菜单中”Merge Queries as New“，通过连接操作（Join）把两个Query合并，生成新的Query。

PowerBI在进行Merge时，只支持**等值条件**的连接操作，等相应字段的值相等时，匹配成功。

例如，选择 EventSoldService 作为其中一个Query，点击EventId，作为连接的条件，第一个表称作左表，第二标称作右表：

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424110911133-1467100411.png)

也可以选择多个数据列作为连接条件，摁住Ctrl，连续点击EventId，SoldServiceId，就可以把这个字段作为连接：

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424111023555-702221827.png)

在进行Merge操作时，PowerBI提供多种连接的类型，如下：

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424110532175-1601734271.png)

在创建Merge查询之后，默认情况下，PowerBI会把连接的右表显示在左表字段的末尾，字段名为右表名，而字段值为"Table"，如下图：

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424111431900-1581303149.png)

用户可以点击该列上方的图标， 对右表进行扩展（Expand）或聚合（Aggregate）操作，扩展操作是指在最终的查询中显示右表的字段，聚合操作是对右表的相应字段进行聚合操作，返回聚合值。

 ![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424111718891-1750251584.png)

**2，数据的追加**

对于一个Query，使用PowerBI可以追加数据，把另一个Query的数据追加到当前Query之中，这相当于集合的Union操作。

![](https://images2018.cnblogs.com/blog/628084/201806/628084-20180612195038044-1692122657.png)

选中当前Query，点击“Append Queries”，可以追加一个Query，或多个Query。

![](https://images2018.cnblogs.com/blog/628084/201806/628084-20180612195149682-1337566899.png)

而用于追加的Query，可以不显示在Report视图中，使这些Query仅仅用于提供数据。

## **五，转换操作**

在查询编辑器中，可以对数据做变换操作（Transform），例如，分组、字符的拆分、透视、逆透视、去重和替换值等。

**1，分组**

Group By用于按照特定的列**对现有的查询**进行分组聚合，产生新的Query。

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424112421467-670090652.png)

**2，拆分字符**

把一个字符类型Column按照分隔符，或者特定数量的字符，分割成多个数据列。

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424131719343-168642712.png)

**3，透视和逆透视**

Pivot Column 用于对数据进行透视操作，Unpivot Column 用于对数据进行逆透视操作，完成数据的行列转换。

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424132652839-68298056.png)

## **六，** **Query的其他操作**

对Query分组，分组的目的是组织Query，便于查找。当Query的数量非常多时，可以按照功能或Page对不同的Query分组。

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424162750756-73831962.png)

Query是否启用加载，是否包含在报表刷新中？

![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180424162904681-433602006.png)

如果启用了“Enable load”，那么Query的数据会显示在Report View中；如果启用了”Include in report refresh“中，Query可以随着报表的刷新而自动刷新数据。

参考文档：

[Power Query M Reference](https://msdn.microsoft.com/en-us/library/mt211003.aspx)

[Add a custom column in Power BI Desktop](https://docs.microsoft.com/en-us/power-bi/desktop-add-custom-column)
