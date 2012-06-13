require 'net/http'

class Graphite
  def initialize(server = 'localhost', basic_user = '', basic_password = '')
    @server, @basic_user, @basic_password = server, basic_user, basic_password
  end

  def get(target)
    uri = URI(URI.encode("http://#{ @server }/render?target=#{ target }&format=json"))

    req = Net::HTTP::Get.new(uri.request_uri)

    if @basic_user
      req.basic_auth @basic_user, @basic_password
    end

    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    JSON(res.body)[0]['datapoints'].compact
  end
end