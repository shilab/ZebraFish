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
	my ($output_line, $id_line) = parse($_);
	if ($output_line ne '')
	{
		$output.=$output_line;
	}
	if (length $id_line)
	{
		$matrixID.=$id_line;
	}
}

sub parse
{
		$_=shift(@_);
        chomp;
        my %genocount;
        if ($_=~/^id/)
        {
			return("$_\n");
            #$output.="$_\n";
        }
        else
        {
                my @genos = split("\t",$_);
                $id = shift @genos;
                foreach (@genos)
                {
			        $genocount{$_}++;
                }
                my $total=0;
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
				print "$low\t$total\n";
                if ($low < $total)
                {
                        my $perc = $low/$total;
						if ($perc >= $MAF)
                        {
                                my $tempgenos = join("\t",@genos);
                                #$output.="$id\t$tempgenos\n";
                                #$matrixID.="$id\t$perc\n";
								return("$id\t$tempgenos\n", "$id\t$perc\n");
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
