class mysql-check {
  
  package { xinetd:
    ensure  => installed
  }

  service { 'xinetd':
    ensure => running,
    enable => true,
  }

  file { 'clustercheck':
    path    => '/usr/local/bin/clustercheck',
    ensure  => file,
    mode    => 755,
    source => 'puppet:///modules/mysql-check/clustercheck',
  }

  file { 'mysqlchk':
    path    => '/etc/xinetd.d/mysqlchk',
    ensure  => file,
    source => 'puppet:///modules/mysql-check/mysqlchk',
    notify => Service["xinetd"],
  }

  augeas{ "service for mysqlchk" : 
    context => "/files/etc/services",
    changes => [ 
        "set service-name[. = 'mysqlchk'] mysqlchk",
        "set service-name[. = 'mysqlchk']/port 9200",
        "set service-name[. = 'mysqlchk']/protocol tcp",
        "set service-name[. = 'mysqlchk']/#comment 'MySQL server status via http'",
    ],
  } 
}
