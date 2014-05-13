#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'test_helper'

class <%= class_name %>Test < ActionMailer::TestCase
<% for action in actions -%>
  test "<%= action %>" do
    @expected.subject = '<%= class_name %>#<%= action %>'
    @expected.body    = read_fixture('<%= action %>')
    @expected.date    = Time.now

    assert_equal @expected.encoded, <%= class_name %>.create_<%= action %>(@expected.date).encoded
  end

<% end -%>
<% if actions.blank? -%>
  # replace this with your real tests
  test "the truth" do
    assert true
  end
<% end -%>
end
