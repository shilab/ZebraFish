#Will Need to change location of file
liver_expression <- read.delim("~/Development/repos/ZebraFish/liver_expression.out")

geneid<-liver_expression[,1]

liver_expr_vals<-liver_expression
liver_expr_vals$id<-NULL

liver_sd<-apply(liver_expr_vals,1,sd)

liver_sd<-liver_sd-mean(liver_sd,na.rm=T)
liver_sd<-liver_sd/sd(liver_sd,na.rm=T)

std_dev<-sd(liver_sd,na.rm=T)

mean <- mean(liver_sd,na.rm=T)

length<-length(liver_sd)

zscores <- vector(length=length(liver_sd))
#create loop for liver_Means 

for(i in 1:length)
{
  z <- (liver_sd[i] - mean)/std_dev
  zscores[i] <- z
}

#geneid<-geneid[which(zscores>3)]
pvals<-pnorm(zscores,lower.tail=F)
liver_expression.filt<-liver_expression[which(pvals<.01),]
write.table(liver_expression.filt,file="~/Development/repos/Zebrafish/liver_expression.out.filter",sep="\t",row.names=FALSE,col.names=TRUE,quote=FALSE)