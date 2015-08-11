#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module Helpers
    module Tags #:nodoc:
      extend ActiveSupport::Autoload

      autoload :Base
      autoload :CheckBox
      autoload :CollectionCheckBoxes
      autoload :CollectionRadioButtons
      autoload :CollectionSelect
      autoload :ColorField
      autoload :DateField
      autoload :DateSelect
      autoload :DatetimeField
      autoload :DatetimeLocalField
      autoload :DatetimeSelect
      autoload :EmailField
      autoload :FileField
      autoload :GroupedCollectionSelect
      autoload :HiddenField
      autoload :Label
      autoload :MonthField
      autoload :NumberField
      autoload :PasswordField
      autoload :RadioButton
      autoload :RangeField
      autoload :SearchField
      autoload :Select
      autoload :TelField
      autoload :TextArea
      autoload :TextField
      autoload :TimeField
      autoload :TimeSelect
      autoload :TimeZoneSelect
      autoload :UrlField
      autoload :WeekField
    end
  end
end
