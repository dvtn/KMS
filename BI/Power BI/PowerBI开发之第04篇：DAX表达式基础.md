# [PowerBI开发 第四篇：DAX 表达式基础 ](https://www.cnblogs.com/ljhdo/p/4789458.html)

DAX 表达式主要用于创建度量列（Measure），度量值是根据用户选择的Filter和公式，计算聚合值，DAX表达式基本上都是引用对应的函数，函数的执行有表级（Table-Level）上下文和行级（Row-Level）上下文之别；其交互行为都是通过表之间的关系实现的，用户选择的Filter，会通过关系对数据进行过滤，是PowerBI报表呈现的数据具有动态交互的特性。在我开发的PowerBI报表项目中，经常使用的DAX表达式函数，其实并不是很多，本文分享一些入门级的常用函数，附上简单的注释，希望对新手设计PowerBI报表有所帮助。

我的PowerBI开发系列的文章目录：[PowerBI开发](https://www.cnblogs.com/ljhdo/category/968907.html)

## **一，常用的操作符**

在DAX表达式中，常用的操作符是：

* 文本使用双引号作为界定符，
* 等号是“=”号，不等号是：<>
* 赋值使用“=”号，
* 布尔值使用 TRUE()和FALSE()函数，
* 空值使用BLANK()函数表示，
* 集合使用大括号{}表示，例如，包含三个元素的集合： {1,2,3}
* 字符的连接符号是：&
* 逻辑运算符号是：逻辑与是 &&，逻辑或是： ||

## **二，过滤函数**

过滤函数能够操作数据的上下文，以实现数据的动态计算，功能非常强大，用于度量中，关于过滤器函数的详细介绍，请查看：《[DAX 第三篇：过滤器函数](https://www.cnblogs.com/ljhdo/p/4610140.html)》

## **三，统计函数**

统计函数用于创建聚合，对数据进行统计分析。在使用统计函数时，必须考虑到数据模型，表之间关系，数据重复等因素，一般都会搭配过滤函数实现数据的提取和分析。

统计量一般是：均值、求和、计数、最大值、最小值、求中位数、获得分位数等。关于统计函数的详细介绍，请查看：《[DAX 第六篇：统计函数](https://www.cnblogs.com/ljhdo/p/4486928.html)》

## **四，文本函数**

在DAX表达式中，字符串使用双引号界定：

**1，格式函数**

**按照指定的格式把值转换成文本**

```
FORMAT(<value>, <format_string>)  
```

**2，空值**

在DAX中，空值（Blank） 和数据库的NULL值是相同的，通过函数ISBLANK(value)判断当前的字段值是否是空值。

```
BLANK()
ISBLANK(<value>) 
```

**3，查找函数**

在一段文本中查找字符串时，从左向右读取文本，查找函数返回第一次匹配的字符的序号，序号从1开始，依次递增。search函数不区分大小写，而find函数区分大小写。

```
FIND(<find_text>, <within_text>[, [<start_num>][, <NotFoundValue>]]) 
SEARCH(<find_text>, <within_text>[, [<start_num>][, <NotFoundValue>]]) 
```

参数 NotFoundValue 是可选的，当查找不到匹配的子串时，返回该参数的值，一般设置为0，-1或BLANK()。

如果不设置该参数，而查找函数查找不到匹配的子串时，函数返回错误。可以通过IFERROR函数处理错误，例如：

```
= IFERROR(SEARCH("-",[PostalCode]),-1)  
```

**5，拼接函数**

把表中的数据按照指定的分隔符拼接成字符串

```
CONCATENATEX(<table>, <expression>, [delimiter])  
```

示例，Employees表中包含[FirstName] 和 [LastName]两列，把这两列拼接成一个字符串：

```
CONCATENATEX(Employees, [FirstName] & “ “ & [LastName], “,”)
```

**6，包含字符串**

检查文本是否包含特定的字符串，并可以使用通配符：? 代表单个字符，* 代表任意多个字符，~ 代表把通配符转义为普通字符。

```
CONTAINSSTRING(<within_text>, <find_text>) 
CONTAINSSTRINGEXACT(<within_text>, <find_text>)
```

注意：CONTAINSSTRING不是大小写敏感的，而CONTAINSSTRINGEXACT 函数是大小写敏感的。

**7，截取子串**

从字符串中截取特定长度的字符串，start_pos是指字符的位置，从1开始，num_chars是指截取的子串的长度：

```
LEFT(<text>, <num_chars>)  
RIGHT(<text>, <num_chars>) 
MID(<text>, <start_pos>, <num_chars>) 
```

**8，替换**

instance_num是指替换的次数，num_chars是指被替换的字符的数量：

```
SUBSTITUTE(<text>, <old_text>, <new_text>, <instance_num>)  
REPLACE(<old_text>, <start_pos>, <num_chars>, <new_text>) 
```

**9，其他常用函数**

* TRIM(`<text>`) ：清理文本两端的空格
* LOWER(`<text>`) ：把文本转换为小写格式
* UPPER (`<text>`) ：把文本转换为大写格式
* LEN(`<text>`) ：计算文本的字符数量
* VALUE(`<text>`) ：把文本型数值转换为数值型

## **五，逻辑函数**

逻辑函数用于表达式，以返回逻辑运算的结果。

**1，逻辑判断函数**

检查逻辑条件是否满足，如果满足，返回value_if_true，如果不满足，返回value_if_false。

```
IF(logical_test>,<value_if_true>, <value_if_false>)  
```

等于使用“=”表示，逻辑与使用“&&”表示，逻辑或使用“||”表示，而逻辑非，通常使用NOT()函数来实现：

```
NOT(<logical>) 
```

** 2，布尔值函数**

通常用于表示数据库的bit类型的值，表示逻辑真和假

```
TRUE()  
FALSE() 
```

**3，错误函数**

如果表达式返回错误，返回value_if_error；如果表达式不返回错误，返回表达式的值。

```
IFERROR(expression, value_if_error) 
```

错误函数等价于：

```
IFERROR(A,B) := IF(ISERROR(A), B, A)
```

**4，包含逻辑**

表（Table）表达式是由大括号构成的集合：{value1,value2,,vlaueN}

IN操作符的用法是：

```
<scalarExpr> IN <tableExpr> 
```

包含行函数的用法是：

```
CONTAINSROW(<tableExpr>, <scalarExpr>[, <scalarExpr>, …]) 
```

示例，以下两个表达式是等价的：

```
[Color] IN { "Red", "Yellow", "Blue" }
CONTAINSROW({ "Red", "Yellow", "Blue" }, [Color])
```

## 六，信息函数

信息函数用于查看值的信息，比如，查看值是否跟类型相匹配等。

**1，检查空值**

ISBANK( value )：用于检测value是否是blank

```
=IF( ISBLANK('CalculatedMeasures'[PreviousYearTotalSales])  
   , BLANK()  
   , ( 'CalculatedMeasures'[Total Sales]-'CalculatedMeasures'[PreviousYearTotalSales] )  
      /'CalculatedMeasures'[PreviousYearTotalSales]) 
```

**2，检查错误**

ISERROR(value)：用于检测value是否是错误

```
= IF( ISERROR( SUM('ResellerSales_USD'[SalesAmount_USD]) /SUM('InternetSales_USD'[SalesAmount_USD])  )  
    , BLANK()  
    , SUM('ResellerSales_USD'[SalesAmount_USD]) /SUM('InternetSales_USD'[SalesAmount_USD])  
    ) 
```

**3，检查值的特性**

* ISEVEN(number)：检查数字的奇偶性
* ISODD(number)：检查数字的奇偶性
* ISNUMBER(`<value>`)：检查值是否是数字
* ISTEXT(`<value>`)：检查值是否是文本
* ISNONTEXT(`<value>`) ：如果值不是文本，或者是blank，那么返回True；否则返回False。

**4，包含数据**

如果在这些列中存在或包含所有引用列的值，则返回true; 否则，该函数返回false。

```
CONTAINS(<table>, <columnName>, <value>[, <columnName>, <value>]…) 
```

例如，下面的DAX表示：检查FactSales表中是否存在一行数据，其ProductKey列的值是214，同时CustomerKey列的值是11185，如果存在这样一行数据，那么返回True，否则返回False：

```
=CONTAINS(FactSales, [ProductKey], 214, [CustomerKey], 11185) 
```

**5，包含行**

IN 操作符和CONTAINSROW()函数的作用是相同的：

```
<scalarExpr> IN <tableExpr> 
( <scalarExpr1>, <scalarExpr2>, … ) IN <tableExpr>

CONTAINSROW(<tableExpr>, <scalarExpr>[, <scalarExpr>, …]) 
```

DAX中NOT IN不是一个操作符，要实现不存在的操作，可以把NOT 放到整个IN表达式的前面：

```
NOT [Color] IN { "Red", "Yellow", "Blue" }
```

例如，使用IN和 CONTAINSROW()函数表示包含特定的值，并列出其否定形式：

```
FILTER(ALL(DimProduct[Color]), [Color] IN { "Red", "Yellow", "Blue" })
FILTER(ALL(DimProduct[Color]), CONTAINSROW({ "Red", "Yellow", "Blue" }, [Color]))

FILTER(ALL(DimProduct[Color]), NOT [Color] IN { "Red", "Yellow", "Blue" })
FILTER(ALL(DimProduct[Color]), NOT CONTAINSROW({ "Red", "Yellow", "Blue" }, [Color]))
```

**6，返回用户信息**

从链接时提供给系统的凭证中返回域名和用户名：

```
USERNAME() 
```

例如，从授权用户表中查找用户，如果该用户存在于授权表（UserTable）中，那么返回Allowed，否则返回空值：

```
=IF(CONTAINS(UsersTable,UsersTable[login], USERNAME()), "Allowed", BLANK()) 
```

## 七，算术函数和日期/时间函数

参考《[Math and Trig functions](https://docs.microsoft.com/en-us/dax/math-and-trig-functions-dax)》和《[Date and time functions](https://docs.microsoft.com/en-us/dax/date-and-time-functions-dax)》

参考文档：

[DAX basics in Power BI Desktop](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-quickstart-learn-dax-basics/)

[Data Analysis Expressions (DAX) Reference](https://msdn.microsoft.com/library/gg413422.aspx)
