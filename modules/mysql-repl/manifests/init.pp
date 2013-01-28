class mysql-repl {
  include mysql-client
  include mysql-conf
 
	package { cup-mysql-repl:
    ensure  => installed
  }

	service { 'mysql':
    name => $service_name,
		ensure => running,
		enable => true,
    subscribe => File['my.cnf'],
	}
}
