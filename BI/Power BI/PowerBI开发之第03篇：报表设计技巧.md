# [PowerBI开发 第三篇：报表设计技巧 ](https://www.cnblogs.com/ljhdo/p/4579181.html)

最近做了几个PowerBI报表，对PowerBI的设计有了更深的理解，对数据的塑形（sharp data），不仅可以在Data Source中实现，例如在TSQL查询脚本中，而且可以在PowerBI中实现，例如，向数据模型中添加自定义字段，或者在报表数据显示时，根据数据表之间的关系做数据的统计。本文主要介绍数据的塑形和UI设计的微调。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，创建数据列**

PowerBI报表的数据分为数据源（Data Source）和数据模型（Data Model）。数据源（Data Source）的逻辑视图是Query，默认情况下，Data Source和Query的结构（Schema）相同。用户可以通过Power Query M语言增加自定义列修改Query的结构，Power Query M语言不会影响Data Source，只会修改Query导出的数据。默认情况下下，PowerBI按照Query把数据加载到Data Model中，默认情况下，Data Model和Query的结构（Schema）相同，用户可以通过DAX表达式在Data Model上创建计算列（Calculated Column）和度量（Measure）。

 **1，** **自定义数据列**

在Data View->Query Editor中，创建自定义数据列，使用的是 **M 公式（M formula ）** ，M公式语言用于创建灵活性数据查询，M公式对大小写敏感。用户添加自定义数据列，这会修改数据模型（Data Model）的架构，PowerBI向Data Model中添加数据列。

例如，创建MonthKey列，通过使用M公式，把DateKey（格式是：yyyyMMdd）转换成MonthKey（格式是：yyyyMM）。

![](https://images2017.cnblogs.com/blog/628084/201708/628084-20170828155947343-935246039.png)

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

**2，计算列（Calculated Column）**

在Report View中，计算列用于从已经加载到数据模型（Model）中的数据，根据公式计算的数据列，这跟在Data Model中增加计算列是不同的，计算列是从数据模型中计算数据，不会修改数据模型，因此，计算列的值，只会出现在Report View 和Data View中。计算列使用DAX定义字段的数据值，基于加载到数据模型的数据和公式计算结果。计算列只计算一次，跟Report没有交互行为，这意味着，计算列不会根据用于在Report Page上选择的Filter，而动态计算表达式的值。

计算列的值是基于当前数据行，进行计算，每行有一个计算列的值。举个例子，显示最近一年的日期：

![](https://images2017.cnblogs.com/blog/628084/201708/628084-20170828175000312-1655764890.png)

**3，度量列（Measure）**

度量值是在报表交互时对报表数据执行的聚合计算，度量值使用DAX定义字段的数据值，从数据模型中计算数据，不会修改数据模型，因此，度量值只会出现在Report View 和Data View中。度量值通常是用于聚合统计，基于用户选择的Filter，以显示不同的聚合值，由于度量值是聚合值，不是每行都有一个聚合值。举个例子，创建度量值 Answer Rate，其公式是：

```
Answer Rate = DISTINCTCOUNT(CloudThreads[AnsweredThreadID])/DISTINCTCOUNT(CloudThreads[ThreadID])
```

度量列能够引用其他表的数据列，根据数据模型中的关系，能够完成很多交互性的数据统计，非常强大，但是，也很绕、绕、绕……

## **二，报表可视化控件的设计**

在显示报表数据时，PowerBI提供多种方式，能够对数据的显示进行微调，使数据显示的效果更合理。

**1，层次结构（ Hierarchy）**

PowerBI 支持在Report View中创建字段的层次结构（Hierarchy），在同一个Query中，拖动一个字段到另一个字段下，PowerBI自动创建一个层次结构，并以父层次字段的名称命名，例如：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915104057813-1652838675.png)

PowerBI内置一个可视化控件HierarchySlicer，能够显示字段的层次结构，在Fields中设置一个层次结构：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915104935782-695524998.png)

控件显示的结构是一个树形结构，点击“三角”，能够展开，以树形结构显示子级别的数据，HierarchySlicer支持逐层展开，如下图所示：

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915104852297-346047075.png)

**2，在Table控件中显示超链接（HyperLink）**

