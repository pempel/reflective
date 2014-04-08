class nginx {
  group { "deployers":
    ensure => present,
  }
  user { "deployer":
    ensure  => present,
    gid     => "deployers",
    require => Group["deployers"],
  }
  package { "nginx":
    ensure => installed,
  }
  service { "nginx":
    ensure => running,
    enable => true,
  }
}
