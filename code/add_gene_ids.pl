#!/usr/bin/perl
use strict;
use warnings;

my %id_annot;
my $file = shift(@ARGV);
my $annot_file = "ZebGene-1_1-st-v1.r4.f38.design.transcript.design-time.pre-release.20110822.csv";

open(FILE,$annot_file) || die "Can't open file $annot_file";
while (<FILE>)
{
	chomp;
	if ($_ =~ /^#/ || $_ =~ /^"transcript/)
	{
		next;
	}
	else
	{
		my @temp = split(",",$_);
		my $id = $temp[0];
		$id =~ s/"//g;
		my $annot = $temp[7];
		my @annottemp = split(/\|/,$annot);
		foreach(@annottemp)
		{
			if ($_ =~/^ENSDARG/)
			{
				$id_annot{$id}=$_;
			}
		}
	}
}

open(FILE,$file) || die "Can't open file $file";
while (<FILE>)
{
	if ($_ =~ /^SNP/)
	{
		print "SNP\tgene\tgeneid\tbeta\tt-stat\tp-value\tFDR\tR";
	}
	else
	{
		my @temp = split("\t",$_);
		my $first = shift @temp;
		my $id = shift @temp;
		my $rest = join("\t", @temp);
		if (exists $id_annot{$id})
		{
			print "$first\t$id\t$id_annot{$id}\t$rest";
		}
		else
		{
			print "$first\t$id\tNA\t$rest";
		}
	}
}

