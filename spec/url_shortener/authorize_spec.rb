require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrlShortener::Authorize do
  
  describe ".new" do
    before(:each) do
      @url_shortener = UrlShortener::Authorize.new('login', 'key')
    end
    
    it "should have the login attribute" do
      @url_shortener.login.should eql('login')
    end
    
    it "should have the api key attribute" do
      @url_shortener.api_key.should eql('key')
    end

    it "should have the base url attribute set to bitly api" do
      @url_shortener.base_url.should eql('http://api.bit.ly')
    end

  end
end