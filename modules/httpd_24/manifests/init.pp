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
}
