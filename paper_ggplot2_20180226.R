#learn from:https://mp.weixin.qq.com/s?__biz=MzA3MTM3NTA5Ng==&mid=2651057661&idx=1&sn=8c4b81454e15e102d15b576ab160754e&chksm=84d9cc6ab3ae457cd66ce7c517b3330e976f0df0ea433a06a7dc4515f39484ffc2599a6ad637&mpshare=1&scene=1&srcid=022037XGs3p02HZhpZGoraGR#rd

#ggplot2图形语法


#ggplot()作为泛型函数（gplot()能快速作图，却不是泛型函数），能对任意类型的R对象
#进行可视化操作，这是ggplot2的精髓所在

#在hadly的ggplot2官方文档中，Hadely这样对Wikinson的图形语法进行了描述：“一张统计
#图形就是从数据到集合对象(geometric object,缩写为geom,包括点、线、条形等)的图形
#属性(aesthetic attributes,缩写为aes，包括颜色、形状、大小等)的一个映射。此外，
#图形中还可能包含数据的统计变换(statistical transformation,缩写stat),最后绘制在
#某个特定的坐标系(coordinate system,缩写为coord)中，而分面(facet,指将绘图窗口
#划分为若干个子窗口)则可以用来生成数据中不同子集的图形。”

#因此在ggplot2中，图形语法中至少包含了如下几个图形部件：
# 1.数据（data）
# 2.映射（mapping）
# 3.几何对象（geom）
# 4.统计变换（stat）
# 5.坐标系（coord）
# 6.分面（facet）
# 7.标度（scale）

#这些组件之间用“+”，以图层（layer）的方式来黏合构图，所以图层是ggplot2中一个重
#要的概念；在掌握基本的图形部件基础上，要完成一幅高质量的统计绘图，仍然需要其
#他图形部件来进一步扩展，这包括：
#8.主题（theme）
#9.位置（position）
#10.存储和输出


##data
#1.在ggplot2中，所接受的数据集必须为data.frame格式
head(mtcars)

#2.这种数据框的格式好处是数据易于存储，也能保留原有的绘图参数，用%+%方便的变更
#已有数据集

library(ggplot2)
p<-ggplot(mtcars,aes(mpg,wt,colour=cyl))+geom_point()
p

mtcarsc<-transform(mtcars,mpg=mpg^2)
p %+% mtcarsc 

#3.ggplot2进行数据分组时必须根据行，而不能根据列。例如在mtcars的数据集中，可以
#把汽车按汽缸数进行分组，但不能按汽车的档位数和汽缸数这两个变量分成两组。这要求
#把“宽”数据转化为“长”数据。所谓的长数据是变量不再是放在各个列上，而是排成一列，
#每一个变量都分别占其中的几行，这样就能方便对每个变量进行分组。reshape2中melt()
#和cast能够灵活的融合(melt)和重铸(cast)在数据框中的数据

library(reshape2)
mtcarsm<-melt(mtcars,id=c("mpg","disp","hp","drat","wt","qsec","vs","carb"))
head(mtcarsm)


##mapping
#1.概念：aes()函数是ggplot2中的映射函数，所谓映射函数即为数据集中的数据关联到
#相应的图形属性过程中的一种对应关系
p1<-ggplot(data = mtcars)
summary(p1)

p2<-ggplot(data = mtcars,mapply=aes(x=wt,y=hp,color=gear))
summary(p2)

#2.映射是将一个变量中离散或连续的数据与一个图形属性中以不同的参数来相互关联，而
#设定能够将这个变量中所有的数据统一为一个图形属性
p<-ggplot(mtcars,aes(wt,mpg))
p+geom_point(color="red")

#3.分组也是映射关系的一种，默认情况下ggplot2把所有观测点分为了一组，如果需要把
#观测点按额外的离散变量进行分组处理，必须修改默认的分组设置

p3<-ggplot(data = mtcars,mapping = aes(x=wt,y=hp))+geom_line()
p3


p4<-ggplot(data = mtcars,mapping = aes(x=wt,y=hp,group=factor(gear)))+geom_line()
p4


##geom和stat
#几何对象执行着图层的实际渲染，控制着生成的图形类型
# 几何对象函数，描述
# geom_abline:线图，由斜率和截距指定
# geom_area:面积图，即连续的条形图
# geom_bar:条形图
# geom_bin2d:二维封箱的热图
# geom_blank:空的几何对象
# geom_boxplot:箱线图
# geom_contour:等高线图
# geom_crossbar:类似于箱线图，但没有触须和极值点
# geom_density:密度图
# geom_density2:二维密度图
# geom_errorbar:误差线
# geom_errorbarh:水平误差线
# geom_freqpoly:频率多边形，类似于直方图
# 






































