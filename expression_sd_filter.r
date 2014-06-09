expression_filter<- function (pval,input_file,colNames=TRUE){

#Read in input file 
expression <- read.delim(input_file)

#Grab the ids and put them into a new variable
geneid<-expression[,1]

#Grab the values, and remove the ids
expr_vals<-expression
if (colNames)
{
  expr_vals[,1]<-NULL
}

#Get the standard deviation of each row and put it in a vector
std_dev<-apply(expr_vals,1,sd, na.rm=T)

#Create the standard normal distribution
std_dev<-std_dev-mean(std_dev,na.rm=T)
std_dev<-std_dev/sd(std_dev,na.rm=T)

#Get the mean and sd of the distribution (Should be 0 and 1)
sd_std_dev<-sd(std_dev,na.rm=T)
mean <- mean(std_dev,na.rm=T)

#Initialize a vector to hold the z-scores
length<-length(std_dev)
zscores <- vector(length=length(std_dev))

#Calculate the z-scores
for(i in 1:length)
{
  z <- (std_dev[i] - mean)/sd_std_dev
  zscores[i] <- z
}

#Calculate the p-vals, and get only those genes that have p-values less than the filtered value
pvals<-pnorm(zscores,lower.tail=F)
expression_filter<-expression[which(pvals<pval),]
out_file<-paste(input_file,".filter",sep="");
#Write the table to an output file
write.table(expression_filter,file=out_file,sep="\t",eol = "\n", row.names=FALSE,col.names=TRUE,quote=FALSE)
#This line may not be necessary
return(expression_filter)
}
