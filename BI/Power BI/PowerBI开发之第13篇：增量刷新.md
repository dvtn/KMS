# [PowerBI开发 第十三篇：增量刷新](https://www.cnblogs.com/ljhdo/p/5556878.html)

PowerBI 将要解锁增量刷新（Incremental refresh）功能，这是一个令人期待的更新，使得PowerBI可以加载大数据集，并能减少数据的刷新时间和资源消耗，该功能目前处于预览状态，只对 Power BI Premium 版本开放预览。

增量刷新只是加快了数据集刷新的速度，对于具有潜在数十亿行的大型数据集，可能还是不适合Power BI Desktop，因为它通常受用户桌面PC上可用资源的限制，以及系统的限制。 因此，这些数据集通常在导入时被过滤，以适应Power BI Desktop。 无论是否使用增量刷新，情况仍然如此。

通常情况下，增量是基于时间戳字段的，在数据源更新数据时，同时更新时间戳。PowerBI保存上一次刷新时的时间戳last_timestamp，所有大于last_timestamp的数据行都是新增加的数据行，也就是说，改变的数据行会被加载到PowerBI的数据集中。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## 一，启用增量刷新

增量刷新默认是禁用的，启用增量刷新的步骤是：打开选项和设置（Options and Settings）窗口，在全局选项（Global）的 “Preview features” 选项卡中，勾选“Incremental Refresh Policies”，这样就启用了PowerBI Service的增量刷新功能。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704120026304-1329785106.png)

目前该功能仍然处于预览阶段，后续可能会被加强，这么酷的一个feature，没有道理会被弃用。

## 二，设置RangeStart和RangeEnd参数

要在Power BI服务中利用增量刷新，首先需要创建时间区间，这要求用户在Power Query 编辑器中创建RangeStart和RangeEnd参数，该参数的名称是保留名称，类型必须是Date/Time，PowerBI Service使用这两个参数实现数据集的增量刷新。

创建参数的窗口如下图所示，Type必须选择Date/Time类型，并设置默认值（Current Value）。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704120748263-207599224.png)

## 三，使用参数过滤查询

使用定义的参数RangeStart和RangeEnd，对查询的Date/Time字段进行过滤。选中Date字段，展开 "Date/Time Filters" ，选择“Custom Filter”，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704134201667-217864715.png)

在“Filter Rows”对话框中，设置用于过滤数据行的表达式，如下图所示：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704121951152-126409794.png)

一旦发布PowerBI，那么参数值会被PowerBI Service自动覆盖，这种行为不需要显式设置。

## 四，定义刷新策略

在PowerBI Desktop中定义刷新策略，在PowerBI Service中应用刷新策略。

在Report视图中，选择被参数RangeStart和RangeEnd过滤的表，右击弹出快捷菜单，点击“Incremental Refresh”，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704122259936-255108514.png)

打开增量刷新的窗口，如下图所示，在该窗口中定义增量刷新的策略：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704123128301-409984285.png)

**1，为数据表启用增量刷新**

 ![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704123249685-942871385.png)

**2，定义刷新的区间**

数据刷新的区间包括保留区间和增量区间，保留区间为6个月，增量区间为7天，这意味着保留近6个月的数据，当刷新数据时，加载数据的时间区间是：开始日期=当前日期-7天， 结束日期=当前日期

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704123452631-1387114086.png)

PowerBI会把在6个月之前的数据从Data Set中移除。

在第一次刷新时，PowerBI会一次性加载6个月的数据，这是依次全量刷新，之后的数据刷新都按照该区间进行增量刷新。

**3，探测数据变化**

当勾选“Detect data changes”选项时，您能选择一个Date/Time列作用时间戳，当探测到该列发生改变时，PowerBI才会启动增量刷新进程。如果该列没有发生任何改变，那就没有必要去刷新数据。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704124157740-19058885.png)

当前的设计要求PowerBI Service保持用于探测数据变化的列不变，并缓存到内存中。

**4，只刷新完整日期**

当勾选“Only refresh complete periods”时，PowerBI不会加载当天的数据，因为当天的数据不是一天的完整数据。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180704124449907-13709736.png)

## **五，归并更新**

PowerBI Service使用基于时间戳的归并方法实现数据集的增量更新，归并更新的实现逻辑是：添加新的数据，对已经存在的数据进行更新，并移除超过保留的时间窗口之外的数据。

例如，以下示例定义了一个刷新策略：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180705102046842-2045465646.png)

用于存储总共5年的数据，并逐步刷新10天的数据。 如果每天刷新数据集，则将对每个刷新操作执行以下操作：

* 添加新的一天数据，（添加新的数据）；
* 刷新在当前日期前10天的数据，（对已经存在的数据进行归并更新）；
* 删除当前日期之前超过5年的数据。 例如，如果当前日期是2019年1月1日，则删除2013年的数据，（移除超过保留的时间窗口之外的数据）。

参考文档：

[Incremental refresh in Power BI Premium](https://docs.microsoft.com/en-us/power-bi/service-premium-incremental-refresh)
