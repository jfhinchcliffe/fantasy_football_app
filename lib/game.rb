require 'csv'
class Game
  attr_reader :home_team, :away_team, :result

  def initialize(home_team, away_team)
    @home_team = home_team
    @away_team = away_team
    @result = {home_team: home_team, away_team: away_team, score: [0,0], status: "Pending"}
  end

  # Big gnarly method that simulates a game
  def play

    current_conditions = get_conditions

    home_team_modifier = 50
    away_team_modifier = 50

    # Add to modifier if they like playing in the current conditions
    home_team_modifier += 10 if @home_team.condition_preference == current_conditions
    away_team_modifier += 10 if @away_team.condition_preference == current_conditions

    home_team_modifier += (@home_team.attack - @away_team.defense) + @home_team.luck
    away_team_modifier += (@away_team.attack - @home_team.defense) + @away_team.luck

    home_team_score, away_team_score, winning_team = animate_game(home_team_modifier, away_team_modifier, current_conditions)

    @result[:score] = [home_team_score, away_team_score]
    @result[:status] = "#{winning_team}, #{@result[:score][0]} to #{@result[:score][1]}"

    puts
    puts @result[:status]
    puts
  end

  FILE_PATH = './data/football_season.csv'

  def save_game_result
    CSV.open(FILE_PATH, "ab") do |file|
      file << [@result[:home_team].name, @result[:away_team].name, @result[:score], @result[:status]]
    end
  end

  def Game.season_results
    puts "Season Results to #{Time.now.strftime('%m/%d/%Y')}".colorize(:red)
    CSV.foreach(FILE_PATH) do |row|
      puts "#{row[0]} vs #{row[1]}, Result: #{row[3]}"
    end
    gets
  end

  def Game.finish_season
    File.open(FILE_PATH, 'w') {}
  end

    private

      def get_conditions
        ['wet 🌧 ', 'dry 🌞 '].sample
      end

      def play_action
         [" ⚽  pass... ⚽ "," ⚽  tackle... ⚽ "," 🙅 free kick! ❌ "," ⚽  pass... ⚽ "," ⚽  pass... ⚽ "," ⚽  pass... ⚽ "," ⚽  pass... ⚽ "," ⚽  pass... ⚽ "," ⚽  pass... ⚽ ", ].sample
      end
      # The crowdpleaser method. Animates the game
      def animate_game(home_team_modifier, away_team_modifier, current_conditions)
        puts "Playing in the #{current_conditions}"
        home_team_score = 0
        away_team_score = 0
        # 20 is the amount of 'minutes' in the game
        20.times do
          sleep(0.5)
          t1 = rand(1..home_team_modifier)
          t2 = rand(1..away_team_modifier)
          if t1 > t2
            kick = rand(1..3)
            if kick > 2
              home_team_score += 1
              puts " 🙌 GOAL TO #{@home_team.name.upcase}🙌  "
            else
              puts play_action
            end
          elsif t2 > t1
            kick = rand(1..3)
            if kick > 2
              away_team_score += 1
              puts " 🙌 GOAL TO #{@away_team.name.upcase}🙌  "
            else
              puts play_action
            end
          end
        end
        winning_team = ""
        if home_team_score > away_team_score
          winning_team  = "#{@home_team.name} win! 🏆 "
        elsif away_team_score > home_team_score
          winning_team = "#{@away_team.name} win! 🏆 "
        else
          winning_team = 'Draw! 😑 '
        end
        return [home_team_score, away_team_score, winning_team]
      end

end
