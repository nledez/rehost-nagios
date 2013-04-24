class ledez-nagios::host-nginx () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "check_nginx":
		source  => "puppet:///modules/ledez-nagios/scripts/check_nginx",
		path => "/usr/local/lib/nagios/plugins/check_nginx",
	}

	file { "nginx.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/nginx.cfg",
		path => "/etc/nagios/nrpe.d/nginx.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
