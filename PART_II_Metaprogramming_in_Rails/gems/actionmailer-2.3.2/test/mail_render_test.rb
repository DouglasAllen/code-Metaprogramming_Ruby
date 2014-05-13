#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'abstract_unit'

class RenderMailer < ActionMailer::Base
  def inline_template(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
    body       render(:inline => "Hello, <%= @world %>", :body => { :world => "Earth" })
  end

  def file_template(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
    body       render(:file => "signed_up", :body => { :recipient => recipient })
  end

  def rxml_template(recipient)
    recipients recipient
    subject    "rendering rxml template"
    from       "tester@example.com"
  end

  def included_subtemplate(recipient)
    recipients recipient
    subject    "Including another template in the one being rendered"
    from       "tester@example.com"
  end

  def included_old_subtemplate(recipient)
    recipients recipient
    subject    "Including another template in the one being rendered"
    from       "tester@example.com"
    body       render(:inline => "Hello, <%= render \"subtemplate\" %>", :body => { :world => "Earth" })
  end

  def initialize_defaults(method_name)
    super
    mailer_name "test_mailer"
  end
end

class FirstMailer < ActionMailer::Base
  def share(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
  end
end

class SecondMailer < ActionMailer::Base
  def share(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
  end
end

class RenderHelperTest < Test::Unit::TestCase
  def setup
    set_delivery_method :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @recipient = 'test@localhost'
  end

  def teardown
    restore_delivery_method
  end

  def test_inline_template
    mail = RenderMailer.create_inline_template(@recipient)
    assert_equal "Hello, Earth", mail.body.strip
  end

  def test_file_template
    mail = RenderMailer.create_file_template(@recipient)
    assert_equal "Hello there, \n\nMr. test@localhost", mail.body.strip
  end

  def test_rxml_template
    mail = RenderMailer.deliver_rxml_template(@recipient)
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<test/>", mail.body.strip
  end

  def test_included_subtemplate
    mail = RenderMailer.deliver_included_subtemplate(@recipient)
    assert_equal "Hey Ho, let's go!", mail.body.strip
  end
end

class FirstSecondHelperTest < Test::Unit::TestCase
  def setup
    set_delivery_method :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @recipient = 'test@localhost'
  end

  def teardown
    restore_delivery_method
  end

  def test_ordering
    mail = FirstMailer.create_share(@recipient)
    assert_equal "first mail", mail.body.strip
    mail = SecondMailer.create_share(@recipient)
    assert_equal "second mail", mail.body.strip
    mail = FirstMailer.create_share(@recipient)
    assert_equal "first mail", mail.body.strip
    mail = SecondMailer.create_share(@recipient)
    assert_equal "second mail", mail.body.strip
  end
end
