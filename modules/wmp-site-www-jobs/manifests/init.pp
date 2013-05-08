class wmp-site-www-jobs {
  
  cron { 'sitemap_cron':
    command => "/usr/bin/curl 'http://localhost/tools/required/jobs?auth=5de4e738ecc1fe2bf2ba5120d45c956d&jID=22' > /dev/null 2>&1",
    user    => root,
    hour    => 5,
    minute  => 25,
  }

}
