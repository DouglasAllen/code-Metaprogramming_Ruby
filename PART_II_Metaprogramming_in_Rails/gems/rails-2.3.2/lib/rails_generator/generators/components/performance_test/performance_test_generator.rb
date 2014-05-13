#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class PerformanceTestGenerator < Rails::Generator::NamedBase
  default_options :skip_migration => false

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_name, "#{class_name}Test"

      # performance test directory
      m.directory File.join('test/performance', class_path)

      # performance test stub
      m.template 'performance_test.rb', File.join('test/performance', class_path, "#{file_name}_test.rb")
    end
  end
end
