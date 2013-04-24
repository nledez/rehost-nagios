class ledez-nagios::host-imap () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "imap.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/imap.cfg",
		path => "/etc/nagios/nrpe.d/imap.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
