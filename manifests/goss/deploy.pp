# rk_tomcat::goss::deploy

class rk_tomcat::goss::deploy {
  file { '/root/goss_deploy.json':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('rk_tomcat/goss_deploy.json.erb'),
  }
}
