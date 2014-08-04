all: data #analysis

data: CNV_matrix.out.filter %out.filter

CNV_matrix: cnv.pl zebrafishallcallsTissuespecificcomparisonnexus6.0.txt
	perl cnv.pl

%_expression: expression.pl gene_all_filesRMA-GENE-FULL-Group1.txt
	perl expression.pl

%.out: overlap.pl %_expression CNV_matrix
	perl overlap.pl

#%_expression.out.filter: expression_sd_filter.R %_expression.out
#	R --no-save < runFilter.R

CNV_matrix.out.filter: CNV_matrix.out filter.pl
	perl filter.pl CNV_matrix.out 0.05

CNV_position: cnv_pos.pl CNV_matrix
	perl cnv_pos.pl

gene_position: ZebGene.pl ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv
	perl ZebGene.pl

%_miRNA_matrix: All-liver-tissue-miRNA-result.csv All-kidney-tissue-miRNA-result.csv miRNA_parser.pl
	perl miRNA_parser.pl All-liver-tissue-miRNA-result.csv liver_miRNA_matrix
	perl miRNA_parser.pl All-kidney-tissue-miRNA-result.csv kidney_miRNA_matrix

%_miRNA_pos: %_miRNA_matrix miRNA_pos.pl
	perl miRNA_pos.pl kidney_miRNA_matrix kidney_miRNA_pos
	perl miRNA_pos.pl liver_miRNA_matrix liver_miRNA_pos

%.miR_out: 
	perl overlap_miRNA.pl kidney_expression kidney_miRNA_matrix
	perl overlap_miRNA.pl liver_expression liver_miRNA_matrix 

%out.filter: %.miR_out
	R --no-save < runFilter.R
