class ius::install inherits ius {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  include ::epel

  package { $ius::params::package_name:
    ensure   => $ius::package_ensure,
    provider => $ius::params::package_provider,
    source   => $ius::params::package_source,
    require  => Class['::epel'],
  }

  if($ius::import_gpgkey)
  {
    file { '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/IUS_GPG_KEY",
      require => Package[$ius::params::package_name],
    }

    exec { 'rpm import gpg eyp-ius repo':
      command => 'rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
      unless  => "bash -c 'rpm -q gpg-pubkey-$(cat /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY | gpg --throw-keyids | grep \"^pub\" | awk \"{ print \\\$2 }\" | cut -f2 -d/ | tr [A-Z] [a-z])'",
      require => File['/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'],
    }
  }
}
