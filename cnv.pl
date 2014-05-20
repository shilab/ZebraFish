#!/usr/bin/perl
use strict;
use warnings;

my $output="id\t";
my %cnvs;
my %ids;
my $filename="zebrafishallcallsTissuespecificcomparisonnexus6.0.txt";
open(FILE,$filename) || "can't open that $filename";
while (<FILE>)
{
	my @temp=split("\t", $_);
	my $rawid=$temp[0];
	my $region=$temp[1];
	my $event=$temp[2];
	@temp=split("_", $rawid);
	my $id=$temp[0];
	$ids{$id}="";
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
	my $value="$id-$event\t";
	$cnvs{$region}.=$value;
	#print "$id\t$region\t$event\n";
}
close FILE;
my @ids=keys %ids;
foreach(@ids)
{
	$output.="$_\t";
}
$output.="\n";
my @keys=keys %cnvs;
foreach(@keys)
{
	my %fish;
	my @temps=split("\t",$cnvs{$_});
	foreach(@temps)
	{
		#print "$_\n";
		my @val=split("-",$_);
		$fish{$val[0]}=$val[1];
	}
	$output.="$_\t";
	foreach(@ids)
	{
		#print "$_\n";
		if (exists $fish{$_})
		{
			$output.="$fish{$_}\t";
		}
		else 
		{
			$output.="2\t";
		}
	}
	$output.="\n";
}
open FILE, ">". "CNV_matrix" or die $!;
print FILE $output;
close FILE;