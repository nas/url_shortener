module UrlShortener
  
  class Response::Expand < UrlShortener::Response
    
    def initialize(response)
      super
    end
    
    def url
      long_url
    end
    
    private
    
    def base_element
      return unless attributes
      return unless attributes.first
      return unless attributes.first.is_a?(Array)
      attributes.first.last
    end
  end
  
end
