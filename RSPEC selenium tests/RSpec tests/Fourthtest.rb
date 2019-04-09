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

  
  it "test_fourth" do
    @driver.get "https://www.arnoldclark.com/"
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "BMW")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "6 Series")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    # ERROR: Caught exception [ERROR: Unsupported command [doubleClick | xpath=(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5] | ]]
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:name, "min_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£70")
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£225")
    @driver.find_element(:id, "search-button").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£70 min monthly payment'])[1]/following::li[1]").click
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "BMW"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='BMW'])[5]/following::li[1]").text).should == "6 Series"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='BMW'])[5]/following::li[2]").text).should == "£70 min monthly payment"
  end
  
  def element_present?(how, what)
    driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end





