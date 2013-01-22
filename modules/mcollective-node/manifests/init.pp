# == Class: wmp-site
class mcollective-node {
  package { 'mcollective':
    ensure  => installed,
  }
         
  package { 'mcollective-common':
    ensure  => installed,
  }
         
  package { 'rubygem-stomp':
    ensure  => installed,
  }

  service { 'mcollective':
    ensure => running,
    enable => true,
    subscribe => File['server.cfg'],
  }         

  file { 'server.cfg':
    path    => '/etc/mcollective/server.cfg',
    ensure  => file,
    require => Package['mcollective'],
    source  => "puppet:///modules/mcollective-node/server.cfg",
  }

  file{"/etc/mcollective/facts.yaml":
    owner    => root,
    group    => root,
    mode     => 400,
    loglevel => debug,  # this is needed to avoid it being logged and reported on every run
    # avoid including highly-dynamic facts as they will cause unnecessary template writes
    content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>")
  }
}
