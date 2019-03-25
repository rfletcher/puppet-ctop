# == Class: ctop
#
# Installs (or removes) ctop
#
# === Parameters
#
# [*ensure*]
#   Possible values: present, absent
#
# [*source*]
#   A URL pointing to the ctop binary
#
# === Examples
#
# Install ctop:
#   include ::ctop
#
#   class { 'ctop': ensure => present, }
#
# Uninstall ctop:
#   class { 'ctop': ensure => absent, }
#
# === Authors
#
# Rick Fletcher <fletch@pobox.com>
#
# === Copyright
#
# Copyright 2019 Rick Fletcher
#
class ctop (
  $ensure       = '0.7.2',
  $platform     = 'linux',
  $architecture = $::architecture,
  $source       = undef,
) {
  $real_source = $source ? {
    undef   => "https://github.com/bcicen/ctop/releases/download/v${ensure}/ctop-${ensure}-${platform}-${architecture}",
    default => $source,
  }

  $file_ensure = $ensure ? {
    absent  => $ensure,
    default => present,
  }

  if $ensure != 'absent' {
    wget::fetch { $real_source:
      source      => $real_source,
      destination => '/usr/local/bin/ctop',
      timeout     => 0,
      verbose     => false,
    }
  }

  file { '/usr/local/bin/ctop':
    ensure => $file_ensure,
    mode   => '0755'
  }
}
