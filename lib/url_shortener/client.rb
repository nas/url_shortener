module UrlShortener
  class Client
    
    attr_accessor :authorize
    
    def initialize(authorize)
      @authorize = authorize
      validated?
    end
    
    # To shorten multiple URLs in a single API call, pass multiple urls
    # e.g. shorten('http://www.google.com', 'http://www.bit.ly')
    def shorten(*urls)
      # HTTParty accepts a hash for url parameters but if more than one parameters are passed
      # to bitly then the url needs to have longUrl parameter multiple times but we cant have
      # duplicate keys in a hash hence this solution
      urls.collect!{|url| CGI.escape(url)}
      end_point_with_params = "#{end_point('shorten')}?longUrl=#{urls.join('&longUrl=')}"
      interface(end_point_with_params).get['nodeKeyVal']
    end
    
    # If a complex url need to be passed then use end_point_with_params else
    # set first parameter to nil while invoking this method and
    # pass rest_url option e.g.
    #  interface(nil, {:rest_url => end_point('expand'), :another_key => 'value'})
    def interface(end_point_with_params, options={})
      if end_point_with_params.nil? && options[:rest_url].nil?
        raise "You must provide either the endpoint as the first parameter or set the :rest_url options"
      end
      rest_url = end_point_with_params ? end_point_with_params : options[:rest_url]
      options.delete(:rest_url)
      params = common_query_parameters.merge!(options)
      UrlShortener::Interface.new(rest_url, :query => params)
    end
    
    def common_query_parameters
      {:login => authorize.login, 
       :apiKey => authorize.api_key, 
       :version => '2.0.1', 
       :format => 'xml'
       }
    end
    
    def end_point(resource)
      "#{authorize.base_url}/#{resource}"
    end
    
    private
    
    def validated?
      valid_authorize_attribute?
    end
    
    def valid_authorize_attribute?
     return true if authorize.is_a?(UrlShortener::Authorize)
     raise UrlShortener::AuthorizationFailure, "Authorization type failure\n Received: #{authorize.class} \n Expected: UrlShortener::Authorize"
    end
    
  end
end