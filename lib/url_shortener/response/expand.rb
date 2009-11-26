module UrlShortener
  
  # e.g. bitly response
  # <bitly>
  #   <errorCode>0</errorCode>
  #   <errorMessage></errorMessage>
  #   <results>
  #     <31IqMl>
  #       <longUrl>http://cnn.com/</longUrl>
  #     </31IqMl>
  #   </results>
  #   <statusCode>OK</statusCode>
  # </bitly>
  
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
