# == Class: redis
#
#  A puppet module for redis, works on Ubuntu 12.10
#
# === Parameters
#
# Document parameters here.
#
# [*append*]
#  Enables aof persistency
#
# === Variables
#
# === Examples
#
#  class {redis:
#    append => true
#  }
#
# === Authors
#
# Author Name <narkisr@gmail.com>
#
# === Copyright
#
# Copyright 2013 Ronen Narkis , unless otherwise noted.
#
class redis(
  $append=false,
  $unbind=false,
  $daemonize=true,
  $manage_services=false,
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

  if($unbind) {
    editfile::config { 'unbind local':
      ensure  => 'absent',
      path    => $conf,
      entry   => 'bind',
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

  if($manage_services) {
    Editfile::Config <||> ~> Service[$service]

    service{$service:
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require => Package[$package]
    }
  }

  if($manage_sysctl) {
    sysctl{'vm.overcommit_memory': value => 1 }
  }
  if($disable_hugepages) {
    exec{'disable hugepages':
      command => 'echo never > /sys/kernel/mm/transparent_hugepage/enabled',
      unless => 'grep -q "[never]" /sys/kernel/mm/transparent_hugepage/enabled',
      path => "/usr/bin:/bin:/usr/sbin:/sbin"
    }
  }
}
