#!/usr/bin/perl


use strict;

use warnings;



my $file_one = "miRNA_kidney_expression";
my $file_two = "miRNA-2_0.annotations.20101222.txt";
my @needs;
my @temp;
my %hash;
open(FILE,$file_one) || die "Can't open file $file_one.\n";
while(<FILE>)
{
	@temp = split "\t",$_;
	if($_ =~/^Pro/)
	{
		next;
	}
	else
	{ 
		push(@needs,$temp[0]);
	}
}
close FILE;

my $output = "Probeid\talignment\n";
open(FILE,$file_two) || die "Can't open file $file_two.\n";
while(<FILE>)
{
	my @t = split "\r",$_;
	foreach(@t)
	{
		if($_ =~/^#/ || $_=~/^Pro/)
		{
			next;
		}
		else
		{	
			@temp = split "\t",$_;
			$hash{$temp[0]} = $temp[7];
		}
	}
}
close FILE;
foreach(@needs)
{	
	$output.="$_\t$hash{$_}\n";	
}


open FILE, ">". "miRNA-AlignmentOnly" or die $!;
print FILE $output;
close FILE;
