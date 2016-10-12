# == Class: httpd
class httpd_24 {
  include wmp-dirs
  
  package { 'httpd':
    ensure  => installed
  }
   
  service { 'httpd':
    name      => 'httpd',
    ensure    => running,
    enable    => true,
    subscribe => File['httpd.conf'],
  }

  file { 'httpd.conf':
    path    => '/etc/httpd/conf/httpd.conf',
    ensure  => file,
    require => Package['httpd'],
    source  => "puppet:///modules/httpd_24/httpd.conf",
  }

  file { 'welcome.conf':
    path    => '/etc/httpd/conf.d/welcome.conf',
    ensure  => absent,
    require => Package['httpd'],
  }

  file { 'data-logs-httpd-dir':
    path    => '/data/logs/httpd',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  }

  file { 'httpdir':
    path    => '/etc/httpd',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0750',
  }

  file { 'httpconfdir':
    path    => '/etc/httpd/conf',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0750',
  }

  file { 'httpconfddir':
    path    => '/etc/httpd/conf.d',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0750',
  }

  file { 'httpbindir':
    path    => '/etc/httpd/bin',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0750',
  }

}
