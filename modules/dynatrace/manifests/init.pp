# == Class: dynatrace-wsagent
class dynatrace-wsagent {

  package { 'cup-dynatrace-wsagent':
    ensure  => installed,
    require => Package['httpd'],
 }


