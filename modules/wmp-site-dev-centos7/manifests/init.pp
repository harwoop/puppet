# == Class: wmp-site
class wmp-site-dev ( $mysql = undef, $nosql_master = undef, $nosql_slave = "localhost", $domain = "www.cambridge.org", $admin_node = false, $disable_ecommerce = false ) {
  include wmp-dirs

  package { 'subversion':
    ensure  => installed,
  } 

  package { 'php-soap':
    ensure  => installed,
  } 

#  package { 'cup-wmp-site':
#    ensure  => installed,
#    require => Package['httpd'],
#  } ~>
         
  file { 'data-httpd-wmp-dir':
    path    => '/data/httpd/wmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'data-logs-httpd-wmp-dir':
    path    => '/data/logs/httpd/wmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'data-httpd-wmp-tmp-dir':
    path    => '/data/httpd/wmp/tmp',
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
  } ~>

  file { 'mod-jk.conf':
    path    => '/etc/httpd/conf.d/mod_jk.conf',
    ensure  => file,
    content  => 'puppet:///modules/wmp-site-dev-centos7/mod_jk.conf',
  }

  file { 'mod-jk.so':
    path    => '/etc/httpd/modules/mod_jk.so',
    ensure  => file,
    content  => 'puppet:///modules/wmp-site-dev-centos7/mod_jk.so',
  }

  file { 'wmp.conf':
    path    => '/etc/httpd/conf.d/wmp.conf',
    ensure  => file,
    content => template("wmp-site-dev/wmp.conf.erb"),
    require => File['mod-jk.conf'],
    notify  => Service['httpd_24'],
  }

  group { 'maniladevgrp':
    name => 'maniladev',
    gid => '501',
    ensure => present,
  }

  user { 'maniladev':
    ensure => present,
    uid => '500',
    gid => 'maniladev',
    home => '/home/maniladev',
    require => Group['maniladevgrp'],
  }

  file { 'maniladev-home':
    path => '/home/maniladev',
    ensure => directory,
    owner => 'maniladev',
    group => 'maniladev',
    mode => '0755',
    require => User['maniladev'],
  }

  file { 'maniladev-ssh':
    path => '/home/maniladev/.ssh',
    ensure => directory,
    owner => 'maniladev',
    group => 'maniladev',
    mode => '0700',
    require => File['maniladev-home'],
  }

  file { 'maniladev-ssh-key':
    path => '/home/maniladev/.ssh/authorized_keys',
    ensure => file,
    owner => 'maniladev',
    group => 'maniladev',
    mode => '0600',
    content => template("wmp-site-dev/authorized_keys.erb"),
    require => File['maniladev-ssh'],
  }

  group { 'voyeurgrp':
    name => 'voyeur',
    gid => '1005',
    ensure => present,
  }

  user { 'voyeur':
    ensure => present,
    uid => '1005',
    gid => 'voyeur',
    home => '/home/voyeur',
    require => Group['voyeurgrp'],
  }

  file { 'voyeur-home':
    path => '/home/voyeur',
    ensure => directory,
    owner => 'voyeur',
    group => 'voyeur',
    mode => '0755',
    require => User['voyeur'],
  }

  file { 'voyeur-ssh':
    path => '/home/voyeur/.ssh',
    ensure => directory,
    owner => 'voyeur',
    group => 'voyeur',
    mode => '0700',
    require => File['voyeur-home'],
  }

  file { 'voyeur-ssh-key':
    path => '/home/voyeur/.ssh/authorized_keys',
    ensure => file,
    owner => 'voyeur',
    group => 'voyeur',
    mode => '0600',
    content => template("wmp-site-dev/voyeur_authorized_keys.erb"),
    require => File['voyeur-ssh'],
  }

  cron { "clear-tomcat-logs":
          command => "find /data/tomcat/logs/ -mtime +14 -delete > /dev/null 2>&1",
          user => "root",
          hour => 2,
          minute => 5,
          ensure => present,
  }

  cron { "zip-tomcat-logs":
          command => "find /data/tomcat/logs/ -mtime +1 -exec gzip {} \; > /dev/null 2>&1",
          user => "root",
          hour => 2,
          minute => 15,
          ensure => present,
  }
}
