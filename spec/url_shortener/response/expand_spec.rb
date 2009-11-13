require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe UrlShortener::Response::Expand do
  
  describe "#url" do
    before(:each) do
      @result_hash = {"1RmnUT" => {"longUrl" => "http://google.com"}}
      @expand = UrlShortener::Response::Expand.new(@result_hash)
      @expand.stub!(:result).and_return(@result_hash)
      @keys = ['1RmnUT']
      @key = '1RmnUT'
      @result_hash.stub!(:keys).and_return(@keys)
      @keys.stub!(:first).and_return(@key)
      @expand.stub!(:result_present?).and_return(true)
      @expand.stub!(:key_present?).and_return(true)
    end
    
    it "should check if keys are present when results are present" do
      @expand.stub!(:result_present?).and_return(true)
      @expand.should_receive(:key_present?)
      @expand.url.should
    end
    
    it "should not check if keys are present when results are not present" do
      @expand.stub!(:result_present?).and_return(false)
      @expand.should_receive(:key_present?).never
      @expand.url.should
    end
    
    it "should return nil if there are no keys" do
      @expand.stub!(:key_present?).and_return(nil)
      @expand.url.should eql(nil)
    end
    
    it "should check if results are present" do
      @expand.should_receive(:result_present?)
      @expand.url.should
    end
    
    it "should return nil is result is not present" do
      @expand.stub!(:result_present?).and_return(nil)
      @expand.url.should eql(nil)
    end
    
    it "should get the result" do
      @expand.should_receive(:result).and_return(@result_hash)
      @expand.url
    end
    
    it "should find the keys in the result returned from bitley" do
      @result_hash.should_receive(:keys).and_return(@keys)
      @expand.url
    end
    
    it "should get first key as there will be only key returning from bitly" do
      @keys.should_receive(:first).and_return(@key)
      @expand.url
    end
    
    it "should return the longUrl" do
      @expand.url.should eql("http://google.com")
    end
  end
end