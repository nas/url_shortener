module UrlShortener
  require 'timeout'
  
  class Interface
    include HTTParty
    
    attr_reader :rest_url
    
    def initialize(rest_url, options={})
      @rest_url = rest_url
      @options = options
      @result = nil
      validate?
    end
    
    def get
      @result ||= UrlShortener::Interface.get(rest_url, @options)
      timeout(10) do
        unless result?(@result)
          raise UrlShortener::NoResult, "No result returned from bit.ly"
        end
        if @result['bitly']['errorCode'] == '203'
          raise UrlShortener::AuthorizationFailure, @result['bitly']['errorMessage']
        end
        if @result['bitly']['statusCode'] != 'OK' && @result['bitly']['errorCode'] != '0'
          raise UrlShortener::ResponseFailure, @result['bitly']['errorMessage']
        end
      end
      return @result['bitly']['results']
    rescue Timeout::Error => e
      raise UrlShortener::ResponseFailure, "Connection timed out"
    end
    
    def result?(result)
      return false unless result
      return false unless (result.is_a?(Hash) && result['bitly'])
      return false if result['bitly'].empty?
      true
    end
    
    private
    
    # To prevent calling UrlShortener::Interface.new(nil)
    def validate?
      return true if rest_url
      raise "Interface Url cannot be nil"
    end
    
  end
end