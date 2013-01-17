# == Class: wmp-site
class wmp-site {
  package { 'cup-wmp-site':
    ensure  => installed,
    require => Package['httpd'],
  }
         
  file { 'wmp.conf':
    path    => '/etc/httpd/conf.d/wmp.conf',
    ensure  => file,
    require => Package['cup-wmp-site'],
    source  => "puppet:///modules/wmp-site/wmp.conf",
  }

}
