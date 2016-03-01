#!/usr/bin/perl

#original script by elena sergienko 
#updated 2014-15 for new weather station by Craig Earley 

use DBI;
use POSIX;

my $sqliteUser='';
my $sqlitePasswd='';
my $sqliteDbname='/path/to/weewx.sdb';
my $sqliteDbhost='host.name';
my $sqliteTable='tableName';
my $sqliteDSNhost="dbi:SQLite:database=$sqliteDbname;host=$sqliteDbhost";

my $psqlUser='mypgUser';
my $psqlPasswd='myPassword';
my $psqlDbname='myPostgresDB';
my $psqlDbhost='localhost';
my $psqlTable='mytable';
my $psqlDSNhost="dbi:Pg:database=$psqlDbname;host=$psqlDbhost";

my $sqliteDB=DBI->connect($sqliteDSNhost, $sqliteUser, $sqlitePasswd) or die $DBI::errstr;
my $psqlDB=DBI->connect($psqlDSNhost, $psqlUser, $psqlPasswd) or die $DBI::errstr;

&addData ($sqliteDB,$sqliteTable,$psqlDB,$psqlTable);

$sqliteDB->disconnect;
$psqlDB->disconnect;

sub addData
{
  my ($sqliteDB,$sqliteTable,$psqlDB,$psqlTable)=@_; 
  my $order = 'datetime';

  my $query = "SELECT * FROM $psqlTable ORDER BY $order DESC limit 1";
  use Date::Parse;
  my $psqlDt = str2time($psqlDB->selectall_arrayref($query)->[0]->[0]); 

  my $dataGet=$sqliteDB->prepare("SELECT * FROM $sqliteTable WHERE $order > $psqlDt ORDER BY $order DESC");
  $dataGet->execute() or die "Couldn't execute the statement: ". $dataGet->errstr;

  while (my @data = $dataGet->fetchrow_array())
	{
  	my $insertData=$psqlDB->prepare(
		"INSERT INTO $psqlTable VALUES (to_timestamp(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
  		$insertData->execute($data[0],$data[3],$data[4],$data[5],$data[6],$data[7],$data[8],$data[9],$data[10],$data[11],$data[12],$data[13],$data[14],$data[15],$data[16],$data[17],$data[18],$data[19],$data[20],$data[21]) or die "Couldn't execute the statement: ". $insertData->errstr;
        }
}

