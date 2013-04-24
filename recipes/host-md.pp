class ledez-nagios::host-md () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "check_md":
		source  => "puppet:///modules/ledez-nagios/scripts/check_md",
		path => "/usr/local/bin/check_md",
	}

	file { "mdadm.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/mdadm.cfg",
		path => "/etc/nagios/nrpe.d/mdadm.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
