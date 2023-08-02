# [PowerBI开发 第一篇：设计PowerBI报表 ](https://www.cnblogs.com/ljhdo/p/4872564.html)

PowerBI是微软新一代的交互式报表工具，把相关的静态数据转换为酷炫的可视化的，能够根据filter条件，对数据执行动态筛选，从不同的角度和粒度上分析数据。PowerBI主要由两部分组成：PowerBI Desktop和 PowerBI Service，前者供报表开发者使用，用于创建数据模型和报表UI，后者是管理报表和用户权限，以及查看报表（Dashboard）的网页平台（Web Portal）。在开始PowerBI制作报表之前，请先下载 [PowerBI Desktop](https://powerbi.microsoft.com/en-us/desktop/)桌面开发工具，并注册[Power BI service](https://preview.powerbi.com/)账户，在注册Service账号之后，开发者可以一键发布（Publish）到云端，用户只需要在IE或Edge浏览器中打开相应的URL链接，在权限允许的范围内查看报表数据。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## 一，**认识PowerBI Desktop主界面**

打开PowerBI Desktop开发工具，主界面非常简洁，分布着开发报表常用的多个面板，每个面板都扮演着重要的角色：

* 顶部是主菜单，打开Home菜单，通过“Get Data”创建数据连接，创建数据源连接是通过Power Query M语言实现的；通过“Edit Queries”对数据源进行编辑；
* 左边框分别是Report，Data和Relationships，在开发报表时，用于切换视图，在Relationships界面中，管理数据关系，数据建模是报表数据交互式呈现的关键；
* 右边是可视化（Visualizations）和字段（Fields），用于设计报表的UI，系统内置多种可视化组件，能够创建复杂、美观的报表；
* 底部边框是Report的Page，通过“+”号新建Page，PowerBI允许在一个Report中创建多个Page，多个Page共享Data和Relationships；

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405192608597-151758998.png)

1，调整Page的大小

查看Page的格式（Format）属性，Page Size的类型是固定的16：9，那么是否可以放大Page的Size，使其可以容纳更多的图标，显示更多的数据呢？答案是可以的，这就需要自定义Page Size。

![](https://img2018.cnblogs.com/blog/628084/201810/628084-20181024154758544-856126748.png)

把Type设置为Custom，并设置Width和Height的大小，就可以增加Page的界面大小。

 ![](https://img2018.cnblogs.com/blog/628084/201810/628084-20181024154935553-1628789502.png)

如果发现Page 缩小，这就需要点开View菜单，通过 Page View 的“Actual Size”，把页面显示调整到指定的大小：

![](https://img2018.cnblogs.com/blog/628084/201908/628084-20190802140315770-1864705498.png)

当Page高度调整超过一个屏幕的大小时，Page的右侧会出现滚动条，用于上下移动Page；当Page的宽度调整超过屏幕的宽度时，Page的下方会出现一个滚动条，用于左右移动Page。

**2，查询编辑器**

PowerBI Desktop另一个重要的编辑界面是查询编辑器（Query Editor），通过点击“Edit Queries”切换到查询编辑器（Query Editor），用于对查询（Query）进行编辑，在左侧的Queries 列表中，共有三种类型的查询，分别是Table，List和Parameter，中间面板是Query的数据，右侧面板是查询设置（Query Settings），如下图所示，查询编辑器（Query Editor）通过菜单提供丰富的编辑功能，例如，通过“Transform”菜单对查询和其字段执行转换操作，通过“Add Column”菜单，适用Power Query M语言为查询添加字段：

![](https://images2017.cnblogs.com/blog/628084/201709/628084-20170929102825044-1263918384.png)

## **二，加载数据**

在Home主菜单中，点击“Get Data”，能够从多种数据源（文档，数据库，Azure等）中加载数据，在PowerBI Desktop中，每一个数据源都被抽象成一个“Query”，在加载数据时，PowerBI支持对Query进行编辑，在Query Editor中编辑Query，对数据进行清理，转换，以满足复杂的业务需求。

**1，加载Excel示例数据**

示例数据：[download this sample Excel workbook](http://go.microsoft.com/fwlink/?LinkID=521962)，将Excel下载到本地主机中，选择Excel数据源类型，点击“Connect”，指定Excel文件的路径：

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405192956019-1912746337.png)

选择需要加载的Sheet，点击Edit，将打开Query Editor对数据进行编辑，在该例中，直接点击“Load”，把Excel中的数据加载到报表中，点击左边的“Data”面板，查看加载的数据，对于数值型数据，前面有累加符号（∑）：

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405210611207-692565327.png)

**2，编辑查询**

每一个数据源都被抽象成一个Query，通过定义相应的数据转换操作，就能在数据集加载到PowerBI时，应用（apply）自定义的数据修改操作，而不需要修改数据源。在Data视图中，点击Home菜单的“Edit Queries”，能够对“Query”进行编辑和转换，例如，清洗脏数据，删除冗余的Column，添加新的Column，转换列的数据类型。在右边的“Query Settings”中，“Applied Steps”显式列出查询的编辑步骤，在编辑完成之后，点击“Close & Apply”，完成查询的修改。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405195424410-1822934149.png)

在菜单Transform中，PowerBI提供丰富的数据转换功能，满足您复杂的分析需求。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421194106946-2009925780.png)

**3，增加一个数据列YearMonth**

数据列YearMonth时Year字段和MonthName字段的结合（Combine），点击菜单Add Column，按住CTRL，同时选中Year和MonthName字段，并从“Add Column”菜单中选择“Column From Examples”：

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421205506384-385051235.png)

双击右侧新建的Column，输入同一数据行的Year和MonthName字段值的拼接（Combine），作为一个示例（Example），PowerBI会根据用户输入的结果，自动检测派生列的值，并生成派生列的计算公式，该公式可以在数据表格的上方查看到：

