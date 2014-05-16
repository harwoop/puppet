# == Class: dynatrace_wsagent
class dynatrace_wsagent {

  package { 'cup-dynatrace-wsagent':
    ensure  => installed,
    require => Package['httpd'],
 }
}

