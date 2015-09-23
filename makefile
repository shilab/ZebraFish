analysis: setup CISresults

clean:
	rm liv* kid* CNV* data/gene_position meQTL_filtered_input
	rm data/liv* data/kid* data/CNV*
	rm results/*

setup:
	mkdir -p results

.SECONDARY:

CISresults: data/CNV_matrix.newID.out.filter data/CNV_position data/liver_expression.out.filter data/gene_position miR_expression miR_CNV covariates
	R --no-save < code/meqtlrun.R

covariates: data/CNV_matrix.newID.out.filter data/CNV_position data/liver_expression.out.filter data/gene_position miR_expression miR_CNV
	R --no-save < code/pca_and_covariates.R

miR_expression: data/liver_miRNA_expression.miR_out.newID data/kidney_miRNA_expression.miR_out.newID miRNA_positions.snps data/liver_expression.miR_out.filter data/kidney_expression.miR_out.filter data/liver_miRNA_expression.miR_expr_out.filter data/kidney_miRNA_expression.miR_expr_out.filter

miR_CNV: data/CNV_matrix.newID.miR_expr_out.filter data/CNV_position data/liver_miRNA_expression.miR_expr_out.newID data/kidney_miRNA_expression.miR_expr_out.newID miRNA_positions.gene

data/gene_position: ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv 
	perl code/ZebGene.pl

data/CNV_position: data/CNV_matrix.newID
	perl code/cnv_pos.pl

data/CNV_matrix.newID.out.filter: data/CNV_matrix.newID.out data/CNV_matrix.newID.miR_expr_out
	R --no-save < code/maf_filter.R

data/CNV_matrix.newID.out: data/CNV_matrix.newID data/liver_expression data/kidney_expression
	perl code/overlap.pl

data/kidney_expression.out: data/CNV_matrix.newID.out
	touch data/kidney_expression.out

data/liver_expression.out: data/kidney_expression.out
	touch data/liver_expression.out

data/CNV_matrix: 
	perl code/cnv.pl

data/CNV_matrix.newID: data/CNV_matrix
	perl code/add_new_ids.pl data/CNV_matrix

data/kidney_expression:
	perl code/expression.pl

data/liver_expression: data/kidney_expression

data/liver_expression.out.filter: data/liver_expression.out data/kidney_expression.out data/kidney_expression.miR_out data/liver_expression.miR_out data/liver_miRNA_expression.miR_expr_out data/kidney_miRNA_expression.miR_expr_out
	R --no-save < code/runFilter.R

data/kidney_expression.out.filter: data/liver_expression.out.filter

data/liver_expression.miR_out.filter: data/kidney_expression.out.filter

data/kidney_expression.miR_out.filter: data/liver_expression.miR_out.filter

data/kidney_miRNA_expression.miR_expr_out.filter: data/kidney_expression.miR_out.filter

data/liver_miRNA_expression.miR_expr_out.filter: data/kidney_miRNA_expression.miR_expr_out.filter

data/kidney_expression.miR_out: data/kidney_expression data/kidney_miRNA_expression data/liver_miRNA_expression
	perl code/overlap_miRNA.pl data/kidney_expression data/kidney_miRNA_expression

data/liver_expression.miR_out: data/liver_expression data/liver_miRNA_expression data/kidney_miRNA_expression
	perl code/overlap_miRNA.pl data/liver_expression data/liver_miRNA_expression

data/liver_miRNA_expression.miR_out: data/liver_expression.miR_out 

data/kidney_miRNA_expression.miR_out: data/kidney_expression.miR_out

data/liver_miRNA_expression.miR_out.newID: data/liver_miRNA_expression.miR_out miRNA_positions.snps
	perl code/remove_miRNA.pl data/liver_miRNA_expression.miR_out

data/kidney_miRNA_expression.miR_out.newID: data/kidney_miRNA_expression.miR_out miRNA_positions.snps
	perl code/remove_miRNA.pl data/kidney_miRNA_expression.miR_out

data/CNV_matrix.newID.miR_expr_out.filter: data/CNV_matrix.newID.out.filter 

data/CNV_matrix.newID.miR_expr_out: data/CNV_matrix.newID data/kidney_miRNA_expression data/liver_miRNA_expression
	perl code/miRNA_overlap.pl

data/kidney_miRNA_expression.miR_expr_out: data/CNV_matrix.newID.miR_expr_out data/liver_miRNA_expression data/kidney_miRNA_expression

data/liver_miRNA_expression.miR_expr_out: data/kidney_miRNA_expression.miR_expr_out

data/liver_miRNA_expression.miR_expr_out.newID: data/liver_miRNA_expression.miR_expr_out miRNA_positions.snps
	perl code/remove_miRNA.pl data/liver_miRNA_expression.miR_expr_out

data/kidney_miRNA_expression.miR_expr_out.newID: data/kidney_miRNA_expression.miR_expr_out miRNA_positions.snps
	perl code/remove_miRNA.pl data/kidney_miRNA_expression.miR_expr_out

data/old_miRNA_positions: data/kidney_miRNA_expression miRNA_positions.snps
	perl code/miRNA_pos.pl data/kidney_miRNA_expression data/old_miRNA_positions
	rm data/old_miRNA_positions.snps
	awk '{print "chr"$2"\t"$3"\t"$4"\t"$1}' data/old_miRNA_positions.gene | tail -n +2 > data/old_miRNA_positions
	rm data/old_miRNA_positions.gene

miRNA_positions.snps: 
	perl code/update_miRNA_pos.pl

miRNA_positions.gene: miRNA_positions.snps

data/kidney_miRNA_expression: 
	perl code/miRNA_parser.pl All-kidney-tissue-miRNA-result.csv data/kidney_miRNA_expression

data/liver_miRNA_expression:
	perl code/miRNA_parser.pl All-liver-tissue-miRNA-result.csv data/liver_miRNA_expression
