#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "ruport"

# draws pretty little lines all over the place on a PDF

class SimpleLines < Ruport::Controller
  stage :horizontal_lines
end

class PDFLines < Ruport::Formatter::PDF
  renders :pdf, :for => SimpleLines

  def build_horizontal_lines
    data.each do |points|
      pad(10) { horizontal_line(*points) }
    end
    render_pdf
  end
end

# generate 35 random lines
data = (0..34).inject([]) { |s,r|
  s << [rand(100),100+rand(400)]
}

puts SimpleLines.render_pdf(:data => data)
