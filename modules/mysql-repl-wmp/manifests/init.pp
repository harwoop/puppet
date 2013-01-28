class mysql-repl-wmp {
 
	package { cup-mysql-repl-wmp:
    ensure  => installed
  } ->

	file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
		source => 'puppet:///modules/mysql-conf/my.cnf',
	} ~>

	service { 'mysql':
    name => $service_name,
		ensure => running,
		enable => true,
	}

}
