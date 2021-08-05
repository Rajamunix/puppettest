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
     String $ensure){
    package {'$mypackage':
      name => '$mypackage',
      ensure => $ensure,
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
       appX::config_file:ensure: 1.0
       appX::service::service: appX
       appX::service::ensure: on
