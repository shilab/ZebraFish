#!/usr/bin/perl
use strict;
use warnings;

my $output="";
my %oldID;
my %newID;
my %combined_ID;
my $old_IDfile = "data/old_CNV_with_ID";
my $new_IDfile = "data/new_CNV_positions";
my $CNV_file = $ARGV[0];
my %CNV_data;

open(FILE,$old_IDfile) || die "Can't open file $old_IDfile.\n";
while(<FILE>)
{
	chomp;
	my @temp = split("\t",$_);
	my $key = $temp[3];
	my $id = $temp[4];
	$oldID{$key}=$id;
}
close FILE;

open(FILE,$new_IDfile) || die "Can't open file $new_IDfile.\n";
while(<FILE>)
{
	chomp;
	my @temp = split("\t",$_);
	my $chr = $temp[0];
	my $start = $temp[1];
	my $end = $temp[2];
	my $id = $temp[3];
	$start = reverse $start;
	$start =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
	$start = reverse $start;
    $end = reverse $end;
    $end =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
    $end = reverse $end;
	my $new_id= "$chr:$start-$end";
	$newID{$id}=$new_id;
}
close FILE;

my @keys = keys %newID;
foreach(@keys)
{
	$combined_ID{$oldID{$_}}=$newID{$_};
	#print "$oldID{$_}\t$newID{$_}\n";
}

open(FILE,$CNV_file) || die "Can't open file $CNV_file.\n";
while(<FILE>)
{
	chomp;
	if ($_=~/id/)
	{
		$output.="$_\n";
	}	
	else
	{
		my @temp = split("\t",$_);
		my $id = shift(@temp);
		my $val = join("\t",@temp);
		$CNV_data{$id}=$val;
	}
}
close FILE;

my @old_IDs = keys %combined_ID;
foreach(@old_IDs)
{
	if ($combined_ID{$_}=~/chr/)
	{
		$output.="$combined_ID{$_}\t$CNV_data{$_}\n";
	}
}

open FILE,">". $CNV_file . ".newID"  or die $!;
print FILE $output;
close FILE;
