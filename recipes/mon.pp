class ledez-nagios::mon () {
	package { "nagios-nrpe-plugin":
		ensure => installed,
	}
}
