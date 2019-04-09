# -*- encoding : utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "2dTest" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.katalon.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
end
 
