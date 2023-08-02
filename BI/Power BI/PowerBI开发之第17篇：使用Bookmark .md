# [PowerBI开发 第十七篇：使用Bookmark](https://www.cnblogs.com/ljhdo/p/14704247.html)

使用PowerBI Desktop中的bookmark（书签），开发人员可以捕获报表中一个页面的当前配置，包括过滤器的设置，Visual的状态等信息，此后，开发人员可以通过激活已保存的bookmark，使报表中的一个Page还原到创建该bookmark时的状态。

对于报表的受众来说，bookmark的创建、修改和删除是非常容易的。用户不仅可以使用bookmark来保存报表的个性化视觉效果（Personalize Visual），还可以通过创建一系列的bookmark，构建类似于PPT的演示文稿，进而，用户按照设定的顺序来遍历bookmark，从而高效地分享自己的Insight。

## **一，Bookmark保存的信息**

从 PowerBI Desktop的主菜单 View中，选择Bookmarks，显示Bookmarks面板：

![图片](https://mmbiz.qpic.cn/mmbiz_png/moMnEPVdGwgBaibDXgbvVlyicHoYr4avGoeQ42UQPoJSgMuH3o7F0IZDE2NFtphpXyoHMib3vAoRscJlk5PynON0A/640?wx_fmt=png)

当创建新的Bookmark时，下面的信息会保存到Bookmark中：

* 当前的Page
* 过滤器（Filter）
* 切片器（Slicer），包括切片器的类型，切片器的状态
* Visaul的选择状态，比如 cross-highlight filters
* 排序方向（Sort Order）
* 下钻位置（Drill location）
* 对象的可见性（Selection pane）
* 可见对象的Focus或Spotlight

## **二，创建Bookmark**

用户根据特定分析的需要，开始配置一个报表页面。当报表中的Visual、Filter、Slice等都已经配置好之后，可以创建一个Bookmark来保存当前Page的状态。

在Bookmarks面板中，点击“Add”按钮创建新的Bookmark:

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132602456-876817796.png)

**1，编辑书签**

对于新创建的Bookmark，点击书签名称后面的“...”，或者选中书签右击，弹出快捷菜单，来编辑书签。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132623816-301423383.png)

Update：编辑当前的bookmark

Rename：重命名当前的bookmark

Delete：删除当前的bookmark

**2，书签组**

Group用于把多个bookmark组织为一个group。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132644232-1755012657.png)

如何把多个bookmark组织到一个分组中？用户首先按住Ctrl，选择要包含bookmark，然后从选中的bookmark中任选一个bookmark，点击书签名称后面的“...”，最后点击“Group”，选中的bookmark就被添加到分组中。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132710826-1229628984.png)

对于创建的bookmark group，可以为group重命名，把其他bookmark拖拽到分组中，或者把分组里的bookmark拖拽出分组。

**3，Bookmark保存的内容**

编辑Bookmark保存的内容：

* 勾选Data，表示bookmark保存数据属性，比如filter和slicer；
* 勾选Display，表示bookmark保存显示属性，比如，对象的spotlight和可见性；
* 勾选Current Page，当前Page的修改，表示当bookmark创建时，当前Page是可见的。

这些功能是非常有用的，当使用bookmark在report view 或Visual选择之间切换时，用户可以选择关闭数据属性，这样当普通用户通过选择bookmark切换视图时，不会重置过滤器。

## **三，把shape、button或image关联到bookmark**

用户还可以把shape、button或image等对象关联到bookmark，使用此功能，当用户选择一个对象时，将显示与该对象相关联的bookmark。

当使用button时，该功能特别有用。把一个对象跟bookmark相关联，需要把对象的Action属性设置为Bookmark，并从Bookmark列表中选择一个已创建的Bookmark。通过Selection设置对象的可见性，并结合对象的Action，可以实现非常酷炫的效果。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132736434-1775402110.png)

举个例子，在报表中，通过button的Action和bookmark，控制图片的可见性。

**Step1：设置两个相同的button，这两个button在相同的位置，显示相同的文本，本文为了方便演示，两个Button的文本和位置做了区分。**

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132751740-98951298.png)

**Step2，先隐藏Show按钮，后创建Bookmark，命名为Show Image bookmark。**

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426133055163-1098360388.png)

**Step3：首先隐藏Hide按钮和图片，然后显示Show按钮，最后创建Bookmark，命名为Hide Image bookmark。**

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132805096-425441206.png)

**Step4：设置button的Action**

设置Show Image 按钮的Action Type为Bookmark，设置Bookmark为Show Image bookmark：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426133000579-164086359.png)

显示Hide Image 按钮，设置Hide Image 按钮的Action Type为Bookmark，设置Bookmark为Hide Image bookmark：

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132937493-290011797.png)

注意：在设置为Bookmark属性之后，把Hide Image 按钮隐藏掉。

这样，就实现了一个动态的效果：当点击Show Image按钮时，Page显示为  Show Image bookmark 保存的状态，当点击Hide Image按钮时，Page显示为 Hide Image bookmark 保存的状态。

## **四，PowerBI Service中的bookmark**

当把包含bookmark的报表 publish到PowerBI Service时，用户可以在PowerBI Service中，通过View > Bookmarks pane 查看报表中的 Bookmarks，通过View > Selection pan 可以查看对象的可见性。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132902595-1674059180.png)

PowerBI Service 可以保存personnel bookmarks，报表的受众可以通过私人书签捕获报表的当前状态，进而使用bookmark来实现酷炫的演示效果。

![](https://img2020.cnblogs.com/blog/628084/202104/628084-20210426132923007-1300099057.png)
