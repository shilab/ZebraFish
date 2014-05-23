#!/usr/bin/perl
use strict;
use warnings;

my $filename = $ARGV[0];

my $output;
my $id;
my $matrixID="";
open(FILE,$filename) || die "Can't open file $filename";
while (<FILE>)
{
	chomp;
	my %genocount;
	if ($_=~/^cnvid/)
	{
		$output.="$_\n";
		print "$_\n";
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
			#print $_ . "\t" . $genocount{$_} . "\n";

				if($genocount{$_} < $low)
				{
					$low = $genocount{$_};
				}
				$total+=$genocount{$_};
		}
		if ($low < $total)
		{
			my $perc = $low/$total;
			#print "$perc\n";
			if ($perc >= 0.1)
			{
				#print "$id\t$perc\t$low\t$total\n";
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
