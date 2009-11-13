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
  
  describe "API actions" do
    before(:each) do
      authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(authorize)
      @interface = stub('UrlShortener::Interface', :get => {})
      @client.stub!(:interface).and_return(@interface)
    end
    
    describe "#shorten" do
      before(:each) do
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
      
      it "should return the UrlShortener::Response::Shorten object" do
        @client.shorten(@url).should be_instance_of(UrlShortener::Response::Shorten)
      end

    end
    
    describe "#stats" do
      before(:each) do
        @hash = 'qweWE' 
        @short_url = 'http://bit.ly/wesSD'
        @end_point = 'http://api.bit.ly/stats'
        @client.stub!(:end_point).and_return(@end_point)
      end
      
      it "should raise IncompleteRequestParameter when key value pair for neither hash nor shortUrl is not present" do
        lambda {@client.stats(:invalid => 'anyvalue')}.should raise_error(UrlShortener::IncompleteRequestParameter)
      end
      
      it "should get the end point" do
        @client.should_receive(:end_point).with('stats')
        @client.stats(:hash => @hash)
      end
      
      it "should use the interface to connect and pass the hash when url hash is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :hash => 'qweWE'}).and_return(@interface)
        @client.stats(:hash => @hash)
      end

      it "should use the interface to connect and pass the shortUrl when shortUrl is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :shortUrl => 'http://bit.ly/wesSD'}).and_return(@interface)
        @client.stats(:shortUrl => @short_url)
      end
      
      it "should get the data using interface" do
        @interface.should_receive(:get)
        @client.stats(:hash => @hash)
      end
    end
    
    describe "#info" do
      before(:each) do
        @hash = 'qweWE' 
        @short_url = 'http://bit.ly/wesSD'
        @end_point = 'http://api.bit.ly/info'
        @client.stub!(:end_point).and_return(@end_point)
      end
      
      it "should raise IncompleteRequestParameter when key value pair for neither hash nor shortUrl is not present" do
        lambda {@client.info(:invalid => 'anyvalue')}.should raise_error(UrlShortener::IncompleteRequestParameter)
      end
      
      it "should get the end point" do
        @client.should_receive(:end_point).with('info')
        @client.info(:hash => @hash)
      end
      
      it "should use the interface to connect and pass the hash when url hash is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :hash => 'qweWE'}).and_return(@interface)
        @client.info(:hash => @hash)
      end

      it "should use the interface to connect and pass the shortUrl when shortUrl is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :shortUrl => 'http://bit.ly/wesSD'}).and_return(@interface)
        @client.info(:shortUrl => @short_url)
      end
      
      it "should get the data using interface" do
        @interface.should_receive(:get)
        @client.info(:hash => @hash)
      end
    end

    describe "#expand" do
     before(:each) do
        @hash = 'qweWE' 
        @short_url = 'http://bit.ly/wesSD'
        @end_point = 'http://api.bit.ly/expand'
        @client.stub!(:end_point).and_return(@end_point)
      end

      it "should raise IncompleteRequestParameter when key value pair for neither hash nor shortUrl is not present" do
        lambda {@client.expand(:invalid => 'anyvalue')}.should raise_error(UrlShortener::IncompleteRequestParameter)
      end

      it "should get the end point" do
        @client.should_receive(:end_point).with('expand')
        @client.expand(:hash => @hash)
      end

      it "should use the interface to connect to bitly and pass the hash when url hash is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :hash => 'qweWE'}).and_return(@interface)
        @client.expand(:hash => @hash)
      end

      it "should use the interface to connect to bitly and pass the shortUrl when shortUrl is used" do
        @client.should_receive(:interface).with(nil, {:rest_url => @end_point, :shortUrl => 'http://bit.ly/wesSD'}).and_return(@interface)
        @client.expand(:shortUrl => @short_url)
      end

      it "should get the data using interface" do
        @interface.should_receive(:get)
        @client.expand(:hash => @hash)
      end
      
      it "should return the long url of the hash provided" do
        @interface.should_receive(:get).and_return('qweWE' => {'longUrl' => 'http://www.goog.com'})
        @client.expand(:hash => @hash).result['qweWE'].values.should include('http://www.goog.com')
      end
      
      it "should return the long url for the shortUrl provided" do
        @interface.should_receive(:get).and_return('wesSD' => {'longUrl' => 'http://www.goog.com'})
        @client.expand(:shortUrl => @short_url).result['wesSD'].values.should include('http://www.goog.com')
      end
      
      it "should return the UrlShortener::Response::Expand object" do
        @client.expand(:hash => @hash).should be_instance_of(UrlShortener::Response::Expand)
      end
      
    end
  end
  
  describe "#interface" do
    before(:each) do
      authorize = UrlShortener::Authorize.new 'login', 'key'
      @client = UrlShortener::Client.new(authorize)
      @common_query_parameters = {}
      @client.stub!(:common_query_parameters).and_return(@common_query_parameters)
      @first_parameter = '/some/uri'
      @url = '/a/url'
    end
    
    it "should initialize the interface object" do
      UrlShortener::Interface.should_receive(:new).with('/some/uri', :query => {})
      @client.interface(@first_parameter)
    end
    
    it "should get the common query parameters" do
      @client.should_receive(:common_query_parameters)
      @client.interface(@first_parameter)
    end
    
    it "should use the rest_url key from the options if first_parameter is set to nil" do
      UrlShortener::Interface.should_receive(:new).with('/a/url', :query => {})
      @client.interface(nil, {:rest_url => @url})
    end
    
    it "should use the first parameter if rest_url option as well as the first parameter is provided" do
      UrlShortener::Interface.should_receive(:new).with('/some/uri', :query => {})
      @client.interface(@first_parameter, {:rest_url => @url})
    end
    
    it "should raise an error when neither the first parameter is set nor the rest_url options" do
      lambda { @client.interface(nil, {}) }.should raise_error("You must provide either the endpoint as the first parameter or set the :rest_url options")
    end
    
    it "should remove the rest_url key value from the options" do
      options = {:rest_url => @url}
      options.should_receive(:delete).with(:rest_url)
      @client.interface(@first_parameter, options)
    end
    
    it "should merge the rest of the options passed to the common_query_parameters" do
      options = {:rest_url => @url, :tt => 'val'}
      @common_query_parameters.should_receive(:merge!).with(options)
      @client.interface(@first_parameter, options)
    end
    
    it "should keys for the parameters that are passed in the options" do
      options = {:rest_url => @url, :tt => 'val'}
      UrlShortener::Interface.should_receive(:new).with('/a/url', :query => {:tt => 'val'})
      @client.interface(nil, options)
    end
  end
  
end