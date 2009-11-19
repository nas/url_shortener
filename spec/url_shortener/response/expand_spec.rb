require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe UrlShortener::Response::Expand do
  
  describe "#url" do
    before(:each) do
      @result_hash = {"1RmnUT" => {"longUrl" => "http://google.com"}}
      @expand = UrlShortener::Response::Expand.new(@result_hash)
      @expand.stub!(:long_url).and_return('http://google.com')
    end
    
    it "should get the long_url" do
      @expand.should_receive(:long_url)
      @expand.url
    end
    
    it "should return the longUrl" do
      @expand.url.should eql("http://google.com")
    end
  end
end