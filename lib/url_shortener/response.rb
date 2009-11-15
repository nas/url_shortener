module UrlShortener
  class Response
    
    attr_reader :result, :attributes
    
    def initialize(result)
      @result = result
      @attributes = Hashie::Mash.new(result)
    end
    
  end
end