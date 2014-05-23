#Will Need to change location of file
kidney_expression <- read.delim("~/Development/repos/ZebraFish/kidney_expression")

geneid<-kidney_expression[,1]

kid_expr_vals<-kidney_expression
kid_expr_vals$id<-NULL

kid_sd<-apply(kid_expr_vals,1,sd)

kid_sd<-kid_sd-mean(kid_sd,na.rm=T)
kid_sd<-kid_sd/sd(kid_sd,na.rm=T)

std_dev<-sd(kid_sd,na.rm=T)

mean <- mean(kid_sd,na.rm=T)

length<-length(kid_sd)

zscores <- vector(length=length(kid_sd))
#create loop for kid_Means 

for(i in 1:length)
{
  z <- (kid_sd[i] - mean)/std_dev
  zscores[i] <- z
}

#geneid<-geneid[which(zscores>3)]
pvals<-pnorm(zscores,lower.tail=F)
kid_expression.filt<-kidney_expression[which(pvals<.01),]
write.table(kid_expression.filt,file="~/Development/repos/Zebrafish/kidney_expression.out.filter",sep="\t",row.names=FALSE,col.names=TRUE,quote=FALSE)