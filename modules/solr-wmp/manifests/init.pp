# == Class: solr-wmp
class solr-wmp ( $master = undef, $master_url = "http://nosql-master.aws.internal:8080/wmp/" ) {
  
  include tomcat

  package { 'cup-solr':
    ensure  => '4.2.1-cupel',
    require => Package['cup-apache-tomcat'],
  }
   
  file { 'root-conf-catalina':
    path    => '/data/tomcat/conf/Catalina',
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0755',
    require => Package['cup-solr'],
  } ~>

  file { 'root-conf-catalina-localhost':
    path    => '/data/tomcat/conf/Catalina/localhost',
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0755',
    require => Package['cup-solr'],
  } ~>

  file { 'wmp.xml':
    path    => '/data/tomcat/conf/Catalina/localhost/wmp.xml',
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/wmp.xml",
  } ~>

  file { 'solr.xml':
    path    => '/data/solr/wmp/solr/solr.xml',
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    require => Package['cup-solr'],
    source  => "puppet:///modules/solr-wmp/solr.xml",
  } 

  solr-wmp::config {'product':
    core => "product",
    master => $master,
    master_url => $master_url
  } 

  solr-wmp::config {'search':
    core => "search",
    master => $master,
    master_url => $master_url
  }

  solr-wmp::config {'resources':
    core => "resources",
    master => $master,
    master_url => $master_url
  }
}
