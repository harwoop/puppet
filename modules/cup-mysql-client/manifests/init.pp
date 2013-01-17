# == Class: mysql-client
class mysql-client {
  package { 'mysql':
    ensure  => installed
  }
      
  file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
    require => Package['mysql'],
    source  => "puppet:///modules/cup-mysql-client/my.cnf",
  }


}
