class gluster-client ($device = undef, $mount = undef, $options = "") {

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
    file { "gluster_mp-$mount":
      path => $mount,
      ensure => directory,
      require => Package['glusterfs-fuse'],
    }
    mount { "gluster_m-$mount":
      device => $device,
      name => $mount,
      fstype => 'glusterfs',
      options => $options,
      ensure => mounted,
      require => Package['glusterfs-fuse'],
    }
  } else {
    notfiy { "Not mounting fs": }
  }
}
