# Define: rsyslog::client::imfile
#
# This module manages custom files being pushed through rsyslog via
# imfile module.
#
# Parameters:
#  [*logfilename*]  - full path of file you wish to monitor in rsyslog
#  [*filetag*]      -
#  [*statefile*]    -
#  [*severity*]     -
#  [*factility*]    -
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  rsyslog::client::imfile { 'mcollective_imfile':
#    logfilename => '/var/log/mcollective.log',
#    filetag     => 'mcollective',
#    statefile   => 'mcollective_state'
#  }
#
define rsyslog::client::imfile(
  $logfilename       = undef,
  $filetag           = undef,
  $statefile         = undef,
  $severity          = 'debug',
  $factility         = 'local3',
) {
  require rsyslog::params

  if $logfilename == undef { fail('logfilename not set.') }
  if $filetag == undef { fail('filetag not set.') }
  if $statefile == undef { fail('statefile not set.') }

  $extsyslog_dir = $rsyslog::params::extsyslog_dir
  file { "${extsyslog_dir}/${filetag}":
    ensure  => file,
    path    => "${extsyslog_dir}/${filetag}.conf",
    backup  => false,
    content => template('rsyslog/imfile.conf.erb'),
    require => Class['rsyslog::install'],
    notify  => Class['rsyslog::service'],
  }
}
