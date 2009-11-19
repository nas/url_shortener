require File.dirname(__FILE__) + '/../../spec_helper'

describe UrlShortener::Response::Info do
  
  describe "#hash" do
    before(:each) do
      @response = {"doc" => {"hash"=>"31IqMl"}}
      @info = UrlShortener::Response::Info.new(@response)
    end
    
    it "should check if doc element with value exists" do
      @info.should_receive(:doc_value?)
      @info.hash
    end
    
    it "should return nil if doc element does not have any values" do
      @info.stub!(:doc_value?).and_return(nil)
      @info.hash.should eql(nil)
    end
    
    it "should return the hash value if doc element has values" do
      @info.stub!(:doc_value?).and_return(true)
      @info.hash.should eql("31IqMl")
    end
  end
  
  
  
  
  
end