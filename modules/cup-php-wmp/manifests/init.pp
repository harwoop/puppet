# == Class: php-wmp
class php-wmp {

  package { 'php':
    ensure  => installed
  }

  file { 'php.ini':
    path    => '/etc/php.ini',
    ensure  => file,
    require => Package['php'],
    source  => "puppet:///modules/cup-php-wmp/php.ini",
  }

  package { 'php-mysql':
    ensure  => installed
  }

  package { 'php-mbstring':
    ensure  => installed
  }

  package { 'php-pecl-apc':
    ensure  => installed
  }

  file { 'apc.ini':
    path    => '/etc/php.d/apc.ini',
    ensure  => file,
    require => Package['php-pecl-apc'],
    source  => "puppet:///modules/cup-php-wmp/apc.ini",
  }

  package { 'php-intl':
    ensure  => installed
  }

  package { 'php-devel':
    ensure  => installed
  }

  package { 'curl':
    ensure  => installed
  }

}
