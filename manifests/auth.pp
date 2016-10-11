# rk_tomcat::auth
#
# Manage authentication data stored on disk.
class rk_tomcat::auth(
  $content,
  $dir,
  $owner,
  $group,
  $mode,
) {
  validate_hash($content)

  file { $dir:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  $content.each |$file_name,$file_content| {
    file { "${dir}/${file_name}":
      ensure  => 'present',
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => $file_content,
    }
  }
}
