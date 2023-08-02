# [PowerBI开发 第五篇：关系和交互](https://www.cnblogs.com/ljhdo/p/4819735.html)

PowerBI 使用 内存的列式数据库  **VertiPaq** ，用于对已发布的数据集进行数据压缩和快速处理，能够使PowerBI报表执行脱机访问，面向列的处理，高度优化对1:N关系的处理性能。关系是数据分析的基础，正因为数据之间存在关系，分析数据才有了意义。PowerBI支持的关系（Reliationship）有1:N（称作一对多的关系）和1:1两种，PowerBI不支持多对多的关系，在设计PowerBI时，通常把1:1的关系合并成一张表，因为任何一个关系都会降低查询性能。通常意义上，所谓的PowerBI的关系通常是指一对多的关系，关系（1:N）的构成：两端是查找表（Lookup，维度表Dimension Table）和事实表（Fact，数据表Data Table），其中查找表处于关系的“1”端，而事实表处于关系的“N”端，维度表中建立关系的列的值是唯一的，事实表中建立关系的列的值可以有重复值。

在PowerBI Desktop的关系（Relationship）视图中，通过实线/虚线表示物理关系（Physical Relationship），实线的两端是1和*号，表示关系的两端，这种实线表示的关系处于活跃状态，虚线是不活跃的关系。虚拟关系（Virtual Relationship）是通过DAX表达式（例如，通过FILTER函数）创建的关系，一般是用在度量值中，用于交互查询。PowerBI的关系，实际上是按照特定的属性对另一端进行切片，通常是按照1端的属性，对N端进行切片和聚合分析。

PowerBI的关系和关系型数据库的外键相似，外键是通过两个表（事实表和维度表）之间的数据列创建的，例如，事实表（Fact）的数据列**c_f**引用维度表（Dimension）的数据列 **c_d** ，前提是：**c_d**列的值是唯一的，**c_f**的值必须是**c_d**列中的值，而**c_f**列的值允许重复。在PowerBI中，允许**c_f**列引用不存在于**c_d**列中的值，这种情况下，PowerBI自动向维度表的c_d列中添加空值（BLANK()，该空值可以通过Slicer查看），用于引用不满足外键关系的列值，称作回写空值。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，单向交叉方向**

当关系的“Cross Filter Direction”属性设置为单向的箭头，即把Cross Filter Direction设置为Single时，箭头由查找表指向事实表，一旦关系创建成功，查找表用于对事实表进行过滤，按照查找表对事实表进行切片（聚合查询）。

这种传统的数据模型和数据仓库的星型模型相同，特点是：维度表包含属性，事实表包含度量（measure），按照维度表的属性对事实表的度量进行切片/聚合查询。

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170918200654775-429976106.png)

## **二，双向交叉过滤**

当关系的“Cross Filter Direction”属性设置为双向的箭头，即把Cross Filter Direction设置为Both时，为了实现数据的过滤，逻辑上可以认为，PowerBI把这两个表展开成一个大表。

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170918201938728-1595147923.png)

双向交叉过滤方向会导致有些关系处于不活跃状态（inactive），当一个维度(lookup)表和多个事实表有关系时，避免使用Both方向，这样可能会导致部分关系失效，处于不活跃状态。单向过滤（single-driectional filtering）PowerBI的默认设置，而双向过滤（bi-directional filtering）是一个不好的设置，因为通过事实表对查找表进行过滤由一定的性能消耗。

## **三，关系的传递**

在PowerBI中，关系是可以传递的，这就意味着，过滤条件是可以传递的。把Filter看作是流水，箭头的指向是由上游指向下游（查找表处于上游，而数据表处于下游），Filter由查找表流向数据表。一般情况下，按照查找表对数据表进行过滤，Filter由查找表流向数据表，再流向其他关联的数据表；如果把交叉过滤的方向设置双向过滤，那么PowerBI可以按照数据表对查找表进行过滤，也就是说，过滤（Filter）由数据表逆流到查找表。双向交叉过滤使得查找表被过滤和切片，并能对查找表执行聚合查询。

 ![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170918212555150-553374603.png)

关系的传递有一个副作用，就是Filter的全选和不选有很大的不同：不选包含Blank值，而全选不包含Blank值。

在关系的传递时，数据行的缺失会导致下游数据出现空值（BLANK），我使用如下的关系图演示，注意关系的类型和指向：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919102700181-1957506861.png)

导入示例的数据，各个表的数据如下图所示：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919100948290-1892218945.png)

把CourseID作为Filter（Slice可视化控件），下游数据（Card可视化控件，Count(Distinct EventID）会出现Blank，这是因为存在StudentID=4的数据行没有选择对应的CourseID。

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919103449353-1440378568.png)

不选择任何Filter时，“Count of EventID”的值是2， **包含Blank对应的EventID** ：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919103734493-940286817.png)

当选择CourseID=1时，“Count of EventID”的值是1：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919103751665-32370546.png)

当选择所有Filter时，“Count of EventID”的值是1：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170919103807478-1209278215.png)

## **四，关系的设计**

把数据模型设计成维度表和事实表，维度表和事实表之间的关系是1:N，交叉过滤方向由维度表指向事实表，避免使用Both交叉方向。

由于PowerBI不支持“多对多”关系类型，在处理这种数据时，通常有两种方式：

1. **删除关系** ：把"多对多"的数据合并到一个表中
2. **把"多对多"的关系转换成两个"一对多"的关系** ：新建一个维度表，该维度表只包含单列的唯一值，连接原“多对多”的两个表

参考文档：

[Power BI Desktop New Feature: Bi-Directional Relationships!](https://powerpivotpro.com/2015/08/power-bi-desktop-new-feature-bi-directional-relationships/)

[Why Is My Relationship Inactive in Power BI Desktop?](http://www.sqlchick.com/entries/2015/11/7/why-is-my-relationship-inactive-in-power-bi-desktop)
