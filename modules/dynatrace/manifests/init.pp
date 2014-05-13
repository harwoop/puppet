# == Class: dynatrace
##????class php-wmp ($mysql_cache_enabled = true, $apc_cache_size = "128M") {

  package { 'dynatrace':
#    ensure  => installed,
#    require => Package['httpd'],
#  }

  file { 'dynatrace.conf':
    path    => '/etc/httpd/conf.d/php.conf',
    ensure  => file,
    require => Package['dynatrace'],
    source  => "puppet:///modules/dynatrace/dynatrace.conf",
  }

}
