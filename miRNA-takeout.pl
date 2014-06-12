#!/usr/bin/perl


use strict;

use warnings;


my $file = "miRNA-Alignment";
my @line;
my @ali;
my $output = "Probeid\tAlignment\n";
open(FILE,$file) || die "Can't open file $file.\n";
while(<FILE>)
{
	my @a = split "\t", $_;
	my $alignment = $a[1];
	if($alignment =~ /^I/ ||$alignment =~ /^V/|| $alignment =~ /^\d:/ ||$alignment =~ /^\d\d:/|| $alignment =~ /^chr\d:/)
	{
		if(($alignment =~ /^\d\D/ && $alignment !~ /^\d:/)||$alignment =~ /^\d\d_random/||$alignment =~ /^I_random/||$alignment =~ /^III_random/||$alignment =~ /^IV_random/)
		{
			next;
		}
		else
		{
			push(@line,$_);
		}
	}
	else
	{
		next;
	}
}
	$output.= "@line\n";
close FILE;

open FILE, ">". "$file"."#-pos" or die $!;
print FILE $output;
close FILE;