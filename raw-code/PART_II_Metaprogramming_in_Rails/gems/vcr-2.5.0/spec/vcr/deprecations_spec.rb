#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe VCR, 'deprecations', :disable_warnings do
  describe ".config" do
    it 'delegates to VCR.configure' do
      VCR.should_receive(:configure)
      VCR.config { }
    end

    it 'yields the configuration object' do
      config_object = nil
      VCR.config { |c| config_object = c }
      expect(config_object).to be(VCR.configuration)
    end

    it 'prints a deprecation warning' do
      VCR.should_receive(:warn).with(/VCR.config.*deprecated/i)

      VCR.config { }
    end
  end

  describe "Config" do
    it 'returns the same object referenced by VCR.configuration' do
      expect(VCR::Config).to be(VCR.configuration)
    end

    it 'prints a deprecation warning' do
      VCR.should_receive(:warn).with(/VCR::Config.*deprecated/i)

      VCR::Config
    end

    it 'preserves the normal undefined constant behavior' do
      expect {
        VCR::SomeUndefinedConstant
      }.to raise_error(NameError)
    end
  end

  describe "Cassette::MissingERBVariableError" do
    it 'returns VCR::Errors::MissingERBVariableError' do
      expect(VCR::Cassette::MissingERBVariableError).to be(VCR::Errors::MissingERBVariableError)
    end

    it 'prints a deprecation warning' do
      VCR::Cassette.should_receive(:warn).with(/VCR::Cassette::MissingERBVariableError.*deprecated/i)

      VCR::Cassette::MissingERBVariableError
    end

    it 'preserves the normal undefined constant behavior' do
      expect {
        VCR::Cassette::SomeUndefinedConstant
      }.to raise_error(NameError)
    end
  end

  describe "VCR.configure { |c| c.stub_with ... }" do
    it 'delegates to #hook_into' do
      VCR.configuration.should_receive(:hook_into).with(:fakeweb, :excon)
      VCR.configure { |c| c.stub_with :fakeweb, :excon }
    end

    it 'prints a deprecation warning' do
      VCR.configuration.should_receive(:warn).with(/stub_with.*deprecated/i)
      VCR.configure { |c| c.stub_with :fakeweb, :excon }
    end
  end

  describe "VCR::Middleware::Faraday" do
    it 'prints a deprecation warning when passed a block' do
      Kernel.should_receive(:warn).with(/Passing a block .* is deprecated/)
      VCR::Middleware::Faraday.new(stub) { }
    end
  end

  describe "VCR::RSpec::Macros" do
    it 'prints a deprecation warning' do
      Kernel.should_receive(:warn).with(/VCR::RSpec::Macros is deprecated/)
      Class.new.extend(VCR::RSpec::Macros)
    end
  end
end

