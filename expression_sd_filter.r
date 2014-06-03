expression_filter<- function (mEQTL,pval,input_file){

#Will Need to change location of file
expression <- read.delim(input_file)

geneid<-expression[,1]

expr_vals<-expression
expr_vals$id<-NULL

std_dev<-apply(expr_vals,1,sd)

std_dev<-std_dev-mean(std_dev,na.rm=T)
std_dev<-std_dev/sd(std_dev,na.rm=T)

sd_std_dev<-sd(std_dev,na.rm=T)

mean <- mean(std_dev,na.rm=T)

length<-length(std_dev)

zscores <- vector(length=length(std_dev))

for(i in 1:length)
{
  z <- (std_dev[i] - mean)/sd_std_dev
  zscores[i] <- z
}

pvals<-pnorm(zscores,lower.tail=F)
expression_filter<-expression[which(pvals<.01),]
out_file<-paste(input_file,".filter",sep="");
write.table(kid_expression.filt,file=out_file,sep="\t",row.names=FALSE,col.names=TRUE,quote=FALSE)
return(expression_filter)
}