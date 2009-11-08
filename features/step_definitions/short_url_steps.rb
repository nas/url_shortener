# ==============
# = When Steps =
# ==============
When /^I submit a request to shorten the url "([^\"]*)"$/ do |url|
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  client = UrlShortener::Client.new(authorize)
  @result = client.shorten(url)
end

# ==============
# = Then Steps =
# ==============
Then /^I should get the response from "([^\"]*)"$/ do |arg1|
  @result.should_not be_nil
end

Then /^the shorten url should be "([^\"]*)"$/ do |short_url|
  @result['shortUrl'].should eql(short_url)
end

Then /^the hash should be "([^\"]*)"$/ do |hash|
  @result['hash'].should eql(hash)
end