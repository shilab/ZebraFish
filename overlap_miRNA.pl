#!/usr/bin/perl
use strict;
use warnings;

my %samples;
my %mirna_samples;

my @mirna_index;
my @samples_index;

my $sample_file = shift(@ARGV);
my $mirna_file = shift(@ARGV);

my $sample_output;
my $mirna_output;

my $i;
open(FILE,$sample_file) || die "Can't open file $sample_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^id/)
	{
		$i=0;
		my @temp = split("\t",$_);
		foreach(@temp)
		{
			$samples{$_}=$i;
			$i++;
		}
	}
}
close FILE;

open(FILE,$mirna_file) || die "Can't open file $mirna_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^id/)
	{
		$i=0;
		my @temp = split("\t",$_);
		foreach(@temp)
		{
			if(exists $samples{$_})
			{
				push(@samples_index, $samples{$_});
				push(@mirna_index, $i);
			}
			$i++;
		}	
	}
}
close FILE;

open(FILE,$sample_file) || die "Can't open file $sample_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^[A-Za-z0-9]/)
	{
		my @temp = split("\t",$_);
		$sample_output.=join("\t",@temp[@samples_index]) . "\n";
	}
}
close FILE;

open(FILE,$mirna_file) || die "Can't open file $mirna_file.\n";
while(<FILE>)
{
	chomp;
        if ($_=~/^[A-Za-z0-9]/)
        {
        	my @temp = split("\t",$_);
        	$mirna_output.=join("\t",@temp[@mirna_index]) . "\n";
	}
}
close FILE;

open FILE, ">". $mirna_file . ".miR_out" or die $!;
print FILE $mirna_output;
close FILE;

open FILE, ">". $sample_file . ".miR_out" or die $!;
print FILE $sample_output;
close FILE;
