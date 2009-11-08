module UrlShortener
  class Authorize
    
    attr_accessor :login, :api_key, :base_url
    
    def initialize(login, api_key)
      @login = login
      @api_key = api_key
      @base_url = 'http://api.bit.ly'
    end
  end
end