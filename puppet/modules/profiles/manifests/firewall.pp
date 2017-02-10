# == Class: profiles::firewall
#
# Full description of class profiles here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profiles':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class profiles::firewall (
  $rules = {}
){

  class { ['profiles::firewall::pre', 'profiles::firewall::post']: } ->
  resources { 'firewall':
    purge => true
  }

  Firewall {
    require => Class['profiles::firewall::pre'],
    before  => Class['profiles::firewall::post'],
  }

  firewall { '22-ssh':
    proto  => 'tcp',
    dport  => '22',
    action => 'accept',
  }

  create_resources( 'profiles::firewall::rule', $rules )

}