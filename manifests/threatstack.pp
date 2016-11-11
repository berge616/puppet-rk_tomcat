# Wrapper class for threatstack
class rk_tomcat::threatstack (
    $deploy_key,
    $configure_agent,
){
  class { '::threatstack':
    deploy_key      => $deploy_key,
    configure_agent => $configure_agent,
  }
  file_line { '/etc/rc.d/rc.local':
    path => '/etc/rc.d/rc.local',
    line => "/opt/threatstack/bin/cloudsight setup --deploy-key=${deploy_key} --hostname=${::fqdn}",
  } #/opt/threatstack/bin/cloudsight setup --deploy-key=${deploy_key} --hostname=${::fqnd}
}
