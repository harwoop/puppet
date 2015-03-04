class dba-admin {

  group { 'dba-admingrp':
    name => 'dba-admin',
    gid => '571',
    ensure => present,
  }

  user { 'dba-admin':
    ensure => present,
    uid => '570',
    gid => 'dba-admin',
    home => '/home/dba-admin',
    require => Group['dba-admingrp'],
  }

  file { 'dba-admin-home':
    path => '/home/dba-admin',
    ensure => directory,
    owner => 'dba-admin',
    group => 'dba-admin',
    mode => '0755',
    require => User['dba-admin'],
  }

  file { 'dba-admin-ssh':
    path => '/home/dba-admin/.ssh',
    ensure => directory,
    owner => 'dba-admin',
    group => 'dba-admin',
    mode => '0700',
    require => File['dba-admin-home'],
  }

  file { 'dba-admin-ssh-key':
    path => '/home/dba-admin/.ssh/authorized_keys',
    ensure => file,
    owner => 'dba-admin',
    group => 'dba-admin',
    mode => '0600',
    source  => "puppet:///modules/dba-admin/authorized_keys",
    require => File['dba-admin-ssh'],
  }

  file { 'mysql-log-dir':
    path => '/data/logs/mysql',
    ensure => directory,
    recurse => true,
    mode => '0765',
  }

  file { 'var-log-messages':
    path => '/var/log/messages',
    ensure => file,
    mode => '0644',
  }

}
