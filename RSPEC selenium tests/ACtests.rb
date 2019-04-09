require 'selenium-webdriver'
require 'minitest'
require 'pry'

Selenium::WebDriver::Chrome.driver_path = "/Users/e0061509/Documents/selenium tests/chromedriver"
driver = Selenium::WebDriver.for(:chrome, detach: true)
driver.get("http://arnoldclark.com")

dropDownMenu = driver.find_element(:name, 'make')
option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
option.select_by(:value, 'Audi')
driver.find_element(:id, 'search-button').click

assert_equal(@driver.title, "30,037 Used cars for sale in the UK | Arnold Clark")

dropDownMenu = driver.find_element(:name, 'model')
option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
option.select_by(:option, 'A1')    # pick a model

String Actualtext = driver.findElement("YourElementLocator").getAttribute("href")
Assert.assertEquals(Actualtext, "http://www.arnoldclark.com" );
System.out.println("URL matching --> Part executed");


assert_equal(@driver.title, "30,037 Used cars for sale in the UK | Arnold Clark")

driver.find_element(:class, 'ac-searchtag').text
    puts "test passed" if text == "Audi"

    Then("I should be directed to the serps page with the correct filters applied") do
        driver.find_element(:id, 'make').find_element(:selected_value, "Audi")
      end
    
    
      

      after(:each) 
      @driver.quit
      @verification_errors.should == []
    end
 

    3rd test definition 

    require "json"
require "selenium-webdriver"
require "rspec"


require 'rubygems'
require 'bundler/setup'

load Gem.bin_path('rspec-core', 'rspec')
include RSpec::Expectations
Selenium::WebDriver::Chrome.driver_path = "/Users/e0061509/Documents/selenium tests/chromedriver"
driver = Selenium::WebDriver.for(:chrome, detach: true)

Given("I am a user") do
    driver.get("http://arnoldclark.com") 
  end
  
  When("i search for fords") do
    dropDownMenu = driver.find_element(:name, 'make')
    option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
    option.select_by(:value, 'Ford')
    driver.find_element(:id, 'search-button').click
  end
  
  Then("I reach the serps page with fords displayed") do
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
    
  


