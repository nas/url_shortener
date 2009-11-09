require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrlShortener::Client do
  describe ".new" do
    before(:each) do
      @authorize = UrlShortener::Authorize.new 'login', 'key'
    end
    
    it "should recieve the authorize object" do
      client = UrlShortener::Client.new(@authorize)
      client.authorize.should eql(@authorize)
    end
    
    it "should raise an error if the authorize attribute is not a UrlShortener::Authorize object" do
      lambda{ UrlShortener::Client.new(nil) }.should raise_error(UrlShortener::AuthorizationFailure)
    end
    
  end
  
  describe "#end_point" do
    before(:each) do
      @authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(@authorize)
      @resource = 'any'
    end
    
    it "should get the base url from authorization" do
      @authorize.should_receive(:base_url)
      @client.end_point(@resource)
    end
    
    it "should return the combination of base url and resource" do
      @client.end_point(@resource).should eql('http://api.bit.ly/any')
    end
  end
  
  describe "#common_query_parameters" do
    before(:each) do
      @authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(@authorize)
    end
    
    it "should return a hash of comman parameters" do
      @client.common_query_parameters.should be_instance_of(Hash)
    end
    
    it "should include the login key" do
      @client.common_query_parameters.keys.should include(:login)
    end
    
    it "should include the apiKey key" do
      @client.common_query_parameters.keys.should include(:apiKey)
    end
    
    it "should include the version key" do
      @client.common_query_parameters.keys.should include(:version)
    end
    
    it "should include the format key" do
      @client.common_query_parameters.keys.should include(:format)
    end
    
    it "should get login attribute of authorize object" do
      @authorize.should_receive(:login)
      @client.common_query_parameters
    end
    
    it "should have the login key value from the login attribute of authorize object" do
      @client.common_query_parameters[:login].should eql('login')
    end
    
    it "should get api key attribute of authorize object" do
      @authorize.should_receive(:api_key)
      @client.common_query_parameters
    end
    
    it "should have the apikey value from the api_key attribute of authorize object" do
      @client.common_query_parameters[:apiKey].should eql('key')
    end
    
    it "should have the value of xml for the format key" do
      @client.common_query_parameters[:format].should eql('xml')
    end
  end
  
  describe "#shorten" do
    before(:each) do
      authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(authorize)
      @interface = stub('UrlShortener::Interface', :get => {})
      @client.stub!(:interface).and_return(@interface)
      @url = 'http://www.domain.com/path?params=value'
    end
    
    it "should do the url escaping" do
      CGI.should_receive(:escape).with(@url)
      @client.shorten(@url)
    end
    
    it "should get the end point" do
      @client.should_receive(:end_point)
      @client.shorten(@url)
    end
    
    it "should use the interface to connect to bitly" do
      @client.should_receive(:interface).and_return(@interface)
      @client.shorten(@url)
    end
    
    it "should get the data using interface" do
      @interface.should_receive(:get)
      @client.shorten(@url)
    end
    
  end
  
  describe "#interface" do
    before(:each) do
      authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(authorize)
      @client.stub!(:common_query_parameters).and_return({})
    end
    
    it "should initialize the interface object" do
      UrlShortener::Interface.should_receive(:new).with('/some/uri', :query => {})
      @client.interface('/some/uri')
    end
    
    it "should get the common query parameters" do
      @client.should_receive(:common_query_parameters)
      @client.interface('/some/uri')
    end
  end
  
end