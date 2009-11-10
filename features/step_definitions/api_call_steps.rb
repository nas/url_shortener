# ==============
# = When Steps =
# ==============
When /^I submit a request to shorten the url "([^\"]*)"$/ do |url|
  @result = client.shorten(url)
end

When /^I submit a request to shorten the urls "([^\"]*)" and "([^\"]*)"$/ do |url1, url2|
  @result = client.shorten(url1, url2)
end


When /^I submit a request to expand a short url using the hash "([^\"]*)"$/ do |hash|
  @result = client.expand(:hash => hash)
end

When /^I submit a request to expand a short url using the short url "([^\"]*)"$/ do |short_url|
  @result = client.expand(:shortUrl => short_url)
end

When /^I submit a request to get stats for a short url using the hash "([^\"]*)"$/ do |hash|
  @result = client.stats(:hash => hash)
end

When /^I submit a request to get stats for a short url using the short url "([^\"]*)"$/ do |short_url|
  @result = client.stats(:shortUrl => short_url)
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

Then /^the shorten url should be "([^\"]*)" and "([^\"]*)"$/ do |expanded_url1, expanded_url2|
  @result.each do |res|
    res['shortUrl'].should eql(expanded_url1) if res['nodeKey'] == 'http://www.github.com/nas'
    res['shortUrl'].should eql(expanded_url2) if res['nodeKey'] == 'http://www.google.com'
  end
end

Then /^the hash values should be "([^\"]*)" and "([^\"]*)"$/ do |hash1, hash2|
  @result.each do |res|
    res['hash'].should eql(hash1) if res['nodeKey'] == 'http://www.github.com/nas'
    res['hash'].should eql(hash2) if res['nodeKey'] == 'http://www.google.com'
  end
end


Then /^the hash should be "([^\"]*)"$/ do |hash|
  @result['hash'].should eql(hash)
end

Then /^the expanded url should be "([^\"]*)"$/ do |expanded_url|
  @result.should eql(expanded_url)
end

Then /^the result should have "([^\"]*)" and "([^\"]*)" keys in the returned hash$/ do |key1,key2|
  @result.keys.should include(key1, key2)
end

private

def client
  authorize = UrlShortener::Authorize.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  UrlShortener::Client.new(authorize)
end


