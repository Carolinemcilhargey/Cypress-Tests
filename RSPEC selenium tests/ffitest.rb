# -*- encoding : utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
require "pry"
include RSpec::Expectations

describe "FfitestRb" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.arnoldclark.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_ffitest_rb" do
    @driver.get "https://www.arnoldclark.com/"
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Fiat")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "500")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:name, "min_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£100")
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£300")
    @driver.find_element(:id, "search-button").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Sort'])[2]/following::select[1]").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Sort'])[2]/following::select[1]")).select_by(:text, "Monthly payment (high to low)")
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").attribute("value")).should == "0"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Fiat'])[5]/following::li[1]").attribute("value")).should == "0"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Fiat'])[5]/following::li[2]").attribute("value")).should == "0"
    (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£100 min monthly payment'])[1]/following::li[1]").attribute("value")).should == "0"
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
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
    alert = @driver.switch_to().alert()
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
