define ledez-nagios::agent (
	$allowed_hosts = '127.0.0.1,91.121.88.157,87.98.179.41'
) {

	file { "allowed.cfg":
		content => template('ledez-nagios/allowed.cfg.erb'),
		path => "/etc/nagios/nrpe.d/allowed.cfg",
		owner  => "root",
		group  => "root",
		mode   => 644,
		notify => Service["nagios-nrpe-server"],
	}
}
