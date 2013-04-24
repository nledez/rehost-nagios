class ledez-nagios::host-clamav () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "check_clamav":
		source  => "puppet:///modules/ledez-nagios/scripts/check_clamav",
		path => "/usr/local/bin/check_clamav",
	}

	file { "clam_test.conf":
		content => template('ledez-nagios/clam_test.conf.erb'),
		path => "/etc/clamav/clam_test.conf",
		owner  => "root",
		group  => "root",
		mode => 644,
	}

	file { "clamav.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/clamav.cfg",
		path => "/etc/nagios/nrpe.d/clamav.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
