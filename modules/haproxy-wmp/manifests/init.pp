# == Class: haproxy-wmp
class haproxy-wmp {
 
  class { 'haproxy':
    enable           => true,
    global_options   => {
      'log'     =>  ["127.0.0.1 local0", "127.0.0.1 local1 notice"],
      'chroot'  => '/var/lib/haproxy',
      'pidfile' => '/var/run/haproxy.pid',
      'maxconn' => '4096',
      'user'    => 'haproxy',
      'group'   => 'haproxy',
      'daemon'  => '',
      'stats'   => 'socket /var/lib/haproxy/stats'
    },
    defaults_options => {
      'log'     => 'global',
      'stats'   => 'enable',
      'option'  => ['redispatch', 'dontlognull', 'tcplog'],
      'retries' => '3',
      'timeout' => [
        'http-request 10s',
        'queue 1m',
        'connect 10s',
        'client 1m',
        'server 1m',
        'check 10s'
      ],
      'maxconn' => '8000',
      'contimeout' => '5000',
      'clitimeout' => '50000',
      'srvtimeout' => '50000',
    },
  }

  haproxy::listen { 'mysql-cluster':
    ipaddress => $::ipaddress,
    ports     => '3306',
    options   => {
      'mode'      => 'tcp',
      'balance'   => 'roundrobin',
      'stick-table' => 'type ip size 1k expire 60m',
      'stick'     => 'on src',
      'option'    => 'httpchk',
    }
  }

  haproxy::listen { 'stats-listener':
    ipaddress => $::ipaddress,
    ports     => '80',
    options   => {
      'mode'      => 'http',
      'balance'   =>  'roundrobin',
      'stats'     => ['uri /haproxy/stats', 'auth stats:cupadmin123'],
    }
  }

}
