#用于分词的包
library(jiebaRD)
library(jiebaR)
#用于绘制词云的包
library(RColorBrewer)
library(wordcloud)

#建立分词引擎 添加stop_word停止词参数
mixseg = worker(stop_word = "stop_words.utf8")
#对文本进行分词
segwords <- segment("threebody.txt", mixseg)

#将分词后的文本读入R中
mytxt <- read.csv(file = segwords, head = F, stringsAsFactors = F, sep = "", encoding = "UTF-8")
#将分词后的文本转换为向量
mytxtvector <- unlist(mytxt)
#去掉不需要、无意义的字符
mytxtvector <- gsub("[0-9a-zA-Z]+?", "", mytxtvector)
mytxtvector <- gsub("\n", "", mytxtvector)
mytxtvector <- gsub(" ", "", mytxtvector)
#去掉一个字的词
mytxtvector <- subset(mytxtvector, nchar(as.character(mytxtvector)) > 1)
#统计词频 写入数据框中
myfreq <- table(unlist(mytxtvector))
myfreq <- rev(sort(myfreq))
myfreq <- data.frame(word = names(myfreq), freq = myfreq)
#去掉只出现过一次的词
myfreq2 = subset(myfreq, myfreq$freq >= 2)

#绘制词云
#设置一个颜色系
mycolors <- brewer.pal(8, "Dark2")
#设置字体
windowsFonts(myFont = windowsFont("微软雅黑"))
#画出云图
wordcloud(myfreq2$word, myfreq2$freq, random.order = F, random.color = F, colors = mycolors, family = "myFont")

