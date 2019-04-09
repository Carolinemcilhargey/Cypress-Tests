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
  
  it "test_homepage" do
    @driver.get"https://www.arnoldclark.com/"
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Next'])[1]/following::div[2]").click
    verify { @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Next'])[1]/following::h2[1]").text.should =~ /^What’s new[\s\S]$/ }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Next'])[1]/following::div[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='More details'])[2]/preceding::button[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='More details'])[2]/preceding::button[1]").text).should == "Shortlist" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Search'])[1]/following::div[1]").click
    verify { @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Search'])[1]/following::p[1]").text.should =~ /^Selling your car[\s\S] We’ll buy it\. Receive a free instant valuation today$/ }
    @driver.find_element(:link, "Receive a free instant valuation today").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Tax strategy'])[2]/following::div[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Tax strategy'])[2]/following::h1[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Tax strategy'])[2]/following::form[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Tax strategy'])[2]/following::h1[1]").text).should == "We’re making selling your car simpler" }
    @driver.find_element(:link, "Arnold Clark").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Find a dealer'])[4]/following::div[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Find a dealer'])[4]/following::h2[1]").text).should == "Also from Arnold" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Also from Arnold'])[1]/following::a[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Insurance'])[1]/following::div[5]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Insurance'])[1]/following::h1[1]").text).should == "Customer Services" }
    @driver.find_element(:id, "branding").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='used cars'])[1]/following::caption[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='used cars'])[1]/following::caption[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='used cars'])[1]/following::caption[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='used cars'])[1]/following::caption[1]").text).should == "Representative example" }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Representative APR'])[1]/following::small[1]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Representative APR'])[1]/following::small[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Representative APR'])[1]/following::small[1]").text).should == "OFFER SUBJECT TO STATUS, TERMS AND CONDITIONS. CLICK HERE FOR DETAILS INCLUDING OUR PANEL OF LENDERS." }
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='About Arnold Clark'])[2]/following::div[3]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='About Arnold Clark'])[2]/following::h2[1]").text).should == "About Arnold Clark" }
    @driver.find_element(:name, "make").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Citroën")
    @driver.find_element(:name, "model").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "Berlingo")
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
    @driver.find_element(:name, "max_price").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£350")
    @driver.find_element(:id, "search-button").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Search'])[1]/following::h1[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Search'])[1]/following::h1[1]").text).should == "74 Used Citroën Berlingo cars for sale" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Berlingo'])[4]/following::li[1]").text).should == "£350 max monthly payment" }
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
