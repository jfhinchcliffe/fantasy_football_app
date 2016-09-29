require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/menu_helper'

describe MenuHelper do

  before do
    @all_teams = []
    @team1 = instance_double("Team", :name => "Bulls")
    @team2 = instance_double("Team", :name => "Snakes")
    @team3 = instance_double("Team", :name => "Anvils")
    @all_teams << @team1
    @all_teams << @team2
    @all_teams << @team3
    @unique_team = instance_double("Team", :name => "Tallywhackers")
  end

  describe "search function" do
    it "returns the object searched for" do
      expect(MenuHelper.find_team(@all_teams, "Snakes")).to eql(@team2)
    end

    it "returns not found when team doesn't exist" do
      expect(MenuHelper.find_team(@all_teams, "FakeName")).to eql(false)
    end

  end

  describe "random number generator" do
    it "returns a number between 1 and the range sent in" do
      expect(MenuHelper.num_generator(10)).to be_between(1, 10)
    end


  end

  describe "team constructor" do
    before do
      @generated_team = MenuHelper.team_constructor
    end

    # it "returns a valid name" do
    #   expect(@generated_team[:name].class)).to be_(String)
    # end

    it "returns a valid defense" do
      expect(@generated_team[:defense]).to be_between(1, 10)
    end

    it "returns a valid attack" do
      expect(@generated_team[:attack]).to be_between(1, 10)
    end
  end

  # describe "unique team names only" do
  #   NEED TO FIGURE OUT HOW TO TEST USER INPUT
  #   it "accepts a new, unique team name " do
  #     expect(MenuHelper.find_team(@all_teams, @unique_team)).to eql()
  #   end
  #
  #
  # end

end
