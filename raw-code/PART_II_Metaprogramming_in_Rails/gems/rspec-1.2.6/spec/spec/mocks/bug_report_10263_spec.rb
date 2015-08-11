#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
describe "Mock" do
  before do
    @mock = mock("test mock")
  end
  
  specify "when one example has an expectation (non-mock) inside the block passed to the mock" do
    @mock.should_receive(:msg) do |b|
      b.should be_true #this call exposes the problem
    end
    @mock.msg(false) rescue nil
  end
  
  specify "then the next example should behave as expected instead of saying" do
    @mock.should_receive(:foobar)
    @mock.foobar
    @mock.rspec_verify
    begin
      @mock.foobar
    rescue Exception => e
      e.message.should == "Mock 'test mock' received unexpected message :foobar with (no args)"
    end
  end 
end

