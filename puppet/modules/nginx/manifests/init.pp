class nginx {
  group { "deployers":
    ensure => present,
  }
  user { "deployer":
    ensure => present,
    gid => "deployers",
    require => Group["deployers"],
  }
}
