class no-puppet {
        service { "puppet":
		ensure => stopped,
		enable => false,
	}
}
