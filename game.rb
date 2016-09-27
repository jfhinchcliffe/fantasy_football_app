class Game

  def initialize(home_team, away_team)
    @home_team = home_team
    @away_team = away_team
    @result = {home_team: home_team, away_team: away_team, score: [0,0], status: "Pending"}
  end

  def check
    puts "HOLLA"
    gets
  end

  def play
    puts @home_team
    puts @away_team
    gets
  end


end
