# [PowerBI 开发 第22篇：异常检测（Anomaly Detection) ](https://www.cnblogs.com/ljhdo/p/16495175.html)

异常检测通过自动检测时间序列数据中的异常来增强折线图，并且提供了异常解释，以帮助用户进行根本原因的分析。异常检测只能用于Line Chart中，并且必须有Date字段作为X坐标轴，实际上，PowerBI按照时间序列，用SR-CNN算法来检测数据的异常，即微软的时序异常检测服务（Time-Series Anomaly Detection Service at Microsoft）。

启用异常检测，只需要在Analyse面板中选择“Find anomalies”。

![](https://img2022.cnblogs.com/blog/628084/202207/628084-20220719190724976-613739577.gif)

## 一，格式化异常

开发人员可以格式化表示异常的icon的形状、大小和颜色，以及预期范围的颜色、样式和透明度，这种自定义的设置可以通过Anomaly的Color，Size和Marker来实现。在报表中，异常以这种可见的icon显示出来。

开发人员还可以配置算法的参数，敏感度是算法数据的敏感程度，默认的敏感度（Sensitivity）是70%，如果增加敏感度，算法对数据的变化更加敏感，在这种情况下，即使是轻微的偏差也会被标记为异常。 如果您降低灵敏度，则该算法对它认为异常的内容更具容忍度。

 ![](https://img2022.cnblogs.com/blog/628084/202207/628084-20220719190955697-903431134.png)

有异常数据的时序数据如下图所示，Marker是一个下三角的形状：

![](https://img2022.cnblogs.com/blog/628084/202207/628084-20220719191848370-73493985.png)

## 二，解释异常

除了检测异常之外，PowerBI还可以自动解释数据中的异常。当选择异常时，Power BI 会跨数据模型中的字段运行分析，以找出可能的解释，提供自然语言来解释异常，以及与该异常相关的因素，并按其解释强度对相关的因素进行排序。

以下例子，8 月 30 日的收入为 5187 美元，高于 2447 美元至 3423 美元的预期范围，点击异常点，可以查看关于异常的更多详细信息。

![](https://img2022.cnblogs.com/blog/628084/202207/628084-20220719191444494-403947939.gif)

## 三，配置异常

开发人员可以通过“Explain by”来控制用于分析异常的字段。 例如，通过把Seller和City拖入“Explain by”字段，Power BI 把对异常的分析限制在这些字段中。在这种情况下，8 月 31 日的异常似乎与特定卖家和特定城市有关，卖家“Fabrikam”的强度为 99%。强度用于表示数据点跟异常值相关联的程度，如果“维度=Value”的强度越大，那么说明该数据点导致异常的关联程度越高。

 ![](https://img2022.cnblogs.com/blog/628084/202207/628084-20220719192556310-327941629.png)

参考文档：

[Anomaly detection](https://docs.microsoft.com/en-us/power-bi/visuals/power-bi-visualization-anomaly-detection)

[Tony Xing&#39;s post on the SR-CNN algorithm in Azure Anomaly Detector](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/overview-of-sr-cnn-algorithm-in-azure-anomaly-detector/ba-p/982798)
