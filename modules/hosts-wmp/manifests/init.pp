class hosts-wmp {

  host { 'wmp-uat-vyre.int.cambridge.org':
    ensure => present,
    ip     => '91.240.3.133',
  }

  host { 'wmp-uat-iis.int.cambridge.org':
    ensure => present,
    ip     => '91.240.2.24',
  }

}
