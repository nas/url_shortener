module UrlShortener
  class Response
    
    attr_reader :result, :attributes
    
    def initialize(result)
      @result = result
      @attributes = Hashie::Mash.new(result)
    end
    
    def method_missing(method_name, *args)
      element = camelize(method_name)
      base_element.send(element.to_sym)
    end
    
    private
    
    def camelize(string)
      split_string_by_underscore = split_by_char(string, '_')
      return split_string_by_underscore.first if split_string_by_underscore.size == 1
      capitalized_parts = []
      split_string_by_underscore.each_with_index do |word_part,index| 
        next if index == 0
        capitalized_parts << word_part.capitalize
      end
      camelized_string = capitalized_parts.unshift(split_string_by_underscore[0])
      camelized_string.join('')
    end
    
    def split_by_char(string, splitter)
      operable_string = string.is_a?(String) ? string : string.id2name
      operable_string.split(splitter)
    end
    
    def base_element
      attributes
    end
    
  end
end