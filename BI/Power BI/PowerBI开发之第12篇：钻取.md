# [PowerBI开发 第十二篇：钻取 ](https://www.cnblogs.com/ljhdo/p/4984038.html)

钻取是指沿着层次结构（维度的层次）查看数据，钻取可以变换分析数据的粒度。钻取分为下钻（Drill-down）和上钻（Drill-up），上钻是沿着数据的维度结构向上聚合数据，在更大的粒度上查看数据的统计信息，而下钻是沿着数据的维度向下，在更小的粒度上查看更详细的数据。举个例子，当前的粒度是月份，按照年份查看数据是上钻，而按照日期来查看数据是下钻，日期的数据是详细的数据，而每天的数据是高度聚合的数据。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，层次结构**

钻取数据，离不开层次结构，最常用的层次结构数据是日期维度，日期维度是自然层次结构，下层的结点只有一个父结点，如下表所示：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703184747072-1152823361.png)

在PowerBI的Report视图中创建Date Hierarchy，该层次结构由三个级别组成，从上至下依次是Year，Month和Date：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703192034265-274451749.png)

PowerBI没有内置层次结构切片，设计人员需要从Marketplace中下载自定义的HierarchySlicer，用于显示Date Hierarchy：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703191409664-426191769.png)

## 二，Chart级别的钻取

在同一个Chart上，通过钻取操作，导航到不同的层次结构上查看数据，

例如，如下数据是某数据仓库中包含的创建于2018年的所有Post的数据，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703190137469-1058231891.png)

在Relationship视图中，通过CreatedDateKey和Date维度的DateKey关联起来，在Report视图中，通过Line Chart查看不同Date层次结构上Post数量，Line Chart的属性设置如下图所示：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703191445814-1221667302.png)

默认的级别是顶层的Year，在该级别上，Line显示的数据是2018年的所有Post的总数，由于只有2018这一个年份，因此Line Chart只显示一个点。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703190536732-320635862.png)

通过下钻按钮（两个向下的箭头），导航到Month级别查看Post的数据，在该级别上，可以看到2018年的所有月份的Post数量和增长趋势：

 ![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703190626114-970324689.png)

上钻按钮是一个向上的箭头，可以从Month级别返回到Year级别。上钻和下钻是按照层次结构，逐层钻取的。

## **三，把钻取关联到其他图表**

钻取过滤默认时启用的，钻取会对其他的图表（Visual）进行过滤，这就意味着，当你在一个Visual上进行钻取操作时，其他Visual上的数据也会被过滤。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704095043748-411838231.png)

## 三，钻透

钻透（Drillthrough）允许你在报表中创建一个Page，该Page（称作钻透Page）提供模型中单个实体的详细信息，然后在其他Page中引用该实体列，通过使用数据点（Data Point）从当前Page导航到钻透Page上，并把过滤上下文传递到钻透Page上。

过滤上下文分为钻透过滤器和Page级别的过滤器上下文，钻透过滤上下文是指拖放到DrillThrough中的字段。当启用 Keep all filters 时，PowerBI把当前Page中所有过滤器的上下文应用到钻透Page上；当禁用Keep all filters时，PowerBI只把钻透过滤器的上下文应用到钻透Page上。Keep all filters的默认设置是Off，不把当前Page级别的过滤器上下文传递到钻透Page。

当设置Keep all filters为On时，导航到钻透Page时，您可以从Drillthrough中查看到传递到钻透Page的所有过滤上下文。

 **钻透过滤的用法：钻透是通过相同的字段实现的，** 在设计钻透时，用户需要在钻透Page上设置钻透过滤的字段，源Page上的数据点（Data Point）也包含该字段。

**1，类别钻透**

设计人员可以在Fields中设置钻透过滤器，在钻透Page上把MonthKey字段设置为钻透字段，用作类别（Used as category）。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704102027849-2047470839.png)

选中一个数据点（Data Point），该数据点的轴是MonthKey（用作钻透的字段），右击选中Drillthrough，导航到钻取Page（本例中是Page2），过滤器的上下文会被引用到钻透Page，用户看到的实体的详细信息是被过滤之后的数据。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704102437363-664404777.png)

**2，度量钻透**

度量钻透（Measure drillthrough）是指把独立或汇总数字列传递到钻透Page中，在把数字列用作类别或汇总时允许钻透。

例如，对PostID进行钻透，设置当对PostID进行聚合时允许钻透。

 ![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704113359089-1766512013.png)

选中一个数据点（Data Point），右击选中Drillthrough，导航到钻取Page，从DRILLTHROUGH列表中查看所有传递到钻透Page的过滤上下文。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704114430719-1301829062.png)

参考文档：

[Power BI Desktop May Feature Summary](https://powerbi.microsoft.com/en-us/blog/power-bi-desktop-may-2018-feature-summary/)

[Power BI Desktop September Feature Summary](https://powerbi.microsoft.com/en-us/blog/power-bi-desktop-may-2018-feature-summary/)
