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

MAF=0.05

Mode <- function(x)
{
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

snps$LoadFile('CNV_matrix.newID.out')
maf.list = vector('list', length(snps))
for(sl in 1:length(snps))
{
    slice = snps[[sl]];
    maf.list[[sl]] = rowMeans(slice != apply(slice, 1, Mode),na.rm=T)/2;
}
maf = unlist(maf.list)
sum(maf>=MAF)
snps$RowReorder(maf>MAF);
write.table(as.matrix(snps),'CNV_matrix.newID.out.filter',row.names=T,col.names=T,sep="\t",quote=F)

snps$LoadFile('CNV_matrix.newID.miR_expr_out')
maf.list = vector('list', length(snps))
for(sl in 1:length(snps))
{
	slice = snps[[sl]];
    maf.list[[sl]] = rowMeans(slice != apply(slice, 1, Mode),na.rm=T)/2;
}
maf = unlist(maf.list)
sum(maf>=MAF)
snps$RowReorder(maf>MAF);
write.table(as.matrix(snps),'CNV_matrix.newID.miR_expr_out.filter',row.names=T,col.names=T,sep="\t",quote=F)
