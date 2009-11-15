require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrlShortener::Response do
  
  describe ".new" do
    before(:each) do
      @response_hash = {:a_key => 'value'}
      @attribute = stub('Hashie::Mash')
      Hashie::Mash.stub!(:new).and_return(@attribute)
      @response = UrlShortener::Response.new(@response_hash)
    end
    
    it "should set the result method" do
      @response.result.should eql(@response_hash)
    end
    
    it "should set the attrubutes" do
      @response.attributes.should eql(@attribute)
    end
    
    it "should initialize a new Hashie::Mash attribute" do
      Hashie::Mash.should_receive(:new).with(@response_hash)
      @response.attributes    
      UrlShortener::Response.new(@response_hash)
    end
  end
end