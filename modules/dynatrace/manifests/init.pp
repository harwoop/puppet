# == Class: dynatrace_wsagent
class dynatrace-wsagent {

  package { 'cup-dynatrace_wsagent':
    ensure  => installed,
    require => Package['httpd'],
 }
}

