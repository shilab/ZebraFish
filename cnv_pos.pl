#!/usr/bin/perl

use strict;
use warnings;

my $filename = "CNV_ZFn.txt";
open(FILE, $filename) || die "Can't open file $filename";
my @line = <FILE>;

my @lines;
foreach(@line)
{
	@lines = split("\"",$_);
}

my $output = "snpid\tchr\tpos\n";
foreach (@lines)
{
	if ($_=~/^cnv/)
	{
		next;
	}
	else
	{
		if ($_=~/^chr/)
		{
			my $id = $_;
			$output.="$id\t";
			$id = substr($id,3);
			my @id = split(":",$id);
			my $chr = $id[0];
			$output.="$chr\t";
			@id = split("-",$id[1]);
			my $start = $id[0];
			my $end = $id[1];
			my @start = split(",",$start);
			$start = join("",@start);
			my @end = split(",",$end);
			$end = join("",@end);
			my $mid = ($start+$end)/2;
			$output.="$mid\n";
			#print "$id\n";
		}
	}
}

open FILE, ">". "CNV_position" or die $!;
print FILE $output;
close FILE;