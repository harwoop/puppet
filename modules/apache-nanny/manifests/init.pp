# == Class: apache-nanny
class apache-nanny {

  package { 'mailx':
    ensure  => installed,
  }

  file { '/app/scripts':
    ensure => directory,
    mode => '0755',
  }

  file { 'apache-nanny.sh':
    path    => '/app/scripts/apache-nanny.sh',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    source  => "puppet:///modules/apache-nanny/apache-nanny.sh",
  }

  file { 'nanny':
    path    => '/etc/logrotate.d/nanny',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/apache-nanny/nanny",
  }

        cron { "apache-nanny":
                command => "/app/scripts/apache-nanny.sh > /dev/null 2>&1",
                user => "root",
                hour => "*",
                minute => "*/5",
                ensure => present,
        }
}
