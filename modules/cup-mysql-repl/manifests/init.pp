class mysql-repl {
  include cup-mysql-client
  
	package { cup-mysql-repl:
    ensure  => installed
  }

	service { 'mysql':
    name => $service_name,
		ensure => running,
		enable => true,
    subscribe => File['my.cnf'],
	}

	file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
    require => Package['mysql'],
		source => 'puppet:///modules/mysql-repl/my.cnf',
	}
}
