class ius::params {

  $package_name     = 'ius-release'
  $package_provider = 'rpm'

  # https://rhel5.iuscommunity.org/ius-release.rpm
  # https://rhel6.iuscommunity.org/ius-release.rpm
  # https://rhel7.iuscommunity.org/ius-release.rpm
  # https://centos5.iuscommunity.org/ius-release.rpm
  # https://centos6.iuscommunity.org/ius-release.rpm
  # https://centos7.iuscommunity.org/ius-release.rpm

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystem
      {
        'RedHat':
        {
          case $::operatingsystemrelease
          {
            /^5.*$/:
            {
              $package_source='https://rhel5.iuscommunity.org/ius-release.rpm'
            }
            /^6.*$/:
            {
              $package_source='https://rhel6.iuscommunity.org/ius-release.rpm'
            }
            /^7.*$/:
            {
              $package_source='https://rhel7.iuscommunity.org/ius-release.rpm'
            }
            default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
          }
        }
        default:
        {
          # alias CentOS i derivats
          case $::operatingsystemrelease
          {
            /^5.*$/:
            {
              $package_source='https://centos5.iuscommunity.org/ius-release.rpm'
            }
            /^6.*$/:
            {
              $package_source='https://centos6.iuscommunity.org/ius-release.rpm'
            }
            /^7.*$/:
            {
              $package_source='https://centos7.iuscommunity.org/ius-release.rpm'
            }
            default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
          }
        }
      }
    }
    default: { notice ("${::operatingsystem} will not have the IUS repository applied")  }
  }
}
