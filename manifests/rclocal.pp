# rk_tomcat::rclocal

class rk_tomcat::rclocal {
  class { '::rclocal':
    ensure => present,
  }
}
