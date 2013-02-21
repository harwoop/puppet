class gluster-client ($device = "gluster-eu-west:/wmp-files", $mount = "/mnt", $options = "defaults") {

  package { 'fuse':
    ensure => installed,
  }

  package { 'fuse-libs':
    ensure => installed,
    require => Package['fuse'],
  }

  package { 'glusterfs':
    ensure => installed,
    require => Package['fuse-libs'],
  }

  package { 'glusterfs-fuse':
    ensure => installed,
    require => Package['glusterfs'],
  }

  if $mount and $device {
    notify { "Attempting to mount fs": }
    file { "gluster_mount_point-$hostname":
      path => $mount, 
      ensure => directory,
      owner => "apache",
      group => "apache",
      mode => "0755",
      require => Package['glusterfs-fuse'],
    }
    mount { "gluster_mount_$hostname":
      name  => $mount,
      device => $device,
      fstype => 'glusterfs',
      options => $options,
      ensure => mounted,
      require => Package['glusterfs-fuse'],
    }
  } else {
    notfiy { "Not mounting fs": }
  }
}
