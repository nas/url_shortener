module UrlShortener
  
  class Response::Expand < UrlShortener::Response
    
    def initialize(response)
      super
    end
    
    def url
      return unless result_present?
      return unless key_present?
      url_hash = result.keys.first
      result[url_hash]['longUrl']
    end
    
    private
    
    def result_present?
      result && !result.empty?
    end
    
    def key_present?
      result_present?
      result.keys && !result.keys.empty?
    end
  end
  
end
