# -*- encoding : utf-8 -*-
Given("I have variable A") do
    @a = 50
  end
  
  Given("I have variable B") do
    @b = 70
  end
  
  When("I multiply a and b") do
    @mul = @a * @b
  end
  
  Then("I display the result") do
    puts "multiplication of #{@a} and #{@b} is #{@mul}"
    raise "should be 3500" if @mul != 3500
  end
  
 
