# == Class: httpd
class httpd {
  include wmp-dirs
  
  package { 'httpd':
    ensure  => installed
  }
   
  service { 'httpd':
    name      => 'httpd',
    ensure    => running,
    enable    => true,
    subscribe => [ File['httpd.conf'], File['modules/mod-pagespeed/files/pagespeed.conf'], ],
  }
      
  file { 'httpd.conf':
    path    => '/etc/httpd/conf/httpd.conf',
    ensure  => file,
    require => Package['httpd'],
    source  => "puppet:///modules/httpd/httpd.conf",
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
