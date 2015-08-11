#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Ruport : Extensible Reporting System                                
#
# controller/grouping.rb : Group data controller for Ruby Reports
#
# Written by Michael Milner, 2007.
# Copyright (C) 2007, All Rights Reserved
#
# This is free software distributed under the same terms as Ruby 1.8
# See LICENSE and COPYING for details.
#
module Ruport
  
  # This class implements the basic controller for a single group of data.
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
  # * build_group_header
  # * build_group_body
  # * build_group_footer
  #
  class Controller::Group < Controller
    options { |o| o.show_table_headers = true }

    stage :group_header, :group_body, :group_footer
  end

  # This class implements the basic controller for data groupings in Ruport
  # (a collection of Groups).
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
  # * <tt>show_group_headers</tt> #=> true    
  # * <tt>style</tt> #=> :inline  
  #
  # == Formatter hooks called (in order)
  #
  # * build_grouping_header
  # * build_grouping_body
  # * build_grouping_footer
  # * finalize_grouping
  #
  class Controller::Grouping < Controller
    options do |o| 
      o.show_group_headers = true 
      o.style = :inline
    end

    stage :grouping_header, :grouping_body, :grouping_footer
    
    finalize :grouping
  end
  
end
