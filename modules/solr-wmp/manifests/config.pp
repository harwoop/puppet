define solr-wmp::config ( $core, $master = undef, $master_url = "http://nosql-master/wmp" ) {

  if $master == undef {
    $slave_config = template("solr-wmp/slave.xml.erb")
  } else {
    $slave_config = template("solr-wmp/master.xml.erb")
  }


  file { "$core-solr-core-dir":
    path    => "/data/solr/wmp/solr/$core",
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0755',
  } ~>

  file { "$core-solr-conf-dir":
    path    => "/data/solr/wmp/solr/$core/conf",
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0755',
  } ~>

  file { "$core-solr-conf-lang-dir":
    path    => "/data/solr/wmp/solr/$core/conf/lang",
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0755',
  } ~>

  file { "$core-solrconfig.xml":
    path    => "/data/solr/wmp/solr/$core/conf/solrconfig.xml",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    content  => template("solr-wmp/$core/solrconfig.xml.erb"),
    notify => File['solr.xml'],
  } ~>

  file { "$core-schema.xml":
    path    => "/data/solr/wmp/solr/$core/conf/schema.xml",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/schema.xml",
  } ~>

  file { "$core-currency.xml":
    path    => "/data/solr/wmp/solr/$core/conf/currency.xml",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/currency.xml",
  } ~>

  file { "$core-synonyms.txt":
    path    => "/data/solr/wmp/solr/$core/conf/synonyms.txt",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/synonyms.txt",
  } ~>

  file { "$core-stopwords.txt":
    path    => "/data/solr/wmp/solr/$core/conf/stopwords.txt",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/stopwords.txt",
  } ~>

  file { "$core-protwords.txt":
    path    => "/data/solr/wmp/solr/$core/conf/protwords.txt",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/protwords.txt",
  }

  file { "$core-stopwords_en.txt":
    path    => "/data/solr/wmp/solr/$core/conf/lang/stopwords_en.txt",
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode   => '0644',
    source  => "puppet:///modules/solr-wmp/$core/lang/stopwords_en.txt",
  }

}
