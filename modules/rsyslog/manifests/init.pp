# == Class: rsyslog
#
# This module manages rsyslog
#
# Parameters:
#  [*enabled*]      - Boolean determining whether you want to
#                     install or setup rsyslog as a client or server
#  [*server*]       - Boolean determining whether you would like to
#                     install and setup the server component.
#  [*client*]       - Boolean determining whether you would like to
#                     install and setup the client component.
#  [*syslogserver*] - Syslog FQDN for the client
#  [*tcp_enable*]   - Boolean determining whether you want to
#                     have TCP communication enabled.
#  [*udp_enable*]   - Boolean determining whether you want to
#                     have UDP communication enabled.
#  [*tcp_port*]     - TCP port used by the server/client
#  [*udp_port*]     - UDP port used by the server/client
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog':
#    enabled      => true,
#    server       => true,
#    tcp_port     => "514",
#    tcp_enable   => true
#  }
#
class rsyslog(
  $enabled      = $rsyslog::params::enabled,
  $server       = false,
  $client       = $server ? {
    true    => false,
    false   => true,
    default => true
    },
  $syslogserver = undef,
  $tcp_enable   = $rsyslog::params::tcp_enabled,
  $udp_enable   = $rsyslog::params::udp_enabled,
  $tcp_port     = $rsyslog::params::tcp_port,
  $udp_port     = $rsyslog::params::udp_port
) {
  require rsyslog::params
  if $enabled == false {
    notify {'client or server parameter needs to be declared.':}
  } else {
    if $server == true {
      class { 'rsyslog::server::setup':
        tcp_enable => $tcp_enable,
        udp_enable => $udp_enable,
      }
    } else {
      if $syslogserver == undef {
        warning('No syslog server defined, will setup stand alone config')
      } else {
        class { 'rsyslog::client::setup':
          syslogserver => $syslogserver,
          tcp_enable   => $tcp_enable,
          udp_enable   => $udp_enable
        }
      }
    }
  }
}