# == Class: php-wmp
class php-wmp ($mysql_cache_enabled = true, $apc_cache_size = "128M") {

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

  file { 'php.conf':
    path    => '/etc/httpd/conf.d/php.conf',
    ensure  => file,
    require => Package['php'],
    source  => "puppet:///modules/php-wmp/php.conf",
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
    content  => template("php-wmp/apc.ini.erb"),
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
    content  => template("php-wmp/mysqlnd_qc.ini.erb"),
  }


}
