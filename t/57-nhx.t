#!/usr/bin/perl
use strict;
use warnings;
use Test::More 'no_plan';
use Bio::Phylo::IO qw'parse_tree unparse';

my $expected = {
	'155657|estExt_Genewise1.C_15140004' => { 
		'length' => 5.3435, 
		'nhx' => { 'D' => 'N', 'G' => '155657|estExt_Genewise1.C_15140004', 'T' => 283909 }
	},
	'jgi|Helro1|186101' => {
		'length' => 100000, 
		'nhx' => { 'D' => 'N', 'G' => 'jgi|Helro1|186101', 'T' => 6412 }
	},
	'Annelida' => {
		'length' => 0.0000, 
		'nhx' => { 'D' => 'N', 'B' => 27, 'T' => 6340 }
	},
	'222316' => {
		'length' => 2.9506, 
		'nhx' => { 'D' => 'N', 'G' => 222316, 'T' => 225164 }
	},
	'Lophotrochozoa' => {
		'length' => 0, 
		'nhx' => { 'D' => 'N', 'B' => 0, 'T' => 1206795 }
	},
	'31120' => {
		'length' => 1.0547, 
		'nhx' => { 'D' => 'N', 'G' => 31120, 'T' => 81824 }
	}, 
	'PTSG_04766T0' => {
		'length' => 1.0994, 
		'nhx' => { 'D' => 'N', 'G' => 'PTSG_04766T0', 'T' => 218847 }
	}
};

my $tree = parse_tree(
	'-format' => 'nhx',
	'-handle' => \*DATA,
);
isa_ok($tree, 'Bio::Phylo::Forest::Tree');
for my $name ( keys %$expected ) {
	my $node = $tree->get_by_name($name);
	isa_ok($node, 'Bio::Phylo::Forest::Node');
	ok($node->get_branch_length == $expected->{$name}->{'length'}, "branch length of $name");
	for my $key ( keys %{ $expected->{$name}->{'nhx'} } ) {
		my $exp = $expected->{$name}->{'nhx'}->{$key};
		my $obs = $node->get_meta_object( 'nhx:' . $key );
		ok( $obs eq $exp, "$key: $obs eq $exp" );
	}
}
ok( unparse(
	'-format' => 'nhx',
	'-phylo'  => $tree,
), 'unparse to NHX' );

