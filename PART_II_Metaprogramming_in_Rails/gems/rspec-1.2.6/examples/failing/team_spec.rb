#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'


class Team
  attr_reader :players
  def initialize
    @players = Players.new
  end
end

class Players
  def initialize
    @players = []
  end
  def size
    @players.size
  end
  def include? player
    raise "player must be a string" unless player.is_a?(String)
    @players.include? player
  end
end

describe "A new team" do
  
  before(:each) do
    @team = Team.new
  end
  
  it "should have 3 players (failing example)" do
    @team.should have(3).players
  end
  
  it "should include some player (failing example)" do
    @team.players.should include("Some Player")
  end

  it "should include 5 (failing example)" do
    @team.players.should include(5)
  end
  
  it "should have no players"
  
end
