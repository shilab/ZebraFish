data: %CISresults

.SECONDARY:

%CISresults: CNV_matrix.newID.out.filter CNV_position liver_expression.out.filter gene_position miR_expression miR_CNV
	R --no-save < all_meqtl.R

miR_expression: liver_miRNA_expression.miR_out kidney_miRNA_expression.miR_out liver_miRNA_pos.snps kidney_miRNA_pos.snps  liver_expression.miR_out.filter kidney_expression.miR_out.filter liver_miRNA_expression.miR_expr_out.filter kidney_miRNA_expression.miR_expr_out.filter

miR_CNV: CNV_matrix.newID.miR_expr_out.filter CNV_position liver_miRNA_expression.miR_expr_out liver_miRNA_pos.gene liver_miRNA_pos.gene kidney_miRNA_pos.gene

gene_position: ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv 
	perl ZebGene.pl

CNV_position: CNV_matrix.newID
	perl cnv_pos.pl

CNV_matrix.newID.out.filter: CNV_matrix.newID.out
	perl filter.pl CNV_matrix.newID.out 0.05

CNV_matrix.newID.out: CNV_matrix.newID liver_expression kidney_expression
	perl overlap.pl

kidney_expression.out: CNV_matrix.newID.out
	touch kidney_expression.out

liver_expression.out: kidney_expression.out
	touch liver_expression.out

CNV_matrix: 
	perl cnv.pl

CNV_matrix.newID: CNV_matrix
	perl add_new_ids.pl CNV_matrix

kidney_expression:
	perl expression.pl

liver_expression: kidney_expression

liver_expression.out.filter: liver_expression.out kidney_expression.out kidney_expression.miR_out liver_expression.miR_out liver_miRNA_expression.miR_expr_out kidney_miRNA_expression.miR_expr_out
	R --no-save < runFilter.R

kidney_expression.out.filter: liver_expression.out.filter

liver_expression.miR_out.filter: kidney_expression.out.filter

kidney_expression.miR_out.filter: liver_expression.miR_out.filter

kidney_miRNA_expression.miR_expr_out.filter: kidney_expression.miR_out.filter

liver_miRNA_expression.miR_expr_out.filter: kidney_miRNA_expression.miR_expr_out.filter

kidney_expression.miR_out: kidney_expression kidney_miRNA_expression liver_miRNA_expression
	perl overlap_miRNA.pl kidney_expression kidney_miRNA_expression
liver_expression.miR_out: liver_expression liver_miRNA_expression kidney_miRNA_expression
	perl overlap_miRNA.pl liver_expression liver_miRNA_expression

liver_miRNA_expression.miR_out: liver_expression.miR_out 

kidney_miRNA_expression.miR_out: kidney_expression.miR_out

CNV_matrix.newID.miR_expr_out.filter: CNV_matrix.newID.miR_expr_out
	perl filter.pl CNV_matrix.newID.miR_expr_out 0.05

CNV_matrix.newID.miR_expr_out: CNV_matrix.newID
	perl miRNA_overlap.pl

kidney_miRNA_expression.miR_expr_out: CNV_matrix.newID.miR_expr_out liver_miRNA_expression kidney_miRNA_expression

liver_miRNA_expression.miR_expr_out: kidney_miRNA_expression.miR_expr_out

kidney_miRNA_pos.snps: kidney_miRNA_expression 
	perl miRNA_pos.pl kidney_miRNA_expression kidney_miRNA_pos

kidney_miRNA_pos.gene: kidney_miRNA_pos.snps

liver_miRNA_pos.snps: liver_miRNA_expression
	perl miRNA_pos.pl liver_miRNA_expression liver_miRNA_pos

liver_miRNA_pos.gene: liver_miRNA_pos.snps

kidney_miRNA_expression: 
	perl miRNA_parser.pl All-kidney-tissue-miRNA-result.csv kidney_miRNA_expression
liver_miRNA_expression:
	perl miRNA_parser.pl All-liver-tissue-miRNA-result.csv liver_miRNA_expression
