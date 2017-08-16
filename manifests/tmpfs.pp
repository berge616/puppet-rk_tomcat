# rk_tomcat::tmpfs
#
# Create a tmpfs filesystem for Tomcat to use as scratch space
class rk_tomcat::tmpfs(
  $group,
  $mountpoint,
  $ramdisk_size,
) {

  file { $mountpoint:
    ensure => directory,
    owner  => 'root',
    group  => $group,
    mode   => '0770',
  } ->

  mounttab { $mountpoint:
    ensure   => present,
    provider => 'augeas'
    fstype   => 'tmpfs',
    device   => 'tmpfs',
    dump     => 0,
    pass     => 2,
    options  => [
      "size=${ramdisk_size}",
    ]
  } ->

  mountpoint { $mountpoint:
    ensure   => present,
    remounts => true,
  }
}
