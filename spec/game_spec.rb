require './game'
require './team'

describe Game do

    before do
      Game.finish_season
      @team1 = Team.new({name: "Bulls", attack: 9, defense: 5, luck: 3, condition_preference: "dry"})
      @team2 = Team.new({name: "SnuggleMonsters", attack: 9, defense: 5, luck: 3, condition_preference: "dry"})
      @game = Game.new(@team1, @team2)
    end

    describe "game information" do
      it "outputs the game information home team, away team" do
        expect(@game.home_team.name).to eql(@team1.name)
        expect(@game.away_team.name).to eql(@team2.name)
      end
    end

    describe "check" do
      it "outputs check from the check method" do
        expect(@game.check).to eql("HOLLA")
      end
    end

    describe "play" do

      before do
        @game.play
      end

      it "should populate the score array after a game is played" do
        expect(@game.result[:score]).not_to eql([0,0])

      end

      it "status should should display a winner, loser, or draw after game is played" do
        expect(@game.result[:status]).not_to eql("Pending")
      end

    end

    # describe "saving" do
    #
    #   it "outputs the contents of the seasons file" do
    #     expect(Game.season_results).to output("{@game.result[:home_team]} vs #{@game.result[:away_team]}, score #{@game.result[:score]}").to_stdout
    #   end
    # end
    #{@game.result[:home_team]} vs #{@game.result[:away_team]}, score #{@game.result[:score]}"

end
