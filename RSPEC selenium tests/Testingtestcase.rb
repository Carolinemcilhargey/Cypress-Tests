# -*- encoding : utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Testingtestcase" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.katalon.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_ingtestcase" do
    @driver.get "https://www.arnoldclark.com/"
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Chrysler")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "Ypsilon")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Monthly payment'])[1]/following::label[1]").click
    @driver.find_element(:name, "min_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£1000")
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£30,000")
    @driver.find_element(:id, "search-button").click
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "Chrysler"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Chrysler'])[4]/following::li[1]").text).should == "Ypsilon"
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Ypsilon'])[4]/following::li[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Ypsilon'])[4]/following::li[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Ypsilon'])[4]/following::div[1]").click
  end
  
  def element_present?(how, what)
    ${receiver}.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    ${receiver}.switch_to.alert
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
    alert = ${receiver}.switch_to().alert()
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
