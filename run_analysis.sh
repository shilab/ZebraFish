perl cnv.pl
perl cnv_pos.pl
perl expression.pl
perl ZebGene.pl
perl overlap.pl
perl filter.pl CVN_matrix.out

R --no-save <<RSCRIPT
library("MatrixEQTL", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
source('~/Development/repos/ZebraFish/kid_sd.r')
source('~/Development/repos/ZebraFish/liver_sd.r')
source('~/Development/repos/ZebraFish/zeb_meQTL.R')

