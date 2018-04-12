# rk_tomcat::rsyslog::deploy
#
class rk_tomcat::rsyslog::deploy(
  $catalina_home,
  $application_tag,
  $logdna_tokens,
) {

  File {
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  $rsyslog_tag = "datahub-${application_tag}"
  file { $rsyslog_tag:
    ensure  => absent,
    path    => "/etc/rsyslog.d/55-${rsyslog_tag}.conf",
  }

  $rsyslog_logdna_tag = "logdna-${application_tag}"
  $applogs_token = $logdna_tokens['applogs']
  $ensure_logdna = $applogs_token ? {
    ''      => 'absent',
    default => 'present',
  }
  file { $rsyslog_logdna_tag:
    ensure  => $ensure_logdna,
    path    => "/etc/rsyslog.d/22-${rsyslog_logdna_tag}.conf",
    content => template('rk_tomcat/logdna-tomcat.conf.erb'),
  }

  exec { 'restart_rsyslog':
    command   => 'echo "/sbin/service rsyslog restart >/dev/null 2>&1" >> /etc/rc.d/rc.local',
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    logoutput => 'on_failure',
    unless    => 'grep rsyslog /etc/rc.d/rc.local 2>/dev/null',
  }
}