Transform:Text.Combine({Text.From([Year])," ",[Month Name]})

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421210308337-43152790.png)

点击OK，并把列名Combined修改YearMonth，并切换到Home菜单，点击“Close & Apply”，应用Query的编辑，并关闭Query Editor窗体。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421210925806-224890323.png)

## **三，添加可视化组件**

在制作报表之前，必须熟悉报表数据及其数据之间的关系，本例只有一个数据表，所有的数据及其关系都存储在一个数据表中，在Relationships视图中，只有孤零零的一个表。

点击“Report”，进入到报表编辑界面，使用Visualizations中可视化组件，设计报表UI。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405202319753-2053763817.png)

**1，使用分片器（Slicer）**

Slicer是一个过滤器（Filter），每一个CheckBox都是一个选项（Item）；单击选中，再次单击，取消选择；按住CTRL不放，能够多选；不选择任何Item，表示不对数据应用该Filter，不选和全选是不相同的。从PowerBI的内部运行原理上来解释，如果没有选择Slicer的任何一个选项，那么PowerBI不会对数据执行筛选操作；如果全选，那么PowerBI对数据执行筛选操作。由于在数据模型中，数据表之间可能存在多层关系，不选和全选的结果可能是不相同的，在后面的数据建模章节中，我会解释这一点。

例如，拖曳一个Slicer，把Country作为Filter，UI效果如图：

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405202745300-1880647937.png)

每一个可视化组件（Visualization）都需要设置Fields属性，将数据字段Country从Fields列表中拖曳（Drag）到Field字段中，PowerBI会自动对数据进行去重（Distinct），只显示唯一值，并按照显示值进行排序。

Field右边是一个刷子的图形，用于改变可视化组件的显示属性，读者可以尝试着修改，以定制数据的UI显示效果。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405210711363-1365790887.png)

每一个可视化组件，都会三个级别的过滤器（Filers），分为组件级别，Page级别，Report级别，用于对数据进行过滤，该过滤是静态设置的，不会动态地根据用户选择的Filter对数据进行过滤。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170405210816191-622891908.png)

**2，对Slicer的显示进行排序**

PowerBI支持数据值的排序，在排序时，可视化组件根据排序值（Sort）执行排序操作，在相应的顺序位置上呈现数据的显示值（Display)，因此，排序操作会使用到排序列（Sort By Column）和显示列（Display By Column），默认情况下，显示列就是排序列；用户可以在“Modeling”菜单中修改默认的排序行为，组件在显示数据列Column1的数据时，按照另外一个数据列Column2的值的顺序。

在右边框的Fields中选择排序的显示列，在“Modeling”菜单中，选择“Sort By Column”，默认的排序列是显示列，可以选择其他数据列作为排序列。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421214128149-1071479731.png)

**3，使用Line Chart可视化组件**

从Visualizations列表中，选择Line chart组件，轴线（Axis）属性选择Product字段，该可视化组件会按照Product呈现数据，每一个Product都是数据分析的一个维度，一个视角；Values属性选择Gross Sales和Sales 字段，该可视化组件会显示两条曲线，曲线的值分别是按照Product划分的Gross Sales和Sales，这就是说，对于每一个Product，都会分别计算Gross Sales和Sales的值。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421203831087-1870385732.png)

**4，使用Stacked column Chart可视化组件**

分组显式报表数据，如图，设置Axis属性为YearMonth，Value数据设置为Profit，Legend属性设置为Product，Legend属性的作用是再次分组，本例设置Legend属性为Product，这意味着，当Axis属性为某一个月（Year Month）时，PowerBI按照Product对Value进行分组，分别设置各个Product所占的利润（Value属性是Profit）；

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421211559368-1889720508.png)

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421214257634-1399962781.png)

该可视化组件的数据呈现并不完美，因为，底部的YearMonth不是按照自然月进行排序的，而是按照字符的顺序进行排序，为了修改这个“瑕疵”，必须改变组件默认的排序行为，使其按照排序列的值进行排序，由于数据表中有Date字段，可以按照Date字段排序，而显示的字段是YearMonth。实现的步骤非常简单，分两步：

Step1：在右边Fields列表中选中YearMonth字段，

Step2：打开菜单“Modeling”，点击“Sort by Column”，默认的排序字段是YearMonth，把排序列选中为Date字段。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421213047306-565879034.png)

在修改YearMonth的排序列之后，组件的显示正常，YearMonth轴按照自然月从左向右，依次递增。

## **四，设计第一个PowerBI报表**

当点击Slicer可视化组件（Year，Country）中的选项时，右边和下面的可视化组件中的数据会自动变化，这种交互式的“联动”变化是通过关系（Relationship）来实现的，对于本例，由于报表只有一个数据源，关系隐藏在单表中，对于多个表之间的交互式关系，可以在“Relationships”面板中，通过数据建模来实现，我会在《[PowerBI 第二篇：数据建模](http://www.cnblogs.com/ljhdo/p/4552739.html)》中详细讲述PowerBI的数据建模和关系，以及动态关联的实现。

![](https://images2015.cnblogs.com/blog/628084/201704/628084-20170421213425212-1980644241.png)

参考文档：

[Getting started with Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-getting-started/)

[Add a column from an example in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-add-column-from-example/)

[Power BI 文档](https://powerbi.microsoft.com/zh-cn/documentation/powerbi-desktop-get-the-desktop/)

[Power BI 的引导学习](https://powerbi.microsoft.com/zh-cn/guided-learning/powerbi-learning-0-0-what-is-power-bi/)

[微软又一逆天可视化神器——Power BI](http://card.weibo.com/article/h5/s?from=timeline&isappinstalled=0#cid=1001603959151645616083)
