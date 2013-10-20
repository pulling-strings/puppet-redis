# Setting up redis on Ubuntu based systems
class redis::ubuntu{
  include apt

  apt::ppa { 'ppa:chris-lea/redis-server': }

  package{'redis-server':
    ensure  => present,
    require => Apt::Ppa['ppa:chris-lea/redis-server']
  }


}
