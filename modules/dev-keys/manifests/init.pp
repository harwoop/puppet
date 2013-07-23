class dev-keys {
  ssh_authorized_key { 'wmp-dev-key':
    ensure => present,
    user => "ec2-user",
    type => "ssh-rsa",
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC6FlLnZgM0i8PjR6JQBTv2F2g9wQYcxXq/07J4Rt3FR8Z9WJFe6riLuavYLGcVEOER9UkQrhS+6ggeNAcy+E6oGUi/VeFJwZBP3Ff+rzMU2fzeruuUiBi/01oMsNZfZnyxomPRfLDqO0kWKq2YCl6i1btxC1stwmBIyCNbD6EA93Uu85yUibCF7CBCGDUZRh10D8+AbnJIZJzlo6YJTdUzhne06EroJQ2MhNkZgEMmjEhyk/ytgudX4KvLw7hY0MwrDRmWz/O/A2XDvrRKsjmKx7M3wSY6LCIKn0YEE2u3tnJXOL22fA6t5hT+7K0ams7AKBCPNlwIxawL75R5PZ7F',
  }
}
