use warnings;
use strict;
use Test::More qw( no_plan );

do 'ZebGene.pl';

my $expected = "12943963\t1\t23256\t58985\n";
is (parse('"12943963","12943963","chr1","+","23256","58985","---","ENSDART00000003463 // ensGene // ENSDART00000003463|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671|NM_173228| /// ENSDART00000122230 // ensGene // ENSDART00000122230|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671|| /// ENSDART00000128600 // ensGene // ENSDART00000128600|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671||  ","---","---","---","---","---","---","---","---","---","main"'), $expected);

is (parse('#%create_date=Mon Aug 22 12:17:44 PDT 2011'), '');

is (parse('"transcript_cluster_id","probeset_id","seqname","strand","start","stop","total_probes","gene_assignment","mrna_assignment","swissprot","unigene","GO_biological_process","GO_cellular_component","GO_molecular_function","pathway","protein_domains","crosshyb_type","category"'), '');

is (parse('"12943914","12943914","---","---","---","---","---","---","intron_control_probeset","---","---","---","---","---","---","---","---","intron_control"'),'');
