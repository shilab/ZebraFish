#!/usr/bin/perl


use strict;

use warnings;


my $file = "miRNA-Alignment#-pos";
my $output;

my $data1;
my $data2;
my $data3;


open(FILE,$file) || die "Can't open file $file.\n";
while(<FILE>)
{
	my @a = split "\t",$_;
	my $id = $a[0];
	my $alignment = $a[1];
#        $output.="$id\t$alignment";
	if($_ =~/\/\//)
	{
		my @b = split "//",$alignment;
		my $ali = $b[0];
		$data1 = join("\t", $id, $ali);
		$output.= "$data1";

	}
	else
	{
		$output.= "$_";
	}
}
close FILE;

open FILE, ">". "$file"."no_slash" or die $!;
print FILE $output;
close FILE;
