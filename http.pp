# Install the Apache HTTP Server:
package{'httpd':
  ensure => 'installed',
}
 
# Edit the main Apache configuration file to adjust the resource use settings.
 
$myservice_content = 'info= <IfModule prefork.c>
                      StartServers        4
                      MinSpareServers     20
                      MaxSpareServers     40
                      MaxClients          200
                      MaxRequestsPerChild 4500
                     </IfModule>'
       
file{'/etc/httpd/conf/httpd.conf':
  ensure  => present,
  content => $myservice_content,
}

# Configure Apache for Virtual Hosting

$myapache_content = 'info = <VirtualHost *:80>
                    ServerAdmin admin@example.org
                    ServerName example.org
                    ServerAlias www.example.org
                    DocumentRoot /srv/www/example.org/public_html/
                    ErrorLog /srv/www/example.org/logs/error.log
                    CustomLog /srv/www/example.org/logs/access.log combined
                    </VirtualHost>'
       
file{ '/etc/httpd/conf.d/vhost.conf':
  ensure  => present,
  content => $myapache_content,
}   
 
 
# Create the directories referenced above:
 
file {'/srv/www/example.org/public_html':
  ensure => 'directory',
  recurse => true,
}
 
file {'/srv/www/example.org/logs':
  ensure => 'directory',
  recurse => true,
}
 
# Start Apache:
 
service {'httpd':
  ensure => running,
  enable => true,
}

['mod_perl', 'mod_wsgi', 'mod_php', 'mod_php-pear'].each |String $mod_package| {
  package{"Install package ${mod_package}":
    name   => $mod_package,
    ensure => installed,
  }

