class ledez-nagios {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	package { "nagios-nrpe-server":
		ensure => installed,
	}

	package { "nagios-plugins":
		ensure => installed,
	}

	package { "nagios-plugins-basic":
		ensure => installed,
	}

	package { "nagios-plugins-standard":
		ensure => installed,
	}

	service { "nagios-nrpe-server":
		require => Package["nagios-nrpe-server"],
		ensure => running,
		enable => true,
	}
	
	file { [ "/usr/local/lib/nagios", "/usr/local/lib/nagios/plugins" ]:
		ensure => "directory",
		owner  => "root",
		group  => "staff",
		mode   => 755,
	}

	file { "syslog-ng.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/syslog-ng.cfg",
		path => "/etc/nagios/nrpe.d/syslog-ng.cfg",
		notify => Service["nagios-nrpe-server"],
	}

	file { "system.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/system.cfg",
		path => "/etc/nagios/nrpe.d/system.cfg",
		notify => Service["nagios-nrpe-server"],
	}

	file { "linux.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/linux.cfg",
		path => "/etc/nagios/nrpe.d/linux.cfg",
		notify => Service["nagios-nrpe-server"],
	}

	file { "check_memory":
		source  => "puppet:///modules/ledez-nagios/scripts/check_memory",
		path => "/usr/local/lib/nagios/plugins/check_memory",
		notify => Service["nagios-nrpe-server"],
	}

	file { "check_apt":
		source  => "puppet:///modules/ledez-nagios/scripts/check_apt",
		path => "/usr/local/bin/check_apt",
		notify => Service["nagios-nrpe-server"],
	}
}
