class opsview-slave {
  
  package { 'httpd':
    ensure => installed,
  }

  package { 'net-snmp':
    ensure => installed,
  }

  package { 'openldap':
    ensure => installed,
  }

  package { 'libmcrypt':
    ensure => installed,
  }

  package { 'gd':
    ensure => installed,
  }

  package { 'mrtg':
    ensure => installed,
  }

  package { 'expat':
    ensure => installed,
  }

  package { 'rrdtool':
    ensure => installed,
  }

  package { 'rrdtool-perl':
    ensure => installed,
  }

  package { 'mysql51-libs':
    ensure => installed,
  }

  exec { "install pymongo for nagios checks":
    creates => "/usr/lib/python2.6/site-packages/pymongo-2.5-py2.6-linux-x86_64.egg",
    cwd => "/root",
    command => "/usr/bin/easy_install pymongo==2.5",
    user => "root",
    logoutput => on_failure,
  }

  group { "nagios":
    ensure => present,
    gid => 1000
  } ~>

  group { "nagcmd":
    ensure => present,
    gid => 1001
  } ~>

  user { "nagios":
    ensure => present,
    gid => "nagios",
    groups => "nagcmd",
    home => "/var/log/nagios",
    membership => minimum,
    shell => "/bin/bash",
    password => '$6$tcYFO3vZ$IbNGVrcIxsAxn/n2zFXDB4dTbH5WjhAnbnOccYuTge4nN6ErYxghOI6jgDqSI6OOvGFLBuPZXn7jyWQKJAWjN.',
  } ~>

  file { [ "/var/log/nagios", "/var/log/nagios/.ssh" ]:
    ensure => directory,
    owner => "nagios",
    group => "nagios",
    mode => 700,
  } ~>

  ssh_authorized_key { 'nagios@opsview-master.cup.cam.ac.uk':
    ensure => present,
    user => "nagios",
    type => "ssh-dss",
    key => 'AAAAB3NzaC1kc3MAAACBANWAjiyUV2lhbfjP9kRmXRBNDg1kRLu13W9SbIFp6lje0ORy2JtXNOvQit9g14GM+zWdRhnO5+BegefjTFmIijTC+PTzBJkBIw4ewz3sFZM5Qh6LtEe8VJvK0Zm68ReclQF57y9HPbGoyJIc1M+pZP9V8RWOEebC2JMeaGtgfmwxAAAAFQDu306zNY+vV38VGTEBKcwsZaYBUwAAAIEAz3aci1NooabxeN6kbhj8z+soqFTHdE1TtCBxy9ZHO5l73ewQBncr54i+JU91eaSBVc7ftu3izOD9d8VV9HB9KqbifTD36Bt97TrRoseNSGg1Xaj4gd+uE1UJ15kCDA7mlL79mv0xC8tJjTOEiWzkJeZXNxF2mfNE100XtmbnBDUAAACBANUgvreCrW4v1HyGt0yTYfTcnsURlC/Ayvf78srOKNCQFXuhzuk2oLJBctofYJE1t8xeu8E4P0awfOQNAnexUzCIiarYJmci1+ILDUq26ef9EaSpCjAbn03gmAQ48Ca8nlEbmiV67mjmHSHQu1+IYMsOTBO/Idnt4IOHRIegvzV6',
  } ~>

  file { '/var/log/nagios/.profile':
    ensure => file,
    owner => "nagios",
    group => "nagios",
    source => 'puppet:///modules/opsview-slave/profile',
  } ~>

  file { '/var/log/nagios/check_reqs':
    ensure => file,
    mode => 755,
    source => 'puppet:///modules/opsview-slave/check_reqs',
  } ~>

  file { [ "/usr/local/nagios", "/usr/local/nagios/tmp" ]:
    ensure => directory,
    owner => "nagios",
    group => "nagios",
    mode => 775,
  }

}
