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

  package { 'php-mysqlnd':
    ensure  => installed,
    require => Package['php'],      
  }

  package { 'php-mbstring':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'php-gd':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'php-xml':
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

  package { 'cup-php-pecl-mongo':
    ensure  => installed,
    require => Package['php'],
  }

  package { 'cup-php-pecl-mysqlnd_qc':
    ensure  => installed,
    require => Package['php-mysqlnd'],
  } ~>

  file { 'mysqlnd_qc.ini':
    path    => '/etc/php.d/mysqlnd_qc.ini',
    ensure  => file,
    source  => "puppet:///modules/php-wmp/mysqlnd_qc.ini",
  }


}
