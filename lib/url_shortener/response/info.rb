module UrlShortener
  
  # All elements within doc are available as instance method calls.
  # such as; info_response_instance.htmlMetaDescription or info_response_instance.htmlTitle
  # if you don't like using camelised method names then you can use underscores like
  # info_response_instance.html_meta_description or info_response_instance.html_title and it should work fine
  # 
  # e.g. xml response
  # <bitly>
  #   <errorCode>0</errorCode>
  #   <errorMessage/>
  #     <results>
  #       <doc>
  #         <urlFetched>http://www.cnn.com/</urlFetched>
  #         <shortenedByUser>bitly</shortenedByUser>
  #         <keywords/>
  #         <hash>31IqMl</hash>
  #         <exif/>
  #         <longUrl>http://cnn.com/</longUrl>
  #         <htmlMetaDescription>
  #           CNN.com delivers the latest breaking news and information on the latest top stories, weather, business, entertainment, politics, and more. For in-depth coverage, CNN.com provides special reports, video, audio, photo galleries, and interactive guides.
  #         </htmlMetaDescription>
  #         <indexed>1253643458</indexed>
  #         <htmlTitle>
  #           CNN.com - Breaking News, U.S., World, Weather, Entertainment &amp; Video News
  #         </htmlTitle>
  #         <htmlMetaKeywords>
  #           <item>CNN</item>
  #           <item>CNN news</item>
  #           <item>CNN.com</item>
  #           <item>CNN TV</item>
  #           <item>news</item>
  #         </htmlMetaKeywords>
  #         <mirrorUrl/>
  #         <keyword/>
  #         <contentLegth>99195.0</contentLegth>
  #       <fileExtension/>
  #     </doc>
  #   </results>
  # <statusCode>OK</statusCode>
  # </bitly>
  
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