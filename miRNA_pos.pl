#!/usr/bin/perl
use strict;
use warnings;

my $output = "Probeid\tchr\tposition\n";

#my $file_one = "kidney_expression00";
my $input_file = shift(@ARGV);
my $output_file = shift(@ARGV);
my $annotation_file = "miRNA-2_0.annotations.20101222.txt";

my $values;
my @needs;
my %hash;
my @k;

my @line;

open(FILE,$input_file) || die "Can't open file $input_file.\n";
while(<FILE>)
{
	my @temp = split "\t",$_;
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

open(FILE,$annotation_file) || die "Can't open file $annotation_file.\n";
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

foreach(@k)
{
	my $level2out = parse_two($_);
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
	my @temp = split "\t",$_;
	my $keys = $temp[0];
	my $values = $temp[7];
	return ($keys, $values);
}

sub parse_two
{
	my $level2out;
	$_ = shift(@_);
	my @a = split "\t", $_;
	my $id = $a[0];
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
	my $level3out;
	my $chr;
	$_ = shift(@_);
	my @tem = split "\t", $_;
	my $id = $tem[0];

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
	my $start = $align[0];

	@align = split(" ",$align[1]);
	my $end = $align[0];

	my $position = ($start + $end) /2;

	$level3out = "$id\t$chr\t$position\n";
	return $level3out;
}

open FILE, ">". "$output_file" or die $!;
print FILE $output;
close FILE;
