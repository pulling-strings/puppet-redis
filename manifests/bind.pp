# redis bind settings
define redis::bind(
  $unbind=false,
  $bind = false
){
  
  if($bind) {
    editfile::config { "bind ${bind}":
      ensure  => $bind,
      path    => $::redis::conf,
      entry   => 'bind',
      sep     => ' ',
      require => Package[$::redis::package]
    } ~> Service[$::redis::service]
  } elsif($unbind) {
    editfile::config { 'unbind local':
      ensure  => 'absent',
      path    => $redis::conf,
      entry   => 'bind',
      sep     => ' ',
      require => Package[$::redis::package]
    } ~> Service[$::redis::service]
  }
}
