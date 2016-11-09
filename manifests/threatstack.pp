# Wrapper class for threatstack
class rk_tomcat::threatstack (
    $deploy_key,
    $configure_agent,
){
  class { '::threatstack':
    deploy_key      => $deploy_key,
    configure_agent => $configure_agent,
  }
}
