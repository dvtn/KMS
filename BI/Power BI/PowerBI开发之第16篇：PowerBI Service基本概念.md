# [PowerBI开发 第十六篇：PowerBI Service基本概念](https://www.cnblogs.com/ljhdo/p/11807401.html)

PowerBI Service 有时也称作PowerBI Online，是PowerBI的Saas（Software as a service）部分。在典型的PowerBI开发的工作流程中，用户使用PowerBI Desktop创建Report，然后把该Report发布到PowerBI Service中；用户在PowerBI Service中创建Dashboard，并可以把Report或Dashboard分享给其他用户。从总体上来看，PowerBI Service 有4个主要的构建模块，分别是Dashboards、Reports、Workbooks 和 Datasets，这四个模块都是目录，位于workspaces目录中。

## 一，Workspaces目录

在PowerBI Service中，Workspaces目录是Dashboards、Reports、Workbooks 和 Datasets的上层容器，有两类Workspace：My workspace和Workspaces。

* My workspace：是个人的workspace，只有用户自己有访问权限。用户可以从My workspace中分享Dashboard和Report。
* Workspaces： 用于和同事进行协同工作，或者分享内容，也是创建、发布和管理报表的空间。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191106202643240-224445345.png)

## 二，Reports目录

Reports目录是组织和管理Report的目录，开发人员把报表从PowerBI Desktop中发布到Reports空间中。每一个Report都包含一个或多个Page，用户打开Page查看图表，比如线图、直方图等，Page中的图表（chart）也称作visual。

## 三，Datasets目录

Datasets目录用于组织和管理workspace下的所有dataset。dataset是数据（data）的集合，data是Report中的一个数据源。一个Report所需要的数据都包含在一个dataset中，报表中图表显示的数据都从dataset中来的。

用户可以在PowerBI Service中对Dataset进行实时刷新（Refresh now）、定时刷新（Schedule refresh）、安全设置（Security）和管理权限（Manage permissions）。

## 四，Dashboards目录

Dashboards目录是组织和管理Dashboard的空间，一个Dashboard是用户在PowerBI Service中创建的，或其他用户分享的Dashboard。Dashboard是包含零个或多个图表（也叫做tile）的画布，在Dashboard中，tile是平铺显示的。

把一个tile添加到Dashbaord的动作叫做pin。在PowerBI Service上创建Dashboard，有两种pin的方式，第一种方式是把整个Page固定（pin）到Dashboard，把page作为一个单独的tile；第二种方式是把page中的一个visual固定（pin）到Dashboard，把visual作为一个单独的tile。

**1，Pin a live Page**

用户打开一个Report，选择“Pin a live Page”，新建一个Dashboard。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191106195958481-1321630452.png)

**2，Pin visual**

从report中选择图表（visual），点击visual右上角的"Pin visual"，把visual固定到dashboard，该visual在dashboard上显示为一个tile。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191106201332988-830949174.png)

**3，widget**

有一个特殊类型的tile，称作widget，用户可以直接把widget添加到Dashboard中。

例如，打开一个Dashboard，点击“Add tile”，用户可以把 Web content、Image、Text box、Video和Custom streaming data 等5个类型的tile直接添加到Dashboard中。

![](https://img2018.cnblogs.com/blog/628084/201911/628084-20191107105944116-932212077.png)

**4，Dashboard的作用**

Dashboard只跟一个workspace有关联，这就意味着，一个Dashboard只能从单个workspace下的report中pin图表或Page，不能跨Workspace来pin。

Dashboar的作用是：对于同一个workspace中的多个report，用户可以把感兴趣的图表集中到一个画布上查看，也就是说，在现有的多个Report的基础上，针对关注的业务主题，进行再次设计。

## 五，Workbooks目录

Workbooks目录是组织和管理workbook的空间，workbook是一个特殊类型的dataset。如果报表从Excel 文件中获取数据，那么用户有两个选项：Import 和 Connect。 如果用户选择Import选项，那么Excel中的数据会被导入到PowerBI中，作为Dataset中的一个数据源；如果用户选择Connect选项，那么数据源所在的workbook会显示在PowerBI中，作为一个workbook，就像该Workbook是在线的。

参考文档：

[Basic concepts for designers in the Power BI service](https://docs.microsoft.com/en-us/power-bi/service-basic-concepts)
