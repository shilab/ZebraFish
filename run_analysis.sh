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
source('~/Development/repos/ZebraFish/kid_sd.r')
source('~/Development/repos/ZebraFish/liver_sd.r')
source('~/Development/repos/ZebraFish/zeb_meQTL.R')

