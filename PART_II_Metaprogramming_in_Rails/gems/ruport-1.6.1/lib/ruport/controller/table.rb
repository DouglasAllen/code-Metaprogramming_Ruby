#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# controller/table.rb : Tabular data controller for Ruby Reports
#
# Written by Gregory Brown, December 2006.  Copyright 2006, All Rights Reserved
# This is Free Software, please see LICENSE and COPYING for details.

module Ruport

  # This class implements the basic controller for table rows.
  #
  # == Supported Formatters 
  #  
  # * Formatter::CSV
  # * Formatter::Text
  # * Formatter::HTML
  #
  # == Formatter hooks called (in order)
  #  
  # * build_row
  #
  class Controller::Row < Controller
    stage :row
  end

  # This class implements the basic tabular data controller for Ruport.
  #
  # == Supported Formatters 
  #  
  # * Formatter::CSV
  # * Formatter::Text
  # * Formatter::HTML
  # * Formatter::PDF
  #
  # == Default layout options 
  #  
  # * <tt>show_table_headers</tt> #=> true
  #
  # == Formatter hooks called (in order)
  #  
  # * prepare_table
  # * build_table_header
  # * build_table_body
  # * build_table_footer
  # * finalize_table
  #
  class Controller::Table < Controller
    options { |o| o.show_table_headers = true }

    prepare :table
    
    stage :table_header, :table_body, :table_footer

    finalize :table
  end
end
