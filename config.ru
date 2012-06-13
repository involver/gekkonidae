require File.dirname(__FILE__) + '/lib/gekkonidae'

config_file = 'config/gekkonidae.yml'

options = {
  graphite_server: 'localhost',
  graphite_port: 80,
  graphite_basic_user: '',
  graphite_basic_password: '',
  api_key: ''
}

if File.exists? config_file
 options.merge!(Hash[YAML::load(open('config/gekkonidae.yml')).map { |k, v| [k.to_sym, v] }])
end

run Gekkonidae.new(options)
