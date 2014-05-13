#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

require 'test/unit'
require 'test/rake_test_setup'
require 'test/in_environment'

require 'rake'

class TestWin32 < Test::Unit::TestCase
  include InEnvironment
  include TestMethods

  Win32 = Rake::Win32

  def test_win32_system_dir_uses_home_if_defined
    in_environment('RAKE_SYSTEM' => nil, 'HOME' => 'C:\\HP') do
      assert_equal "C:/HP/Rake", Win32.win32_system_dir
    end
  end

  def test_win32_system_dir_uses_homedrive_homepath_when_no_home_defined
    in_environment(
      'RAKE_SYSTEM' => nil,
      'HOME' => nil,
      'HOMEDRIVE' => "C:",
      'HOMEPATH' => "\\HP"
      ) do
      assert_equal "C:/HP/Rake", Win32.win32_system_dir
    end
  end

  def test_win32_system_dir_uses_appdata_when_no_home_or_home_combo
    in_environment(
      'RAKE_SYSTEM' => nil,
      'HOME' => nil,
      'HOMEDRIVE' => nil,
      'HOMEPATH' => nil,
      'APPDATA' => "C:\\Documents and Settings\\HP\\Application Data"
      ) do
      assert_equal "C:/Documents and Settings/HP/Application Data/Rake", Win32.win32_system_dir
    end
  end

  def test_win32_system_dir_fallback_to_userprofile_otherwise
    in_environment(
      'RAKE_SYSTEM' => nil,
      'HOME' => nil,
      'HOMEDRIVE' => nil,
      'HOMEPATH' => nil,
      'APPDATA' => nil,
      'USERPROFILE' => "C:\\Documents and Settings\\HP"
      ) do
      assert_equal "C:/Documents and Settings/HP/Rake", Win32.win32_system_dir
    end
  end

  def test_win32_system_dir_nil_of_no_env_vars
    in_environment(
      'RAKE_SYSTEM' => nil,
      'HOME' => nil,
      'HOMEDRIVE' => nil,
      "HOMEPATH" => nil,
      'APPDATA' => nil,
      "USERPROFILE" => nil
      ) do
      assert_exception(Rake::Win32::Win32HomeError) do
        Win32.win32_system_dir
      end
    end
  end

end
