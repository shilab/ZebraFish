#!/usr/bin/perl
use strict;
use warnings;

#cnv.pl converts the raw CNV callfile to a numerical matrix. 

my $output="id\t";
my %cnvs;
my %ids;

my $filename="zebrafishallcallsTissuespecificcomparisonnexus6.0.txt";
open(FILE,$filename) || die "can't open that $filename";
while (<FILE>)
{
        if($_=~/^Sample/)
        {
                next;
        }
	my ($region, $value)=parse($_);
	$cnvs{$region}.=$value;
}
close FILE;


#Add the ids to the header
my @ids=keys %ids;
foreach(@ids)
{
	$output.="$_\t";
}
$output.="\n";

#Add the CN for each CNV to the matrix
my @keys=keys %cnvs;
foreach(@keys)
{
	my ($id, $cnvs) = parse_keys($_);
	$output.="$id\t$cnvs\n";
}
sub parse
{
	$_=shift(@_);
        my @temp=split("\t", $_);
        my $rawid=$temp[0];
        my $region=$temp[1];
        my $event=$temp[2];

        @temp=split("_", $rawid);
        my $id=$temp[0];
        $ids{$id}="";

        #Convert the descriptive events to numerical equivalents
        if ($event eq "Homozygous Copy Loss")
        {
                $event=0;
        }
        elsif ($event eq "CN Loss")
        {
                $event=1;
        }
        elsif ($event eq "CN Gain")
        {
                $event=3;
        }
        elsif ($event eq "High Copy Gain")
        {
                $event=4;
        }
        #For each CNV add the correpsonding fish with their events
        #The value of the hash will be fish-event
        my $value="$id-$event\t";
	return ($region, $value);
}

sub parse_keys
{
	$_=shift(@_);
        my %fish;
        #Recover the fish and CN for each CNV
	if (exists $cnvs{$_})
	{
		my @temps=split("\t",$cnvs{$_});
		foreach(@temps)
		{
			#Separate the fish and CN, and put them into the fish hash
			my @val=split("-",$_);
			$fish{$val[0]}=$val[1];
		}
		#Add the CN id to the matrix
		my $id = "$_";
		#$output.="$_\t";

		my $line;
		foreach(@ids)
		{
			#Add a fish's CN to the matrix if it has a change
			if (exists $fish{$_})
			{
				$line.="$fish{$_}\t";
				#$output.="$fish{$_}\t";
			}
			#For fish that don't have a different CN, just add 2
			else
			{
				$line.="2\t";
				#$output.="2\t";
			}
		}
		return($id,$line);
	}
}

open FILE, ">". "data/CNV_matrix" or die $!;
print FILE $output;
close FILE;
