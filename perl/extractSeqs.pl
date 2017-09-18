#! /usr/bin/env perl

=head1 NAME

=head1 SYNOPSIS

  perl extractSeqs.pl [-file fasta file] [-o output fasta file]  [-s1 symbol] [-s2 symbol] [-h help]

=head1 DESCRIPTION

  This script reads ....

  
Typical usage is as follows:

  % perl extractSeqs.pl -file input.fa -o output output.fa -s1 ">=500"
  
=head2 Options

The following options are accepted:

 --file=<fasta/fastq file name>   	(Mandatory).

 --format=Fasta or Fastq (Default Fasta).

 --s1=<symbol>		  			Can be either ">" or "<" or "==" or ">=" or "<="  plus the SIZE

 --s2=<symbol>		  			Can be either ">" or "<" or "==" or ">=" or "<="  plus the SIZE (optional)

 --o=<file>		  		Output file (default output.fa)

 --help                   	This documentation.


=head1 AUTHOR

Luca Cozzuto <luca.cozzuto@crg.es> 

=cut
use warnings;
use strict;
use Data::Dumper;
use File::Basename;
use Pod::Usage;
use Getopt::Long;
use Bio::SeqIO;
use Bio::SearchIO; 

my $USAGE = "perl extractSeqs.pl [-file fasta file] [-format ] [-o output fasta file] [-s2 symbol] [-s1 symbol] [-h help]";

my ($input,$output,$length,$format,$symbol1, $symbol2,$show_help);

&GetOptions(    	
			'format=s'		=> \$format,
			'file=s'		=> \$input,
			'output|o=s'		=> \$output,
			'symbol2|s2=s'		=> \$symbol2,
			'symbol1|s1=s'		=> \$symbol1,
			'help|h'        	=> \$show_help
			)
  or pod2usage(-verbose=>2);
pod2usage(-verbose=>2) if $show_help;

if (!$output) { $output = "output.fa"}
if (!$input) { die ("Please specify input file")}
if (!$symbol1) { die ("Please specify symbol!")}
if (!$symbol2) { $symbol2 = ">=0"};
if (!$format) { $format = "Fasta"}

#READ FASTA FILE
my %hash;
my $inseq  = Bio::SeqIO->new(-file => "<$input" , '-format' => $format);
my $seq_out = Bio::SeqIO->new(-file   => ">$output",'-format' => $format);


while (my $seq = $inseq->next_seq) {
  if (eval $seq->length.$symbol1 && eval $seq->length.$symbol2)  {
  		#print $seq->length."$symbol1 ".$seq->length."$symbol2\n";
        $seq_out->write_seq($seq);
  }
}
