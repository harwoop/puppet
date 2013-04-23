#!/usr/bin/perl 
#

use DBI;

my $db_username = "root";
my $db_password = "sh33pd0g";
my $backup_command = "/home/ec2-user/safesnap.sh /dev/xvdf daily";

# Get our cluster address before we drop out of the cluster
print "Connecting to local db\n";
my $mysql_dbh = DBI->connect("DBI:mysql:;host=127.0.0.1", $db_username, $db_password) or die "Failed to connect to db!";
my ($cluster_addr) = $mysql_dbh->selectrow_array(q{ SELECT @@wsrep_cluster_address });

print "Cluster peer is $cluster_addr, now disconnecting from cluster\n";
$mysql_dbh->do(q{ SET GLOBAL wsrep_cluster_address = "" });

print "Flusing and locking tables...\n";
$mysql_dbh->do(q{ SET GLOBAL wsrep_on ='OFF' });
$mysql_dbh->do(q{ FLUSH LOCAL TABLES WITH READ LOCK });

print "Staring snapshot process\n";
my $output = qx{ $backup_command };
print $output;

print "Unlocking tables...\n";
$mysql_dbh->do(q{ UNLOCK TABLES });
$mysql_dbh->do(q{ SET GLOBAL wsrep_on ='ON' });

print "Reconnecting to cluster peer $cluster_addr\n";
$mysql_dbh->do("SET GLOBAL wsrep_cluster_address = '$cluster_addr'");

