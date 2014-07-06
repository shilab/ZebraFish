#!/usr/bin/perl
use strict;
use warnings;


my $filename = "miRNA-2_0.annotations.20101222.txt";
my $output="Probeid\tchr\tstart\tend\n";
my @line;

open(FILE, $filename) || die "Can't open file $filename";
while(<FILE>)
{
#        $_=~ s/\r?\n$//;
	@line = split "\r",$_;
}
close FILE;
foreach(@line)
{	
  	if ($_ =~/^#/ || $_=~/^Pro/)
	{
		next;
	}
	else
	{
		my @temp = split "\t", $_;
		my $probeid = $temp[0];
		$output .= "$probeid\t";

		my $alignment = $temp[7];
		$alignment = substr($alignment,3);
		my @alignment = split(":",$alignment);
		my $chr = $alignment[0];
		$output.="$chr\t";
		
		@alignment = split("-",$alignment[1]);
		my $start = $alignment[0];
		$output.="$start\t";

		@alignment = split(" ",$alignment[1]);
		my $end = $alignment[0];
		$output .="$end\n";
	}
}
close FILE;

open FILE, ">". "mRNApositiondata" or die $!;
print FILE $output;
close FILE;
