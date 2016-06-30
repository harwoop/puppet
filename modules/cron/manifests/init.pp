class cron {
        $minute1 = generate('/usr/bin/env', 'sh', '-c',  'printf $((RANDOM%30+0))')
        $minute2 = $minute1 + 30
        $minute3 = $minute1 + 15
	$minute4 = $minute1 + 18

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

        file { 'puppet_clientbucket_cleanup.sh':
    		path   => '/usr/local/bin/puppet_clientbucket_cleanup.sh',
    		ensure => present,
    		mode   => 750,
    		source => "puppet:///modules/cron/puppet_clientbucket_cleanup.sh",
  	} 

        cron { "puppet-clear-log-dirs":
                command => "/usr/local/bin/puppet_clientbucket_cleanup.sh >2&1",
                user => "root",
                hour => 5,
                minute => $minute4,
                ensure => present,
        }

        cron { "puppet-clear-logs":
                command => "/usr/bin/find /var/lib/puppet/clientbucket/ -mtime +14 -atime +14 -delete > /dev/null 2>&1",
                user => "root",
                hour => 5,
                minute => $minute3,
                ensure => present,
        }

       file { '/etc/cron.deny':
       ensure => 'present',
       mode    => '0644',
       source => "puppet:///modules/cron/cron.deny",
       }
       file    { '/etc/at.deny':
       ensure => 'present',
       mode    => '0644',
       source => "puppet:///modules/cron/at.deny",
}
}

