#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# stub frameworks like to gum up Object, so this is deliberately
# set NOT to run so that you don't accidentally run it when you
# run this dir.

# To run it, stand in this directory and say:
#
#   RUN_MOCHA_EXAMPLE=true ruby ../bin/spec mocking_with_mocha.rb

if ENV['RUN_MOCHA_EXAMPLE']
  Spec::Runner.configure do |config|
    config.mock_with :mocha
  end
  describe "Mocha framework" do
    it "should should be made available by saying config.mock_with :mocha" do
      m = mock()
      m.expects(:msg).with("arg")
      m.msg
    end
    it "should should be made available by saying config.mock_with :mocha" do
      o = Object.new
      o.expects(:msg).with("arg")
      o.msg
    end
  end
end
