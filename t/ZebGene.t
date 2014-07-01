use warnings;
use strict;
use Test::More qw( no_plan );

do 'ZebGene.pl';

my $expected = "12943963\t1\t23256\t58985\n";
is (parse('"12943963","12943963","chr1","+","23256","58985","---","ENSDART00000003463 // ensGene // ENSDART00000003463|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671|NM_173228| /// ENSDART00000122230 // ensGene // ENSDART00000122230|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671|| /// ENSDART00000128600 // ensGene // ENSDART00000128600|ENSDARG00000075827|coagulation factor VIIi [Source:ZFIN;Acc:ZDB-GENE-021206-10]|f7i|protein_coding|KNOWN|KNOWN|282671||  ","---","---","---","---","---","---","---","---","---","main"'), $expected, 'Normal output test');

is (parse('#%create_date=Mon Aug 22 12:17:44 PDT 2011'), '','Skip header with #');

is (parse('"transcript_cluster_id","probeset_id","seqname","strand","start","stop","total_probes","gene_assignment","mrna_assignment","swissprot","unigene","GO_biological_process","GO_cellular_component","GO_molecular_function","pathway","protein_domains","crosshyb_type","category"'), '', 'Skip header without #');

is (parse('"12943914","12943914","---","---","---","---","---","---","intron_control_probeset","---","---","---","---","---","---","---","---","intron_control"'),'', 'Skip blank data');

is (parse('\n'),'', 'New line test');

is (parse('"13119545","13119545","chr22","+","2340548","2352419","---","ENSDART00000061535 // ensGene // ENSDART00000061535|ENSDARG00000043296|interferon regulatory factor 6 [Source:ZFIN;Acc:ZDB-GENE-040426-1137]|irf6|protein_coding|KNOWN|KNOWN|393570|NM_200598| /// ENSDART00000139501 // ensGene // ENSDART00000139501|ENSDARG00000043296|interferon regulatory factor 6 [Source:ZFIN;Acc:ZDB-GENE-040426-1137]|irf6|protein_coding|KNOWN|PUTATIVE|393570|| /// ENSDART00000063562 // ensGene // ENSDART00000063562|ENSDARG00000043296|interferon regulatory factor 6 [Source:ZFIN;Acc:ZDB-GENE-040426-1137]|irf6|protein_coding|KNOWN|KNOWN|393570||  ","---","---","---","---","---","---","---","---","---","main"'), "13119545\t22\t2340548\t2352419\n", 'Double digit chromosme test');

is (parse('"13270685","13270685","chrZv9_NA123","-","35158","44920","---","ENSDART00000130360 // ensGene // ENSDART00000130360|ENSDARG00000074923|solute carrier family 16, member 7 (monocarboxylic acid transporter 2) [Source:HGNC Symbol;Acc:10928]|SLC16A7|protein_coding|KNOWN_BY_PROJECTION|KNOWN|561188|| /// NM_001099419.1 // ZGTC // --- /// ENSDART00000110209 // ensGene // ENSDART00000110209|ENSDARG00000074923|solute carrier family 16, member 7 (monocarboxylic acid transporter 2) [Source:HGNC Symbol;Acc:10928]|SLC16A7|protein_coding|KNOWN_BY_PROJECTION|KNOWN|561188|NM_001099419|  ","---","---","---","---","---","---","---","---","---","main"'),'','Non-numeric chromsome test');
