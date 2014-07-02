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

  file { 'librarians_report_monthly':
    path   => '/usr/local/bin/librarians_report_monthly',
    ensure => present,
    mode   => 700,
    source => "puppet:///modules/wmp-db-reports/librarians_report_monthly",
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
  } ~>

  cron { 'librarians_report_monthly':
    command => '/usr/local/bin/librarians_report_monthly > /dev/null 2>&1',
    user    => root,
    hour    => 1,
    minute  => 0,
    monthday => 1,
  }
}
