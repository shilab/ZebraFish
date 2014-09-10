#!/usr/bin/perl
use strict;
use warnings;

#Initialize output with the header
my $output = "snpid\tchr\tpos\n";
my $filename = "CNV_matrix.newID";
open(FILE, $filename) || die "Can't open file $filename";
while(<FILE>)
{
	if ($_=~/^id/)
	{
		next;
	}
	else
	{
		$output.=parse($_);
	}
}

sub parse
{
	$_=shift(@_);
	if ($_=~/^chr/)
	{
		my $line;
		#Get the CNV id, which contains the position
		my @temp = split "\t", $_;
		my $id = $temp[0];
		#Add the CNV id to the output
		#$output.="$id\t";
		$line.="$id\t";		

		#Remove "chr" from the id string
		$id = substr($id,3);
		#Extract the chromosome number from the id
		my @id = split(":",$id);
		my $chr = $id[0];
		#Add the chromosome number to the output
		#$output.="$chr\t";
		$line.="$chr\t";

		#Split the id into the start and stop positions
		@id = split("-",$id[1]);
		my $start = $id[0];
		my $end = $id[1];
		#Remove the commas from the numbers by splitting at the comma, then re-joining without a comma
		my @start = split(",",$start);
		$start = join("",@start);
		my @end = split(",",$end);
		$end = join("",@end);
		#Calculate the midpoint and add it to the output
		my $mid = ($start+$end)/2;
		#$output.="$mid\n";
		$line.="$mid\n";

		return $line;
	}
}

open FILE, ">". "CNV_position" or die $!;
print FILE $output;
close FILE;
