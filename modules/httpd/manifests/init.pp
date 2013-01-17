# == Class: httpd
class httpd {
  
  package { 'httpd':
    ensure  => installed
  }
   
  service { 'httpd':
    name      => $service_name,
    ensure    => running,
    enable    => true,
    subscribe => File['httpd.conf'],
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

}
