#!/usr/bin/perl


use strict;

use warnings;


my $output = "Probeid\tchr\tposition\n";

my $file_one = "kidney_expression00";
my $file_two = "miRNA-2_0.annotations.20101222.txt";

my $keys;
my $values;
my @needs;
my @temp;
my %hash;
my @k;

my @line;
my $level2out;
my $id;

my $chr;
my $start;
my $end;
my $position;
my $level3out;

open(FILE,$file_one) || die "Can't open file $file_one.\n";
while(<FILE>)
{
	@temp = split "\t",$_;
	if($_ =~/^Pro/)
	{
		next;
	}
	else
	{ 
		push(@needs,$temp[0]);
	}
}
close FILE;
#print "@needs\n";

open(FILE,$file_two) || die "Can't open file $file_two.\n";
while(<FILE>)
{
	my @t = split "\r",$_;
	foreach(@t)
	{
		if($_ =~/^#/ || $_=~/^Pro/)
		{
			next;
		}
		else
		{	
			my ($keys, $values) = parse_one($_);
			$hash{$keys} = $values;
		}
	}
}
close FILE;

foreach(@needs)
{	
	push(@k,"$_\t$hash{$_}\n");	
}

#print "@k\n";

foreach(@k)
{
	$level2out = parse_two($_);
	if($level2out eq " ")
	{
		next;
	}
	else
	{
		push(@line,$level2out);
	}
}

#print @line;
foreach(@line)
{	
	$output .= parse_three($_);
}

sub parse_one
{
	$_ = shift(@_);
	@temp = split "\t",$_;
	$keys = $temp[0];
	$values = $temp[7];
	return ($keys, $values);
}

sub parse_two
{
	$_ = shift(@_);
	my @a = split "\t", $_;
	$id = $a[0];
	my $alignment = $a[1];
	if($alignment =~ /^I/ ||$alignment =~ /^V/|| $alignment =~ /^\d:/ ||$alignment =~ /^\d\d:/|| $alignment =~ /^chr\d:/ || $alignment =~ /^chr\d\d:/)
	{
		if(($alignment !~ /^\d\D/ || $alignment =~ /^\d:/) && $alignment !~ /^\d\d_random/ && $alignment !~ /^I_random/ && $alignment !~ /^III_random/ && $alignment !~ /^IV_random/)
		{
			if($_ =~/\/\//)
			{
				my @b = split "//",$alignment;
				my $ali = $b[0];
				$level2out = "$id\t$ali\n";
			}
			else
			{
				$level2out = $_;
			}
		}
		else
		{
			$level2out = " ";
		}
	}
	else
	{
		$level2out = " ";
	}
	return $level2out;
}

sub parse_three
{
	$_ = shift(@_);
	my @tem = split "\t", $_;
	$id = $tem[0];

	my $align = $tem[1];
	$align = substr($align,0);
	my @align = split(":",$align);
	my $type = $align[0];
	if($type eq "I")
	{
		$chr = 1;
	}
	elsif($type eq "II")
	{
		$chr = 2;
	}
	elsif($type eq "III")
	{
		$chr = 3;
	}
	elsif($type eq "IV")
	{
		$chr = 4;
	}
	elsif($type eq "V")
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
	
	@align = split("-",$align[1]);
	$start = $align[0];

	@align = split(" ",$align[1]);
	$end = $align[0];

	$position = ($start + $end) /2;

	$level3out = "$id\t$chr\t$position\n";
	return $level3out;
}

open FILE, ">". "miRNA_#_and_position" or die $!;
print FILE $output;
close FILE;
