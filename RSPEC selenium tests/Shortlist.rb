# -*- encoding : utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
require 'pathname'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path("/Users/e0061509/Documents/selenium tests/Gemfile",
  Pathname.new(__FILE__).realpath)

require 'rubygems'
require 'bundler/setup'

load Gem.bin_path('rspec-core', 'rspec')
include RSpec::Expectations

describe "ShortlistRb" do

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
  
  it "test_shortlist_rb" do
    @driver.get "https://www.arnoldclark.com/"
    @driver.find_element(:id, "search-button").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Perth Kia / Jeep'])[1]/following::button[2]").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='CLICK&nbsp;HERE'])[1]/following::span[1]").click
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
