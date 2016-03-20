# Setting up redis on Ubuntu based systems
class redis::ubuntu{
  include apt

  if $lsbdistrelease == '15.10' {
    package{'software-properties-common':
      ensure  => present
    } -> Exec <||>

    Service {
      provider => systemd
    }
  } else {
    package{'python-software-properties':
      ensure  => present
    } -> Exec <||>
  }

  apt::ppa {'ppa:chris-lea/redis-server': }

  package{'redis-server':
    ensure  => present,
    require => Apt::Ppa['ppa:chris-lea/redis-server']
  }


}
