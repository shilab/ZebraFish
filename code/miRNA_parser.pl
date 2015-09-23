#!/usr/bin/perl
use strict;
use warnings;

#my $filename="All-liver-tissue-miRNA-result.csv";
my $filename = shift(@ARGV);
my $output_file = shift(@ARGV);
my $output;
my @sample;
my @set;
my $col=0;
open(FILE,$filename) || die "Can't open file $filename";
while (<FILE>)
{
	if ($_=~ /^ProbeSet Name/)
	{
		my @head = split(",",$_);
		foreach(@head)
		{
			my @temp=split(/ /,$_);
			push (@set,$temp[0]);
			if($_=~ /.CEL$/)
			{
				push (@sample,$col);
			}
			$col++;
		}
		$output .= "id\t" . join ("\t", @set[@sample]) . "\n";
		unshift(@sample,0);
	}
	else
	{
		my @line = split(",", $_);
		$output .= join ("\t", @line[@sample]) ."\n";
	}
}
close FILE;

open FILE, ">". "$output_file" or die $!;
print FILE $output;
close FILE;
