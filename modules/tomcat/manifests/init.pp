# == Class: tomcat
class tomcat ( $minmem = undef, $permgen = undef ) {
  
  if $minmem == undef {
    $minmem_opt = '2048m'
  } else {
    $minmem_opt = $minmem
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
