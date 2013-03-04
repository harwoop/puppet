# Class: rsyslog::params
#
#   This class provides parameters for all other classes in the rsyslog
#   module.  This class should be inherited or marked as required.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::params': }
# or
# require rsyslog::params
#
class rsyslog::params {
  $syslogserver = undef
  $tcp_port     = '514'
  $udp_port     = '514'
  $enabled      = true
  $storeconfigs = $settings::storeconfigs
  $tcp_enabled  = false
  $udp_enabled  = false
  $logpath      = '/var/log/syslog'

  case $::osfamily {
    RedHat: {
      $syslog_config = '/etc/rsyslog.conf'
      $extsyslog_dir = '/etc/rsyslog.conf.d'
      $packagename   = 'rsyslog'
      $svc_name      = 'rsyslog'
    }
    Debian: {
      $syslog_config = '/etc/rsyslog.conf'
      $extsyslog_dir = '/etc/rsyslog.conf.d'
      $packagename   = 'rsyslog'
      $svc_name      = 'rsyslog'
    }
    default: {
      fail("${module_name} supports osfamily's RedHat and Debian.")
    }
  }
}