# Manage redis bind settings, you can either pass a bind value:
# redis::bind {'allow all':
#   bind => '0.0.0.0'
# }
# or remove the bind entry completely:
# 
# redis::bind {'allow all':
#   unbind => true
# }
define redis::bind(
  $unbind=false,
  $bind = false
){
  
  if($bind) {
    validate_string($bind)
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
