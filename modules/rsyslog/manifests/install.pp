# Class: rsyslog::install
#
# This class installs rsyslog package
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::install': }
#
class rsyslog::install {
  require rsyslog::params
  package { $rsyslog::params::packagename:
    ensure => present,
  }

  $extsyslog_dir = $rsyslog::params::extsyslog_dir
  file { $extsyslog_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750'
  }
}
