# Wrapper class for threatstack
class rk_tomcat::threatstack (
    $deploy_key,
    $configure_agent,
){
  $threatstack_template = @(END)
runcmd:
 - [ "/opt/threatstack/bin/cloudsight", "setup", "--deploy-key=<%= $deploy_key -%>" ]
END

  class { '::threatstack':
    deploy_key      => $deploy_key,
    configure_agent => false,
    #configure_agent => $configure_agent,
  }
  file { '/etc/cloud/cloud.cfg.d/99_threatstack.cfg':
    ensure  => file,
    content => inline_epp($threatstack_template, {'deploy_key' => $deploy_key}),
  }
}