__DATA__
(((((155657|estExt_Genewise1.C_15140004:5.3435[&&NHX:D=N:G=155657|estExt_Genewise1.C_15140004:T=283909],jgi|Helro1|186101:100000[&&NHX:D=N:G=jgi|Helro1|186101:T=6412])Annelida:0.0000[&&NHX:D=N:B=27:T=6340],222316:2.9506[&&NHX:D=N:G=222316:T=225164])Lophotrochozoa:0[&&NHX:D=N:B=0:T=1206795],(31120:1.0547[&&NHX:D=N:G=31120:T=81824],PTSG_04766T0:1.0994[&&NHX:D=N:G=PTSG_04766T0:T=218847])Codonosigidae:0.5003[&&NHX:D=N:B=71:T=81524])Opisthokonta:0[&&NHX:D=N:B=0:T=33154],(((((((((((((AAEL002068-PA:0.1301[&&NHX:D=N:G=AAEL002068:T=7159],CPIJ801731-PA:0.3867[&&NHX:D=N:G=CPIJ801731:T=7176])Culicinae:0.0273[&&NHX:D=N:B=13:T=43817],(AGAP008086-PA:0.1074[&&NHX:D=N:G=AGAP008086:T=7165],ADAR001234-PA:0.1659[&&NHX:D=N:G=ADAR001234:T=43151])Anopheles:0.1139[&&NHX:D=N:B=100:T=7164])Culicidae:0.1991[&&NHX:D=N:B=13:T=7157],((((((FBpp0268508:0.0377[&&NHX:D=N:G=FBgn0240677:T=7245],FBpp0129242:0.0403[&&NHX:D=N:G=FBgn0103001:T=7220])melanogaster_subgroup:0.0129[&&NHX:D=N:B=84:T=32351],((FBpp0208612:0.0081[&&NHX:D=N:G=FBgn0181985:T=7240],FBpp0202221:0.0124[&&NHX:D=N:G=FBgn0175625:T=7238])melanogaster_subgroup:0.0154[&&NHX:D=N:B=100:T=32351],FBpp0087958:0.0184[&&NHX:D=N:G=FBgn0033235:T=7227])melanogaster_subgroup:0.0166[&&NHX:D=N:B=100:T=32351])melanogaster_subgroup:0.1114[&&NHX:D=N:B=84:T=32351],FBpp0114422:0.1533[&&NHX:D=N:G=FBgn0088270:T=7217])melanogaster_group:0.0581[&&NHX:D=N:B=99:T=32346],FBpp0250491:0.2265[&&NHX:D=N:G=FBgn0223340:T=7260])Sophophora:0.0313[&&NHX:D=N:B=23:T=32341],((FBpp0174491:0.0022[&&NHX:D=N:G=FBgn0147994:T=7234],FBpp0278338:0.0038[&&NHX:D=N:G=FBgn0081273:T=46245])pseudoobscura_subgroup:0.0181[&&NHX:D=N:B=100:T=32358],((FBpp0278998:0.0021[&&NHX:D=N:G=FBgn0246618:T=46245],FBpp0190122:0.0039[&&NHX:D=N:G=FBgn0163597:T=7234])pseudoobscura_subgroup:0.0037[&&NHX:D=N:B=93:T=32358],FBpp0278999:0.0070[&&NHX:D=N:G=FBgn0246619:T=46245])pseudoobscura_subgroup:0.0623[&&NHX:D=Y:B=93:T=32358])pseudoobscura_subgroup:0.1607[&&NHX:D=Y:B=100:T=32358])Sophophora:0.0277[&&NHX:D=N:B=7:T=32341],((FBpp0229383:0.0975[&&NHX:D=N:G=FBgn0202169:T=7244],FBpp0168945:0.1497[&&NHX:D=N:G=FBgn0142465:T=7230])Drosophila:0.0446[&&NHX:D=N:B=10:T=32281],FBpp0154489:0.0729[&&NHX:D=N:G=FBgn0128046:T=7222])Drosophila:0.0666[&&NHX:D=N:B=10:T=7215])Drosophila:0.2196[&&NHX:D=N:B=15:T=7215])Diptera:0.1025[&&NHX:D=N:B=96:T=7147],HMEL015688-PA:0.4620[&&NHX:D=N:G=HMEL015688:T=34740])Endopterygota:0.0650[&&NHX:D=N:B=24:T=33392],TCOGS2_TC011343-PA:0.3628[&&NHX:D=N:G=TCOGS2_TC011343:T=7070])Endopterygota:0.0575[&&NHX:D=N:B=3:T=33392],((PHUM489100-PA:0.2411[&&NHX:D=N:G=PHUM489100:T=121224],ACYPI010000-PA:0.5213[&&NHX:D=N:G=ACYPI010000:T=7029])Paraneoptera:0.0850[&&NHX:D=N:B=12:T=33342],((ACEP_00004684-PA:0.1629[&&NHX:D=N:G=ACEP_00004684:T=12957],GB11914-PA:0.1802[&&NHX:D=N:G=GB11914:T=7460])Aculeata:0.0838[&&NHX:D=N:B=100:T=7434],NV12438-PA:0.1997[&&NHX:D=N:G=NV12438:T=7425])Apocrita:0.1517[&&NHX:D=N:B=100:T=7400])Neoptera:0.1641[&&NHX:D=N:B=4:T=33340])Neoptera:0.1650[&&NHX:D=Y:B=4:T=33340],DappuP303461:0.4016[&&NHX:D=N:G=DappuG303461:T=6669])Pancrustacea:0.0187[&&NHX:D=N:B=22:T=197562],ISCW009643-PA:0.3969[&&NHX:D=N:G=ISCW009643:T=6945])Arthropoda:0.0619[&&NHX:D=N:B=11:T=6656],(((((((((ENSGACP00000018431:0.0770[&&NHX:D=N:G=ENSGACG00000013937:T=69293],ENSONIP00000013462:0.0781[&&NHX:D=N:G=ENSONIG00000010708:T=8128])Percomorpha:0.0068[&&NHX:D=N:B=73:T=32485],(ENSTRUP00000042641:0.0423[&&NHX:D=N:G=ENSTRUG00000016669:T=31033],ENSTNIP00000022757:0.0432[&&NHX:D=N:G=ENSTNIG00000019531:T=99883])Tetraodontidae:0.0825[&&NHX:D=N:B=99:T=31031])Percomorpha:0.0332[&&NHX:D=N:B=56:T=32485],ENSORLP00000000673:0.0987[&&NHX:D=N:G=ENSORLG00000000547:T=8090])Percomorpha:0.0382[&&NHX:D=Y:B=79:T=32485],ENSGMOP00000020941:0.1434[&&NHX:D=N:G=ENSGMOG00000019468:T=8049])Holacanthopterygii:0.0398[&&NHX:D=N:B=81:T=123370],ENSDARP00000094505:0.1549[&&NHX:D=N:G=ENSDARG00000070566:T=7955])Clupeocephala:0.0481[&&NHX:D=N:B=83:T=186625],(((((((ENSGALP00000003014:0.0126[&&NHX:D=N:G=ENSGALG00000001950:T=9031],ENSMGAP00000007764:0.0179[&&NHX:D=N:G=ENSMGAG00000007600:T=9103])Phasianidae:0.0746[&&NHX:D=N:B=100:T=9005],ENSTGUP00000006453:0.0785[&&NHX:D=N:G=ENSTGUG00000006265:T=59729])Neognathae:0.0882[&&NHX:D=N:B=100:T=8825],ENSACAP00000015931:0.2229[&&NHX:D=N:G=ENSACAG00000016159:T=28377])Sauria:0.0210[&&NHX:D=N:B=1:T=32561],ENSPSIP00000010132:0.1180[&&NHX:D=N:G=ENSPSIG00000008988:T=13735])Sauropsida:0.0301[&&NHX:D=N:B=0:T=8457],(((((((ENSECAP00000019899:0.0558[&&NHX:D=N:G=ENSECAG00000022206:T=9796],ENSPVAP00000001269:0.0796[&&NHX:D=N:G=ENSPVAG00000001350:T=132908])Laurasiatheria:0.0142[&&NHX:D=N:B=48:T=314145],(((ENSAMEP00000003927:0.0238[&&NHX:D=N:G=ENSAMEG00000003694:T=9646],ENSCAFP00000029108:0.0441[&&NHX:D=N:G=ENSCAFG00000019672:T=9615])Caniformia:0.0110[&&NHX:D=N:B=96:T=379584],ENSMPUP00000011403:0.0582[&&NHX:D=N:G=ENSMPUG00000011493:T=9669])Caniformia:0.0101[&&NHX:D=N:B=94:T=379584],ENSFCAP00000006698:0.0537[&&NHX:D=N:G=ENSFCAG00000007223:T=9685])Carnivora:0.0282[&&NHX:D=N:B=98:T=33554])Laurasiatheria:0.0104[&&NHX:D=N:B=34:T=314145],((ENSTTRP00000007169:0.0469[&&NHX:D=N:G=ENSTTRG00000007579:T=9739],ENSBTAP00000001782:0.0744[&&NHX:D=N:G=ENSBTAG00000001353:T=9913])Cetartiodactyla:0.0289[&&NHX:D=N:B=96:T=91561],ENSVPAP00000008526:0.0460[&&NHX:D=N:G=ENSVPAG00000009159:T=30538])Cetartiodactyla:0.0195[&&NHX:D=N:B=27:T=91561])Laurasiatheria:0.0165[&&NHX:D=N:B=18:T=314145],ENSEEUP00000014445:0.1206[&&NHX:D=N:G=ENSEEUG00000015814:T=9365])Laurasiatheria:0.0074[&&NHX:D=N:B=6:T=314145],(((((((((((ENSP00000360782:0.0022[&&NHX:D=N:G=ENSG00000165688:T=9606],ENSGGOP00000010643:0.0045[&&NHX:D=N:G=ENSGGOG00000010912:T=9593])Homininae:0.0009[&&NHX:D=N:B=27:T=207598],ENSPTRP00000036911:0.0062[&&NHX:D=N:G=ENSPTRG00000021556:T=9598])Homininae:0.0081[&&NHX:D=N:B=23:T=207598],(ENSGGOP00000023866:0.0700[&&NHX:D=N:G=ENSGGOG00000022251:T=9593],ENSPTRP00000061011:0.1137[&&NHX:D=N:G=ENSPTRG00000042128:T=9598])Homininae:0.0609[&&NHX:D=N:B=100:T=207598])Homininae:0.0001[&&NHX:D=Y:B=0:T=207598],ENSPPYP00000022172:0.0135[&&NHX:D=N:G=ENSPPYG00000019773:T=9601])Hominidae:0[&&NHX:D=N:B=0:T=9604],ENSNLEP00000010061:0.0073[&&NHX:D=N:G=ENSNLEG00000008214:T=61853])Hominoidea:0.0061[&&NHX:D=N:B=0:T=314295],ENSMMUP00000004138:0.0242[&&NHX:D=N:G=ENSMMUG00000003098:T=9544])Catarrhini:0.0129[&&NHX:D=N:B=1:T=9526],ENSCJAP00000020015:0.4064[&&NHX:D=N:G=ENSCJAG00000010849:T=9483])Simiiformes:0.0194[&&NHX:D=N:B=1:T=314293],ENSTSYP00000007062:0.0872[&&NHX:D=N:G=ENSTSYG00000007710:T=9478])Haplorrhini:0.0182[&&NHX:D=N:B=0:T=376913],(ENSMICP00000005337:0.0473[&&NHX:D=N:G=ENSMICG00000005847:T=30608],ENSOGAP00000014223:0.0657[&&NHX:D=N:G=ENSOGAG00000015875:T=30611])Strepsirrhini:0.0265[&&NHX:D=N:B=96:T=376911])Primates:0.0058[&&NHX:D=N:B=0:T=9443],(((ENSRNOP00000037642:0.0316[&&NHX:D=N:G=ENSRNOG00000026775:T=10116],ENSMUSP00000075762:0.0359[&&NHX:D=N:G=ENSMUSG00000026926:T=10090])Murinae:0.0536[&&NHX:D=N:B=100:T=39107],ENSDORP00000005407:0.0941[&&NHX:D=N:G=ENSDORG00000005777:T=10020])Sciurognathi:0.0145[&&NHX:D=N:B=65:T=33553],ENSSTOP00000012636:0.0794[&&NHX:D=N:G=ENSSTOG00000014103:T=43179])Sciurognathi:0.0217[&&NHX:D=N:B=53:T=33553])Euarchontoglires:0.0089[&&NHX:D=N:B=0:T=314146],(((ENSCPOP00000006539:0.0887[&&NHX:D=N:G=ENSCPOG00000007258:T=10141],ENSOPRP00000011404:0.1764[&&NHX:D=N:G=ENSOPRG00000012497:T=9978])Glires:0.0141[&&NHX:D=N:B=8:T=314147],ENSTBEP00000012214:0.1214[&&NHX:D=N:G=ENSTBEG00000014084:T=37347])Euarchontoglires:0.0165[&&NHX:D=N:B=0:T=314146],((ENSDNOP00000009031:0.0592[&&NHX:D=N:G=ENSDNOG00000011655:T=9361],ENSCHOP00000007454:0.0671[&&NHX:D=N:G=ENSCHOG00000008433:T=9358])Xenarthra:0.0298[&&NHX:D=N:B=19:T=9348],((ENSPCAP00000012513:0.0794[&&NHX:D=N:G=ENSPCAG00000013361:T=9813],ENSETEP00000006490:0.1080[&&NHX:D=N:G=ENSETEG00000007991:T=9371])Afrotheria:0.0260[&&NHX:D=N:B=54:T=311790],ENSLAFP00000014764:0.0421[&&NHX:D=N:G=ENSLAFG00000017604:T=9785])Afrotheria:0.0557[&&NHX:D=N:B=54:T=311790])Eutheria:0.0205[&&NHX:D=N:B=3:T=9347])Eutheria:0.0283[&&NHX:D=N:B=0:T=9347])Eutheria:0.0123[&&NHX:D=Y:B=0:T=9347])Eutheria:0.0917[&&NHX:D=N:B=1:T=9347],((ENSSHAP00000008481:0.0270[&&NHX:D=N:G=ENSSHAG00000007346:T=9305],ENSMEUP00000008272:0.0317[&&NHX:D=N:G=ENSMEUG00000009055:T=9315])Marsupialia:0.0096[&&NHX:D=N:B=70:T=9263],ENSMODP00000021919:0.0278[&&NHX:D=N:G=ENSMODG00000017572:T=13616])Marsupialia:0.1027[&&NHX:D=N:B=70:T=9263])Theria:0.0350[&&NHX:D=N:B=13:T=32525],ENSOANP00000020593:0.1046[&&NHX:D=N:G=ENSOANG00000013025:T=9258])Mammalia:0.0653[&&NHX:D=N:B=4:T=40674])Amniota:0.0568[&&NHX:D=N:B=1:T=32524],ENSXETP00000001656:0.1941[&&NHX:D=N:G=ENSXETG00000000748:T=8364])Tetrapoda:0.0066[&&NHX:D=N:B=4:T=32523],ENSLACP00000020304:0.3431[&&NHX:D=N:G=ENSLACG00000017844:T=7897])Sarcopterygii:0.0741[&&NHX:D=N:B=1:T=8287])Euteleostomi:0.0876[&&NHX:D=N:B=81:T=117571],ENSPMAP00000009857:0.2925[&&NHX:D=N:G=ENSPMAG00000008943:T=7757])Vertebrata:0.1182[&&NHX:D=N:B=99:T=7742],(ENSCSAVP00000007088:0.1488[&&NHX:D=N:G=ENSCSAVG00000004241:T=51511],ENSCINP00000014838:0.2993[&&NHX:D=N:G=ENSCING00000007235:T=7719])Ciona:0.4142[&&NHX:D=N:B=93:T=7718])Chordata:0.0537[&&NHX:D=N:B=3:T=7711],SPU_018758tr:0.5121[&&NHX:D=N:G=SPU_018758gn:T=7668])Deuterostomia:0.0761[&&NHX:D=N:B=3:T=33511])Coelomata:0.0947[&&NHX:D=N:B=0:T=33316],(((((((((((CBN03909:0.0143[&&NHX:D=N:G=CBN03909:T=135651],CBN19698:0.0147[&&NHX:D=N:G=CBN19698:T=135651])Caenorhabditis_brenneri:0.1625[&&NHX:D=Y:B=99:T=135651],CRE03692:0.1813[&&NHX:D=N:G=CRE03692:T=31234])Caenorhabditis:0.0550[&&NHX:D=N:B=92:T=6237],CBG22171:0.2634[&&NHX:D=N:G=CBG22171:T=473542])Caenorhabditis:0.0499[&&NHX:D=N:B=3:T=6237],Y71G12B.24:0.1603[&&NHX:D=N:G=Y71G12B.24:T=6239])Caenorhabditis:0.0847[&&NHX:D=N:B=3:T=6237],CJA11278:0.2749[&&NHX:D=N:G=CJA11278:T=281687])Caenorhabditis:0.3711[&&NHX:D=N:B=97:T=6237],Hba_16259:0.3688[&&NHX:D=N:G=Hba_16259:T=37862])Rhabditoidea:0.0997[&&NHX:D=N:B=69:T=55879],PPA00394:0.6640[&&NHX:D=N:G=PPA00394:T=54126])Chromadorea:0.0982[&&NHX:D=N:B=35:T=119089],(KOG2067.13:0.0002[&&NHX:D=N:G=KOG2067.13:T=34506],g7904:0.0021[&&NHX:D=N:G=g7904:T=34506])Strongyloides_ratti:0.8346[&&NHX:D=Y:B=98:T=34506])Chromadorea:0.0427[&&NHX:D=Y:B=3:T=119089],(BUX.s00579.380:0.4554[&&NHX:D=N:G=BUX.s00579.380:T=6326],MhA1_Contig271.frz3.gene19:0.5291[&&NHX:D=N:G=MhA1_Contig271.frz3.gene19:T=6305])Tylenchida:0.1448[&&NHX:D=N:B=23:T=6300])Chromadorea:0.1218[&&NHX:D=N:B=1:T=119089],EFV60472:1.0166[&&NHX:D=N:G=EFV60472:T=6334])Nematoda:0.1036[&&NHX:D=N:B=0:T=6231],Smp_094050.2__mRNA:0.8927[&&NHX:D=N:G=Smp_094050:T=6183])Bilateria:0.1241[&&NHX:D=N:B=0:T=33213])Bilateria:0.1528[&&NHX:D=Y:B=0:T=33213],NEMVEDRAFT_v1g11103-PA:0.4385[&&NHX:D=N:G=NEMVEDRAFT_v1g11103:T=45351])Eumetazoa:0.0531[&&NHX:D=N:B=0:T=6072],PAC_15719356:0.7176[&&NHX:D=N:G=Aqu1.220828:T=400682])Metazoa:0.1305[&&NHX:D=N:B=0:T=33208],TriadP21554:0.8671[&&NHX:D=N:G=TriadG21554:T=10228])Metazoa:0.2663[&&NHX:D=N:B=0:T=33208])Opisthokonta:0[&&NHX:D=Y:B=1:T=33154],(YHR024C:0.6120[&&NHX:D=N:G=YHR024C:T=559292],SPBC18E5.12c.1_pep:0.7805[&&NHX:D=N:G=SPBC18E5.12c:T=284812])Ascomycota:0.4588[&&NHX:D=N:B=96:T=4890])Opisthokonta:0[&&NHX:D=N:B=0:T=33154];