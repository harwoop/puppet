# == Class: mariabb-client
class mariadb-client {
  include 'mariadb-conf'

  package { 'mariadb':
    ensure  => installed
  }

 service { 'mariadb':
    name      => 'mysqld',
    ensure    => running,
    enable    => true,
  }

}
