# -*- encoding : utf-8 -*-
require "json"
require 'selenium-webdriver'
require "rspec"
require "Pry"
include RSpec::Expectations
Selenium::WebDriver::Chrome.driver_path = "/Users/e0061509/Documents/selenium tests/chromedriver"
driver = Selenium::WebDriver.for(:chrome, detach: true)


describe "my test" do
  before(:each) do

    @driver = Selenium::WebDriver.for(:chrome)
    @base_url = "https://www.arnoldclark.com"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end 
end

Given("I am an Arnold Clark user") do
  driver.get("http://arnoldclark.com")
end

When("i search for MG cars") do
  driver.find_element(:name, "make").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "make")).select_by(:text, "MG")
  driver.find_element(:name, "model").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "model")).select_by(:text, "MG3") 
end


Then("when i press search i should be presented the serps page with MG3s displaying") do 
  expect(message).to eql "120 Used MG MG3 cars for sale"
end