在Product View中，选中Query的某一个字段，如下图，选中字段 ProfileLink，

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915105358641-462112564.png)

 在**Modeling**菜单下，该字段的Data Type为Text，设置文本的Data Category为Web URL：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915105504719-605593530.png)

在**Table**可视化控件的视图属性中，设置Values的URL Icon属性为On，

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915110054813-1354448358.png)

在Table控件中，Web URL的显示如下所示，点击LInk，能够直接打开浏览器，跳转到指定的网址：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915105855141-2042254251.png)

**3，数字的小数位的控制**

可以在PowerBI中设置字段的数据类型，选中一个字段，打开Modeling菜单,

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915110341953-88926843.png)

 选择字段的数据类型，Format为 Decimal number，选择货币符号（$）， 显示百分比（%），千位分隔符（,），或小数位数（0-N）,这里设置 显示的小数位数是1，只显示一位小数。

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915110440625-1184623727.png)

显示的效果如下，Score 保留一位小数点，并使用千位分割符号：

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915111214610-882739699.png)

**4，字段值的过滤**

可视化（Visual）控件只显示排名靠前的TOP N行数据，这可以通过为字段设置过滤条件来实现，在FIELDS列表中，点击字段后面的”...“ ，添加过滤条件（Add filter），按照特定字段的值（By value），过滤当前字段的值：

![](https://images2017.cnblogs.com/blog/628084/201710/628084-20171027180640742-36916216.png)

例如，在一个Table visual中，把Filter Type设置为Top N，把Show items设置为Top 20，把By Value设置为度量值 Contribution Score，PowerBI按照度量值降序排列，只显示排名前20的数据行：

![](https://images2017.cnblogs.com/blog/628084/201710/628084-20171027181041351-1483319273.png)

PowerBI 支持两种显示的项目（Show item)类型：Top和Bottom，PowerBI按照排序值（by value）降序排名。

字段的过滤类型，共有三种，如下图所示，可以根据需要，创建适合业务逻辑的过滤器：

![](https://images2017.cnblogs.com/blog/628084/201710/628084-20171027182145086-639051654.png)

## **三，根据当前的数据导出数据**

在数据建模时，需要创建两个表之间的关系，PowerBI要求跟关系相关的两个数据列，必须有一列是唯一值，不允许存在重复值。在DimCalendar表中，存在DateKey列，该列是以int表示的日期类型，例如，2017年10月1日，用DateKey表示是20171001，从DimCalendar表中导出MonthKey，公式是MonthKey=DateKey/100。需要根据MonthKey列新建一个Query，做法是：

**1，添加新的查询（Query）**

在查询编辑器（Query Editor）中，选中列 MonthKey，右击弹出快捷菜单，选择“Add as New Query”，从当前列中新建查询

![](https://images2017.cnblogs.com/blog/628084/201710/628084-20171027181520383-1828852674.png)

**2，把List转换成Table**

此时，新建的Query命名为MonthKey，是一个List类型，需要把List转换成Table，选中该List，打开主菜单Transform，点击“To table Convert”，把List转换成Table

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915124857047-13100463.png)

从一个List创建Table，PowerBI需要用户选择界定符，该List没有任何界定符，选择None：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915124958266-1609542448.png)

**3，修改数据**

新表的数据列名是Column1，右击弹出快捷菜单，点击“Rename”，把该列重命名为MonthKey，点击“Change Type”把该列的数据类型修改为“Whole Number”，点击“Remove Duplicates”，删除重复的数据值

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915125703407-1632318963.png)

**4，查看导出数据表的实现步骤**

在右侧的查询设置（Query Settings）中查看实现的步骤，选择某一个Step，点击Step 名称前的“×”，能够把该Step删除。

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170915130131750-1246548344.png)

附：鉴于本人接触PowerBI的时间不长，cover的内容有限，后续有新的设计技巧，我会持续更新

参考文档：

[Tutorial: Create calculated columns in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-tutorial-create-calculated-columns/)

[Tutorial: Create your own measures in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-tutorial-create-measures/)

[Power Query M Reference](https://msdn.microsoft.com/en-us/library/mt211003.aspx)

[Hyperlinks in tables](https://powerbi.microsoft.com/en-us/documentation/powerbi-service-hyperlinks-in-tables/)

[Measures in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-measures/)

[Calculated columns in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-calculated-columns/)
