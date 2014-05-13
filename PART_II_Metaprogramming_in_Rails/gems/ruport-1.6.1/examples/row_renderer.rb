#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "ruport"

class CSV2Something < Ruport::Controller
  required_option :csv_file
  stage :table_body

  module Helpers
    def table_feeder
      Table(options.csv_file,:has_names => false) { |t,r| yield(r) }
    end
  end

end

class HTML < Ruport::Formatter::HTML

  renders :html, :for => CSV2Something

  def layout
    output << "<html><div id='ruport'><table>\n"
    yield
    output << "</table></div></html>\n"
  end
  
  def build_table_body
    table_feeder { |r| render_row(r) }
  end
end

class Text < Ruport::Formatter::Text
  renders :text, :for => CSV2Something

  def build_table_body
    table_feeder { |r|  output << r.to_a.join("$") }
  end
 
end

CSV2Something.render_html(:csv_file => "example.csv",:io => STDOUT)
