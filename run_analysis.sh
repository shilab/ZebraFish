echo "Extracting genotypes, expression and positions";
perl cnv.pl
perl cnv_pos.pl
perl expression.pl
perl ZebGene.pl
echo "Overlapping and filtering";
perl overlap.pl
perl filter.pl CVN_matrix.out

echo "Running analysis";
R --no-save <<RSCRIPT
library("MatrixEQTL", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
source('~/Development/repos/ZebraFish/expression_sd_filter.r')
liv_expr<-expression_filter(0.01,'~/Development/Repos/ZebraFish/liver_expression.out')
kid_expr<-expression_filter(0.01,'~/Development/Repos/ZebraFish/kidney_expression.out')
source('~/Development/repos/ZebraFish/zeb_meQTL.R')

