# == Class: mod-pagespeed
class mod-pagespeed {

  package { 'mod-pagespeed-stable':
    ensure  => installed,
    require => Package['httpd'],
  } ~>

  file { 'pagespeed.conf':
    path    => '/etc/httpd/conf.d/pagespeed.conf',
    ensure  => file,
    source  => "puppet:///modules/mod-pagespeed/pagespeed.conf",
    notify  => Service["httpd"],
  }

}
