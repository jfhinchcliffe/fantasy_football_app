require_relative './menu_helper'

describe MenuHelper do

  before do
    @all_teams = []
    @team1 = instance_double("Team", :name => "Bulls")
    @team2 = instance_double("Team", :name => "Snakes")
    @team3 = instance_double("Team", :name => "Anvils")
    @all_teams << @team1
    @all_teams << @team2
    @all_teams << @team3
  end

  describe "search function" do
    it "returns the object searched for" do
      expect(MenuHelper.find_team(@all_teams, "Snakes")).to eql(@team2)
    end

    it "returns not found when team doesn't exist" do
      expect(MenuHelper.find_team(@all_teams, "FakeName")).to eql(false)
    end

  end

  describe "unique"

end
