usage()
{ 
	echo "Usage: $0 <-m MAF % filter> <-s p-value filter>" 1>&2; 
	exit 1;
}

while getopts ":m:s:" o; do
	case "${o}" in
		m)
			maf=${OPTARG}
			;;
		s)
			sd=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done

if [ $OPTIND -ne 5 ]
then
	usage; 
	exit 1; 
fi

echo "Extracting genotypes, expression and positions";
perl cnv.pl
perl cnv_pos.pl
perl expression.pl
perl ZebGene.pl
echo "Overlapping and filtering";
perl overlap.pl
perl filter.pl CNV_matrix.out ${maf}

echo "Running analysis";
R --no-save <<RSCRIPT
library("MatrixEQTL", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
source('~/Development/repos/ZebraFish/expression_sd_filter.r')
liv_expr<-expression_filter(${sd},'~/Development/Repos/ZebraFish/liver_expression.out')
kid_expr<-expression_filter(${sd},'~/Development/Repos/ZebraFish/kidney_expression.out')
source('~/Development/repos/ZebraFish/zeb_meQTL.R')

