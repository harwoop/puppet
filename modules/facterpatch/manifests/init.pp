class facterpatch {
      file {'/usr/lib/ruby/site_ruby/1.8/facter/ec2.rb':
       ensure  => file,
       owner   => 'root',
       source => "puppet:///modules/facterpatch/ec2.rb", # Template from a module files directory
      }

}
