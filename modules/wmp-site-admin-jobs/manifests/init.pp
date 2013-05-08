class wmp-site-admin-jobs {
  
  file { 'update_jobs.sh':
    path   => '/usr/local/bin/update_jobs.sh',
    ensure => present,
    mode   => 755,
    source => "puppet:///modules/wmp-site-admin-jobs/update_jobs.sh",
  } ~>

  cron { 'update_jobs_cron':
    command => '/usr/local/bin/update_jobs.sh > /dev/null 2>&1',
    user    => root,
    hour    => 4,
    minute  => 25,
  }

}
