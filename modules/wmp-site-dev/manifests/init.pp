# == Class: wmp-site
class wmp-site-dev ( $mysql = undef, $nosql_master = undef, $nosql_slave = "localhost", $domain = "www.cambridge.org", $admin_node = false, $disable_ecommerce = false ) {
  include wmp-dirs

  package { 'subversion':
    ensure  => installed,
  } 

  package { 'php-soap':
    ensure  => installed,
  } 

  package { 'cup-wmp-site':
    ensure  => installed,
    require => Package['httpd'],
  } ~>
         
  file { 'data-httpd-wmp-dir':
    path    => '/data/httpd/wmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'data-logs-httpd-wmp-dir':
    path    => '/data/logs/httpd/wmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'data-httpd-wmp-tmp-dir':
    path    => '/data/httpd/wmp/tmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'wmp.conf':
    path    => '/etc/httpd/conf.d/wmp.conf',
    ensure  => file,
    content  => template("wmp-site-dev/wmp.conf.erb"),
    notify  => Service['httpd'],
  }

}
