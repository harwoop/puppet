# Class: rsyslog::client::setup
#
# This class installs rsyslog
#
# Parameters:
#  [*syslogserver*]   - Syslog FQDN for the client
#  [*enable_tcp*]     - Boolean determining whether you want to
#                       have TCP communication enabled.
#  [*tcp_port*]       - TCP port used by the client
#  [*enable_udp*]     - Boolean determining whether you want to
#                       have UDP communication enabled.
#  [*udp_port*]       - UDP port used by the client
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::client::setup':
#   syslogserver => 'syslog.example.internal',
#   tcp_enable   => true,
#   tcp_port     => '514',
#   udp_enable   => false
# }
class rsyslog::client::setup(
  $syslogserver = undef,
  $tcp_enable   = $rsyslog::params::tcp_enabled,
  $tcp_port     = $rsyslog::params::tcp_port,
  $udp_enable   = $rsyslog::params::udp_enabled,
  $udp_port     = $rsyslog::params::udp_port
) {
  require rsyslog::params
  class { 'rsyslog::install': }
  class { 'rsyslog::service': }

  file { "${rsyslog::params::syslog_config}":
    ensure   => file,
    backup   => true,
    owner    => 'root',
    group    => 'root',
    mode     => '0750',
    checksum => md5,
    content  => template('rsyslog/rsyslog.conf.erb'),
    require  => Class['rsyslog::install'],
    notify   => Class['rsyslog::service']
  }
}