class ledez-nagios::host-mysql () {
	File {
		ensure => "present",
		owner  => "root",
		group  => "root",
		mode   => 755,
	}

	file { "mysql.cfg":
		source  => "puppet:///modules/ledez-nagios/conf/mysql.cfg",
		path => "/etc/nagios/nrpe.d/mysql.cfg",
		mode => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
