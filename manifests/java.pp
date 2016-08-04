# rk_tomcat::java
#
class rk_tomcat::java (
  $zulu_package,
  $zulu_version,
) {

  # install Zulu
  exec { 'install_zulu_repo_key':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'rpm --import http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems',
    logoutput => 'on_failure',
    unless    => "rpm -q $zulu_package",
  } ->

  yumrepo { 'zulu':
    ensure   => 'present',
    name     => 'zulu-$releasever - Azul Systems Inc., Zulu packages for $basearch',
    baseurl  => 'http://repos.azulsystems.com/rhel/$releasever/$basearch',
    gpgkey   => 'http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems',
    enabled  => 1,
    gpgcheck => 1,
    protect  => 1,
  } ->

  package { $zulu_package:
    ensure => $zulu_version,
  }
}
