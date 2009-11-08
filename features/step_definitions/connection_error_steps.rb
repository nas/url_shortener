# ===============
# = Given Steps =
# ===============
Given /^I use "([^\"]*)" "([^\"]*)" login name as "([^\"]*)"$/ do |info_type, service, login|
  @login = login
end

Given /^I use "([^\"]*)" "([^\"]*)" api key as "([^\"]*)"$/ do |info_type, service, api_key|
  @api_key = api_key
end

Given /^I use "([^\"]*)" credentials$/ do |info_type|
  @authorize = UrlShortener::Authorize.new(@login, @api_key)
end

Given /^"([^\"]*)" is online$/ do |site|
  check_url=Net::HTTP.get_response(URI.parse('http://'+site))
  check_url.code.should eql '200'
end

# ==============
# = When Steps =
# ==============

When /^I submit a request to "([^\"]*)"$/ do |arg1|
  begin
    @client = UrlShortener::Client.new(@authorize)
    @client.shorten('http://cnn.com')
  rescue => e
    @error = e
  end
end

# ==============
# = Then steps =
# ==============


Then /^I should get the "([^\"]*)" error$/ do |error_class|
  @error.class.to_s.should eql(error_class)
end