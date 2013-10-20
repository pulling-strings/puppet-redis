# Setting redis on redhat based systems
class redis::redhat {
  include epel
  Yumrepo <||> ->

  package{'redis':
    ensure  => present
  }
}
