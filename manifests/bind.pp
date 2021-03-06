# Manage redis bind settings, you can either pass a bind value:
# redis::bind {'allow all':
#   bind => '0.0.0.0'
# }
# or remove the bind entry completely:
# 
# redis::bind {'no bindings at all':
#   unbind => true
# }
define redis::bind(
  $unbind=false,
  $bind = false
){

  if(::redis::manage_service == true){
    Editfile::Config<||> ~> Service[$::redis::service]
  }

  if($bind) {
    validate_string($bind)
    editfile::config { "bind ${bind}":
      ensure  => $bind,
      path    => $::redis::conf,
      entry   => 'bind',
      sep     => ' ',
      require => Package[$::redis::package]
    }
    
  } elsif($unbind) {
    editfile::config { 'unbind local':
      ensure  => 'absent',
      path    => $redis::conf,
      entry   => 'bind',
      sep     => ' ',
      require => Package[$::redis::package]
    }
  }
}
