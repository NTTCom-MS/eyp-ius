class ius (
            $package_ensure                 = 'installed',
            $import_gpgkey                  = true,
          ) inherits ius::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::ius::install': } ->
  Class['::ius']

}
