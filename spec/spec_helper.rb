ENV['RACK_ENV'] = "test"

require 'capybara/rspec'
require 'rack/test'
require 'fakeweb'
require 'gekkonidae'

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  app_config = Hash[YAML::load(open('../config/gekkonidae.yml.example')).map { |k, v| [k.to_sym, v] }]
  Gekkonidae.new(app_config)
end

def register_fakeweb_graphite_data
  FakeWeb.register_uri(:get, "http://graphite.example.com/render?target=t&format=json",
                       :body => '[{"target": "default.test.boottime", "datapoints": [[2325798544.0, 1339512060], [1325798544.0, 1339512120]]}]')
end
