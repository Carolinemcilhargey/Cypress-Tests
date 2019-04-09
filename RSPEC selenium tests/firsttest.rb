# -*- encoding : utf-8 -*-
require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path = "/Users/e0061509/Documents/selenium tests/chromedriver"
driver = Selenium::WebDriver.for(:chrome, detach: true)
driver.get("http://arnoldclarkemployee.com")
driver.find_element(:name, "employeeId").send_keys("61509")
driver.find_element(:name, "password").send_keys("password")
driver.find_element(:css, "ch-btn.ch-btn--block.ch-btn--success").click


driver.find_element(:name, "make").click



    dropDownMenu = @driver.find_element(:name, 'make')
    option = Selenium::WebDriver::Support::Select.new(make)
    option.select_by(:text, 'Audi')
    option.select_by(:value, 'Audi')


driver.find_element(:name, "make").click
dropdown_list = driver.find_element(:name, "make").click

options = dropdown_list.find_elements(:name, "make")

options.each { |option| option.click if option.value == 'BMW'}


If(text.contains("Audi cars for sale")

    System.out.println(“Expected text is obtained”)
    
    else
         System.out.println(“Expected text is not obtained”)
    end



assert(driver.find_element(:class => "ac-results__heading").text.include?("Audi cars for sale"))

Assert.assertEquals(“Audi cars for sale“, driver.getTitle())
puts "Test passed" if assert == true
 

If(text.contains("Audi cars for sale")

    System.out.println(“Expected text is obtained”)
    
else
         System.out.println(“Expected text is not obtained”)
    end




    
    after(:each) do
        @driver.quit
        @verification_errors.should == []
      end
      
      it "test_2d" do
        @driver.get "https://www.arnoldclark.com/"
        @driver.find_element(:name, "make").click
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "make")).select_by(:text, "Ford")
        @driver.find_element(:name, "model").click
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "model")).select_by(:text, "Focus RS")
        @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[5]").click
        @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Monthly payment'])[1]/following::label[1]").click
        @driver.find_element(:name, "min_price").click
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "min_price")).select_by(:text, "£4000")
        @driver.find_element(:name, "max_price").click
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "max_price")).select_by(:text, "£15,000")
        @driver.find_element(:id, "search-button").click
        @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='£4000 min cash price'])[1]/following::li[1]").click
        (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Remove all'])[1]/following::li[1]").text).should == "Ford"
        (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Ford'])[5]/following::li[1]").text).should == "Focus RS"
        (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Focus RS'])[4]/following::li[1]").text).should == "£4000 min cash price"
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
    
