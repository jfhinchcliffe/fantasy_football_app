require 'csv'
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
  # Big gnarly method that simulates a game
  def play
    puts @home_team
    puts @away_team
    home_team_score = 0
    away_team_score = 0
    home_team_score += (@home_team.attack) - (@away_team.defense)
    away_team_score += (@away_team.attack) - (@away_team.defense)
    home_team_score += ((rand(1..@home_team.luck) + 1) * rand(1..@home_team.luck))
    away_team_score += (rand(1..@home_team.luck) * rand(1..@home_team.luck))
    if home_team_score > away_team_score
      puts "#{@home_team.name} win!"
      @result[:status] = "#{@home_team.name} win!"
    elsif home_team_score < away_team_score
      puts "#{@away_team.name} win!"
      @result[:status] = "#{@away_team.name} win!"
    else
      puts "DRAW!"
      @result[:status] = "Draw"
    end
    @result[:score] = [home_team_score, away_team_score]
    save_game_result
  end

  def save_game_result
    CSV.open("football_season.csv", "ab") do |file|
      file << [@result[:home_team].name, @result[:away_team].name, @result[:score]]
    end
  end

  def Game.finish_season
    File.open('football_season.csv', 'w') {}
  end

  def Game.season_results
    CSV.foreach('football_season.csv') do |row|
      puts "#{row[0]} vs #{row[1]}, score #{row[2]}"
    end
    gets
  end


end
