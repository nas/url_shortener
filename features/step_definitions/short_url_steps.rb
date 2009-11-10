# ==============
# = When Steps =
# ==============
When /^I submit a request to shorten the url "([^\"]*)"$/ do |url|
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  client = UrlShortener::Client.new(authorize)
  @result = client.shorten(url)
end

When /^I submit a request to expand a short url using hash$/ do
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  client = UrlShortener::Client.new(authorize)
  @result = client.expand(:hash => 'DyE5')
end

When /^I submit a request to expand a short url using short url$/ do
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  client = UrlShortener::Client.new(authorize)
  @result = client.expand(:shortUrl => 'http://bit.ly/1K8JOn')
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

Then /^the expanded url should be "([^\"]*)"$/ do |arg1|
  @result.should eql('http://www.google.co.uk/')
end


