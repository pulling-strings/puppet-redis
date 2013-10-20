# Setting redis on redhat based systems
class redis::redhat {
  include epel
  package{'redis':
    ensure  => present
  }
}
