require 'spec_helper'
require 'widgets/number'

describe Gekkonidae do
  before do
    register_fakeweb_graphite_data
  end

  describe "GET /status" do
    it "should not reach a page with no api_key" do
      get "/status"
      last_response.status.should be(401)
    end

    it "should not reach a page with bad api_key" do
      get "/status?api_key=BAAAAD"
      last_response.status.should be(401)
    end

    it "should reach a page with a good api_key" do
      get "/status?api_key=EXAMPLEKEY123"
      last_response.status.should be(200)
      last_response.body.should == 'Alive'
    end
  end

  describe "GET /number" do
    it "should return valid json" do
      get "/number?api_key=EXAMPLEKEY123&target=t"
      last_response.body.should == Number.new(NumberItem.new(1325798544.0)).to_json
    end
  end

  describe "GET /linechart" do
    it "should return valid json" do
      get "/linechart?api_key=EXAMPLEKEY123&target=t"

      chart = Linechart.new([2325798544.0,1325798544.0])
      chart.axisy = [1325798544.0,2325798544.0]
      last_response.body.should == chart.to_json
    end
  end

  describe "GET /textstate" do
    it "should return valid json" do
      get "/textstate?api_key=EXAMPLEKEY123&if=1&then=Y&else=N&target=t"

      text = Text.new([TextItem.new("N", 1)])
      last_response.body.should == text.to_json
    end
  end
end