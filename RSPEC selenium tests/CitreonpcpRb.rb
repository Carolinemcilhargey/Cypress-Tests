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
  
  it "test_citreonpcp_rb" do
    @driver.get "https://www.arnoldclark.com/nearly-new-cars/bmw/m5/m5-4dr-dct-competition-pack/2018/ref/cc_bw817rruyljkeviz"
    @driver.find_element(:link, "Arnold Clark").click
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Citroen")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "C4 Cactus")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:name, "min_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£90")
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£400")
    @driver.find_element(:id, "search-button").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "Ford" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Citroen'])[1]/following::li[1]").text).should == "C4 Cactus" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='C4 Cactus'])[4]/following::li[1]").text).should == "£90 min monthly payment" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£90 min monthly payment'])[1]/following::li[1]").text).should == "£400 max monthly payment" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Video tour'])[2]/following::a[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='About HP'])[1]/following::h2[1]").text).should == "Personal contract purchase" }
    @driver.find_element(:id, "deposit").clear
    @driver.find_element(:id, "deposit").send_keys "500"
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Annual mileage'])[1]/following::button[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Deposit'])[1]/following::span[1]").text).should == "£500" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Calculate your finance'])[1]/following::th[1]").text).should == "Monthly payment" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Representative APR'])[1]/following::button[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Send your enquiry'])[1]/following::span[1]").text).should == "Citroen C4 Cactus" }
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
