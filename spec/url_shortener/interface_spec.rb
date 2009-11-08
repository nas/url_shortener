require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrlShortener::Interface do
  
  describe ".new" do
    it "should have the rest url" do
      @interface = UrlShortener::Interface.new('some/url')
      @interface.rest_url.should eql('some/url')
    end
    
    it "should raise error when nil parameter is provided" do
      lambda { UrlShortener::Interface.new(nil) }.should raise_error('Interface Url cannot be nil')
    end
  end
  
  describe "#get" do
    before(:each) do
      @rest_url = 'http://some/url'
      @interface = UrlShortener::Interface.new(@rest_url)
      @interface.stub!(:result?).and_return(true)
      @result = {'bitly' => {'errorCode' => '0', 'statusCode' => 'OK', 'results' => 'return result'}}
      UrlShortener::Interface.stub!(:get).and_return(@result)
    end
    
    it "should call the get class method provided by httparty" do
      UrlShortener::Interface.should_receive(:get).with(@rest_url,{}).and_return(@result)
      @interface.get
    end
    
    it "should have a 10 second timeout set" do
      @interface.should_receive(:timeout).with(10)
      @interface.get
    end
    
    it "should raise NoResult error whern there is no result" do
      @interface.stub!(:result?)
      lambda { @interface.get }.should raise_error(UrlShortener::NoResult, "No result returned from bit.ly")
    end
    
    it "should raise AuthorizationFailure error when not authorised and error code in 203" do
      result = {'bitly' => {'errorCode' => '203', 'errorMessage' => 'Any message returned'}}
      UrlShortener::Interface.stub!(:get).and_return(result)
      lambda { @interface.get }.should raise_error(UrlShortener::AuthorizationFailure, "Any message returned")
    end
    
    it "should raise response failure when returned status code is not OK and error code is not 0" do
      result = {'bitly' => {'errorCode' => 'not 0', 'statusCode' => 'not OK', 'errorMessage' => 'Any message returned'}}
      UrlShortener::Interface.stub!(:get).and_return(result)
      lambda { @interface.get }.should raise_error(UrlShortener::ResponseFailure, "Any message returned")
    end
    
    it "should return the results hash from the returned results if status code is OK and errorCode is 0" do
      @interface.get.should eql('return result')
    end
  end
  
  describe "#result?" do
    before(:each) do
      @rest_url = 'http://some/url'
      @interface = UrlShortener::Interface.new(@rest_url)
    end
    it "should return false if result is not present" do
      @interface.result?(nil).should eql(false)
    end
    
    it "should return false if result is not a hash" do
      @interface.result?('d').should eql(false)
    end
    
    it "should return false if there is no 'bitly' key in the result" do
      @interface.result?({}).should eql(false)
    end
    
    it "should return nil if the value for 'bitly' key is nil" do
      @interface.result?({'bitly' => nil}).should eql(false)
    end
    
    it "should return false if the value for 'bitly' key is an empty hash" do
      @interface.result?({'bitly' => {}}).should eql(false)
    end
    
    it "should return true if the value for 'bitly' key is a hash with some key values" do
      @interface.result?({'bitly' => {'otherkeys' => 'othervalues'}}).should eql(true)
    end
  end
end