#!/usr/bin/perl 
use strict;
use warnings;

my $kid_output;
my $liver_output;
#Initialize kidney and liver arrays with the ID column
my @kidney=(0);
my @liver=(0);
my $i=0;
my @id;

my $filename="gene_all_filesRMA-GENE-FULL-Group1.txt";
open(FILE,$filename) || die "can't open that $filename";
while (<FILE>)
{
    #Remove windows style newlines
    $_ =~ s/\r?\n$//;
    chomp;
    if ($_ =~ /^Probe/)
    {
    	#Get columns by splitting by tabs
	my @header = split("\t", $_);
	foreach (@header)
	{
	    #Remove the trailing information from the id
	    my @temp = split(/ /, $_);
	    #Put id into the id array
	    push (@id, $temp[0]);
	    #Put kidney column numbers into the kidney array
	    if ($_ =~ /kid/)
	    {
		push(@kidney, $i);
	    }
	    #Put the liver column numbers into the liver array
	    elsif ($_ =~ /liver/)
	    {
		push(@liver, $i);
	    }
	    $i++;
	}
    }
    elsif ($_=~/^[A-Za-z0-9]/)
    {
    	#Split the lines and then rejoin using the column numbers in the kidney and liver arrays
	my @line = split("\t", $_);
	$kid_output .= join ("\t", @line[@kidney]) ."\n";
	$liver_output .= join ("\t", @line[@liver])."\n";
    }
}
close FILE;

#Get the ids for the header, and add the header to the beginning of the output strings
$id[0] = "id";
$kid_output = join("\t", @id[@kidney]) ."\n$kid_output";
$liver_output = join("\t", @id[@liver]) ."\n$liver_output";

open FILE, ">". "kidney_expression" or die $!;
print FILE $kid_output;
close FILE;

open FILE, ">". "liver_expression" or die $!;
print FILE $liver_output;
close FILE;
