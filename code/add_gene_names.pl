use strict;
use warnings;

my %name_annot;
my $file = shift(@ARGV);
my $annot_file = "ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv";

open(FILE,$annot_file) || die "Can't open file $annot_file";
while (<FILE>)
{
    chomp;
	if ($_ =~ /protein_coding/)
	{
		$_ = (split 'protein_coding')[0];
		my @annot = split /\|/, $_;
		my $genename = $annot[-1];
		my $id = (split ",", $annot[0])[0];
		$id =~ s/"//g;
		$name_annot{$id}=$genename;
	}
}
close FILE;

open(FILE,$file) || die "Can't open file $file";
while (<FILE>)
{
    if ($_ =~ /^SNP/)
    {
        print "SNP\tgene\tgenename\tgeneid\tbeta\tt-stat\tp-value\tFDR\tR";
    }
    else
    {
        my @temp = split("\t",$_);
        my $first = shift @temp;
        my $id = shift @temp;
        my $rest = join("\t", @temp);
        if (exists $name_annot{$id})
        {
            print "$first\t$id\t$name_annot{$id}\t$rest";
        }
        else
        {
            print "$first\t$id\tNA\t$rest";
        }
    }
}
