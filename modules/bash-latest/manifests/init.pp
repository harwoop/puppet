# == Class: bash-latest 
class bash-latest {
  
  package { 'bash':
    ensure  => latest,
  }

}
