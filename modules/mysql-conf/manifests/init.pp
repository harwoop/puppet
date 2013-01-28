class mysql-conf {

	file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
		source => 'puppet:///modules/mysql-conf/my.cnf',
	}
}
