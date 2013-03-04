require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'rsyslog' do
  let(:facts) { {:hostname => 'node01', :domain => 'example.internal', :osfamily => 'RedHat'} }
  let(:params) do { 
  	   :server       => false,
  	   :client       => true,
  	   :syslogserver => "syslog.example.internal",
  	   :enabled      => true,
  	   :tcp_port     => "514", 
  	   :udp_port     => "514",
  	   :enable_tcp   => true,
  	   :enable_udp   => true
  	 }
  end

  it { should contain_class('rsyslog') }
end
