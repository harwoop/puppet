class testmod {
	file { "managed_node":
		ensure => present,
		path    => '/etc/managed_node',
		content => 'This node brought to you by puppet',
	}
}
