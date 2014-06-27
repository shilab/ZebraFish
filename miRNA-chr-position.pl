#!/usr/bin/perl
use strict;
use warnings;

my $output="Probeid\tchr\tstart\tend\n";
my @line;
my $probeid;
my $chr;
my $start;
my $end;

my $filename = "miRNA-Alignment#-posno_slash";
open(FILE, $filename) || die "Can't open file $filename";
while(<FILE>)
{
        $_=~ s/\r?\n$//;
	my @t = split "\r",$_;
	push(@line,@t);
}
close FILE;
foreach(@line)
{	
  	if ($_=~/^Pro/)
	{
		next;
	}
	else
	{
		my @temp = split "\t", $_;
		$probeid = $temp[0];
		$output.="$probeid\t";

		my $alignment = $temp[1];
		$alignment = substr($alignment,0);
		my @alignment = split(":",$alignment);
		my $type = $alignment[0];
		if($type =~ /I/)
		{
			$chr = 1;
		}
		elsif($type =~ /II/)
		{
			$chr = 2;
		}
		elsif($type =~ /III/)
		{
			$chr = 3;
		}
		elsif($type =~ /IV/)
		{
			$chr = 4;
		}
		elsif($type =~ /V/)
		{
			$chr = 5;
		}
		elsif($type=~/^c/)
		{
			$chr = substr($type,3);
		}
		else
		{
			$chr = $type;
		}
		$output.="$chr\t";
		
		@alignment = split("-",$alignment[1]);
		$start = $alignment[0];
		$output.="$start\t";

		@alignment = split(" ",$alignment[1]);
		$end = $alignment[0];
		$output.="$end\n";
	}
}

open FILE, ">". "miRNApositiondata" or die $!;
print FILE $output;
close FILE;
