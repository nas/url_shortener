require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe UrlShortener::Response::Shorten do
  
  describe "#urls" do
    before(:each) do
      @response = {'nodeKeyVal' => {'shortUrl' => 'http://a/short/url'}}
      @shorten_response = UrlShortener::Response::Shorten.new(@response)
      @shorten_response.stub!(:result).and_return(@response)
    end
    
    it "should get the result" do
      @shorten_response.should_receive(:result).at_least(1).and_return(@response)
      @shorten_response.urls
    end
    
    it "should check whether result's nodeKeyVal values is an array" do
      @response['nodeKeyVal'].should_receive(:is_a?).with(Array)
      @shorten_response.urls
    end
    
    it "should raise when there are no results" do
      @shorten_response.should_receive(:raise_if_no_result)
      @shorten_response.urls
    end
    
    describe "when no results are returned" do
      before(:each) do
        @response = {}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
      end
      
      it "should raise error if there is no 'nodeKeyVal' key in the response parameter" do
        lambda { @shorten_response.urls }.should raise_error(UrlShortener::NoResult, "Empty Result set.")
      end
      
      it "should raise error when if the response parameter  or result is empty?" do
        @response = nil
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        lambda { @shorten_response.urls }.should raise_error(UrlShortener::NoResult, "Empty Result set.")      
      end
    end
    
    describe "when returned result is not an array" do
      before(:each) do
        @response['nodeKeyVal'].stub!(:is_a?).and_return(false)
      end
      
      it "should return the short url" do
        @shorten_response.urls.should eql('http://a/short/url')
      end
      
    end
    
    describe "when returned result is an array" do
      before(:each) do
        @response = {'nodeKeyVal' => [{'shortUrl' => 'http://a/short/url'}, {'shortUrl' => 'http://another/short/url'}]}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        @shorten_response.stub!(:result).and_return(@response)
      end
      
      it "should return an array of short urls" do
        @shorten_response.urls.should include('http://a/short/url', 'http://another/short/url')
      end
      
    end
    
  end
  
  describe "#urls with long url keys" do
    before(:each) do
      @response = {'nodeKeyVal' => {'shortUrl' => 'http://a/short/url', 'nodeKey' => 'http://a/long/url'}}
      @shorten_response = UrlShortener::Response::Shorten.new(@response)
      @shorten_response.stub!(:result).and_return(@response)
    end
    
    describe "when no results are returned" do
      before(:each) do
        @response = {}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
      end
      
      it "should raise error if there is no 'nodeKeyVal' key in the response parameter" do
        lambda { @shorten_response.urls_with_long_url_keys }.should raise_error(UrlShortener::NoResult, "Empty Result set.")
      end
      
      it "should raise error when if the response parameter  or result is empty?" do
        @response = nil
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        lambda { @shorten_response.urls_with_long_url_keys }.should raise_error(UrlShortener::NoResult, "Empty Result set.")      
      end
    end
    
    describe "when returned result is not an array" do
      before(:each) do
        @response['nodeKeyVal'].stub!(:is_a?).and_return(false)
      end
      
      it "should return the long url as the hash key" do
        @shorten_response.urls_with_long_url_keys.keys.should include('http://a/long/url')
      end
      
      it "should return the short url as the hash value" do
        @shorten_response.urls_with_long_url_keys.values.should include('http://a/short/url')
      end
      
    end
    
    describe "when returned result is an array" do
      before(:each) do
        @response = {'nodeKeyVal' => [{'shortUrl' => 'http://a1/short/url', 'nodeKey' => 'http://a1/long/url'}, 
                                      {'shortUrl' => 'http://a2/short/url', 'nodeKey' => 'http://a2/long/url'}]}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        @shorten_response.stub!(:result).and_return(@response)
      end

      it "should return long urls as keys" do
        @shorten_response.urls_with_long_url_keys.keys.should include('http://a1/long/url', 'http://a2/long/url')
      end
      
      it "should return short urls as values" do
        @shorten_response.urls_with_long_url_keys.values.should include('http://a1/short/url', 'http://a2/short/url')
      end
      
      it "should have the first long url key value set to the first short url" do
        @shorten_response.urls_with_long_url_keys['http://a1/long/url'].should eql('http://a1/short/url')
      end
      
      it "should have the second long url key value set to the second short url" do
        @shorten_response.urls_with_long_url_keys['http://a2/long/url'].should eql('http://a2/short/url')
      end
      
      it "should only have two keys values when two short urls are returned" do
        @shorten_response.urls_with_long_url_keys.size.should eql(2)
      end

    end
    
  end
  
  describe "#hashes" do

    before(:each) do
      @response = {'nodeKeyVal' => {'hash' => 'aHash'}}
      @shorten_response = UrlShortener::Response::Shorten.new(@response)
      @shorten_response.stub!(:result).and_return(@response)
    end

    it "should get the result" do
      @shorten_response.should_receive(:result).at_least(1).and_return(@response)
      @shorten_response.hashes
    end

    it "should check whether result's nodeKeyVal values is an array" do
      @response['nodeKeyVal'].should_receive(:is_a?).with(Array)
      @shorten_response.hashes
    end

    it "should raise when there are no results" do
      @shorten_response.should_receive(:raise_if_no_result)
      @shorten_response.hashes
    end
      
    describe "when no results are returned" do
      before(:each) do
        @response = {}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
      end
      
      it "should raise error if there is no 'nodeKeyVal' key in the response parameter" do
        lambda { @shorten_response.hashes }.should raise_error(UrlShortener::NoResult, "Empty Result set.")
      end
    
      it "should raise error when if the response parameter  or result is empty?" do
        @response = nil
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        lambda { @shorten_response.hashes }.should raise_error(UrlShortener::NoResult, "Empty Result set.")      
      end
    end
    
    describe "when returned result is not an array" do
      before(:each) do
        @response['nodeKeyVal'].stub!(:is_a?).and_return(false)
      end
      
      it "should return the short url" do
        @shorten_response.hashes.should eql('aHash')
      end
      
    end
    
    describe "when returned result is an array" do
      before(:each) do
        @response = {'nodeKeyVal' => [{'hash' => 'aHash'}, {'hash' => 'anHash'}]}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        @shorten_response.stub!(:result).and_return(@response)
      end
      
      it "should return an array of hashes" do
        @shorten_response.hashes.should include('aHash', 'anHash')
      end
      
    end
    
  end
  
  describe "#hashes with long url keys" do
    before(:each) do
      @response = {'nodeKeyVal' => {'hash' => 'aHash', 'nodeKey' => 'http://a/long/url'}}
      @shorten_response = UrlShortener::Response::Shorten.new(@response)
      @shorten_response.stub!(:result).and_return(@response)
    end
    
    describe "when no results are returned" do
      before(:each) do
        @response = {}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
      end
      
      it "should raise error if there is no 'nodeKeyVal' key in the response parameter" do
        lambda { @shorten_response.hashes_with_long_url_keys }.should raise_error(UrlShortener::NoResult, "Empty Result set.")
      end
      
      it "should raise error when if the response parameter  or result is empty?" do
        @response = nil
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        lambda { @shorten_response.hashes_with_long_url_keys }.should raise_error(UrlShortener::NoResult, "Empty Result set.")      
      end
    end
    
    describe "when returned result is not an array" do
      before(:each) do
        @response['nodeKeyVal'].stub!(:is_a?).and_return(false)
      end
      
      it "should return the long url as the hash key" do
        @shorten_response.hashes_with_long_url_keys.keys.should include('http://a/long/url')
      end
      
      it "should return the short url as the hash value" do
        @shorten_response.hashes_with_long_url_keys.values.should include('aHash')
      end
      
    end
    
    describe "when returned result is an array" do
      before(:each) do
        @response = {'nodeKeyVal' => [{'hash' => 'a1Hash', 'nodeKey' => 'http://a1/long/url'}, 
                                      {'hash' => 'a2Hash', 'nodeKey' => 'http://a2/long/url'}]}
        @shorten_response = UrlShortener::Response::Shorten.new(@response)
        @shorten_response.stub!(:result).and_return(@response)
      end

      it "should return long urls as keys" do
        @shorten_response.hashes_with_long_url_keys.keys.should include('http://a1/long/url', 'http://a2/long/url')
      end
      
      it "should return hashes as values" do
        @shorten_response.hashes_with_long_url_keys.values.should include('a1Hash', 'a2Hash')
      end
      
      it "should have the first long url key value set to the first hash value" do
        @shorten_response.hashes_with_long_url_keys['http://a1/long/url'].should eql('a1Hash')
      end
      
      it "should have the second long url key value set to the second hash value" do
        @shorten_response.hashes_with_long_url_keys['http://a2/long/url'].should eql('a2Hash')
      end
      
      it "should only have two keys values when two short urls are returned" do
        @shorten_response.hashes_with_long_url_keys.size.should eql(2)
      end

    end
    
  end
  
end
