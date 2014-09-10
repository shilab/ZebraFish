#!/usr/bin/perl
use strict;
use warnings;

#Initialize output with header
my $output; #= "gene_id\tchr\tleft\tright\n"; 
my $filename = "CNV_old_positions";
my $id=0;
open(FILE, $filename) || die "Can't open file $filename";
while (<FILE>)
{
	$output.=parse($_);
}

#Print output to file
open FILE,">"."CNV_bed" or die $!;
print FILE $output;
close FILE;

sub parse
{
	$_=shift(@_);
	chomp;
	if ($_=~/^chr/)
	{
		$id++;
	    my @line = split(":",$_);
	    #Remove the quotes from the data
	    my $chr=$line[0];
	    my @temp = split("-",$line[1]);
	    my $start = $temp[0];
	    my @start = split(",",$start);
		$start=join("",@start);
		my $stop = $temp[1];
		my @stop = split(",",$stop);
		$stop=join("",@stop);
	    
	    #Remove the chr from the chromosome data
	    #if ($chr =~/^chr\d/)
	    #{
		#$chr = substr($chr, 3);
		#Add the data to the output
		my $line = "$chr\t$start\t$stop\t$id\n";
		return $line;
	    #}
	}
}
