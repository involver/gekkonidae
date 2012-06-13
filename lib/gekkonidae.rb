require 'sinatra/base'

require 'graphite'
require 'widgets/number'
require 'widgets/text'
require 'charts/linechart'

class Gekkonidae < Sinatra::Base
  def initialize(conf)
    super
    @config = conf
    @graphite = Graphite.new(conf[:graphite_server], conf[:graphite_basic_user], conf[:graphite_basic_password])
  end

  before '/*' do
    if @config[:api_key]
      @config[:api_key] == params[:api_key] || throw(:halt, [401, "Not authorized\n"])
    end
  end

  get '/number' do
    params[:target] || throw(:halt, [400, "Missing target\n"])
    results = @graphite.get(params[:target])

    results.last.first || results.pop
    last = results.last.first

    if params[:second]
      Number.new(NumberItem.new(last), NumberItem.new(params[:second])).to_json
    else
      Number.new(NumberItem.new(last)).to_json
    end
  end

  get '/linechart' do
    params[:target] || throw(:halt, [400, "Missing target\n"])
    results = @graphite.get(params[:target])

    last = results.last(30).map {|i| i.first}.compact

    chart = Linechart.new(last)
    chart.axisy = params[:min] || [last.min, last.max]
    params[:color] && chart.colour = params[:color]
    chart.to_json
  end

  get '/textstate' do
    params[:target] || throw(:halt, [400, "Missing target\n"])
    params[:if] || throw(:halt, [400, "Missing if\n"])
    params[:then] || throw(:halt, [400, "Missing then\n"])
    params[:else] || throw(:halt, [400, "Missing else\n"])

    results = @graphite.get(params[:target])

    results.last.first || results.pop
    last = results.last.first

    if params[:if].to_f == last
      Text.new([TextItem.new(params[:then], 0)]).to_json
    else
      Text.new([TextItem.new(params[:else], 1)]).to_json
    end
  end

  get '/status' do
    "Alive"
  end
end