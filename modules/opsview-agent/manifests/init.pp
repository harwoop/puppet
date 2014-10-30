class opsview-agent {

  package { 'opsview-agent':
    ensure => installed,
  } ~>

  service { 'opsview-agent':
    name      => 'opsview-agent',
    ensure    => running,
    enable    => true,
    subscribe => File['extra.cfg'],
  }

  file { 'extra.cfg':
    path => '/usr/local/nagios/etc/nrpe_local/extra.cfg',
    ensure => file,
    owner => "nagios",
    group => "nagios",
    mode => 555,
    source => 'puppet:///modules/opsview-agent/extra.cfg',
    require => Package['opsview-agent'],
  }

  file { 'nagios_sudo':
    path => '/etc/sudoers.d/nagios_sudo',
    ensure => file,
    owner => "root",
    group => "root",
    mode => 400,
    source => 'puppet:///modules/opsview-agent/nagios_sudo',
    require => Package['opsview-agent'],
  }

  file { 'check_gluster.pl':
    path => '/usr/local/nagios/libexec/check_gluster.pl',
    ensure => file,
    owner => "nagios",
    group => "nagios",
    mode => 770,
    source => 'puppet:///modules/opsview-agent/check_gluster.pl',
    require => Package['opsview-agent'],
  }

  file { 'check_puppet_agent':
    path => '/usr/local/nagios/libexec/check_puppet_agent',
    ensure => file,
    owner => "nagios",
    group => "nagios",
    mode => 770,
    source => 'puppet:///modules/opsview-agent/check_puppet_agent',
    require => Package['opsview-agent'],
  }

}
