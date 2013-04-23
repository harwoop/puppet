# == Class: gluster-server
class gluster-server ( $cluster_hostname = "gluster-eu-west" ) {
  
  package { 'xfsprogs':
    ensure  => installed
  }
   
  package { 'fuse':
    ensure  => installed
  }
   
  package { 'fuse-libs':
    ensure  => installed
  }
   
  package { 'glusterfs':
    ensure  => installed
  }
   
  package { 'glusterfs-fuse':
    ensure  => installed
  }
   
  package { 'glusterfs-server':
    ensure  => installed
  }
   
  package { 'glusterfs-geo-replication':
    ensure  => installed
  }
   
  service { 'glusterd':
    name      => 'glusterd',
    ensure    => running,
    enable    => true,
    subscribe => File['glusterd.conf'],
  }
      
  file { 'glusterd.conf':
    path    => '/etc/glusterd.conf',
    ensure  => file,
    require => Package['glusterfs-server'],
  }

  file { 'glusterd':
    path    => '/etc/init.d/glusterd',
    ensure  => file,
    mode    => 755,
    require => Package['glusterfs-server'],
    source => "puppet:///modules/gluster-server/glusterd"
  }

#  file { 'Knsupdate.aws.internal.+157+39899.private':
#    path    => '/etc/cup/Knsupdate.aws.internal.+157+39899.private',
#    ensure  => file,
#    mode    => 700,
#    require => Package['glusterfs-server'],
#    source => "puppet:///modules/gluster-server/Knsupdate.aws.internal.+157+39899.private"
#  }
#
#  file { 'rr-update.sh':
#    path    => '/usr/local/bin/rr-update.sh',
#    ensure  => file,
#    mode    => 755,
#    require => File['Knsupdate.aws.internal.+157+39899.private'],
#    content => template("gluster-server/rr-update.sh.erb")
#  }

  file { "brick":
    path => "/mnt/brick",
    ensure => directory,
    require => Package['glusterfs-server'],
  } ~>

  mount { "brick-mount":
    device => "/dev/xvdf",
    name => "/mnt/brick",
    fstype => 'xfs',
    options => 'defaults',
    ensure => mounted,
    require => Package['glusterfs-server'],
  }

}
