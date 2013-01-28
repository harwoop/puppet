# == Class: mysql-client
class mysql-client {
  include 'mysql-conf'

  package { 'mysql':
    ensure  => installed
  }
}
