package {['tree',
          'csvkit']:
    ensure => present,
}

package {['bash_kernel']:
    ensure   => present,
    provider => 'pip3',
}

exec { 'bash-kernel':
    command => '/usr/bin/python3 -m bash_kernel.install',
    onlyif  => '/usr/bin/test ! -d /usr/local/share/jupyter/kernels/bash'
}
