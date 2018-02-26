# 加载第三方包
library(ggplot2)
library(klaR)#使用GermanCredit数据集
library(sqldf)


### Step 1. 数据导入
# 数据读取
data("GermanCredit")
df<-GermanCredit


### Step 2. 数据探查与清洗
head(df)
str(df)
summary(df)

#变量赋值：credit_risk取值为字符型，出于习惯将它转化为y标签值0，1
df$credit_risk<-ifelse(df$credit_risk=='bad',1,0)


#检查缺失值
#检查每列的缺失情况
na_num<-apply(df,2,function(x) sum(is.na(x)))
na_num

#缺失百分百
sort(na_num,decreasing = T)/nrow(df)

#发现变量有缺失，具体看下存在缺失的观测值
subset(df,is.na(job))

#或
library(sqldf)
sqldf('select * from df where job is null')

#常用的缺失值可视化拓展包VIM,mice
library(VIM)
aggr(df)

library(mice)
md.pattern(df)


#缺失值处理

#缺失值赋众数
df[is.na(df$job),'job']<-names(table(df$job)[which.max(table(df$job))])
sum(is.na(df$job))

#缺失值赋均值
df[which(is.na(df$age),'age')]<-mean(df$age,na.rm = T)

#缺失值赋特定值
for (i in 1:ncol(df)) {
  if(is.character(df[,i])){
    df[is.na(df[,i]),i]<-"missing"
  }
  
  if(is.numeric(df[,i])){
    df[is.na(df[,i]),i]<- -9999
  }
}


#缺失值插补法
library(DMwR)
knnImputation(data,k=10,scale = T,meth = "weighAvg",distData = NULL)

library(mice)
mice(data,m=5)



#查看特征取值个数
val_num<-data.frame()
for (i in 1:ncol(df)) {
  t1<-length(unique(df[,i]))
  t2<-names(df)[i]
  
  val_num<-rbind(data.frame(variable=t2,num=t1,type=mode(df[,i]),
                 stringsAsFactors=F),val_num)
}

rm(i,t1,t2);gc()

#或
apply(df, 2, function(x) length(unique(x)))


#转换数据类型：发现某些离散型变量的数据类型为数值型，将这些转为字符型处理
convert_cols<-val_num[which(val_num$num<5),'variable']

df[,convert_cols]<-sapply(df[,convert_cols],as.character)

str(df[,val_num[val_num$num<5,'variable']])


#查看数据分布

#连续型变量查看各变量分位数
num_distribution<-c()
temp_name<-c()

for(i in names(df)){
  if(is.numeric(df[,i])){
    temp<-quantile(df[,i],probs = c(0,0.10,0.25,0.50,0.75,0.90,0.95,0.98,
                                    0.99,1),na.rm = T,names = T)
    temp_name<-c(temp_name,i)
    num_distribution<-rbind(num_distribution,temp)
  }
}

row.names(num_distribution)<-temp_name
num_distribution<-as.data.frame(num_distribution)
num_distribution$variable<-temp_name
rm(i,temp,temp_name)


#离散型变量查看各取值占比
char_distribution<-data.frame(stringsAsFactors = F)

for (i in names(df)) {
  if(!is.numeric(df[,i])){
    temp<-data.frame(Variable=i,table(df[,i]),stringAsFactors=F)
    char_distribution<-rbind(char_distribution,temp)
  }
}

char_distribution$Per<-char_distribution$Freq/nrow(df)

rm(i,temp)


#异常值删除：在变量分布中发现age最小值为0为异常值，这边做删除处理
age_0<-subset(df,age==0)
age_0

df<-df[-which(df$age==0),]
rm(age_0)


#查看自变量与应变量联合分布

































