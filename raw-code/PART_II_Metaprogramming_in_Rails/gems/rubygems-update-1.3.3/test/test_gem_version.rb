#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#--
# Copyright 2006 by Chad Fowler, Rich Kilmer, Jim Weirich and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/version'

class TestGemVersion < RubyGemTestCase

  def setup
    super

    version = Object.new
    def version.to_s() '1.4.0' end

    @v1_0 = Gem::Version.new '1.0'
    @v1_2 = Gem::Version.new '1.2'
    @v1_3 = Gem::Version.new '1.3'
    @v1_4_0 = Gem::Version.new version
  end

  def test_class_create
    assert_version Gem::Version.create('1.0')
    assert_version Gem::Version.create("1.0 ")
    assert_version Gem::Version.create(" 1.0 ")
    assert_version Gem::Version.create("1.0\n")
    assert_version Gem::Version.create("\n1.0\n")

    assert_equal Gem::Version.create('1'), Gem::Version.create(1)
  end

  def test_class_create_malformed
    e = assert_raises ArgumentError do Gem::Version.create("junk") end
    assert_equal "Malformed version number string junk", e.message

    e = assert_raises ArgumentError do Gem::Version.create("1.0\n2.0") end
    assert_equal "Malformed version number string 1.0\n2.0", e.message
  end

  def test_bad
    assert_inadequate( "",            "> 0.1")
    assert_inadequate( "1.2.3",       "!= 1.2.3")
    assert_inadequate( "1.2.003.0.0", "!= 1.02.3")
    assert_inadequate( "4.5.6",       "< 1.2.3")
    assert_inadequate( "1.0",         "> 1.1")
    assert_inadequate( "0",           ">")
    assert_inadequate( "0",           "<")
    assert_inadequate( "",            "= 0.1")
    assert_inadequate( "1.1.1",       "> 1.1.1")
    assert_inadequate( "1.2",         "= 1.1")
    assert_inadequate( "1.40",        "= 1.1")
    assert_inadequate( "1.3",         "= 1.40")
    assert_inadequate( "9.3.3",       "<= 9.3.2")
    assert_inadequate( "9.3.1",       ">= 9.3.2")
    assert_inadequate( "9.3.03",      "<= 9.3.2")
    assert_inadequate( "1.0.0.1",     "= 1.0")
  end

  def test_bump_trailing_zeros
    v = Gem::Version.new("5.0.0")
    assert_equal "5.1", v.bump.to_s
  end

  def test_bump
    v = Gem::Version.new("5.2.4")
    assert_equal "5.3", v.bump.to_s
  end

  def test_bump_alpha
    v = Gem::Version.new("5.2.4.a")
    assert_equal "5.3", v.bump.to_s
  end

  def test_bump_one_level
    v = Gem::Version.new("5")
    assert_equal "6", v.bump.to_s
  end

  def test_eql_eh
    v1_2   = Gem::Version.new '1.2'
    v1_2_0 = Gem::Version.new '1.2.0'

    assert_equal true, v1_2.eql?(@v1_2)
    assert_equal true, @v1_2.eql?(v1_2)

    assert_equal false, v1_2_0.eql?(@v1_2)
    assert_equal false, @v1_2.eql?(v1_2_0)

    assert_equal false, @v1_2.eql?(@v1_3)
    assert_equal false, @v1_3.eql?(@v1_2)
  end

  def test_eql_eh4
    v1_4   = Gem::Version.new '1.4'
    v1_4_0 = Gem::Version.new "1.4.0"

    assert_equal true, v1_4_0.eql?(@v1_4_0)
    assert_equal true, @v1_4_0.eql?(v1_4_0)

    assert_equal false, v1_4.eql?(@v1_4_0)
    assert_equal false, @v1_4_0.eql?(v1_4)

    assert_equal false, @v1_4_0.eql?(@v1_3)
    assert_equal false, @v1_3.eql?(@v1_4_0)
  end

  def test_equals2
    v = Gem::Version.new("1.2")

    assert_equal v, @v1_2
    assert_equal @v1_2, v

    refute_equal @v1_2, @v1_3
    refute_equal @v1_3, @v1_2
  end

  def test_hash
    v1_2   = Gem::Version.new "1.2"
    v1_2_0 = Gem::Version.new "1.2.0"
    v1_4_0 = Gem::Version.new "1.4.0"

    assert_equal v1_2.hash, @v1_2.hash

    refute_equal v1_2_0.hash, @v1_2.hash

    assert_equal v1_4_0.hash, @v1_4_0.hash

    refute_equal @v1_2.hash, @v1_3.hash

    refute_equal @v1_2.hash, @v1_4_0.hash
  end

  def test_illformed_requirements
    [ ">>> 1.3.5", "> blah" ].each do |rq|
      assert_raises ArgumentError, "req [#{rq}] should fail" do
        Gem::Version::Requirement.new rq
      end
    end
  end

  def test_normalize
    assert_equal [0],         Gem::Version.new("").normalize.map { |part| part.value }
    assert_equal [0],         Gem::Version.new("0").normalize.map { |part| part.value }
    assert_equal [1],         Gem::Version.new("1").normalize.map { |part| part.value }
    assert_equal [1],         Gem::Version.new("1.0").normalize.map { |part| part.value }
    assert_equal [1, 1],      Gem::Version.new("1.1").normalize.map { |part| part.value }
    assert_equal [1, 1, "a"], Gem::Version.new("1.1.a").normalize.map { |part| part.value }
  end

  def test_ok
    assert_adequate( "0.2.33",      "= 0.2.33")
    assert_adequate( "0.2.34",      "> 0.2.33")
    assert_adequate( "1.0",         "= 1.0")
    assert_adequate( "1.0",         "1.0")
    assert_adequate( "1.8.2",       "> 1.8.0")
    assert_adequate( "1.112",       "> 1.111")
    assert_adequate( "0.2",         "> 0.0.0")
    assert_adequate( "0.0.0.0.0.2", "> 0.0.0")
    assert_adequate( "0.0.1.0",     "> 0.0.0.1")
    assert_adequate( "10.3.2",      "> 9.3.2")
    assert_adequate( "1.0.0.0",     "= 1.0")
    assert_adequate( "10.3.2",      "!= 9.3.4")
    assert_adequate( "10.3.2",      "> 9.3.2")
    assert_adequate( "10.3.2",      "> 9.3.2")
    assert_adequate( " 9.3.2",      ">= 9.3.2")
    assert_adequate( "9.3.2 ",      ">= 9.3.2")
    assert_adequate( "",            "= 0")
    assert_adequate( "",            "< 0.1")
    assert_adequate( "  ",          "< 0.1 ")
    assert_adequate( "",            " <  0.1")
    assert_adequate( "  ",          "> 0.a ")
    assert_adequate( "",            " >  0.a")
    assert_adequate( "0",           "=")
    assert_adequate( "0",           ">=")
    assert_adequate( "0",           "<=")
    assert_adequate( "3.1",         "< 3.2.rc1")
    assert_adequate( "3.2.0",       "> 3.2.0.rc1")
    assert_adequate( "3.2.0.rc2",   "> 3.2.0.rc1")
    assert_adequate( "3.0.rc2",     "< 3.0")
    assert_adequate( "3.0.rc2",     "< 3.0.0")
    assert_adequate( "3.0.rc2",     "< 3.0.1")
  end

  def test_parse_parts_from_version_string
    assert_equal [], part_values(Gem::Version.new("").parse_parts_from_version_string)
    assert_equal [1], part_values(Gem::Version.new("1").parse_parts_from_version_string)
    assert_equal [1, 0], part_values(Gem::Version.new("1.0").parse_parts_from_version_string)
    assert_equal [1, 0, "a"], part_values(Gem::Version.new("1.0.a").parse_parts_from_version_string)
  end

  def test_prerelease
    assert Gem::Version.new('1.2.0.a').prerelease?
    assert Gem::Version.new('2.9.b').prerelease?
    assert Gem::Version.new('22.1.50.0.d').prerelease?

    refute Gem::Version.new('1.2.0').prerelease?
    refute Gem::Version.new('2.9').prerelease?
    refute Gem::Version.new('22.1.50.0').prerelease?
  end
  
  def test_release
    assert_equal Gem::Version.new('1.2.0'), Gem::Version.new('1.2.0.a').release
    assert_equal Gem::Version.new('1.1'),   Gem::Version.new('1.1.rc10').release
    assert_equal Gem::Version.new('1.9.3'), Gem::Version.new('1.9.3.alpha.5').release
    assert_equal Gem::Version.new('1.9.3'), Gem::Version.new('1.9.3').release
  end

  def test_satisfied_by_eh_boxed
    assert_inadequate("1.3", "~> 1.4")
    assert_adequate(  "1.4", "~> 1.4")
    assert_adequate(  "1.5", "~> 1.4")
    assert_inadequate("2.0", "~> 1.4")

    assert_inadequate("1.3",   "~> 1.4.4")
    assert_inadequate("1.4",   "~> 1.4.4")
    assert_adequate(  "1.4.4", "~> 1.4.4")
    assert_adequate(  "1.4.5", "~> 1.4.4")
    assert_inadequate("1.5",   "~> 1.4.4")
    assert_inadequate("2.0",   "~> 1.4.4")
    
    assert_inadequate("1.1.pre", "~> 1.0.0")
    assert_adequate(  "1.1.pre", "~> 1.1")
    assert_inadequate("2.0.a",   "~> 1.0")
    assert_adequate(  "2.0.a",   "~> 2.0")
  end

  def test_satisfied_by_eh_multiple
    req = [">= 1.4", "<= 1.6", "!= 1.5"]
    assert_inadequate("1.3", req)
    assert_adequate(  "1.4", req)
    assert_inadequate("1.5", req)
    assert_adequate(  "1.6", req)
    assert_inadequate("1.7", req)
    assert_inadequate("2.0", req)
  end

  def test_spaceship
    assert_equal 0, Gem::Version.new('1.0') <=> Gem::Version.new('1.0.0')
    assert_equal 1, Gem::Version.new('1.0') <=> Gem::Version.new('1.0.a')
    assert_equal 1, Gem::Version.new('1.8.2') <=> Gem::Version.new('0.0.0')
    assert_equal 1, Gem::Version.new('1.8.2') <=> Gem::Version.new('1.8.2.a')
    assert_equal 1, Gem::Version.new('1.8.2.b') <=> Gem::Version.new('1.8.2.a')
    assert_equal 0, Gem::Version.new('') <=> Gem::Version.new('0')
  end

  def test_boxed
    assert_inadequate("1.3", "~> 1.4")
    assert_adequate(  "1.4", "~> 1.4")
    assert_adequate(  "1.5", "~> 1.4")
    assert_inadequate("2.0", "~> 1.4")

    assert_inadequate("1.3",   "~> 1.4.4")
    assert_inadequate("1.4",   "~> 1.4.4")
    assert_adequate(  "1.4.4", "~> 1.4.4")
    assert_adequate(  "1.4.5", "~> 1.4.4")
    assert_inadequate("1.5",   "~> 1.4.4")
    assert_inadequate("2.0",   "~> 1.4.4")
  end

  def test_to_s
    v = Gem::Version.new("5.2.4")
    assert_equal "5.2.4", v.to_s
  end

  def assert_adequate(version, requirement)
    ver = Gem::Version.new(version)
    req = Gem::Requirement.new(requirement)
    assert req.satisfied_by?(ver),
      "Version #{version} should be adequate for Requirement #{requirement}"
  end

  def assert_inadequate(version, requirement)
    ver = Gem::Version.new(version)
    req = Gem::Version::Requirement.new(requirement)
    refute req.satisfied_by?(ver),
      "Version #{version} should not be adequate for Requirement #{requirement}"
  end

  def assert_version(actual)
    assert_equal @v1_0, actual
    assert_equal @v1_0.version, actual.version
  end

  def part_values(*parts)
    parts.flatten.map { |part| part.value }
  end
