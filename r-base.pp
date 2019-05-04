package {['r-base']:
    ensure => present,
}

package {['libzmq3-dev', 
          'libcurl4-openssl-dev', 
          'libssl-dev']:
    ensure => present,
}

file { '/home/vagrant/IRscript':
    content => "
        install.packages(
            c('crayon', 'pbdZMQ', 'devtools'), 
            repos='https://cloud.r-project.org',
            lib='/usr/lib/R/library/')

        devtools::install_github('IRkernel/IRkernel')

        IRkernel::installspec(user=FALSE)
        "
}

exec { 'irkernel':
    command => '/usr/bin/Rscript /home/vagrant/IRscript && /bin/rm /home/vagrant/IRscript',
    user    => 'root',
    onlyif  => '/usr/bin/test ! -d /usr/local/share/jupyter/kernels/ir'
}
