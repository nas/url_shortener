module UrlShortener
  
  # Provides methods to access stats data returned by bitly for a short url
  # Apart from the obvious methods provided below such as :
  #   * hash
  #   * referrers
  #   * user_referrers
  # the value of any xml element can be accessed using their element names
  # like clicks
  
  # e.g. stats response xml
  # <bitly>
  #   <errorCode>0</errorCode>
  #   <errorMessage/>
  #   <results>
  #     <referrers>
  #       <nodeKeyVal>
  #         <direct>818</direct>
  #         <nodeKey></nodeKey>
  #       </nodeKeyVal>
  #       <nodeKeyVal>
  #         <nodeKey>www.exalead.com</nodeKey>
  #         <nodeKeyVal>
  #           <nodeValue>1</nodeValue>
  #           <nodeKey>/</nodeKey>
  #         </nodeKeyVal>
  #       </nodeKeyVal>
  #       <nodeKeyVal>
  #       <nodeKeyVal>
  #         <nodeValue>1</nodeValue>
  #         <nodeKey></nodeKey>
  #       </nodeKeyVal>
  #       <nodeKey>www.tongs.org.uk</nodeKey>
  #     </nodeKeyVal>
  #     REST OF THE ELEMENTS SKIPPED .......
  #       </referrers>
  #       <hash>1RmnUT</hash>
  #     <clicks>2343</clicks>
  #   </results>
  #   <statusCode>OK</statusCode>
  # </bitly>
  
  
  class Response::Stats < UrlShortener::Response
    
    def initialize(response)
      super
    end
    
    # Just to override the hash method provided by hashie
    # that adds some other hash value
    def hash
      result['hash']
    end
    
    def referrers
      find_referrers
    end
    
    def user_referrers
      find_referrers(true)
    end
    
    # There are user referrers and only referrers
    def find_referrers(user_referrers=false)
      return unless referrer_data?
      base_referrer = user_referrers ? attributes.userReferrers : attributes.referrers
      return unless base_referrer
      referrer_values(base_referrer)
    end
    
    private
    
    def referrer_values(base_referrer)
      collect_referrers = []
      base_referrer.nodeKeyVal.each { |base| collect_referrers << full_referrer_urls(base) if node_key?(base) }
      collect_referrers.flatten
    end
    
    def full_referrer_urls(base)
      return unless node_key?(base)
      resources = base.nodeKeyVal.is_a?(Array) ? base.nodeKeyVal.collect{|node| node.nodeKey} : base.nodeKeyVal.nodeKey
      referrer_urls(base.nodeKey, resources)
    end
    
    def node_key?(base)
      !(base.nil? || base.nodeKeyVal.nil?)
    end
    
    def attributes_present?
      !(attributes.nil? || attributes.empty?)
    end
    
    def referrers_present?(another_attr=nil)
      return !(attributes.referrers.nil? || attributes.referrers.empty?) unless another_attr
      !(attributes.send(:another_attr).nil? || attributes.send(:another_attr).empty?)
    end
    
    def referrer_data?
      attributes_present? && referrers_present?
    end
    
    def referrer_urls(base_url, resources)
      return base_url unless resources
      resources.collect { |resource| "#{base_url}#{resource}" }
    end
    
  end
end