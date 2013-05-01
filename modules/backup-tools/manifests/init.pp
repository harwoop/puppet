# == Class: backup-tools 
class backup-tools {
  
  package { 'perl-DBD-MySQL':
    ensure  => installed,
  }

  file { 'safesnap.sh':
    path    => '/usr/local/bin/safesnap.sh',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/backup-tools/safesnap.sh",
  }

  file { 'snap_galera.pl':
    path    => '/usr/local/bin/snap_galera.pl',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/backup-tools/snap_galera.pl",
  }

}
