#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use Cwd;
use DBI;

my $dbh = DBI->connect('DBI:mysql:nlpOCR', 'root', '' ) || die "Could not connect to database: $DBI::errstr";

my ($dir) = @ARGV;
#get full paht
my $path = getcwd()."/".$dir;

#Given a directory Grab load all images into a DB
opendir(DIR, $dir);
my @files  = readdir(DIR);
closedir(DIR);

foreach my $letter (@files){
	next if ($letter eq '.' || $letter eq '..');
	insertDB($letter);
}


## insert into db
sub insertDB {
	my ($letter) = @_;
	my @pieces = split('_', $letter);
	my $stmt = "INSERT IGNORE INTO words (wordID, word) VALUES ('$pieces[0]', '$pieces[1]')";
	my $sth = $dbh->prepare($stmt);
	$sth->execute;
	
	my $file = $path."/".$letter;
	$stmt = "INSERT INTO letters (wordID, indexOfLetter, pathToLetter) VALUES ('$pieces[0]', '$pieces[2]', '$file')";
	$sth = $dbh->prepare($stmt);
	$sth->execute;
}


