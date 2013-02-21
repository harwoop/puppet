# == Class: mongo-wmp
class mongo-wmp {
  
  include wmp-dirs

  package { 'mongo-10gen':
    ensure  => installed
  }
   
  package { 'mongo-10gen-server':
    ensure  => installed
  }
   
  service { 'mongod':
    name      => 'mongod',
    ensure    => running,
    enable    => true,
    subscribe => File['mongod.conf'],
  }
      
  file { 'mongod.conf':
    path    => '/etc/mongod.conf',
    ensure  => file,
    require => Package['mongo-10gen-server'],
    source  => "puppet:///modules/mongo-wmp/mongod.conf",
  }

  file { '/data/mongo':
    path    => '/data/mongo',
    ensure  => directory,
    owner   => 'mongod',
    group   => 'mongod',
    mode    => '0744',
    require => Package['mongo-10gen-server'],
  } ~>

  file { '/data/logs/mongo':
    path    => '/data/logs/mongo',
    ensure  => directory,
    owner   => 'mongod',
    group   => 'mongod',
    mode    => '0744',
  }
}
