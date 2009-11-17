require File.dirname(__FILE__) + '/../../spec_helper'

describe UrlShortener::Response::Stats do
  
  describe "#clicks" do
    before(:each) do
      @hashie = stub('Hashie::Mash')
      @response = {:referrers => {:key => :val}, :clicks => '23'}
      @stats = UrlShortener::Response::Stats.new(@response)
      @stats.stub!(:attributes).and_return(@hashie)
      @hashie.stub!(:clicks)
    end
    
    it "should get the hash attributes" do
      @stats.should_receive(:attributes).and_return(@hashie)
      @stats.clicks
    end
    
    it "should get the clicks from the hash attributes" do
      @hashie.should_receive(:clicks)
      @stats.clicks
    end
    
    it "should return nil when response is empty" do
      response = {}
      @stats = UrlShortener::Response::Stats.new(response)
      @stats.clicks.should eql(nil)
    end
  end
  
  describe "#user_clicks" do
    before(:each) do
      @hashie = stub('Hashie::Mash')
      @response = {:referrers => {:key => :val}, :clicks => '23', :userClicks => '233'}
      @stats = UrlShortener::Response::Stats.new(@response)
      @stats.stub!(:attributes).and_return(@hashie)
      @hashie.stub!(:userClicks).and_return('233')
    end
    
    it "should get the hash attributes" do
      @stats.should_receive(:attributes).and_return(@hashie)
      @stats.user_clicks
    end
    
    it "should get the user clicks from the hash attributes" do
      @hashie.should_receive(:userClicks)
      @stats.user_clicks
    end
    
    it "should return userClicks" do
      @stats.user_clicks.should eql('233')
    end
    
    it "should return nil when response is empty" do
      response = {}
      @stats = UrlShortener::Response::Stats.new(response)
      @stats.user_clicks.should eql(nil)
    end
  end
  
  describe "#referrers" do
    before(:each) do
      @response = {:referrers => {:nodeKeyVal => {:nodeKey => 'val'}}}
      @stats = UrlShortener::Response::Stats.new(@response)    end
    
    it "should get the hash attributes" do
      @stats.should_receive(:find_referrers)
      @stats.referrers
    end
    
  end
  
  describe "#user_referrers" do
    before(:each) do
      @response = {:referrers => {:nodeKeyVal => {:nodeKey => 'val'}}}
      @stats = UrlShortener::Response::Stats.new(@response)    
    end
    
    it "should get the hash attributes" do
      @stats.should_receive(:find_referrers).with(true)
      @stats.user_referrers
    end
    
  end
  
  describe "#find_referrers" do
    before(:each) do
      @response = {:referrers => {:nodeKeyVal => {:nodeKey => 'val'}}}
      @stats = UrlShortener::Response::Stats.new(@response)    
    end
    
    it "should check if referrer data is present " do
      @stats.should_receive(:referrer_data?)
      @stats.find_referrers
    end
    
    context "when no referrer data present" do
      before(:each) do
        @stats.stub!(:referrer_data?)
      end
      it "should return nil" do
        @stats.find_referrers.should eql(nil)
      end
      
      it "should try to find the attributes" do
        @stats.should_receive(:attributes).never
        @stats.find_referrers
      end
      
      it "should not try to get the referrer values" do
        @stats.should_receive(:referrer_values).never
        @stats.find_referrers
      end
    end
    
    context "when referrer data is present but referrer element is not" do
      before(:each) do
        @hashie = stub('Hashie::Mash')
        @stats.stub!(:referrer_data?).and_return(true)
        @stats.stub!(:attributes).and_return(@hashie)
        @hashie.stub!(:referrers)
        @hashie.stub!(:userReferrers)
      end
      
      it "should find the attributes" do
        @stats.should_receive(:attributes).times.at_least(1)
        @stats.find_referrers
      end
      
      it "should get referrers if true is not passed in parameter for user referrers" do
        @hashie.should_receive(:referrers)
        @stats.find_referrers
      end
      
      it "should not get user referrers if true is not passed in parameter for user referrers" do
        @hashie.should_receive(:userReferrers).never
        @stats.find_referrers
      end
      
      it "should get user referrers if true is passed in parameter for user referrers" do
        @hashie.should_receive(:userReferrers)
        @stats.find_referrers(true)
      end
      
      it "should not get referrers if true is passed in parameter for user referrers" do
        @hashie.should_receive(:referrers).never
        @stats.find_referrers(true)
      end
      
      it "should not get referrer values when referrers are not present" do
        @stats.should_receive(:referrer_values).never
        @stats.find_referrers
      end
    end
    
    context "when both referrer data referrer element is present" do
      before(:each) do
        @hashie = stub('Hashie::Mash')
        @stats.stub!(:referrer_data?).and_return(true)
        @stats.stub!(:attributes).and_return(@hashie)
        @hashie.stub!(:referrers).and_return(@hashie)
      end
      
      it "should get referrer values when referrers are present" do
        @stats.should_receive(:referrer_values).with(@hashie)
        @stats.find_referrers
      end
    end
    
  end
  
end