#!/usr/bin/perl
use strict;
use warnings;

my %kid_samples;
my %liver_samples;

my @cnv_index;
my @kid_index;
my @liver_index;

my $kid_file = "data/kidney_expression";
my $liver_file = "data/liver_expression";
my $cnv_file = "data/CNV_matrix.newID";

my $kid_output;
my $liver_output;
my $cnv_output;

my $i;
open(FILE,$kid_file) || die "Can't open file $kid_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^id/)
	{
		$i=0;
		my @temp = split("\t",$_);
		foreach(@temp)
		{
			$kid_samples{$_}=$i;
			$i++;
		}
	}
}
close FILE;

open(FILE, $liver_file) || die "Can't open file $liver_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^id/)
	{
		$i=0;
		my @temp = split("\t",$_);
		foreach(@temp)
		{
			$liver_samples{$_}=$i;
			$i++;
		}
	}
}
close FILE;

open(FILE,$cnv_file) || die "Can't open file $cnv_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^id/)
	{
		$i=0;
		my @temp = split("\t",$_);
		foreach(@temp)
		{
			if((exists $kid_samples{$_}) && (exists $liver_samples{$_}))
			{
				push(@liver_index, $liver_samples{$_});
				push(@kid_index, $kid_samples{$_});
				push(@cnv_index, $i);
			}
			$i++;
		}	
	}
}
close FILE;

open(FILE,$kid_file) || die "Can't open file $kid_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/^[A-Za-z0-9]/)
	{
		my @temp = split("\t",$_);
		$kid_output.=join("\t",@temp[@kid_index]) . "\n";
	}
}
close FILE;

open(FILE,$liver_file) || die "Can't open file $liver_file.\n";
while(<FILE>)
{
	chomp;
        if ($_=~/^[A-Za-z0-9]/)
        {
        	my @temp = split("\t",$_);
        	$liver_output.=join("\t",@temp[@liver_index]) . "\n";
	}
}
close FILE;

open(FILE,$cnv_file) || die "Can't open file $cnv_file.\n";
while(<FILE>)
{
	chomp;
        if ($_=~/^[A-Za-z0-9]/)
        {
        	my @temp = split("\t",$_);
        	$cnv_output.=join("\t",@temp[@cnv_index]) ."\n";
	}
}
close FILE;


open FILE, ">". "data/kidney_expression.out" or die $!;
print FILE $kid_output;
close FILE;

open FILE, ">". "data/liver_expression.out" or die $!;
print FILE $liver_output;
close FILE;

open FILE, ">". "data/CNV_matrix.newID.out" or die $!;
print FILE $cnv_output;
close FILE;
