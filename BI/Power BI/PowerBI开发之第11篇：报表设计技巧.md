# [PowerBI开发 第十一篇：报表设计技巧（更新）](https://www.cnblogs.com/ljhdo/p/4650727.html)

PowerBI版本在持续的更新，这使得报表设计能够实现更多新的功能，您可以访问 [PowerBI Blog](https://powerbi.microsoft.com/en-us/blog/)查看PowerBI的最新更新信息，本文总结了PowerBI新版本的重要更新和设计技巧。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，同步切片**

开发人员在设计报表时，根据分析的需要把报表划分为不同的主题，每个主题独占报表的一个Page，而在这些Page上，一般会摆放相同的过滤器。过滤器也叫做切片（Slicer），提供了分析数据的视角。

用户切换Page查看报表时，希望通过相同的视角来观察报表，发现数据中隐藏的insight。同步切换是一个非常酷的更新，但是，使用该功能的限制是，目前只能用于PowerBI Desktop内置的Slicer，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703165109224-1420560461.png)

而对于从Markplace中加载的用户自定义的Slicer，还不能启用同步切片的功能，例如，HierarchySlicer 不能实现切片的同步：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703165316507-1311175372.png)

在PowerBI Desktop中设置切换同步的步骤是：

**step1：打开同步切片的视图**

在Report试图中，打开View菜单，勾选Sync slicers选项

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703165829339-54529979.png)

**step2，添加同步的Slicer**

在同步切片的视图中，选择同步切片的Page。切片同步是把整个Page的切片都添加进去，使得整个Page的切片和其他Page的切片都是同步的。不同的Page中的切片同步可以分组，每个分组中的切片是同步的。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703170123780-186854082.png)

## **二，持久化过滤器**

用户在PowerBI Service中查看报表时，有时会从当前的报表切换到其他的报表上，等到回到原来的报表上时，用户希望PowerBI能够保存切片，这就意味着，PowerBI Service必须保存终端用户离开当前报表时所选择的切片，并在用户重新打开当前报表时，他看到的就是他之前看到的样子，之前选中的切片现在依然是选中的。用户的这个需求可以通过 Persistent filters 来实现，这个功能在PowerBI中默认是启用的。这意味着，所有的PowerBI报表会自动保存Filters，Slicers 和其他的数据视图的更新。

设计人员可以通过 File -> Options and settings -> Options-> Current File -> Report settings 来查看Persistent filters的设置：

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703171015964-2044538514.png)

在当前的版本中，持久化过滤器有一定的使用限制，当Page中存在自定义的切片器时，持久化过滤的作用就会失效。

开发人员在发布（Publish）报表时，会把报表的切片、过滤器等设置为初始状态，我们把报表发布时的状态称作报表的默认状态。在启用Persistent filters之后，PowerBI Service上会保存用户的切片数据。当你看到如下的图标时，说明，报表当前没有处于默认状态，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703171810387-908726812.png)

用户可以通过 Reset to default 按钮，把切片重置到发布时的默认状态。

## 三，切片器被增强

切片（Slicer）是PowerBI内置的图表，该图表会根据数据的类型，提供不同的类型，切片的类型有：List、Dropdown、Between、Before、After和Relative，设计人员可以通过![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703174224605-2122046681.png)设置切片的类型。

例如，如果切片的数据是Date类型的，把切片的类型设置为 Between，用户可以选择连续的日期区间。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703174412833-1285663998.png)

## 四，隐藏切片

把切片隐藏（Hide）起来，使用户查看不到切片器的存在。这样，可以在用户不知情的情况下，选择特定的过滤条件，或者把过滤条件传递到其他Page。

有时，需要把固定的条件做为钻透（Drillthrough）的过滤器，该过滤条件不想被用户感知到，并且还需要把切片器的条件传递到钻透Page，这就要把切片隐藏起来。

首先，在Page Size中增加Page的Height，然后，把切片器拉到Page的底部，最后，减少Page的Height，PowerBI就可以把切片器隐藏起来。

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180731164526931-1851732209.png)

## 五，条件格式化

根据一个字段对另一个字段进行格式化显示，当前的版本，能够对字段的背景色和字段颜色进行动态设置。

设置条件格式化的步骤是，选中一个Chart，点击其Format属性 ![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703175259210-333653976.png)，打开 Conditional formatting 目录，

![](https://images2018.cnblogs.com/blog/628084/201807/628084-20180703175426487-1978466837.png)

格式化选项的默认值是Off，当切换到On时，PowerBI Desktop会自动打开设置窗体，设计人员在窗体中设置Background color scales和Font color scales。

## 六，Enable Load  和 Include In Report Refresh

Enable Load：为Query加载数据，如果禁用Query的Enable Load，那么Query仍然可以用于其他Query中，例如Merge Queries as New，但是其数据不会加载到报表中，也会显示在Report Builder中，即不可用于报表的计算。

Include In Report Refresh：意味着，当你点击Refresh按钮时，该Query会自动刷新数据。

### 1， Enable Load

通过**Merge Queries as New**操作，把Price和Orders的数据合并到Merge1中，报表使用Merge1进行显示和计算。对于Price和Orders，虽然报表不会用到，但是也不能删除，即使Hide，也会占用空间。

![](https://img2022.cnblogs.com/blog/628084/202209/628084-20220915181046864-1784691524.png)

当把Price和Orders的Enable Load 禁用之后，名称会显示为斜体，报表会把这两个table的数据删掉，这两个数据集不会出现Fields列表中。

![](https://img2022.cnblogs.com/blog/628084/202209/628084-20220915181138382-538460355.png)

### 2，Include In Report Refresh

假设您正在开发包含多个表的报表，而您只想刷新单个表的数据，通常当您按下刷新按钮时所有表的数据都会刷新，因为默认情况下所有查询都会选中“Include In Report Refresh”。

如果除了Orders表之外，其他所有表都取消选中“Include In Report Refresh”，当点击Refresh按钮时，报表指挥刷新Orders表。

参考文档：

[Announcing Persistent Filters in the Power BI Service](https://powerbi.microsoft.com/en-us/blog/announcing-persistent-filters-in-the-service/)

[Power BI Desktop February Feature Summary](https://powerbi.microsoft.com/en-us/blog/power-bi-desktop-february-2018-feature-summary/)

[Power BI Desktop May Feature Summary](https://powerbi.microsoft.com/en-us/blog/power-bi-desktop-may-2018-feature-summary/)
