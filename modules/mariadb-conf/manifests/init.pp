class mariadb-conf {

	file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
		source => 'puppet:///modules/mariadb-conf/my.cnf',
	}
}
