class ledez-nagios::host-vz () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "check_ubc":
		source  => "puppet:///modules/ledez-nagios/scripts/check_ubc",
		path => "/usr/local/bin/check_ubc",
	}

	file { "check_vzquota":
		source  => "puppet:///modules/ledez-nagios/scripts/check_vzquota",
		path => "/usr/local/bin/check_vzquota",
	}

	file { "openvz.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/openvz.cfg",
		path => "/etc/nagios/nrpe.d/openvz.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
