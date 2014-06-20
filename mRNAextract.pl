#!/usr/bin/perl
use strict;
use warnings;

my $file_one = "miRNA_kidney_expression";
my $file_two = "miRNA-2_0.annotations.20101222.txt";
my @needs;
my @temp;
my @tempp;
open(FILE,$file_one) || die "Can't open file $file_one.\n";
while(<FILE>)
{
	@temp = split "\t",$_;
	@needs = $temp[0];
}
close FILE;

my $output = "Probeid\talignment\n";
open(FILE,$file_two) || die "Can't open file $file_two.\n";
while(<FILE>)
{
	$_=~ s/\r?\n$//; # I don't know whether need it or not!
	if($_ =~/^#/ || $_=~/^"#/ || $_=~/^Pro/)
	{
		next;
	}
	else
	{
		@tempp = split "\t",$_;
		my %hash = ($tempp[0],$tempp[7]);
		foreach(@needs)
		{
			$output.= $hash{$_};	
		}
	}
}
close FILE;

open FILE, ">". "extract" or die $!;
print FILE $output;
close FILE;
