require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrlShortener::Response do
  
  describe ".new" do
    before(:each) do
      @response = {:a_key => 'value'}
    end
    
    it "should set the result attribute" do
      response = UrlShortener::Response.new(@response)
      response.result.should eql(@response)
    end
  end
end