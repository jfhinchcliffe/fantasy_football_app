require 'csv'
module MenuHelper

  def MenuHelper.display_team_name(team, display_options)
    puts "Team Name:".colorize(:red) + " #{team.name}" if display_options[:name]
    puts "Attack:".colorize(:blue) + " #{team.attack}" if display_options[:attack]
    print "Defense:".colorize(:blue) + " #{team.defense} " if display_options[:defense]
    print "Luck:".colorize(:blue) + " #{team.luck} \n" if display_options[:luck]
    puts "Preferred Conditions:".colorize(:yellow) + " #{team.condition_preference}" if display_options[:condition_preference]
  end

  # def Menuhelper.finish_season
  #   File.open('football_season.csv', 'w') {}
  # end

  def MenuHelper.find_team(teams, team_to_find)
    teams.each do |team|
      if team.name == team_to_find
        puts "#{team.name} found!"
        return team
      end
    end
    return = false
  end



end
