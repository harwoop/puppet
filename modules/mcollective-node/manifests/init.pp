# == Class: wmp-site
class mcollective-node {
  package { 'mcollective':
    ensure  => latest,
  } ~>
         
  package { 'mcollective-common':
    ensure  => latest,
  } ~>
         
  package { 'mcollective-nrpe-agent':
    ensure  => latest,
  } ~>

  package { 'mcollective-package-agent':
    ensure  => latest,
  } ~>

  package { 'mcollective-puppet-agent':
    ensure  => latest,
  } ~>

  package { 'mcollective-service-agent':
    ensure  => latest,
  } ~>

  package { 'rubygem-stomp':
    ensure  => latest,
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
