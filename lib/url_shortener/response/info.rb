module UrlShortener
  class Response::Info < UrlShortener::Response
    
    def initialize(response)
      super
    end
    
    # Just to override the hash method provided by hashie
    # that adds some other hash value
    def hash
      return unless doc_value?
      result['doc']['hash']
    end
    
    private
    
    def doc_value?
      return unless result['doc']
      return if result['doc'].empty?
      true
    end
    
    def base_element
      attributes.doc
    end
    
  end
end