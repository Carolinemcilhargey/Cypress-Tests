require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "ExampleRb" do

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
  
  it "test_example_rb" do
    @driver.get"https://www.arnoldclark.com/"
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Abarth")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "500")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:name, "min_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£150")
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£400")
    @driver.find_element(:id, "search-button").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "Abarth" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Abarth'])[5]/following::li[1]").text).should == "500" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Abarth'])[5]/following::li[2]").text).should == "£150 min monthly payment" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£150 min monthly payment'])[1]/following::li[1]").text).should == "£400 max monthly payment" }
    @driver.find_element(:link, "Arnold Clark").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Receive a free instant valuation today'])[1]/following::div[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Receive a free instant valuation today'])[1]/following::h2[1]").text).should == "Recommended for you" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Next'])[1]/following::div[2]").click
    verify { @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Next'])[1]/following::h2[1]").text.should =~ /^What’s new[\s\S]$/ }
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
