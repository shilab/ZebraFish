#!/usr/bin/perl 
use strict;
use warnings;

my $kid_output;
my $liver_output;
my @kidney=(0);
my @liver=(0);
my $i=0;
my @id;

my $filename="gene_all_filesRMA-GENE-FULL-Group1.txt";
open(FILE,$filename) || die "can't open that $filename";
while (<FILE>)
{
    $_ =~ s/\r?\n$//;
    chomp;
    if ($_ =~ /^Probe/)
    {
	my @header = split("\t", $_);
	foreach (@header)
	{
	    my @temp = split(/ /, $_);
	    push (@id, $temp[0]);
	    if ($_ =~ /kid/)
	    {
		push(@kidney, $i);
	    }
	    elsif ($_ =~ /liver/)
	    {
		push(@liver, $i);
	    }
	    $i++;
	}
    }
    else
    {
	my @line = split("\t", $_);
	$kid_output .= join ("\t", @line[@kidney]) ."\n";
	$liver_output .= join ("\t", @line[@liver])."\n";
    }
}
close FILE;

$id[0] = "id";
$kid_output = join("\t", @id[@kidney]) ."\n$kid_output";
$liver_output = join("\t", @id[@liver]) ."\n$liver_output";

open FILE, ">". "kidney_expression" or die $!;
print FILE $kid_output;
close FILE;

open FILE, ">". "liver_expression" or die $!;
print FILE $liver_output;
close FILE;
