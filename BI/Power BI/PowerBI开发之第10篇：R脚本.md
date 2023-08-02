# [PowerBI开发 第十篇：R 脚本](https://www.cnblogs.com/ljhdo/p/4729828.html)

R是一种专门用于数据分析和统计的脚本语言，广泛应用在每一个需要统计和数据分析的领域。PowerBI支持R脚本，两者强强结合，使PowerBI的功能更加强大。PowerBI Desktop默认没有安装R，在使用R脚本之前，必须向PowerBI Desktop中安装R引擎。用户可以使用R脚本加载数据、对数据进行转换和处理、使用R脚本图形化显示数据，这意味着，PowerBI对R的支持是深度融合的，在数据处理的各个阶段都能使用R。而且，为了便于开发人员使用R进行编程，PowerBI可以直接调用R外部IDE，编程体验更好。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，安装R引擎**

在使用R之前，用户必须向本地主机中安装R引擎。安装的过程非常简单，用户只需要点击File菜单，选择“Options and settings”，打开“Options”窗口，切换到“R scripting”选项卡，根据提示的帮助，安装R引擎和R外部IDE。

R引擎安装的根目录由“Detected R home directories”指定，用于R编程的外部IDE由“Detected R IDEs”指定，如下图，R外部的IDE是 **R Studio** ，R根目录是：**C:\Program Files\R\R-3.4.3**

![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503152256273-1996989486.png)

如果本地主机已经安装了R引擎和R IDE，PowerBI会自动探测到，用户只需要从下来列表中选择相应的列表项。

## **二，使用R脚本加载数据**

数据是数据分析的原材料，R脚本是PowerBI加载数据的一种方法，工作流程是：PowerBI执行R脚本，按照R代码逻辑对数据源进行加工和处理，把最终的数据加载到PowerBI中，创建一个查询（Query），用于代表该数据集。

和其他加载方式一样，用户需要通过“Get Data”菜单来加载数据，从Other分类中，选择R Script，输入R脚本，保存之后，PowerBI自动执行脚本，处理并加载数据。R脚本数据源的图标如下：

![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503145434799-1775653763.png)

点击该图标，打开一个R Script的窗体，例如，输入R脚本，该脚本末尾包含一个数据框，作为最终的输出：

 ![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503150616341-1154746991.png)

## **三，使用R 转换数据** **（Transfrom）**

 在查询编辑器（Query Editor）中，切换到转换（Transform）菜单，用户可以使用“Run R Script”菜单对数据进行转换加工，以生成新的Query，R数据转换的图标如下图：

 ![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180427101617280-1849559139.png)

用户编写R脚本对现有的数据进行转换操作，如下图，PowerBI自动创建一个dataset变量，该变量是数据框类型，作为转换的输入数据；R脚本转换对dataset进行数据处理，最终生成适合业务逻辑的输出数据，输出数据的变量名是output，类型是数据框。使用R脚本对数据进行转换操作。

注意：如果Query中包含Date类型的字段，请首先把Date转换为字符（text）类型，执行完R脚本之后，再把该字段转换为Date类型。这是PowerBI的一个bug，后续可能会被修复。

示例脚本如下图：

 ![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503150855636-1619399598.png)

## **四，使用R显示数据**

在Visualization列表中，选择 R Script Visual，图标如下：

 ![](https://images2018.cnblogs.com/blog/628084/201804/628084-20180427101338512-1150600895.png)

用户启用R脚本之后，向R脚本编辑器中输入字段，例如，向R脚本编辑器中插入两个字段x1和x2，该字段作为R visual的输入字段。

![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503151642755-1806871757.png)

PowerBI 自动创建数据框dataset，移除重复的数据行。用户编写自定义的代码，对输入数据dataset进行处理和重塑，最后编写绘图代码显示数据，例如：

 ![](https://images2018.cnblogs.com/blog/628084/201805/628084-20180503152014674-48686946.png)

一般来说，R脚本包含两部分：

* 用于处理数据的代码；
* 用于绘图的代码；

参考文档：

[How to Import Data from R Scripts into Power BI](https://blog.learningtree.com/how-import-data-from-r-scripts-into-power-bi/)

[Using R in Query Editor](https://docs.microsoft.com/en-us/power-bi/desktop-r-in-query-editor)

[Create Power BI visuals using R](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-r-visuals/)
