# == Class: tomcat
class tomcat ( $minmem = undef, $maxmem = undef, $permgen = undef ) {
  
  if $minmem == undef {
    $minmem_opt = '4096m'
  } else {
    $minmem_opt = $minmem
  }
  
  if $maxmem == undef {
    $maxmem_opt = '4096m'
  } else {
    $maxmem_opt = $maxmem
  }

  if $permgen == undef {
    $permgen_opt = '512m'
  } else {
    $permgen_opt = $permgen
  }

  package { 'cup-jre':
    ensure => installed,
  } ~>

  package { 'cup-apache-tomcat':
    ensure  => installed
  } ~>
   
  file { 'setenv.sh':
    path    => '/data/tomcat/bin/setenv.sh',
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0755',
    content  => template('tomcat/setenv.sh.erb')
  } ~>

  service { 'tomcat':
    name      => 'tomcat',
    ensure    => running,
    enable    => true,
  }
      
}
