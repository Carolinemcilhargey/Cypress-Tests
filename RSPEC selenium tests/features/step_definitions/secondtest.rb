# -*- encoding : utf-8 -*-
require 'selenium-webdriver'
Selenium::WebDriver::Chrome.driver_path = "/Users/e0061509/Documents/selenium tests/chromedriver"
driver = Selenium::WebDriver.for(:chrome, detach: true)

Given("I am on Arnoldclark.com homepage") do
    driver.get("http://arnoldclark.com")
end

When("I select a make and model from the drop down") do
    dropDownMenu = driver.find_element(:name, 'make')
    option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
    option.select_by(:value, 'Audi')
    driver.find_element(:id, 'search-button').click
end

Then("I should be directed to the serps page with the correct filters applied") do
    url = driver.current_url
    raise "URL NOT AS EXPECTED" unless url == "https://www.arnoldclark.com/used-cars/search?utf8=%E2%9C%93&make=Audi&model=&payment_type=monthly&min_price=&max_price="

end

