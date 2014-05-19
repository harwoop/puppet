# == Class: dynatrace-wsagent
class dynatrace-wsagent {

  package { 'cup-dynatrace-wsagent':
    ensure  => installed,
    require => Package['httpd'],
 }

  file { 'dynatrace.ini':
    path    => '/etc/php.d/dynatrace.ini',
    ensure  => file,
    require => Package['cup-dynatrace-wsagent'],
    source  => "puppet:///modules/dynatrace/dynatrace.ini",
  }

}

