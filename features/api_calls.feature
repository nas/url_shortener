Feature: REST calls to bit.ly API
	In order to use bitly url shortening services
	As a user
	I want to make API calls and get information about a URL

	Scenario: Create a short url when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to shorten the url "http://www.github.com/nas"
		Then I should get the response from "bit.ly"
		And the shorten url should be "http://bit.ly/6NaDb"
		And the hash should be "2oV4lu"
	
	Scenario: Create multiple short urls when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to shorten the urls "http://www.github.com/nas" and "http://www.google.com"
		Then I should get the response from "bit.ly"
		And the shorten url should be "http://bit.ly/6NaDb" and "http://bit.ly/8ttn"
		And the hash values should be "2oV4lu" and "2V6CFi"
	
	Scenario: Expand the hash when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to expand a short url using the hash "2oV4lu"
		Then I should get the response from "bit.ly"
		And the expanded url should be "http://www.github.com/nas" for "2oV4lu"
	
	Scenario: Expand the short url when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to expand a short url using the short url "http://bit.ly/6NaDb"
		Then I should get the response from "bit.ly"
		And the expanded url should be "http://www.github.com/nas" for "6NaDb"
	
	Scenario: Get stats from the hash when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to get stats for a short url using the hash "2oV4lu"
		Then I should get the response from "bit.ly"
		And the result should have "referrers" and "clicks" keys in the returned hash

	Scenario: Get stats from the short url when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to get stats for a short url using the short url "http://bit.ly/6NaDb"
		Then I should get the response from "bit.ly"
		And the result should have "referrers" and "clicks" keys in the returned hash
	
	Scenario: Get information from the hash when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to get info for a short url using the hash "2oV4lu"
		Then I should get the response from "bit.ly"
		And the result should have "doc" key in the returned hash
		And the result doc hash should have "longUrl", "shortenedByUser", "htmlTitle", etc keys
		
	Scenario: Get information from the short url when correct login and api key is present
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "correct" credentials
		And "bit.ly" is online
		When I submit a request to get info for a short url using the short url "http://bit.ly/6NaDb"
		Then I should get the response from "bit.ly"
		And the result should have "doc" key in the returned hash
		And the result doc hash should have "longUrl", "shortenedByUser", "htmlTitle", etc keys