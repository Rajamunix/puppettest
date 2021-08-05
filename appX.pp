init.pp
...........
class appX {
  contain appX1::config_file
  contain appX1::service
  }
  
  conifg_file
  ................
  class appX::config_file (
     String $mypackage
     String $version){
    package {'$mypackage':
      name => '$mypackage',
      ensure => $version,
      }
    file {'/etc/init.d/appX':
      ensure => present,
      content => 'puppet:///module/appX/files/abc.txt',
      }
      
    -----
    server.pp
    class appX::service (
     String $service
     String $ensure) {
      service {'$service':
        ensure => $ensure,
        enable => true,
      }
       
       common.yaml
       .............
       appX::config_file:mypackage: appX
       appX::config_file:version: 1.0
       appX::service::service: appX
       appX::service::ensure: running
