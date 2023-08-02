# [PowerBI开发 第十九篇：基于Page创建Tooltip](https://www.cnblogs.com/ljhdo/p/14755014.html)

在PowerBI 报表中，常规的Tooltip是一段文本，当光标悬停在Visual上，Visual上方会自动显示Tooltip的文本。PowerBI 支持用户自定义内容丰富的Tooltip，用户通过创建一个Report Page，在Page上插入文本、图片和图表等，并把该Page设置为Tooltip ，这样就成功创建了一个基于Page的Tooltip ，称作Tooltip Page，显示的效果如下图：

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511130925486-110582401.png)

用户可以设置一个或多个字段与Tooltip Page相关联，当用户把鼠标悬停在包含所选字段的Visual上时，Tooltip Page将会显示在Visual上方，并且Tooltip Page中的数据会受到数据点的过滤。

## 一，创建Tooltip Page

Tooltip实际上是一个Page，启用Page的Tooltip属性，使其作为tooltip来使用。

**1，在PowerBI Desktop中创建一个新的Page**

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511131531929-1995516226.png)

**2，设置Page Size属性**

在Page的Visualizations页面中，打开Format 面板，设置Page Size属性，在下拉列表中选择 Tooltip，使得Page Size可以作为一个Tooltip来显示。

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511131948925-409185031.png)

**3，设置Page View为Actual Size**

默认情况下，PowerBI Desktop会铺满Page的所有可用空间，但是这种处理方式不适用于tooltip，需要设置Page View为Actual Size。选择 View -> Page View > Actual Size：

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511132028771-234838545.png)

**4，命名Page**

在Format面板中，根据Tooltip的目的，为Page命名，其他Visual可以通过名称来引用Tooltip Page。

 ![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511132305223-446675717.png)

** 5，设计Tooltip的UI**

根据需要，向Page中添加所需的Visual，根据Tooltip的空间大小，合理选择1到3个图表。

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511132559569-168556287.png)

**6，启用Tooltip**

启用Page的Tooltip属性，把该Page注册为一个Tooltip，确保该Page可以在一个Visual上显示。

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511132844476-626250389.png)

**7，为Tooltip配置关联的字段**

一旦为Page启用Tooltip之后，该Page就转变成了Tooltip Page，还需要指定与Tooltip Page关联的字段，即配置Tooltip Page在哪些字段上显示。

当指定了相应的字段之后，一旦鼠标悬停在应用这些字段的Visual上方，Tooltip Page就会显示在该Visual上方。字段可以是表中的字段，也可以是计算列和度量。

如下图，设置Tooltip的字段为一个Measure和一个维度列，Tooltip Page将自动会在应用这些字段的Visual上方显示。

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511135044683-1371685414.png)

PowerBI 通过自动检测Tooltip关联的字段来显示Tooltip Page。

## 二，手动设置Tooltip Page

用户可以在Tooltip Page中设置Tooltip包含的字段，当鼠标悬停在这些字段上时，Tooltip Page会自动显示。除此之外，用户还可以手动为一个Visual设置要显示的Tooltip Page。

选择一个Visual，打开Visualizations 窗口，在Format面板中展开Tooltip：

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511135618868-388561305.png)

在Page下拉列表中选择Tooltip 页面，把Tooltip Page和该Visual相关联，当鼠标悬停在该Visual上时，关联的Tooltip Page会自动显示在Visual上方。

![](https://img2020.cnblogs.com/blog/628084/202105/628084-20210511135728893-1897306502.png)

参考文档：

[Create tooltips based on report pages in Power BI Desktop](https://docs.microsoft.com/en-us/power-bi/create-reports/desktop-tooltips)

[Extend visuals with report page tooltips](https://docs.microsoft.com/en-us/power-bi/guidance/report-page-tooltips)
