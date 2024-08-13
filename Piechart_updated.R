library(ggplot2)
library(dplyr)
library(ggThemeAssist)
library(esquisse)

# Create Data
data <- data.frame(
  group=LETTERS[1:5],
  value=c(13,7,9,21,2)
)

# Compute the position of labels
data <- data %>% 
  arrange(desc(group)) %>%
  mutate(prop = value / sum(data$value) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

# Basic piechart
ggplot(data, aes(x="", y=prop, fill=group)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  
  geom_text(aes(y = ypos, label = group), color = "white", size=6) +
  scale_fill_brewer(palette="Set1")


#Noer_er_nuc_piechart   


df<-data.frame(Data_for_all_piecharts_30042021)
df<-data.frame("biotype"=c("Protein coding","LNC RNAs","NC RNAs"),"transcript"=c(6357,1022,1350))

data <- df %>% 
  arrange(desc(biotype)) %>%
  mutate(prop = transcript / sum(df$transcript) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

a<- ggplot(data, aes(x="", y=prop, fill=biotype)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="right") +
  
  geom_text(aes(y = ypos, label = prop), color = "black", size=4) +
  scale_fill_brewer(palette="PuOr")
a1<-a+theme_void()
a1 + theme(axis.ticks = element_line(colour = "gray17"),
    legend.text = element_text(size = 10))
ggsave("NOER vs ER Nucleus_pie.eps", 
       width = 15, height = 10, units="cm", dpi = 600, device ="eps",path = "/Users/sayantanibhattacharjee/Documents/R" ) 

#Noer_er_cyto_piechart   
df1<-data.frame(Data_for_all_piecharts_30042021)
df1<-data.frame("biotype"=c("Protein coding","LNC RNAs","NC RNAs"),"transcript"=c(7036,1232,1907))
data1 <- df1 %>% 
  arrange(desc(biotype)) %>%
  mutate(prop = transcript / sum(df$transcript) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )
# Convert to pie (polar coordinates) and add labels
pie = pie + coord_polar("y", start=0) + geom_text(aes(label = paste0(round(value*100), "%")), position = position_stack(vjust = 0.5))

ggplot(data1, aes(x="", y=prop, fill=biotype)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="right") +
  
  geom_text(aes(y = ypos, label = prop), color = "black", size=4) +
  scale_fill_brewer(palette="PuOr")
ggsave("NOER vs ER cyto_pie.eps", 
       width = 15, height = 10, units="cm", dpi = 600, device ="eps",path = "/Users/sayantanibhattacharjee/Documents/R" ) 


#CHX_nuc_piechart
df2<-data.frame(Data_for_all_piecharts_30042021)
df2<-data.frame("biotype"=c("Protein coding","LNC RNAs","NC RNAs"),"transcript"=c(69,6,17))

data2 <- df2 %>% 
  arrange(desc(biotype)) %>%
  mutate(prop = transcript / sum(df$transcript)*100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

ggplot(data2, aes(x="", y=prop, fill=biotype)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="right") +
  
  geom_text(aes(y = ypos, label = prop), color = "black", size=4) +
  scale_fill_brewer(palette="PuOr")
ggsave("CHX_NOER vs CHX_ER nuc_pie.eps", 
       width = 15, height = 10, units="cm", dpi = 600, device ="eps",path = "/Users/sayantanibhattacharjee/Documents/R" ) 


#CHX_cyto_piechart
df3<-data.frame("biotype"=c("Protein coding","LNC RNAs","NC RNAs"),"transcript"=c(47,7,13))

data3 <- df3 %>% 
  arrange(desc(biotype)) %>%
  mutate(prop = transcript / sum(df$transcript)*100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

ggplot(data3, aes(x="", y=prop, fill=biotype)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="right") +
  
  geom_text(aes(y = ypos, label = prop), color = "black", size=4) +
  scale_fill_brewer(palette="PuOr")
ggsave("CHX_NOER vs CHX_ER cyto_pie.eps", 
       width = 15, height = 10, units="cm", dpi = 600, device ="eps",path = "/Users/sayantanibhattacharjee/Documents/R" ) 
