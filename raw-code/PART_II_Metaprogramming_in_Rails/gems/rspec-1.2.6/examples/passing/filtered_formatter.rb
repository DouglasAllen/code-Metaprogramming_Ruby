#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
$:.unshift File.join(File.dirname(__FILE__), "/../../lib")
require 'spec/runner/formatter/nested_text_formatter'

class FilteredFormatter < Spec::Runner::Formatter::NestedTextFormatter
  def add_example_group(example_group)
    if example_group.options[:show] == false
      @showing = false
    else
      @showing = true
      puts example_group.description 
    end
  end
  
  def example_passed(example)
    puts "  " << example.description if @showing unless example.options[:show] == false
  end
end

