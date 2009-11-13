# ==============
# = When Steps =
# ==============
When /^I submit a request to shorten the url "([^\"]*)"$/ do |url|
  @response = client.shorten(url)
end

When /^I submit a request to shorten the urls "([^\"]*)" and "([^\"]*)"$/ do |url1, url2|
  @response = client.shorten(url1, url2)
end


When /^I submit a request to expand a short url using the hash "([^\"]*)"$/ do |hash|
  @response = client.expand(:hash => hash)
end

When /^I submit a request to expand a short url using the short url "([^\"]*)"$/ do |short_url|
  @response = client.expand(:shortUrl => short_url)
end

When /^I submit a request to get stats for a short url using the hash "([^\"]*)"$/ do |hash|
  @response = client.stats(:hash => hash)
end

When /^I submit a request to get stats for a short url using the short url "([^\"]*)"$/ do |short_url|
  @response = client.stats(:shortUrl => short_url)
end

When /^I submit a request to get info for a short url using the hash "([^\"]*)"$/ do |hash|
  @response = client.info(:hash => hash)
end

When /^I submit a request to get info for a short url using the short url "([^\"]*)"$/ do |short_url|
  @response = client.info(:shortUrl => short_url)
end

# ==============
# = Then Steps =
# ==============
Then /^I should get the response from "([^\"]*)"$/ do |arg1|
  @response.should_not be_nil
end

Then /^the shorten url should be "([^\"]*)"$/ do |short_url|
  @response.urls.should eql(short_url)
end

Then /^the shorten url should be "([^\"]*)" and "([^\"]*)"$/ do |expanded_url1, expanded_url2|
  @response.urls.should include(expanded_url1, expanded_url2)
end

Then /^the hash values should be "([^\"]*)" and "([^\"]*)"$/ do |hash1, hash2|
  @response.hashes.should include(hash1, hash2)
end


Then /^the hash should be "([^\"]*)"$/ do |hash|
  @response.hashes.should eql(hash)
end

Then /^the expanded url should be "([^\"]*)" for "([^\"]*)"$/ do |expanded_url, request_parameter|
  @response.url.should eql(expanded_url)
end

Then /^the result should have "([^\"]*)" and "([^\"]*)" keys in the returned hash$/ do |key1,key2|
  @response.result.keys.should include(key1, key2)
end

Then /^the result should have "([^\"]*)" key in the returned hash$/ do |key|
  @response.result.keys.should include(key)
end

Then /^the result doc hash should have "([^\"]*)", "([^\"]*)", "([^\"]*)", etc keys$/ do |key1, key2, key3|
  @response.result['doc'].keys.should include(key1, key2, key3)
end

private

def client
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  UrlShortener::Client.new(authorize)
end


