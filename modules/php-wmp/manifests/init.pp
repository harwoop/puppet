# == Class: php-wmp
class php-wmp {

  package { 'php':
    ensure  => installed,
    require => Package['httpd'],
  }

  file { 'php.ini':
    path    => '/etc/php.ini',
    ensure  => file,
    require => Package['php'],
    source  => "puppet:///modules/php-wmp/php.ini",
  }

  package { 'php-mysql':
    ensure  => installed,
    require => Package['php'],      
  }

  package { 'php-mbstring':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'php-pecl-apc':
    ensure  => installed,
    require => Package['php'],
  }

  file { 'apc.ini':
    path    => '/etc/php.d/apc.ini',
    ensure  => file,
    require => Package['php-pecl-apc'],
    source  => "puppet:///modules/php-wmp/apc.ini",
  }

  package { 'php-intl':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'php-devel':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'curl':
    ensure  => installed,
    require => Package['php'],
  }

}
