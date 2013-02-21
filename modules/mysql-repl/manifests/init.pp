class mysql-repl {
  include mysql-conf
 
  package { cup-mysql-repl:
    ensure  => installed
  }

  service { 'mysql':
    name => 'mysql',
    ensure => running,
    enable => true,
    subscribe => File['my.cnf'],
  }
}
