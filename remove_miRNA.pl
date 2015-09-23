#!/usr/bin/perl
use strict;
use warnings;

my %newIDs;
my $output;

my $filename = "miRNA_positions.snps";
open(FILE,$filename) || die "Can't open file $filename";
while (<FILE>)
{
	my @temp = split("\t",$_);
	$newIDs{$temp[0]}="";
}
close FILE;

my $filter_file = shift(@ARGV);
open(FILE,$filter_file) || die "Can't open file $filter_file";
while (<FILE>)
{
	my @temp = split("\t",$_);
	if (exists $newIDs{$temp[0]})
	{
		$output.=$_;
	}
}
close FILE;

open FILE,">"."$filter_file" . ".newID" or die $!;
print FILE $output;
close FILE;
