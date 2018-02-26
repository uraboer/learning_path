#learning from: https://mp.weixin.qq.com/s?__biz=MzA3MTM3NTA5Ng==&mid=2651057666&idx=1&sn=849a31830c36ce6b12e4f135c2093f5e&chksm=84d9cf95b3ae468320751ab8c7a15ba7284b53f84b8513777912f1337f21f06ebf7a7c6ff06e&mpshare=1&scene=1&srcid=0221f4cYDLe3kXlkMMGKG5hn#rd

#R语言绘制瀑布图

#waterfall包绘制：对图片的属性修改不够灵活
install.packages("waterfall")
library(waterfall)

mydata<-data.frame(Item=as.factor(c("Before","Factor A","Factor B",
                                    "Factor C","Factor D","Factor E",
                                    "Factor F","Factor G")),
                   data=c(325,-32,-105,38,86,97,232,389))

# mydata
waterfallchart(Item~data,data = mydata)


#waterfalls包：基于ggplot2编写
install.packages("waterfalls")
library(ggplot2)
library(waterfalls)
library(ggthemes)
waterfall(.data = mydata,
          rect_text_labels = paste(levels(mydata$Item),'\n',mydata$data),
                                   fill_colours=c('darkslateblue','chocolate','chocolate','chartreuse',
                                                   'chartreuse','chartreuse','chartreuse','chartreuse'),
                                   calc_total=TRUE,
                                   total_rect_color="darkslateblue",
                                   total_rect_text=paste('After','\n',sum(mydata$data)),
                                   total_rect_text_color="black",
                                   total_axis_text="After",
                                   rect_width=0.9,
                                   draw_axis.x="behind",
                                   rect_border="white",
                                   fill_by_sign=FALSE)+
            theme_map()+
            geom_hline(yintercept=0,colour='skyblue')


#rAmCharts包：可以做出动态的瀑布图，难点在于数据形式的构造，多出一列符号列
# install.packages("rAmCharts")
library(rAmCharts)

mydata=data.frame(label=c('Before','Factor A','Factor B','Factor C','Factor D',
                          'Factor E','Factor F','Factor G','After'),
                  value=c(325,32,105,38,86,97,232,389,1030),
                  operation=c('total','minus','minus','plus','plus','plus','plus','plus','total'))
amWaterfall(data = mydata,show_values = TRUE)


