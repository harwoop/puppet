class mysql-repl-wmp {
#  include haproxy

  package { cup-mysql-repl-wmp:
    ensure  => installed
  } ~>

# NB: Do not create a service dependency between my.cnf and mysqld
# NB: If you do, all nodes will be restarted which may bring down the cluster
  file { 'my.cnf':
    path    => '/etc/my.cnf',
    ensure  => file,
    source => 'puppet:///modules/mysql-repl-wmp/my.cnf',
  }
# NB: Seriously, don't do it

  service { 'mysql':
    name => 'mysql',
    ensure => running,
    enable => true,
  } 

  @@haproxy::balancermember { $hostname:
    listening_service => 'mysql-cluster',
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
    ports             => '3306',
    options           => 'check port 9200 inter 12000 rise 3 fall 3'
  }
}
