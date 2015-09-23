library(MatrixEQTL)
source('code/mxeqtl.R')
me1<-mxeqtl('data/CNV_matrix.newID.out.filter','data/CNV_position','data/kidney_expression.out','data/gene_position','results/CNV_kidney_CISResults',0.05,covariates='data/CNV_kid_cov',qq='results/kidney_CNV-qq.pdf')

me2<-mxeqtl('data/CNV_matrix.newID.out.filter','data/CNV_position','data/liver_expression.out','data/gene_position','results/CNV_liver_CISResults',0.05,covariates='data/CNV_liv_cov',qq='results/liver_CNV-qq.pdf')

me3<-mxeqtl('data/CNV_matrix.newID.miR_expr_out.filter','data/CNV_position','data/kidney_miRNA_expression.miR_expr_out.newID','miRNA_positions.gene','results/CNV-kidney-miR-CISResults',0.05,covariates='data/CNV_kid-miR_cov',qq='results/CNV_kid-miR-qq.pdf')

me4<-mxeqtl('data/CNV_matrix.newID.miR_expr_out.filter','data/CNV_position','data/liver_miRNA_expression.miR_expr_out.newID','miRNA_positions.gene','results/CNV-liver-miR-CISResults',0.05,covariates='data/CNV_liv-miR_cov',qq='results/CNV_liv-miR-qq.pdf')

me5<-mxeqtl('data/kidney_miRNA_expression.miR_out.newID','miRNA_positions.snps','data/kidney_expression.miR_out','data/gene_position','results/kidney-miR-expr-CISResults',0.05,covariates='data/kid-miR-expr_cov',qq='results/kid-miR-expr-qq.pdf')

me6<-mxeqtl('data/liver_miRNA_expression.miR_out.newID','miRNA_positions.snps','data/liver_expression.miR_out','data/gene_position','results/liver-miR-expr-CISResults',0.05,covariates='data/liv-miR-expr_cov',qq='results/liv-miR-expr-qq.pdf')

length(which(me1$cis$eqtls$FDR<0.2))
length(which(me1$cis$eqtls$FDR<0.1))

length(which(me2$cis$eqtls$FDR<0.2))
length(which(me2$cis$eqtls$FDR<0.1))

length(which(me3$cis$eqtls$FDR<0.2))
length(which(me3$cis$eqtls$FDR<0.1))

length(which(me4$cis$eqtls$FDR<0.2))
length(which(me4$cis$eqtls$FDR<0.1))

length(which(me5$cis$eqtls$FDR<0.2))
length(which(me5$cis$eqtls$FDR<0.1))

length(which(me6$cis$eqtls$FDR<0.2))
length(which(me6$cis$eqtls$FDR<0.1))

#Plots FDR<0.2
source('code/CorrBoxPlotZeb.R')
genot<-read.table('data/CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me1,0.2,expr,genot,visual=T,pdf_file='results/CNV-kidney_expression-boxplots-FDR02.pdf')
genot<-read.table('data/CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me2,0.2,expr,genot,visual=T,pdf_file='results/CNV-liver_expression-boxplots-FDRO2.pdf')
genot<-read.table('data/CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me3,0.2,expr,genot,visual=T,pdf_file='results/CNV-liver_miRNA_expression-boxplots-FDR02.pdf')
genot<-read.table('data/CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me4,0.2,expr,genot,visual=T,pdf_file='results/CNV-kidney_miRNA_expression-boxplots-FDR02.pdf')
#Scatter Plots
source('code/CorrScatterPlot.R')
genot<-read.table('data/kidney_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.2,expr,genot,T,T,'results/kidney_expression-miRNA_scatterplot-FDR02.pdf')
genot<-read.table('data/liver_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.2,expr,genot,T,T,'results/liver_expression-miRNA_scatterplot-FDR02.pdf')

#Plots FDR<0.1 
source('code/CorrBoxPlotZeb.R')
genot<-read.table('data/CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me1,0.1,expr,genot,visual=T,pdf_file='results/CNV-kidney_expression-boxplots-FDR01.pdf')
genot<-read.table('data/CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me2,0.1,expr,genot,visual=T,pdf_file='results/CNV-liver_expression-boxplots-FDR01.pdf')
genot<-read.table('data/CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me3,0.1,expr,genot,visual=T,pdf_file='results/CNV-liver_miRNA_expression-boxplots-FDR01.pdf')
genot<-read.table('data/CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me4,0.1,expr,genot,visual=T,pdf_file='results/CNV-kidney_miRNA_expression-boxplots-FDR01.pdf')
#Scatter Plots
source('code/CorrScatterPlot.R')
genot<-read.table('data/kidney_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/kidney_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.1,expr,genot,T,T,'results/kidney_expression-miRNA_scatterplot-FDR01.pdf')
genot<-read.table('data/liver_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('data/liver_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.1,expr,genot,T,T,'results/liver_expression-miRNA_scatterplot-FDR01.pdf')
