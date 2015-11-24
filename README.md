ZebraFish
=========
eQTL Analysis in ZebraFish

Requirements: R and Perl, MatrixEQTL

To reproduce analysis clone the repository, download the data and move it into the folder. Run ```make``` to run all parsing, filtering, eQTL analysis and plot generation.

Three QTL analyses (CNV-expression, CNV-miRNA, miRNA-expression) are done in two tissues (liver and kidney).

Steps:  
* CNV data are parsed out of raw data (code/cnv.pl)  
* CNV positions are parsed out of raw data (code/cnv_pos.pl)  
* Gene expression data are parsed out of raw data (code/expression.pl)  
* Gene positions are parsed out of raw data (code/ZebGene.pl)  
* miRNA expression data are parsed out of raw data (code/miRNA_parser.pl)  
* miRNA positions and CNV positions are updated from Zv9 to ZV10 using [UCSC Genome Liftover](https://genome.ucsc.edu/cgi-bin/hgLiftOver) with default settings (code/add_new_ids.pl, code/update_miRNA_pos.pl)  
* CNV data and gene expression data are overlapped for common samples (code/overlap.pl)  
* CNV data and miRNA expression data are overlapped for common samples (code/miRNA_overlap.pl)  
* miRNA expression data and gene expression data are overlapped for common samples (code/overlap_miRNA.pl)  
* Filter CNVs for MAF>.05 (code/maf_filter.R)  
* Filter miRNA expression and gene expression for most highly variable genes/miRNAs (code/expression_sd_filter.R, code/runFilter.R)  
* Run PCA on each of the inputs to get covariates (code/pca_and_covariates.R)  
* Run eQTL analysis on each of the inputs and generate boxplots or scatterplots (code/meqtlrun.R,code/CorrBoxPlotZeb.R,code/CorrScatterPlotZeb.R,mxeqtl.R)  
* Filter to FDR<0.1, add correlation and gene names to results (makefile)  
* Create network of kidney results and liver results (makefile)  
