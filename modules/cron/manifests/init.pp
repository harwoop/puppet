class cron {
        $minute1 = generate('/usr/bin/env', 'sh', '-c',  'printf $((RANDOM%30+0))')
        $minute2 = $minute1 + 30
        $minute3 = $minute1 + 15

        cron { "manual-puppet":
                command => "/usr/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1",
                user => "root",
                hour => "*",
                minute => [$minute1, $minute2],
                ensure => present,
        }

        service { "puppet":
		ensure => stopped,
		enable => false,
	}

        cron { "puppet-clear-logs":
                command => "/usr/bin/find /var/lib/puppet/clientbucket/ -mtime +14 -atime +14 -delete > /dev/null 2>&1",
                user => "root",
                hour => 5,
                minute => $minute3,
                ensure => present,
        }
}

