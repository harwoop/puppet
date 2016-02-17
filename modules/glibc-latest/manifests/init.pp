# == Class: glibc-latest 
class glibc-latest {
  
  package { 'glibc':
    ensure  => latest,
  }

}
