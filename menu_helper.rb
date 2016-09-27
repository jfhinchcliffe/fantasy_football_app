require 'csv'
require './team'
module MenuHelper

  def MenuHelper.display_team_name(team, display_options)
    puts "Team Name:".colorize(:red) + " #{team.name}" if display_options[:name]
    puts "Attack:".colorize(:blue) + " #{team.attack}" if display_options[:attack]
    print "Defense:".colorize(:blue) + " #{team.defense} " if display_options[:defense]
    print "Luck:".colorize(:blue) + " #{team.luck} \n" if display_options[:luck]
    puts "Preferred Conditions:".colorize(:yellow) + " #{team.condition_preference}" if display_options[:condition_preference]
  end

  def MenuHelper.find_team(teams, team_to_find)
    teams.each do |team|
      if team.name == team_to_find
        puts "#{team.name} found!"
        return team
      end
    end
    puts "#{team_to_find} not found"
    team = false
  end

  def MenuHelper.query(question)
    puts question
    print "> "
    response = gets.strip
  end

  def MenuHelper.unique_team_name_verification(all_teams)
    verify_unique = false
    while verify_unique == false
      team_name = query("Please enter the name of your team")
      if all_teams.any? {|team| team.name == team_name}
        puts "#{team_name} already taken. Please select a new name."
      else
        verify_unique = true
      end
    end
    return team_name
  end

  def MenuHelper.stat_verification(stat_name)
    verify_acceptable = false
    while verify_acceptable == false do
      number = query("Please enter the team #{stat_name} strength (1 to 10)").to_i
      if number <= 0 || number > 10
        puts "Invalid number"
      else
        verify_acceptable = true
      end
    end
    return number
  end

  def MenuHelper.acceptable_response(acceptable_responses)
    verify_acceptable = false
    while verify_acceptable == false do
      answer = query("Does this team play better in wet or dry conditions? ('wet' or 'dry')").downcase
      if acceptable_responses.any? {|response| response == answer}
        verify_acceptable = true
      else
        puts "Invalid response"
      end
    end
    return answer
  end

  def MenuHelper.num_generator(range, value="unknown")
    random_number = rand(1..range)
    return random_number
  end

  def MenuHelper.pretty_format_team(team_hash)
    puts "Name: ".colorize(:yellow) + "#{team_hash[:name]}"
    puts "Attack: ".colorize(:yellow) + "#{team_hash[:attack]}"
    puts "Defense:".colorize(:yellow) + " #{team_hash[:defense]}"
    puts "Luck:".colorize(:yellow) + " #{team_hash[:luck]}"
    puts "Condition Preference:".colorize(:yellow) + " #{team_hash[:condition_preference]}"
  end

  def MenuHelper.team_constructor
    prepend_names = ["Bug","Snot","Snuggle","Jet","Hung","Gronk","Butt","Slug"]
    append_names = ["sters","ists","hammers","bads","greasers","elopes","snipes","sniffers"]
    conditions = ["wet","dry"]
    new_team = Hash.new
    new_team[:name] = "#{prepend_names.sample}#{append_names.sample}"
    new_team[:attack] = num_generator(10)
    new_team[:defense] = num_generator(10)
    new_team[:luck] = num_generator(10)
    new_team[:condition_preference] = conditions.sample
    return new_team
  end
end
