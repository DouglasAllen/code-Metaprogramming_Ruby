#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class ObserverGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions "#{class_name}Observer", "#{class_name}ObserverTest"

      # Observer, and test directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('test/unit', class_path)

      # Observer class and unit test fixtures.
      m.template 'observer.rb',   File.join('app/models', class_path, "#{file_name}_observer.rb")
      m.template 'unit_test.rb',  File.join('test/unit', class_path, "#{file_name}_observer_test.rb")
    end
  end
end
