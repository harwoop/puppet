class wmp-site-admin-jobs {
  
  file { 'update_jobs.sh':
    path   => '/usr/local/bin/update_jobs.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/update_jobs.sh",
  } ~>

  cron { 'update_jobs_cron':
    command => '/usr/local/bin/update_jobs.sh > /dev/null 2>&1',
    ensure  => present,
    user    => root,
    hour    => 07,
    minute  => 00,
    month => absent,
    monthday => absent,
    weekday => absent,
  }

  file { 'full_import.sh':
    path   => '/usr/local/bin/full_import.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/full_import.sh",
  } ~>

  file { 'monthly_reports.sh':
    path   => '/usr/local/bin/monthly_reports.sh',
    ensure => present,
    mode   => 750,
    source => "puppet:///modules/wmp-site-admin-jobs/monthly_reports.sh",
  } ~>

  cron { 'monthly_reports':
    command => '/usr/local/bin/monthly_reports.sh > /dev/null 2>&1',
    ensure  => present,
    user    => root,
    weekday => absent,
    hour    => 03,
    minute  => 00,
    month => absent,
    monthday => 01,
  }

  cron { 'full_import_cron':
    command => '/usr/local/bin/full_import.sh > /dev/null 2>&1',
    ensure  => absent,
    user    => root,
    weekday => 6,
    hour    => 15,
    minute  => 00,
    month => absent,
    monthday => absent,
  }

  file { 'weekly_jobs.sh':
    path   => '/usr/local/bin/weekly_jobs.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/weekly_jobs.sh",
  } ~>

  file { 'monthly_jobs.sh':
    path   => '/usr/local/bin/monthly_jobs.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/monthly_jobs.sh",
  } ~>

  cron { 'monthly_jobs':
    command => '/usr/local/bin/monthly_jobs.sh > /dev/null 2>&1',
    ensure  => present,
    user    => root,
    weekday => absent,
    hour    => 00,
    minute  => 00,
    month => absent,
    monthday => 01,
  }

  cron { 'weekly_jobs':
    command => '/usr/local/bin/weekly_jobs.sh > /dev/null 2>&1',
    ensure  => present,
    user    => root,
    weekday => 01,
    hour    => 00,
    minute  => 00,
    month => absent,
    monthday => absent,
  }


  file { 'spirit_signups.sh':
    path   => '/usr/local/bin/spirit_signups.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/spirit_signups.sh",
  } ~>

  cron { 'spirit_signups':
    command => '/usr/local/bin/spirit_signups.sh > /dev/null 2>&1',
    ensure  => present,
    user    => root,
    hour    => absent,
    minute  => '*/15',
    month => absent,
    monthday => absent,
    weekday => absent,
  }

}