end

class TestGemVersionPart < RubyGemTestCase
  def test_initialize
    assert_equal 1, Gem::Version::Part.new(1).value
    assert_equal 1, Gem::Version::Part.new("1").value
    assert_equal "a", Gem::Version::Part.new("a").value
  end

  def test_spaceship
    assert_equal(-1, Gem::Version::Part.new(1) <=> Gem::Version::Part.new(2))
    assert_equal( 0, Gem::Version::Part.new(2) <=> Gem::Version::Part.new(2))
    assert_equal( 1, Gem::Version::Part.new(2) <=> Gem::Version::Part.new(1))

    assert_equal(-1, Gem::Version::Part.new("a") <=> Gem::Version::Part.new("b"))
    assert_equal( 0, Gem::Version::Part.new("b") <=> Gem::Version::Part.new("b"))
    assert_equal( 1, Gem::Version::Part.new("b") <=> Gem::Version::Part.new("a"))

    assert_equal(-1, Gem::Version::Part.new("a") <=> Gem::Version::Part.new(1))
    assert_equal( 1, Gem::Version::Part.new(1)   <=> Gem::Version::Part.new("a"))
  end

  def test_succ
    assert_equal 2, Gem::Version::Part.new(1).succ.value
    assert_equal "b", Gem::Version::Part.new("a").succ.value
  end
end

