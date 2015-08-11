#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class HelperGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Helper", "#{class_name}HelperTest"

      # Helper and helper test directories.
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('test/unit/helpers', class_path)

      # Helper and helper test class.

      m.template 'helper.rb',
                  File.join('app/helpers',
                            class_path,
                            "#{file_name}_helper.rb")

      m.template 'helper_test.rb',
                  File.join('test/unit/helpers',
                            class_path,
                            "#{file_name}_helper_test.rb")

    end
  end
end
