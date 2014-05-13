#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'money/core_extensions'

describe "Money core extensions" do
  specify "Numberic#to_money works" do
    money = 1234.to_money
    money.cents.should == 1234_00
    money.currency.should == Money.default_currency
    
    money = 100.37.to_money
    money.cents.should == 100_37
    money.currency.should == Money.default_currency
  end
  
  specify "String#to_money works" do
    "100".to_money.should == Money.new(100_00)
    "100.37".to_money.should == Money.new(100_37)
    "100,37".to_money.should == Money.new(100_37)
    "100 000".to_money.should == Money.new(100_000_00)
    "100,000.00".to_money.should == Money.new(100_000_00)
    "1,000".to_money.should == Money.new(1_000_00)
    "-1,000".to_money.should == Money.new(-1_000_00)
    "1,000.0000".to_money.should == Money.new(1_000_00)
    "1,000.5000".to_money.should == Money.new(1_000_50)
    "1.550".to_money.should == Money.new(1_55)
    
    "100 USD".to_money.should == Money.new(100_00, "USD")
    "-100 USD".to_money.should == Money.new(-100_00, "USD")
    "100 EUR".to_money.should == Money.new(100_00, "EUR")
    "100.37 EUR".to_money.should == Money.new(100_37, "EUR")
    "100,37 EUR".to_money.should == Money.new(100_37, "EUR")
    "100,000.00 USD".to_money.should == Money.new(100_000_00, "USD")
    "100.000,00 EUR".to_money.should == Money.new(100_000_00, "EUR")
    "1,000 USD".to_money.should == Money.new(1_000_00, "USD")
    "-1,000 USD".to_money.should == Money.new(-1_000_00, "USD")
    "1,000.5500 USD".to_money.should == Money.new(1_000_55, "USD")
    "-1,000.6500 USD".to_money.should == Money.new(-1_000_65, "USD")
    "1.550 USD".to_money.should == Money.new(1_55, "USD")
    
    "USD 100".to_money.should == Money.new(100_00, "USD")
    "EUR 100".to_money.should == Money.new(100_00, "EUR")
    "EUR 100.37".to_money.should == Money.new(100_37, "EUR")
    "CAD -100.37".to_money.should == Money.new(-100_37, "CAD")
    "EUR 100,37".to_money.should == Money.new(100_37, "EUR")
    "EUR -100,37".to_money.should == Money.new(-100_37, "EUR")
    "USD 100,000.00".to_money.should == Money.new(100_000_00, "USD")
    "EUR 100.000,00".to_money.should == Money.new(100_000_00, "EUR")
    "USD 1,000".to_money.should == Money.new(1_000_00, "USD")
    "USD -1,000".to_money.should == Money.new(-1_000_00, "USD")
    "USD 1,000.9000".to_money.should == Money.new(1_000_90, "USD")
    "USD -1,000.090".to_money.should == Money.new(-1_000_09, "USD")
    "USD 1.5500".to_money.should == Money.new(1_55, "USD")
    
    "$100 USD".to_money.should == Money.new(100_00, "USD")
    "$1,194.59 USD".to_money.should == Money.new(1_194_59, "USD")
    "$-1,955 USD".to_money.should == Money.new(-1_955_00, "USD")
    "$1,194.5900 USD".to_money.should == Money.new(1_194_59, "USD")
    "$-1,955.000 USD".to_money.should == Money.new(-1_955_00, "USD")
    "$1.99000 USD".to_money.should == Money.new(1_99, "USD")
  end
end
