class puppetkick {
        cron { "manual-puppet":
                command => "/usr/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1",
                user => "root",
                hour => "*",
                minute => "*",
                ensure => present,
        }

        service { "puppet":
                ensure => stopped,
                enable => false,
        }
}
