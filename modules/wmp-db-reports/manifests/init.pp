class wmp-db-reports {

  package { 'perl-MIME-Lite':
    ensure => installed,
  } ~>

  file { 'alerts_report_daily':
    path   => '/usr/local/bin/alerts_report_daily',
    ensure => present,
    mode   => 700,
    source => "puppet:///modules/wmp-db-reports/alerts_report_daily",
  } ~>

  file { 'alerts_report_weekly':
    path   => '/usr/local/bin/alerts_report_weekly',
    ensure => present,
    mode   => 700,
    source => "puppet:///modules/wmp-db-reports/alerts_report_weekly",
  } ~>

  cron { 'alerts_report_daily':
    command => '/usr/local/bin/alerts_report_daily > /dev/null 2>&1',
    user    => root,
    hour    => 3,
    minute  => 30,
    weekday => '0-5',
  } ~>

  cron { 'alerts_report_weekly':
    command => '/usr/local/bin/alerts_report_weekly > /dev/null 2>&1',
    user    => root,
    hour    => 3,
    minute  => 30,
    weekday => 6,
  }

}
