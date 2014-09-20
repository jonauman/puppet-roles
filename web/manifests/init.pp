class web {

  case $::osfamily {
    'Debian': { $package = 'apache2' }
    'RedHat': { $package = 'httpd' }
    default: { $package = 'apache2' }
  }

  notify { "package is $package": }
  package { $package: ensure => installed }

}
