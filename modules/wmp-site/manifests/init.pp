# == Class: wmp-site
class wmp-site ( $mysql = undef ) {
  include wmp-dirs

#  package { 'cup-wmp-site':
#    ensure  => installed,
#    require => Package['httpd'],
#  } ~>
         
  file { 'data-logs-httpd-wmp-dir':
    path    => '/data/logs/httpd/wmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'wmp.conf':
    path    => '/etc/httpd/conf.d/wmp.conf',
    ensure  => file,
    content  => template("wmp-site/wmp.conf.erb"),
  }

}
