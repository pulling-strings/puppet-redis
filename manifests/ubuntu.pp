# Setting up redis on Ubuntu based systems
class redis::ubuntu{
  include apt

  if $::lsbdistrelease == '15.10' {
    Package['software-properties-common'] -> Exec <||>
    ensure_packages(['software-properties-common'])
  }

  apt::ppa {'ppa:chris-lea/redis-server': }

  package{'redis-server':
    ensure  => present,
    require => Apt::Ppa['ppa:chris-lea/redis-server']
  }


}
