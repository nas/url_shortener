Feature: When requests fail
	In order to take appropriate measures
	As a user
	I want to be able to get meaningful and appropriate messages when I am not able to connect to bit.ly

	Scenario: Return authorization failure when correct login is present and api key is wrong
		Given I use "correct" "bit.ly" login name as "bitlyapidemo"
		And I use "incorrect" "bit.ly" api key as "123123"
		And I use "incorrect" credentials
		When I submit a request to "bit.ly"
		Then I should get the "UrlShortener::AuthorizationFailure" error
		
	Scenario: Return authorization failure when correct api key is present with wrong login name
		Given I use "incorrect" "bit.ly" login name as "123123"
		And I use "correct" "bit.ly" api key as "R_0da49e0a9118ff35f52f629d2d71bf07"
		And I use "incorrect" credentials
		When I submit a request to "bit.ly"
		Then I should get the "UrlShortener::AuthorizationFailure" error