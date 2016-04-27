# == Class: wmp-admin-keys 
class wmp-admin-keys {
  
  file { 'wyvern.ppk':
    path    => '/etc/ssl/certs/wyvern.ppk',
    ensure  => file,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0400',
    source  => "puppet:///modules/wmp-admin-keys/wyvern.ppk",
  }

}
