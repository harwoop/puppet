class yum-repos {

  file { '/etc/yum.repos.d/10gen.repo':
    ensure  => file,
    source  => 'puppet:///modules/yum-repos/10gen.repo',
  }

  file { '/etc/yum.repos.d/cup.repo':
    ensure  => file,
    source  => 'puppet:///modules/yum-repos/cup.repo',
  }

  file { '/etc/yum.repos.d/mod-pagespeed.repo':
    ensure  => file,
    source  => 'puppet:///modules/yum-repos/mod-pagespeed.repo',
  }

  file { '/etc/yum.repos.d/newrelic.repo':
    ensure  => file,
    source  => 'puppet:///modules/yum-repos/newrelic.repo',
  }
  include 'glibc-latest'
}
