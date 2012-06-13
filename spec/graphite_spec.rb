require 'spec_helper'

require 'graphite'

describe Graphite do
  before do
    register_fakeweb_graphite_data
  end

  it "should return results" do
    g = Graphite.new('graphite.example.com', '', '')
    g.get('t').should == [[2325798544.0, 1339512060], [1325798544.0, 1339512120]]
  end
end