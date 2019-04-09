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
    


 
    driver.get("http://arnoldclark.com")
    driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "make")).select_by(:text, "MG")
    driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "model")).select_by(:text, "MG3")
    driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Monthly payment'])[1]/following::label[1]").click
    driver.find_element(:name, "min_price").click
    
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "min_price")).select_by(:text, "£5000")
    driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "max_price")).select_by(:text, "£30,000")
    driver.find_element(:id, "search-button").click
    assert(driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "MG" 
  end
  
    assert(driver.find_element(:xpath, "(.//*[normalizc e-space(text()) and normalize-space(.)='MG'])[5]/following::li[1]").text).should == "MG3" 
end
    verify { (driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='MG3'])[4]/following::li[1]").text).should == "£5000 min cash price" }
   verify { (driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£5000 min cash price'])[1]/following::li[1]").text).should == "£30000 max cash price" }
   driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Insurance'])[1]/following::div[5]").click
   verify { (driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Insurance'])[1]/following::p[1]").text).should == "Expect the best used car deals in the UK, guaranteed. Find out more" }
  

