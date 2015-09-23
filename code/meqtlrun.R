library(MatrixEQTL)
source('code/mxeqtl.R')
me1<-mxeqtl('CNV_matrix.newID.out.filter','CNV_position','kidney_expression.out','gene_position','CNV_kidney_CISResults',0.05,covariates='CNV_kid_cov',qq='kidney_CNV-qq.pdf')

me2<-mxeqtl('CNV_matrix.newID.out.filter','CNV_position','liver_expression.out','gene_position','CNV_liver_CISResults',0.05,covariates='CNV_liv_cov',qq='liver_CNV-qq.pdf')

me3<-mxeqtl('CNV_matrix.newID.miR_expr_out.filter','CNV_position','kidney_miRNA_expression.miR_expr_out.newID','miRNA_positions.gene','CNV-kidney-miR-CISResults',0.05,covariates='CNV_kid-miR_cov',qq='CNV_kid-miR-qq.pdf')

me4<-mxeqtl('CNV_matrix.newID.miR_expr_out.filter','CNV_position','liver_miRNA_expression.miR_expr_out.newID','miRNA_positions.gene','CNV-liver-miR-CISResults',0.05,covariates='CNV_liv-miR_cov',qq='CNV_liv-miR-qq.pdf')

me5<-mxeqtl('kidney_miRNA_expression.miR_out.newID','miRNA_positions.snps','kidney_expression.miR_out','gene_position','kidney-miR-expr-CISResults',0.05,covariates='kid-miR-expr_cov',qq='kid-miR-expr-qq.pdf')

me6<-mxeqtl('liver_miRNA_expression.miR_out.newID','miRNA_positions.snps','liver_expression.miR_out','gene_position','liver-miR-expr-CISResults',0.05,covariates='liv-miR-expr_cov',qq='liv-miR-expr-qq.pdf')

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
genot<-read.table('CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me1,0.2,expr,genot,visual=T,pdf_file='CNV-kidney_expression-boxplots-FDR02.pdf')
genot<-read.table('CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me2,0.2,expr,genot,visual=T,pdf_file='CNV-liver_expression-boxplots-FDRO2.pdf')
genot<-read.table('CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me3,0.2,expr,genot,visual=T,pdf_file='CNV-liver_miRNA_expression-boxplots-FDR02.pdf')
genot<-read.table('CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me4,0.2,expr,genot,visual=T,pdf_file='CNV-kidney_miRNA_expression-boxplots-FDR02.pdf')
#Scatter Plots
source('code/CorrScatterPlot.R')
genot<-read.table('kidney_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.2,expr,genot,T,T,'kidney_expression-miRNA_scatterplot-FDR02.pdf')
genot<-read.table('liver_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.2,expr,genot,T,T,'liver_expression-miRNA_scatterplot-FDR02.pdf')

#Plots FDR<0.1 
source('code/CorrBoxPlotZeb.R')
genot<-read.table('CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me1,0.1,expr,genot,visual=T,pdf_file='CNV-kidney_expression-boxplots-FDR01.pdf')
genot<-read.table('CNV_matrix.newID.out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_expression.out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me2,0.1,expr,genot,visual=T,pdf_file='CNV-liver_expression-boxplots-FDR01.pdf')
genot<-read.table('CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me3,0.1,expr,genot,visual=T,pdf_file='CNV-liver_miRNA_expression-boxplots-FDR01.pdf')
genot<-read.table('CNV_matrix.newID.miR_expr_out.filter', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_miRNA_expression.miR_expr_out.newID', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrBoxPlot(me4,0.1,expr,genot,visual=T,pdf_file='CNV-kidney_miRNA_expression-boxplots-FDR01.pdf')
#Scatter Plots
source('code/CorrScatterPlot.R')
genot<-read.table('kidney_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('kidney_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.1,expr,genot,T,T,'kidney_expression-miRNA_scatterplot-FDR01.pdf')
genot<-read.table('liver_miRNA_expression.miR_out.newID', header = T, stringsAsFactors=F,row.names=1)
expr<-read.table('liver_expression.miR_out', header = TRUE, stringsAsFactors = FALSE,row.names=1)
CorrScatterPlot(me5,0.1,expr,genot,T,T,'liver_expression-miRNA_scatterplot-FDR01.pdf')
