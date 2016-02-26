node default {
  # include yum::update
  # include os_essentials
  include pgsql_install
  include pgsql_config
  include pgsql_start
  include config_apache
}


class pgsql_start {

  require pgsql_config

  service { 
    'postgresql-9.5':
      enable    => true,
      ensure    => true,
  }
}

class pgsql_config {
  require pgsql_install

  exec { 'initdb':
    command => '/usr/pgsql-9.5/bin/postgresql95-setup initdb',
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  }

  file {
    "/var/lib/pgsql/9.5/data/pg_hba.conf":
        mode => "0600",
        owner => 'postgres',
        group => 'postgres',
        source => 'puppet:///modules/config/pg_hba.conf',
        require => Exec['initdb']
  }

  ### ajustar caminho...

  file {
    "/var/lib/pgsql/9.5/data/postgresql.conf":
        mode => "0600",
        owner => 'postgres',
        group => 'postgres',
        source => 'puppet:///modules/config/postgresql.conf',
        require => Exec['initdb']
  }
}

class pgsql_install {
  require os_essentials


  $install = ['postgresql95-server', 'postgresql95-contrib', 'pgxnclient' ]

  package { 
    $install:
      ensure  => present,
  }
}

class config_apache {
  require os_essentials

  service { 
    httpd:
      enable    => true,
      ensure    => false,
      hasstatus => true,
      require => File["/etc/httpd/conf.d/e-vidence_api.conf", "/etc/httpd/conf.d/e-vidence_web.conf"]
  }  

  file {
    "/etc/httpd/conf.d/e-vidence_api.conf":
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/config/e-vidence_api.conf'
  }  

  file {
    "/etc/httpd/conf.d/e-vidence_web.conf":
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/config/e-vidence_web.conf'
  }
}

class os_essentials {

  require yum::update

  service { 
    iptables:
      enable    => false,
      ensure    => false,
      hasstatus => true
  }

  service { 
    firewalld:
      enable    => false,
      ensure    => false,
      hasstatus => true
  }


  $install = ['vim-enhanced','wget','bzip2', 'epel-release', 'deltarpm', 'httpd', 'php', 'php-pgsql' ]

  package { 
    $install:
      ensure  => present,
  }

  # senha do usuario vagrant
  user { 
    'vagrant': 
      ensure   => present,
      password => '$1$qVcdGhrX$Z4m4wNAEh5ZECx4UXM1ea1',
  }

  package 
  {
    'pgdg-centos95':
      source => 'http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm',
      ensure => present,
      provider => 'rpm'
  }

  ## SELinux stuff
  exec 
  {
    "disable-selinux": 
      command => "/usr/sbin/setenforce 0",
      unless => "getenforce",
      path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  }

  file {
    "/etc/selinux/config":
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/config/selinux_config'
  }

}


class yum::update
{
  # Run a yum update on the 6th of every month between 11:00am and 11:59am.
  # Notes: A longer timout is required for this particular run,
  #        The time check can be overridden if a specific file exists in /var/tmp

  exec 
  {
    "yum-cleanup": 
      command => "/usr/bin/yum clean all",
  }

  exec
  {
    "yum-update":
      command => "/usr/bin/yum -q -y update",
      timeout => 1800
  }

  exec
  {
    "remove-pgsql":
      command => "/usr/bin/rm -rf /var/lib/pgsql/9.5/data/*",
      timeout => 1800
  }
}