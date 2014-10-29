# Redis runit setup
class redis::runit {
  file{'/etc/service/redis':
    ensure => directory,
  } ->

  file { '/etc/service/redis/run':
    ensure => file,
    mode   => 'u+x',
    source => 'puppet:///modules/redis/run_redis',
    owner  => root,
    group  => root,
  }
}
