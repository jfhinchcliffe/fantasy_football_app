require_relative '../lib/team'


describe Team do

  before do
    @team = Team.new({name: "Bulls", attack: 9, defense: 5, luck: 3, condition_preference: "dry"})
  end

  describe "team information" do
    it "outputs the team information" do
      expect(@team.name).to eql("Bulls")
      expect(@team.attack).to eql(9)
      expect(@team.defense).to eql(5)
      expect(@team.luck).to eql(3)
      expect(@team.condition_preference).to eql('dry')
    end
  end

  describe "edit" do
    it "edits team values" do
      @team.edit_team_values("Snakes", 'wet')
      expect(@team.name).to eql("Snakes")
      expect(@team.luck).to eql(3)
      expect(@team.condition_preference).to eql('wet')
    end
  end

end
