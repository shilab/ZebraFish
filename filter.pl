#!/usr/bin/perl
use strict;
use warnings;

my $MAF=0.1;
my $filename = $ARGV[0];
if ((@ARGV)<1)
{
	print "Usage: perl filter.pl <filename> [MAF]\n";
	exit;
}
#TODO: Check if $MAF input is numeric
if ((@ARGV)==2)
{
	$MAF=$ARGV[1];
}

my $output;
my $id;
my $matrixID="";
open(FILE,$filename) || die "Can't open file $filename";
while (<FILE>)
{
	chomp;
	my %genocount;
	if ($_=~/^id/)
	{
		$output.="$_\n";
	}
	else
	{
		my @genos = split("\t",$_);
		$id = shift @genos;
		foreach (@genos)
		{
			$genocount{$_}++;
		}
		my $total;
		my $low = scalar(@genos);
		my @keys = keys %genocount;
		foreach (@keys)
		{

				if($genocount{$_} < $low)
				{
					$low = $genocount{$_};
				}
				$total+=$genocount{$_};
		}
		if ($low < $total)
		{
			my $perc = $low/$total;
			if ($perc >= $MAF)
			{
				my $tempgenos = join("\t",@genos);
				$output.="$id\t$tempgenos\n";
				$matrixID.="$id\t$perc\n";
			}
		}
	}
}

open FILE,">"."$filename" . ".filter" or die $!;
print FILE $output;
close FILE;

open FILE,">"."$filename" . ".matrixID" or die $!;
print FILE $matrixID;
close FILE;
