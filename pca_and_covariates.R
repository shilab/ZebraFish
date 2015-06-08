library(MatrixEQTL)
sep="\t";
missing="NA";
skipRows=1;
skipCols=1;
snps = SlicedData$new();
snps$fileDelimiter = sep;
snps$fileOmitCharacters = missing;
snps$fileSkipRows = skipRows;
snps$fileSkipColumns = skipCols;
snps$fileSliceSize = 2000;
gene = SlicedData$new();
gene$fileDelimiter = sep;
gene$fileOmitCharacters = missing; 
gene$fileSkipRows = skipRows;
gene$fileSkipColumns = skipCols;
gene$fileSliceSize = 2000;

#TODO: Fix filenames

snps$LoadFile('CNV_matrix.newID.out.filter')
pdf('CNV-pca.pdf')
plot(prcomp(as.matrix(snps),type='l'))
dev.off()

gene$LoadFile('kidney_expression.out.filter')
pdf('kidney_expression-pca.pdf')
plot(prcomp(as.matrix(gene)),type='l')
dev.off()
write.table(t(prcomp(as.matrix(gene))$rotation)[1:5,],'kidney_expression.out.filter.cov',row.names=T,col.names=T,sep="\t",quote=F)

CNV_kid<-rbind(t(prcomp(as.matrix(gene))$rotation)[1:5,],t(prcomp(as.matrix(snps))$rotation)[1:5,])
write.table(CNV_kid,'CNV_kid_cov',row.names=T,col.names=T,quote=F,sep="\t")

gene$LoadFile('liver_expression.out.filter')
pdf('liver_expression-pca.pdf')
plot(prcomp(as.matrix(gene)),type='l')
dev.off()
write.table(t(prcomp(as.matrix(gene))$rotation)[1:5,],'liver_expression.out.filter.cov',row.names=T,col.names=T,sep="\t",quote=F) 

CNV_liv<-rbind(t(prcomp(as.matrix(gene))$rotation)[1:5,],t(prcomp(as.matrix(snps))$rotation)[1:5,])
write.table(CNV_liv,'CNV_liv_cov',row.names=T,col.names=T,quote=F,sep="\t")


###CNV-miRNA
snps$LoadFile('CNV_matrix.newID.miR_expr_out.filter')
pdf('CNV-miRNA_pca.pdf')
plot(prcomp(as.matrix(snps),type='l'))
dev.off()

gene$LoadFile('liver_miRNA_expression.miR_expr_out.filter')
pdf('liv-miR_pca.pdf')
plot(prcomp(as.matrix(gene)),type='l')
dev.off()

CNV_liv_miR<-rbind(t(prcomp(as.matrix(gene))$rotation)[1:4,],t(prcomp(as.matrix(snps))$rotation)[1:5,])
write.table(CNV_liv_miR,'CNV_liv-miR_cov',row.names=T,col.names=T,quote=F,sep="\t")

gene$LoadFile('kidney_miRNA_expression.miR_expr_out.filter')
pdf('kid-miR_pca.pdf')
plot(prcomp(as.matrix(gene)),type='l')
dev.off()

CNV_kid_miR<-rbind(t(prcomp(as.matrix(gene))$rotation)[1:4,],t(prcomp(as.matrix(snps))$rotation)[1:5,])
write.table(CNV_kid_miR,'CNV_kid-miR_cov',row.names=T,col.names=T,quote=F,sep="\t")


###miRNA-mRNA
gene$LoadFile('kidney_expression.miR_out.filter')
kid_expr<-as.matrix(gene)
gene$LoadFile('kidney_miRNA_expression.miR_out.filter')
kid_miR<-as.matrix(gene)
kid_miR_expr<-rbind(t(prcomp(kid_expr)$rotation)[1:5,],t(prcomp(kid_miR)$rotation)[1:4,])
write.table(kid_miR_expr,'kid-miR-expr_cov',row.names=T,col.names=T,quote=F,sep="\t")

gene$LoadFile('liver_expression.miR_out.filter')
liv_expr<-as.matrix(gene)
gene$LoadFile('liver_miRNA_expression.miR_out.filter')
liv_miR<-as.matrix(gene)
liv_miR_expr<-rbind(t(prcomp(liv_expr)$rotation)[1:5,],t(prcomp(liv_miR)$rotation)[1:4,])
write.table(liv_miR_expr,'liv-miR-expr_cov',row.names=T,col.names=T,quote=F,sep="\t")
