# == Class: mariabb-client
class mariadb-client {
  include 'mariadb-conf'

  package { 'mariadb':
    ensure  => installed
  }
}
