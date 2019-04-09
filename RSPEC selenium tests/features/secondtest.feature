Feature: Naviagte to serps page 
   Scenario: A user searches for make and model and is directed to serps page 

Given I am on Arnoldclark.com homepage
When I select a make and model from the drop down
Then I should be directed to the serps page with the correct filters applied

