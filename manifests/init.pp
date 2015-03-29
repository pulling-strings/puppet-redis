# Setting up a redis instance
class redis(
  $append=false,
  $daemonize=true,
  $manage_service=true,
  $manage_sysctl=true,
  $disable_hugepages=true,
) {


  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $package = 'redis'
      $service = 'redis'
      $conf = '/etc/redis.conf'
      include redis::redhat
    }
    'Ubuntu':{
      $package = 'redis-server'
      $service = 'redis-server'
      $conf = '/etc/redis/redis.conf'
      include redis::ubuntu
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  if($append){
    editfile::config { 'append true':
      ensure  => 'yes',
      path    => $conf,
      entry   => 'appendonly',
      sep     => ' ',
      require => Package[$package]
    }
  }



  if(!$daemonize) {
    editfile::config { 'daemonize false':
      ensure  => 'no',
      path    => $conf,
      entry   => 'daemonize',
      sep     => ' ',
      require => Package[$package]
    }
  }

  if($manage_service) {
    Editfile::Config <||> ~> Service[$service]

    service{$service:
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => Package[$package]
    }
  }

  if($manage_sysctl) {
    sysctl{'vm.overcommit_memory': value => 1 }
  }

  if($disable_hugepages) {
    $unless = 'grep -q "[never]" /sys/kernel/mm/transparent_hugepage/enabled'
    exec{'disable hugepages':
      command => 'echo never > /sys/kernel/mm/transparent_hugepage/enabled',
      unless  => $unless,
      path    => '/usr/bin:/bin:/usr/sbin:/sbin'
    }
  }
}
