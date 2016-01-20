# == Class: openssh-latest
class openssh-latest {

  package { 'openssh':
    ensure  => latest,
  }

}
