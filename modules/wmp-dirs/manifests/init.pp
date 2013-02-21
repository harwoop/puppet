class wmp-dirs {
  file { 'wmp-data-dir':
    path    => '/data/',
    ensure  => directory,
    mode    => '0755',
  } ~>

  file { 'wmp-log-dir':
    path    => '/data/logs/',
    ensure  => directory,
    mode    => '0755',
  }
}
