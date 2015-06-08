library(MatrixEQTL)
source('mxeqtl.R')
me<-mxeqtl('CNV_matrix.newID.out.filter','CNV_position','kidney_expression.out.filter','gene_position','CNV_kidney_CISResults',0.05,covariates='CNV_kid_cov',qq='kidney_CNV-qq.pdf')

me<-mxeqtl('CNV_matrix.newID.out.filter','CNV_position','liver_expression.out.filter','gene_position','CNV_liver_CISResults',0.05,covariates='CNV_liv_cov',qq='liver_CNV-qq.pdf')

me<-mxeqtl('CNV_matrix.newID.miR_expr_out.filter','CNV_position','kidney_miRNA_expression.miR_expr_out.filter','kidney_miRNA_pos.gene','CNV-kidney-miR-CISResults',0.05,covariates='CNV_kid-miR_cov',qq='CNV_kid-miR-qq.pdf')

me<-mxeqtl('CNV_matrix.newID.miR_expr_out.filter','CNV_position','liver_miRNA_expression.miR_expr_out.filter','liver_miRNA_pos.gene','CNV-liver-miR-CISResults',0.05,covariates='CNV_liv-miR_cov',qq='CNV_liv-miR-qq.pdf')

me<-mxeqtl('kidney_miRNA_expression.miR_out.filter','kidney_miRNA_pos.snps','kidney_expression.miR_out.filter','gene_position','kidney-miR-expr-CISResults',0.05,covariates='kid-miR-expr_cov',qq='kid-miR-expr-qq.pdf')

me<-mxeqtl('liver_miRNA_expression.miR_out.filter','liver_miRNA_pos.snps','liver_expression.miR_out.filter','gene_position','liver-miR-expr-CISResults',0.05,covariates='liv-miR-expr_cov',qq='liv-miR-expr-qq.pdf')

