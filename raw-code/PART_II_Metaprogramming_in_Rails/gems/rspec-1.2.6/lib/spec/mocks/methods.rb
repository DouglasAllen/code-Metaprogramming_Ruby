#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Mocks
    module Methods
      def should_receive(sym, opts={}, &block)
        __mock_proxy.add_message_expectation(opts[:expected_from] || caller(1)[0], sym.to_sym, opts, &block)
      end

      def should_not_receive(sym, &block)
        __mock_proxy.add_negative_message_expectation(caller(1)[0], sym.to_sym, &block)
      end
      
      def stub!(sym_or_hash, opts={})
        if Hash === sym_or_hash
          sym_or_hash.each {|method, value| stub!(method).and_return value }
        else
          __mock_proxy.add_stub(caller(1)[0], sym_or_hash.to_sym, opts)
        end
      end
      
      alias_method :stub, :stub!

      def stub_chain(*methods)
        while methods.length > 1
          stub!(methods.shift).and_return(self)
        end
        stub!(methods.shift)
      end
      
      def received_message?(sym, *args, &block) #:nodoc:
        __mock_proxy.received_message?(sym.to_sym, *args, &block)
      end
      
      def rspec_verify #:nodoc:
        __mock_proxy.verify
      end

      def rspec_reset #:nodoc:
        __mock_proxy.reset
      end
      
      def as_null_object
        __mock_proxy.as_null_object
      end
      
      def null_object?
        __mock_proxy.null_object?
      end

    private

      def __mock_proxy
        if Mock === self
          @mock_proxy ||= Proxy.new(self, @name, @options)
        else
          @mock_proxy ||= Proxy.new(self)
        end
      end
    end
  end
end
